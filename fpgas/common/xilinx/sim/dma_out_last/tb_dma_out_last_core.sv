// Self-checking, seeded core testbench for dma_out_last. The core is clocked
// from outside so the same source runs under Verilator (C++ clock driver) and
// XSIM (tb_dma_out_last wrapper). All stimulus is registered at posedge, so
// both simulators produce identical event traces.
//
// Models: a config stream that holds payload until config_ready (like the
// DmaCsrPlugin StreamFifo), an in-order VMEM with random per-request latency
// and random request backpressure, random output backpressure, dmaReset
// aborts, timer-gated starts, zero-length schedules and reverse addressing.
// Checks: request addresses, returned word/last pairing, output stability
// under stall, no data loss/duplication, no memory-side overflow, timer
// gating, abort termination, busy status, and (seed 0) chained-schedule rate.
module tb_dma_out_last_core (input wire clk);
   localparam DEPTH = 32;
   localparam QN = 16384;

   integer seed, nsched, lmax, p_i0, p_i1, p_ret, p_gap, p_abort, p_timer;
   reg [31:0] rng;
   integer fd;
   integer cyc = 0;
   integer errors = 0;

   // schedule table
   reg [31:0] s_start [0:1023];
   integer    s_len   [0:1023];
   reg        s_last  [0:1023];
   reg        s_rev   [0:1023];
   reg        s_timed [0:1023];
   integer    cur, idx, gap;
   integer    i, k, lat, r;
   reg        aborted;
   integer    timer_cyc;

   // expected output queue (mirrors the DUT tag FIFO order)
   reg [31:0] e_data [0:QN-1];
   reg        e_last [0:QN-1];
   integer    ewp = 0, erp = 0;
   // in-flight memory requests
   reg [31:0] m_addr [0:QN-1];
   integer    m_time [0:QN-1];
   integer    mwp = 0, mrp = 0, m_last_time = 0;

   integer    n_out = 0, n_abort = 0, n_zero = 0, n_timed = 0, idle = 0;
   integer    first_out = -1, last_out = -1;
   reg        held_v = 0, held_l = 0;
   reg [31:0] held_d = 0;

   reg         srst = 1;
   reg  [31:0] ctimer = 0;
   reg         config_valid = 0;
   reg  [31:0] cfg_start = 0, cfg_len = 0, cfg_timer = 0;
   reg         cfg_rev = 0, cfg_last = 0;
   reg         dmaReset = 0;
   reg         t0_valid = 0;
   reg  [31:0] t0_data = 0;
   reg         i0_ready = 0, i1_ready = 0;
   wire        config_ready, t0_ready, i0_valid, i1_valid, i1_last;
   wire        strobe_complete, interrupt;
   wire [31:0] status, i0_addr, i1_data;

   dma_out_last #(.DEPTH(DEPTH)) dut
     (.clk(clk), .srst(srst), .ctimer(ctimer),
      .config_valid(config_valid), .config_ready(config_ready),
      .config_payload_startAddr(cfg_start), .config_payload_length(cfg_len),
      .config_payload_timerInit(cfg_timer), .config_payload_reverse(cfg_rev),
      .config_payload_last(cfg_last),
      .dmaReset(dmaReset), .status(status), .strobe_complete(strobe_complete),
      .interrupt(interrupt), .interrupt_clear(1'b0),
      .t0_data(t0_data), .t0_valid(t0_valid), .t0_ready(t0_ready),
      .i0_addr(i0_addr), .i0_valid(i0_valid), .i0_ready(i0_ready),
      .i1_data(i1_data), .i1_last(i1_last), .i1_valid(i1_valid),
      .i1_ready(i1_ready));

   function [31:0] xs(input [31:0] x);
      reg [31:0] y;
      begin
         y = x ^ (x << 13);
         y = y ^ (y >> 17);
         xs = y ^ (y << 5);
      end
   endfunction

   function [31:0] mem_word(input [31:0] a);
      mem_word = {a[15:0] ^ 16'hC3A5, ~a[15:0]} ^ (a[31:16] * 32'h9E37);
   endfunction

   task fail(input [8*48-1:0] msg);
      begin
         errors = errors + 1;
         if (errors < 20) $display("MISMATCH cycle=%0d: %0s", cyc, msg);
      end
   endtask

   // RNG draws are tasks, not functions: Verilator 4.016 may merge repeated
   // identical side-effecting function calls, desynchronising it from XSIM.
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

   task present(input integer s);
      begin
         cfg_start <= s_start[s];
         cfg_len <= s_len[s];
         cfg_rev <= s_rev[s];
         cfg_last <= s_last[s];
         r_uni(4, 40, r);
         if (s_timed[s])
           cfg_timer <= ctimer + 1 + r;
         else
           cfg_timer <= 32'hFFFF_FFFF;
         config_valid <= 1;
         timer_cyc = -1;
      end
   endtask

   initial begin
      if (!$value$plusargs("SEED=%d", seed)) seed = 1;
      fd = $fopen("trace.csv", "w");
      rng = 32'h1234_5678 ^ (seed * 32'h9E37_79B9);
      if (rng == 0) rng = 1;
      if (seed == 0) begin
         // chained header (1 word, last=0) + payload (255 words, last=1) at
         // full memory/output rate with a fixed read latency
         nsched = 2; lmax = 8; p_i0 = 100; p_i1 = 100; p_ret = 100;
         p_gap = 0; p_abort = 0; p_timer = 0;
         s_start[0] = 32'h40; s_len[0] = 1; s_last[0] = 0; s_rev[0] = 0; s_timed[0] = 0;
         s_start[1] = 32'h100; s_len[1] = 255; s_last[1] = 1; s_rev[1] = 0; s_timed[1] = 0;
      end else begin
         r_uni(150, 300, nsched);
         r_uni(1, 24, lmax);
         r_uni(20, 100, p_i0);
         r_uni(10, 100, p_i1);
         if (seed % 4 == 1) p_i1 = 3;
         r_uni(40, 100, p_ret);
         r_uni(0, 60, p_gap);
         p_abort = (seed % 3 == 0) ? 1 : 0;
         r_uni(0, 15, p_timer);
         for (i = 0; i < nsched; i = i + 1) begin
            r_pct(k);
            if (k < 5) s_len[i] = 0;
            else if (k < 30) s_len[i] = 1;
            else if (k < 85) r_uni(2, 20, s_len[i]);
            else r_uni(21, 90, s_len[i]);
            r_uni(0, 32'h7fff, r);
            s_start[i] = r + 32'h100;
            r_pct(r); s_last[i] = r < 60;
            r_pct(r); s_rev[i] = r < 20;
            r_pct(r); s_timed[i] = r < p_timer;
         end
      end
   end

   always @(posedge clk) begin
      cyc = cyc + 1;
      ctimer <= ctimer + 1;
      if (cyc == 4) begin
         srst <= 0;
         cur = 0; idx = 0; gap = 0; aborted = 0;
         present(0);
      end

      if (!srst) begin
         // ---- output side
         if (held_v && (!i1_valid || i1_data !== held_d || i1_last !== held_l))
           fail("output changed while stalled");
         if (i1_valid && erp == ewp)
           fail("output valid with nothing expected");
         if (i1_valid && i1_ready && erp != ewp) begin
            if (i1_data !== e_data[erp % QN] || i1_last !== e_last[erp % QN]) begin
               fail("output word/last mismatch");
               $display("  exp %08x/%0d got %08x/%0d", e_data[erp % QN],
                        e_last[erp % QN], i1_data, i1_last);
            end
            erp = erp + 1;
            if (first_out < 0) first_out = cyc;
            last_out = cyc;
            n_out = n_out + 1;
            $fwrite(fd, "%0d,out,%08x,%0d\n", cyc, i1_data, i1_last);
         end
         held_v = i1_valid && !i1_ready;
         held_d = i1_data;
         held_l = i1_last;

         // ---- abort (i0_valid is gated by dmaReset, so no request this cycle)
         aborted = 0;
         if (dmaReset && dut.q_state == 1'b1) begin
            aborted = 1;
            n_abort = n_abort + 1;
            if (idx > 0 && erp != ewp) e_last[(ewp - 1) % QN] = 1'b1;
            $fwrite(fd, "%0d,abort,%0d\n", cyc, idx);
         end

         // ---- memory requests
         if (i0_valid && i0_ready) begin
            if (cur >= nsched || idx >= s_len[cur])
              fail("request with no active schedule");
            else begin
               if (i0_addr !== (s_rev[cur] ? s_start[cur] - idx : s_start[cur] + idx))
                 fail("request address");
               if (s_timed[cur] && idx == 0 && (timer_cyc < 0 || cyc <= timer_cyc))
                 fail("started before timerInit");
               e_data[ewp % QN] = mem_word(i0_addr);
               e_last[ewp % QN] = (idx == s_len[cur] - 1) && s_last[cur];
               ewp = ewp + 1;
               if (seed == 0) lat = lmax;
               else r_uni(1, lmax, lat);
               m_last_time = (cyc + lat > m_last_time) ? cyc + lat : m_last_time;
               m_addr[mwp % QN] = i0_addr;
               m_time[mwp % QN] = m_last_time;
               mwp = mwp + 1;
               idx = idx + 1;
               $fwrite(fd, "%0d,req,%08x\n", cyc, i0_addr);
            end
         end
         if (config_valid && cur < nsched && s_timed[cur] && ctimer == cfg_timer
             && timer_cyc < 0)
           timer_cyc = cyc;

         // ---- config handshake (next schedule presented on the pop edge,
         // like a StreamFifo with more entries queued)
         if (config_valid && config_ready) begin
            if (s_len[cur] == 0) n_zero = n_zero + 1;
            else if (!aborted && idx != s_len[cur]) fail("config popped early");
            if (s_timed[cur]) n_timed = n_timed + 1;
            $fwrite(fd, "%0d,cfg,%0d,%0d\n", cyc, cur, idx);
            cur = cur + 1;
            idx = 0;
            gap = 0;
            r_pct(r);
            if (r < p_gap) r_uni(1, 12, gap);
            if (cur < nsched && gap == 0)
              present(cur);
            else
              config_valid <= 0;
         end else if (!config_valid && cur < nsched) begin
            gap = gap - 1;
            if (gap <= 0)
              present(cur);
         end

         // ---- memory returns (in order)
         if (t0_valid) begin
            if (!t0_ready) fail("memory return overflowed dma");
            mrp = mrp + 1;
            $fwrite(fd, "%0d,ret,%08x\n", cyc, t0_data);
         end
         r_pct(r);
         if (mrp != mwp && m_time[mrp % QN] <= cyc && r < p_ret) begin
            t0_valid <= 1;
            t0_data <= mem_word(m_addr[mrp % QN]);
         end else
           t0_valid <= 0;

         // ---- dmaReset pulses and ready patterns
         r_pct(r); dmaReset <= (r < p_abort);
         r_pct(r); i0_ready <= (r < p_i0);
         r_pct(r); i1_ready <= (r < p_i1);

         // ---- completion
         if (cur >= nsched && erp == ewp && mrp == mwp) begin
            idle = idle + 1;
            if (idle == 8) begin
               if (status[0]) fail("status busy after drain");
               // one WAIT->ENABLE bubble at the header/payload boundary
               if (seed == 0 && (n_out != 256 || last_out - first_out != 256))
                 fail("chained schedules not at full rate");
               if (errors == 0)
                 $display("PASS seed=%0d scheds=%0d words=%0d aborts=%0d zero=%0d timed=%0d cycles=%0d",
                          seed, nsched, n_out, n_abort, n_zero, n_timed, cyc);
               else
                 $display("FAIL seed=%0d errors=%0d", seed, errors);
               $fclose(fd);
               $finish;
            end
         end else begin
            idle = 0;
            if (cur >= nsched && !status[0] && erp != ewp)
              fail("status idle with words pending");
         end
         if (cyc > 400000) begin
            $display("FAIL seed=%0d timeout cur=%0d/%0d erp=%0d ewp=%0d",
                     seed, cur, nsched, erp, ewp);
            $finish;
         end
      end
   end
endmodule
