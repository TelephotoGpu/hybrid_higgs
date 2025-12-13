// XSIM driver for fir_filter.  Replays vectors produced by gen_vectors.py
// (stimulus, per-cycle valid/ready patterns, and model-expected output) and
// self-checks: exact output data/last order, output stability while stalled,
// input/sticky-error behaviour after each accepted beat, err_clear, no
// spurious outputs, and completion.  Writes a CSV trace identical in format
// to verilator_fir_filter.cpp.
module tb_fir_filter;
   parameter NTAPS = 16;
   localparam MAXN = 65536;
   localparam MAXP = 400000;

   reg         clk = 0, srst = 1;
   reg  [31:0] t_data = 0;
   reg         t_last = 0, t_valid = 0, i_ready = 0, err_clear = 0;
   wire        t_ready, i_valid, i_last;
   wire [31:0] i_data;
   wire [2:0]  err;

   fir_filter #(.NTAPS(NTAPS)) dut
     (.clk(clk), .srst(srst),
      .t_data(t_data), .t_last(t_last), .t_valid(t_valid), .t_ready(t_ready),
      .i_data(i_data), .i_last(i_last), .i_valid(i_valid), .i_ready(i_ready),
      .err(err), .err_clear(err_clear));

   reg [31:0] in_d [0:MAXN-1];
   reg        in_l [0:MAXN-1];
   reg        in_c [0:MAXN-1];
   reg [2:0]  in_e [0:MAXN-1];
   reg [31:0] ex_d [0:MAXN-1];
   reg        ex_l [0:MAXN-1];
   reg        vpat [0:MAXP-1];
   reg        rpat [0:MAXP-1];

   integer n_in, n_out, npat, fd, fo, r, a, b, c, e;
   integer cyc, idx, oidx, errors, tail;
   integer presenting, cleared, check_err, exp_err;
   integer prev_stall;
   reg [31:0] prev_d;
   reg        prev_l;
   reg [31:0] w;
   reg [1023:0] dir;
   reg          in_fire, out_fire;

   task fail(input [8*96-1:0] msg);
      begin
         errors = errors + 1;
         if (errors < 20)
           $display("MISMATCH cycle=%0d: %0s", cyc, msg);
      end
   endtask

   initial begin
      if (!$value$plusargs("DIR=%s", dir)) dir = ".";
      fd = $fopen({dir, "/meta.txt"}, "r");
      r = $fscanf(fd, "%d %d %d", n_in, n_out, npat);
      $fclose(fd);
      fd = $fopen({dir, "/in.txt"}, "r");
      for (a = 0; a < n_in; a = a + 1) begin
         r = $fscanf(fd, "%h %d %d %d", w, b, c, e);
         in_d[a] = w; in_l[a] = b; in_c[a] = c; in_e[a] = e;
      end
      $fclose(fd);
      fd = $fopen({dir, "/exp.txt"}, "r");
      for (a = 0; a < n_out; a = a + 1) begin
         r = $fscanf(fd, "%h %d", w, b);
         ex_d[a] = w; ex_l[a] = b;
      end
      $fclose(fd);
      fd = $fopen({dir, "/vpat.txt"}, "r");
      for (a = 0; a < npat; a = a + 1) begin r = $fscanf(fd, "%d", b); vpat[a] = b; end
      $fclose(fd);
      fd = $fopen({dir, "/rpat.txt"}, "r");
      for (a = 0; a < npat; a = a + 1) begin r = $fscanf(fd, "%d", b); rpat[a] = b; end
      $fclose(fd);
      fo = $fopen({dir, "/xsim_trace.csv"}, "w");
      $fwrite(fo, "cycle,event,data,last,err\n");

      errors = 0; idx = 0; oidx = 0; presenting = 0; cleared = 0;
      check_err = 0; exp_err = 0; prev_stall = 0; tail = 0;

      // reset
      for (cyc = 0; cyc < 4; cyc = cyc + 1) begin
         #5 clk = 1; #5 clk = 0;
      end
      srst = 0;

      cyc = 0;
      while ((idx < n_in || oidx < n_out || tail < 64) && cyc < npat + 200000) begin
         // ---- drive this cycle (clk low)
         err_clear = 0;
         if (!presenting && idx < n_in) begin
            if (in_c[idx] && !cleared) begin
               err_clear = 1;
               cleared = 1;
            end
            else if (cyc >= npat || vpat[cyc])
              presenting = 1;
         end
         t_valid = presenting;
         t_data  = (idx < n_in) ? in_d[idx] : 32'h0;
         t_last  = (idx < n_in) ? in_l[idx] : 1'b0;
         i_ready = (idx >= n_in && oidx >= n_out) ? 1'b1 : ((cyc >= npat) ? 1'b1 : rpat[cyc]);
         #4;
         // ---- sample handshakes before the edge
         in_fire  = t_valid & t_ready;
         out_fire = i_valid & i_ready;
         if (prev_stall) begin
            if (!i_valid) fail("i_valid dropped while stalled");
            else if (i_data !== prev_d || i_last !== prev_l) fail("output changed while stalled");
         end
         if (^i_valid === 1'bx || ^t_ready === 1'bx) fail("X on handshake");
         if (out_fire) begin
            if (oidx >= n_out) fail("unexpected extra output");
            else if (i_data !== ex_d[oidx] || i_last !== ex_l[oidx]) begin
               $display("  out %0d: got %08h/%0d exp %08h/%0d", oidx, i_data, i_last, ex_d[oidx], ex_l[oidx]);
               fail("output data/last mismatch");
            end
            $fwrite(fo, "%0d,OUT,%08h,%0d,%0d\n", cyc, i_data, i_last, err);
            oidx = oidx + 1;
         end
         if (in_fire)
           $fwrite(fo, "%0d,IN,%08h,%0d,%0d\n", cyc, t_data, t_last, err);
         prev_stall = i_valid & !i_ready;
         prev_d = i_data;
         prev_l = i_last;
         #1 clk = 1;
         #4;
         // ---- after the edge
         if (in_fire) begin
            if (err !== in_e[idx]) begin
               $display("  in %0d: err %0d exp %0d", idx, err, in_e[idx]);
               fail("sticky error mismatch");
            end
            idx = idx + 1;
            presenting = 0;
            cleared = 0;
         end
         if (err_clear && err !== 3'b0) fail("err_clear did not clear");
         if (idx >= n_in && oidx >= n_out) tail = tail + 1;
         #1 clk = 0;
         cyc = cyc + 1;
      end

      if (idx != n_in || oidx != n_out) fail("timeout");
      $fwrite(fo, "%0d,END,%08h,%0d,%0d\n", cyc, 0, 0, err);
      $fclose(fo);
      if (errors == 0)
        $display("PASS: %0d input beats, %0d outputs, %0d cycles", n_in, n_out, cyc);
      else
        $display("FAIL: %0d errors", errors);
      $finish;
   end
endmodule
