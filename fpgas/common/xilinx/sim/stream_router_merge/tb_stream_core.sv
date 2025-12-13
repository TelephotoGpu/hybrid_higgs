// Self-checking, seeded core testbench for stream_router / stream_merge.
// Clocked from outside so the same source runs under Verilator (C++ clock
// driver) and XSIM (tb_stream wrapper); all stimulus is registered at
// posedge, so both simulators produce identical traces.
//
// MODE 0: stream_router alone (random per-port output backpressure).
// MODE 1: stream_merge alone (two random packet sources).
// MODE 2: router -> two random-latency "echo" arms (each transforms data) ->
//         merge, with both arms busy at once.
//
// Checks: per-port payload order/data/last, route-word consumption, bad
// route drops, sticky err + err_clear, merge tag format and per-port
// sequence numbers, no interleaving inside a packet, round-robin
// alternation under contention, output stability while stalled, and
// (seed 0) full-rate throughput.
module tb_stream_core #(parameter MODE = 2) (input wire clk);
   localparam N  = 2;
   localparam QN = 32768;
   localparam AD = 8;              // echo arm FIFO depth

   integer seed, fd, npk, p_gap, p_rdy, p_bad, p_arm;
   reg [31:0] rng;
   integer cyc = 0, errors = 0;
   integer i, k, r, len, p, bad, typ;

   // router input stimulus
   reg [31:0] s_data [0:QN-1];
   reg        s_last [0:QN-1];
   integer    s_n = 0, s_idx = 0, s_half = 0, gap = 0;
   integer    n_bad0 = 0, n_bad1 = 0;
   // expected per-port payload queues (flattened [p*QN + i])
   reg [31:0] x_data [0:N*QN-1];
   reg        x_last [0:N*QN-1];
   integer    xw [0:N-1];
   integer    xr [0:N-1];
   integer    xh [0:N-1];          // xw at the phase boundary
   // merge sources (MODE 1), flattened [p*QN + i]
   reg [31:0] m_data [0:N*QN-1];
   reg        m_last [0:N*QN-1];
   integer    mw [0:N-1];
   integer    mi [0:N-1];
   integer    mgap [0:N-1];
   // echo arms (MODE 2)
   reg [31:0] a_data [0:N*AD-1];
   reg        a_last [0:N*AD-1];
   integer    a_cnt [0:N-1];
   integer    a_rd [0:N-1];
   integer    a_wr [0:N-1];
   // merge output scoreboard
   integer    o_port = -1;
   integer    exp_seq [0:N-1];
   integer    last_pick = -1, n_contend = 0, n_pkts_out = 0;
   // stability
   reg        held_v [0:N-1];
   reg [31:0] held_d [0:N-1];
   reg        held_l [0:N-1];
   // phases
   integer    phase = 0, idle = 0, first_in = -1, last_out = -1, n_words_in = 0, rate_words = 0;

   reg         srst = 1;
   reg  [31:0] t_data = 0;
   reg         t_last = 0, t_valid = 0;
   wire        t_ready;
   reg         err_clear = 0;
   wire        r_err;

   wire [N*32-1:0] r_data;
   wire [N-1:0]    r_last, r_valid;
   reg  [N-1:0]    r_ready = 0;        // router outputs (MODE 0: TB sink, MODE 2: arm inputs)

   reg  [N*32-1:0] g_data = 0;         // merge inputs (MODE 1: sources, MODE 2: arm outputs)
   reg  [N-1:0]    g_last = 0, g_valid = 0;
   wire [N-1:0]    g_ready;
   wire [31:0]     o_data;
   wire            o_last, o_valid;
   reg             o_ready = 0;

   stream_router #(.N(N)) rt
     (.clk(clk), .srst(srst),
      .t_data(t_data), .t_last(t_last), .t_valid(t_valid), .t_ready(t_ready),
      .i_data(r_data), .i_last(r_last), .i_valid(r_valid), .i_ready(r_ready),
      .err(r_err), .err_clear(err_clear));

   stream_merge #(.N(N)) mg
     (.clk(clk), .srst(srst),
      .t_data(g_data), .t_last(g_last), .t_valid(g_valid), .t_ready(g_ready),
      .i_data(o_data), .i_last(o_last), .i_valid(o_valid), .i_ready(o_ready));

   function [31:0] xs(input [31:0] x);
      reg [31:0] y;
      begin
         y = x ^ (x << 13);
         y = y ^ (y >> 17);
         xs = y ^ (y << 5);
      end
   endfunction

   function [31:0] arm_f(input integer port, input [31:0] w);
      arm_f = (port == 0) ? (w ^ 32'h0F0F_1234) : (w + 32'h1357_9BDF);
   endfunction

   task fail(input [8*48-1:0] msg);
      begin
         errors = errors + 1;
         if (errors < 20) $display("MISMATCH cycle=%0d: %0s", cyc, msg);
      end
   endtask

   // RNG draws are tasks: Verilator 4.016 may merge repeated side-effecting
   // function calls.
   task r_pct(output integer v);
      begin
         rng = xs(rng);
         v = rng % 100;
      end
   endtask

   task r_uni(input integer lo, input integer hi, output integer v);
      begin
         rng = xs(rng);
         v = lo + (rng % (hi - lo + 1));
      end
   endtask

   task r_len(output integer v);
      begin
         r_pct(v);
         if (v < 30) v = 1;
         else if (v < 85) r_uni(2, 20, v);
         else r_uni(21, 90, v);
      end
   endtask

   task push_x(input integer port, input [31:0] w, input l);
      begin
         x_data[port*QN + xw[port]] = w;
         x_last[port*QN + xw[port]] = l;
         xw[port] = xw[port] + 1;
      end
   endtask

   initial begin
      if (!$value$plusargs("SEED=%d", seed)) seed = 1;
      fd = $fopen("trace.csv", "w");
      rng = 32'h5271_0000 ^ (seed * 32'h9E37_79B9) ^ (MODE * 32'h85EB_CA77);
      if (rng == 0) rng = 1;
      for (p = 0; p < N; p = p + 1) begin
         xw[p] = 0; xr[p] = 0; xh[p] = 0; mw[p] = 0; mi[p] = 0; mgap[p] = 0;
         a_cnt[p] = 0; a_rd[p] = 0; a_wr[p] = 0; exp_seq[p] = 0;
         held_v[p] = 0; held_d[p] = 0; held_l[p] = 0;
      end
      if (seed == 0) begin
         npk = 40; p_gap = 0; p_rdy = 100; p_bad = 0; p_arm = 100;
      end else begin
         r_uni(150, 300, npk);
         r_uni(0, 60, p_gap);
         r_uni(10, 100, p_rdy);
         if (seed % 4 == 1) p_rdy = 3;
         r_uni(0, 15, p_bad);
         r_uni(20, 100, p_arm);
      end

      if (MODE != 1) begin
         for (i = 0; i < npk; i = i + 1) begin
            if (i == npk / 2) begin
               s_half = s_n;
               for (k = 0; k < N; k = k + 1) xh[k] = xw[k];
            end
            r_uni(0, N - 1, p);
            r_pct(r); bad = (r < p_bad) ? 1 : 0;
            r_pct(r);
            if (seed == 0) len = 60;
            else if (r < 5) len = 0;
            else r_len(len);
            s_data[s_n] = {16'h5271, 12'h000, p[3:0]};
            if (bad != 0) begin
               r_uni(0, 2, typ);
               if (typ == 0) s_data[s_n][31:16] = 16'h5270 ^ i[15:0];
               else if (typ == 1) begin
                  r_uni(4, 15, r);
                  s_data[s_n][r] = 1'b1;
               end else begin
                  r_uni(N, 15, r);
                  s_data[s_n][3:0] = r[3:0];
               end
               if (i < npk / 2) n_bad0 = n_bad0 + 1; else n_bad1 = n_bad1 + 1;
            end
            s_last[s_n] = (len == 0);
            s_n = s_n + 1;
            for (k = 0; k < len; k = k + 1) begin
               rng = xs(rng);
               s_data[s_n] = rng;
               s_last[s_n] = (k == len - 1);
               if (bad == 0)
                 push_x(p, (MODE == 2) ? arm_f(p, rng) : rng, k == len - 1);
               s_n = s_n + 1;
            end
         end
      end else begin
         for (p = 0; p < N; p = p + 1)
           for (i = 0; i < npk / 2; i = i + 1) begin
              if (seed == 0) len = 60; else r_len(len);
              for (k = 0; k < len; k = k + 1) begin
                 rng = xs(rng);
                 m_data[p*QN + mw[p]] = rng;
                 m_last[p*QN + mw[p]] = (k == len - 1);
                 mw[p] = mw[p] + 1;
                 push_x(p, rng, k == len - 1);
              end
           end
      end
   end

   task check_out(input integer port, input [31:0] d, input l);
      begin
         if (xr[port] >= xw[port])
           fail("unexpected output word");
         else begin
            if (d !== x_data[port*QN + xr[port]] || l !== x_last[port*QN + xr[port]]) begin
               fail("payload data/last mismatch");
               $display("  port %0d idx %0d exp %08x/%0d got %08x/%0d", port, xr[port],
                        x_data[port*QN + xr[port]], x_last[port*QN + xr[port]], d, l);
            end
            xr[port] = xr[port] + 1;
         end
         last_out = cyc;
      end
   endtask

   function all_drained(input integer dummy);
      integer q;
      begin
         all_drained = 1;
         for (q = 0; q < N; q = q + 1)
           if (xr[q] != ((MODE != 1 && phase == 0) ? xh[q] : xw[q])) all_drained = 0;
      end
   endfunction

   always @(posedge clk) begin
      cyc = cyc + 1;
      err_clear <= 0;
      if (cyc == 4) srst <= 0;

      if (!srst) begin
         // ---------------------------------------------------- router input
         if (MODE != 1) begin
            if (t_valid && t_ready) begin
               $fwrite(fd, "%0d,in,%08x,%0d\n", cyc, t_data, t_last);
               if (first_in < 0) first_in = cyc;
               n_words_in = n_words_in + 1;
               rate_words = rate_words + 1;
               s_idx = s_idx + 1;
               t_valid <= 0;
               r_pct(r);
               gap = (r < p_gap) ? 1 + (r % 7) : 0;
            end
            if (!(t_valid && !t_ready)) begin
               if (s_idx < s_n && (phase == 1 || s_idx < s_half) && gap == 0) begin
                  t_valid <= 1;
                  t_data <= s_data[s_idx];
                  t_last <= s_last[s_idx];
               end else begin
                  t_valid <= 0;
                  if (gap > 0) gap = gap - 1;
               end
            end
         end

         // ---------------------------------------------------- router outputs
         if (MODE == 0) begin
            for (p = 0; p < N; p = p + 1) begin
               if (held_v[p] && (!r_valid[p] || r_data[p*32 +: 32] !== held_d[p] ||
                                 r_last[p] !== held_l[p]))
                 fail("router output changed while stalled");
               if (r_valid[p] && r_ready[p]) begin
                  $fwrite(fd, "%0d,o%0d,%08x,%0d\n", cyc, p, r_data[p*32 +: 32], r_last[p]);
                  check_out(p, r_data[p*32 +: 32], r_last[p]);
               end
               held_v[p] = r_valid[p] && !r_ready[p];
               held_d[p] = r_data[p*32 +: 32];
               held_l[p] = r_last[p];
               r_pct(r);
               r_ready[p] <= (r < p_rdy);
            end
         end

         // ---------------------------------------------------- echo arms
         if (MODE == 2) begin
            for (p = 0; p < N; p = p + 1) begin
               if (r_valid[p] && r_ready[p]) begin
                  $fwrite(fd, "%0d,a%0d,%08x,%0d\n", cyc, p, r_data[p*32 +: 32], r_last[p]);
                  a_data[p*AD + a_wr[p]] = arm_f(p, r_data[p*32 +: 32]);
                  a_last[p*AD + a_wr[p]] = r_last[p];
                  a_wr[p] = (a_wr[p] + 1) % AD;
                  a_cnt[p] = a_cnt[p] + 1;
               end
               if (g_valid[p] && g_ready[p])
                 g_valid[p] <= 0;
               r_pct(r);
               if ((!g_valid[p] || g_ready[p]) && a_cnt[p] > 0 && r < p_arm) begin
                  g_valid[p] <= 1;
                  g_data[p*32 +: 32] <= a_data[p*AD + a_rd[p]];
                  g_last[p] <= a_last[p*AD + a_rd[p]];
                  a_rd[p] = (a_rd[p] + 1) % AD;
                  a_cnt[p] = a_cnt[p] - 1;
               end
               r_pct(r);
               r_ready[p] <= (a_cnt[p] < AD - 1) && (r < p_arm);
            end
         end

         // ---------------------------------------------------- merge sources
         if (MODE == 1) begin
            for (p = 0; p < N; p = p + 1) begin
               if (g_valid[p] && g_ready[p]) begin
                  $fwrite(fd, "%0d,s%0d,%08x,%0d\n", cyc, p, g_data[p*32 +: 32], g_last[p]);
                  mi[p] = mi[p] + 1;
                  if (first_in < 0) first_in = cyc;
                  n_words_in = n_words_in + 1;
                  rate_words = rate_words + 1;
                  g_valid[p] <= 0;
                  r_pct(r);
                  mgap[p] = (r < p_gap) ? 1 + (r % 7) : 0;
               end
               if (!(g_valid[p] && !g_ready[p])) begin
                  if (mi[p] < mw[p] && mgap[p] == 0) begin
                     g_valid[p] <= 1;
                     g_data[p*32 +: 32] <= m_data[p*QN + mi[p]];
                     g_last[p] <= m_last[p*QN + mi[p]];
                  end else begin
                     g_valid[p] <= 0;
                     if (mgap[p] > 0) mgap[p] = mgap[p] - 1;
                  end
               end
            end
         end

         // ---------------------------------------------------- merge output
         if (MODE != 0) begin
            if (mg.tag) begin
               if (g_valid == {N{1'b1}}) begin
                  n_contend = n_contend + 1;
                  if ({31'b0, mg.pick} == last_pick) fail("round robin did not alternate");
               end
               last_pick = {31'b0, mg.pick};
            end
            if (held_v[0] && (!o_valid || o_data !== held_d[0] || o_last !== held_l[0]))
              fail("merge output changed while stalled");
            if (o_valid && o_ready) begin
               $fwrite(fd, "%0d,out,%08x,%0d\n", cyc, o_data, o_last);
               if (o_port < 0) begin
                  if (o_data[31:16] !== 16'h5271 || o_data[15:12] !== 4'h0 ||
                      o_data[3:0] >= N || o_last !== 1'b0)
                    fail("bad tag word");
                  else begin
                     o_port = {28'b0, o_data[3:0]};
                     if (o_data[11:4] !== exp_seq[o_port][7:0]) fail("tag sequence");
                     exp_seq[o_port] = exp_seq[o_port] + 1;
                     n_pkts_out = n_pkts_out + 1;
                  end
               end else begin
                  check_out(o_port, o_data, o_last);
                  if (o_last) o_port = -1;
               end
            end
            held_v[0] = o_valid && !o_ready;
            held_d[0] = o_data;
            held_l[0] = o_last;
            r_pct(r);
            o_ready <= (r < p_rdy);
         end

         // ---------------------------------------------------- phases / end
         if ((MODE == 1 || s_idx >= (phase == 0 ? s_half : s_n)) && all_drained(0)) begin
            idle = idle + 1;
            if (MODE != 1 && phase == 0 && idle == 6) begin
               if (r_err !== (n_bad0 != 0)) fail("sticky err after phase 0");
               err_clear <= 1;
            end
            if (MODE != 1 && phase == 0 && idle == 8) begin
               if (r_err !== 1'b0) fail("err_clear did not clear");
               phase = 1;
               idle = 0;
               first_in = -1;       // full-rate check covers phase 1 only
               rate_words = 0;
            end
            if ((MODE == 1 || phase == 1) && idle == 12) begin
               if (MODE != 1 && r_err !== (n_bad1 != 0)) fail("sticky err after phase 1");
               if (o_port >= 0) fail("merge left mid-packet");
               if (seed == 0 && last_out - first_in > rate_words + 8 + (MODE == 1 ? npk : 0))
                 fail("not full rate");
               if (errors == 0)
                 $display("PASS mode=%0d seed=%0d words_in=%0d pkts_out=%0d contend=%0d bad=%0d cycles=%0d",
                          MODE, seed, n_words_in, n_pkts_out, n_contend, n_bad0 + n_bad1, cyc);
               else
                 $display("FAIL mode=%0d seed=%0d errors=%0d", MODE, seed, errors);
               $fclose(fd);
               $finish;
            end
         end else
           idle = 0;
         if (cyc > 1000000) begin
            $display("FAIL mode=%0d seed=%0d timeout s_idx=%0d/%0d", MODE, seed, s_idx, s_n);
            $finish;
         end
      end
   end
endmodule
