module q_engine
  #(parameter VMEM_DEPTH = 4096,
    parameter SCALAR_MEM_0 = "scalar0.mif",
    parameter SCALAR_MEM_1 = "scalar1.mif",
    parameter SCALAR_MEM_2 = "scalar2.mif",
    parameter SCALAR_MEM_3 = "scalar3.mif",
    parameter VMEM0 = "vmem0.mif",
    parameter VMEM1 = "vmem1.mif",
    parameter VMEM2 = "vmem2.mif",
    parameter VMEM3 = "vmem3.mif",
    parameter VMEM4 = "vmem4.mif",
    parameter VMEM5 = "vmem5.mif",
    parameter VMEM6 = "vmem6.mif",
    parameter VMEM7 = "vmem7.mif",
    parameter VMEM8 = "vmem8.mif",
    parameter VMEM9 = "vmem9.mif",
    parameter VMEM10 = "vmem10.mif",
    parameter VMEM11 = "vmem11.mif",
    parameter VMEM12 = "vmem12.mif",
    parameter VMEM13 = "vmem13.mif",
    parameter VMEM14 = "vmem14.mif",
    parameter VMEM15 = "vmem15.mif",
    parameter VMEM16 = "vmem16.mif",
    parameter VMEM17 = "vmem17.mif",
    parameter VMEM18 = "vmem18.mif",
    parameter VMEM19 = "vmem19.mif",
    parameter VMEM20 = "vmem20.mif",
    parameter VMEM21 = "vmem21.mif",
    parameter VMEM22 = "vmem22.mif",
    parameter VMEM23 = "vmem23.mif",
    parameter VMEM24 = "vmem24.mif",
    parameter VMEM25 = "vmem25.mif",
    parameter VMEM26 = "vmem26.mif",
    parameter VMEM27 = "vmem27.mif",
    parameter VMEM28 = "vmem28.mif",
    parameter VMEM29 = "vmem29.mif",
    parameter VMEM30 = "vmem30.mif",
    parameter VMEM31 = "vmem31.mif",
    parameter NO_RISCV = 0
    ) 
   (input wire clk,
    input wire         srst,
    input wire         debugReset,
    //t0_stream
    input wire [31:0]  t0_data,
    input wire         t0_last,
    input wire         t0_valid,
    output wire        t0_ready,
    //temporary
    output wire [31:0] i0_data,
    output wire        i0_last,
    output wire        i0_valid,
    input wire         i0_ready,
    output wire        proc_interrupt,

    input wire         sat_detect,
    inout wire [21:0]  gpio,

    //control and status
    input wire [31:0]  status,
    output wire [31:0] control,

    output [1023:0]    mapmov_mover_active,
    output [31:0]      mapmov_trim_start,
    output [31:0]      mapmov_trim_end,
    output [9:0]       mapmov_pilot_ram_addr,
    output [31:0]      mapmov_pilot_ram_wdata,
    output             mapmov_pilot_ram_we,
    output             mapmov_reset, 
    output [15:0]      mapmov_one_value,
    output [15:0]      mapmov_zero_value,
   
    input              i_ringbus_0,
    output             o_ringbus_0,

    input              i_ringbus_1,
    output             o_ringbus_1,

    //uart
    output             io_uart_txd,
    input              io_uart_rxd,

    //jtag
    input              jtag_tms,
    input              jtag_tdi,
    output             jtag_tdo,
    input              jtag_tck
   
    );

   localparam NUM_VMEMS=32;
   localparam VMEM_ADDR_WIDTH=11;
   localparam VMEM_DATA_WIDTH=32;
   
   localparam AWIDTH=13;
   localparam DEPTH=8192;
   

   localparam CROSSBAR_INPUTS=3;
   localparam IARB_ADDR_WIDTH=16;
   reg [IARB_ADDR_WIDTH-1:0] t_crossbar_addr[CROSSBAR_INPUTS-1:0];
   reg [VMEM_DATA_WIDTH-1:0] t_crossbar_data[CROSSBAR_INPUTS-1:0];

   reg                       t_crossbar_valid[CROSSBAR_INPUTS-1:0];
   reg                       t_crossbar_ready[CROSSBAR_INPUTS-1:0];

   reg [VMEM_ADDR_WIDTH-1:0] i_crossbar_addr[NUM_VMEMS-1:0];
   reg [VMEM_DATA_WIDTH-1:0] i_crossbar_data[NUM_VMEMS-1:0];
   reg                       i_crossbar_we[NUM_VMEMS-1:0];
   reg                       i_crossbar_valid[NUM_VMEMS-1:0];
   reg                       i_mem_ready[NUM_VMEMS-1:0];
   
   
   reg [VMEM_DATA_WIDTH-1:0] i_mem_data[NUM_VMEMS-1:0];
   reg                       i_mem_valid[NUM_VMEMS-1:0];
   
   reg [31:0]                i_data[CROSSBAR_INPUTS-1:0];
   reg                       i_valid[CROSSBAR_INPUTS-1:0];
   
   
   reg [31:0]                s_paddr;
   reg                       s_pwrite;
   reg                       s_psel;
   reg                       s_penable;
   reg [31:0]                s_pwdata;
   reg [31:0]                s_prdata;
   reg                       s_pready;
   reg                       s_pslverr;


   wire                      iBus_cmd_valid;
   wire                      iBus_cmd_ready;
   wire [31:0]               iBus_cmd_payload_pc;
   wire                      iBus_rsp_ready;
   wire                      iBus_rsp_error;
   wire [31:0]               iBus_rsp_inst;

   //   assign iBus_rsp_error = 1'b0;

   wire                      dBus_cmd_valid;
   wire                      dBus_cmd_ready;
   wire                      dBus_cmd_payload_wr;
   wire [31:0]               dBus_cmd_payload_address;
   wire [31:0]               dBus_cmd_payload_data;
   wire [1:0]                dBus_cmd_payload_size;
   wire                      dBus_rsp_ready;
   wire                      dBus_rsp_error;
   wire [31:0]               dBus_rsp_data;


   //   reg              proc_interrupt;

   //   assign dBus_rsp_error = 1'b0;

   wire                      dma_0_config_valid;
   wire                      dma_0_config_ready;
   wire [31:0]               dma_0_config_payload_startAddr;
   wire [31:0]               dma_0_config_payload_length;
   wire [31:0]               dma_0_config_payload_timerInit;
   wire                      dma_0_config_payload_reverse;
   wire                      dma_0_config_payload_last_or_run_till_last;
   wire                      dma_0_dmaReset;
   wire [31:0]               dma_0_status;
   wire                      dma_0_interrupt;
   wire                      dma_0_interrupt_clear;

   wire                      dma_1_config_valid;
   wire                      dma_1_config_ready;
   wire [31:0]               dma_1_config_payload_startAddr;
   wire [31:0]               dma_1_config_payload_length;
   wire [31:0]               dma_1_config_payload_timerInit;
   wire [31:0]               dma_1_config_payload_slicer;
   wire                      dma_1_config_payload_reverse;
   wire                      dma_1_config_payload_last_or_run_till_last;
   wire [3:0]                dma_1_config_payload_demapper_constellation;
   wire [15:0]               dma_1_config_payload_demapper_two_over_sigma_sq;
   wire                      dma_1_dmaReset;
   wire [31:0]               dma_1_status;
   wire                      dma_1_interrupt;
   wire                      dma_1_interrupt_clear;

   wire                      dma_2_config_valid;
   wire                      dma_2_config_ready;
   wire [31:0]               dma_2_config_payload_startAddr;
   wire [31:0]               dma_2_config_payload_length;
   wire [31:0]               dma_2_config_payload_timerInit;
   wire                      dma_2_config_payload_reverse;
   wire                      dma_2_config_payload_last_or_run_till_last;
   wire                      dma_2_dmaReset;
   wire [31:0]               dma_2_status;
   wire                      dma_2_interrupt;
   wire                      dma_2_interrupt_clear;

   wire                      dma_3_config_valid;
   wire                      dma_3_config_ready;
   wire [31:0]               dma_3_config_payload_startAddr;
   wire [31:0]               dma_3_config_payload_length;
   wire [31:0]               dma_3_config_payload_timerInit;
   wire                      dma_3_config_payload_reverse;
   wire                      dma_3_config_payload_last_or_run_till_last;
   wire                      dma_3_dmaReset;
   wire [31:0]               dma_3_status;
   wire                      dma_3_interrupt;
   wire                      dma_3_interrupt_clear;

   wire                      dma_4_config_valid;
   wire                      dma_4_config_ready;
   wire [31:0]               dma_4_config_payload_startAddr;
   wire [31:0]               dma_4_config_payload_length;
   wire [31:0]               dma_4_config_payload_timerInit;
   wire                      dma_4_config_payload_reverse;
   wire                      dma_4_config_payload_last_or_run_till_last;
   wire                      dma_4_dmaReset;
   wire [31:0]               dma_4_status;
   wire                      dma_4_interrupt;
   wire                      dma_4_interrupt_clear;


   reg                       timerInterrupt;
   reg                       debug_bus_cmd_valid;
   reg                       debug_bus_cmd_ready;
   reg                       debug_bus_cmd_payload_wr;
   reg [7:0]                 debug_bus_cmd_payload_address;
   reg [31:0]                debug_bus_cmd_payload_data;
   reg [31:0]                debug_bus_rsp_data;
   reg                       debug_resetOut;

   wire                      xbaseband_cmd_valid;
   wire                      xbaseband_cmd_ready;
   wire [31:0]               xbaseband_cmd_payload_instruction;
   wire [31:0]               xbaseband_cmd_payload_rs1;


   wire                      ringbus_0_interrupt_clear;
   wire [31:0]               ringbus_0_write_data;
   wire [31:0]               ringbus_0_write_addr;
   wire                      ringbus_0_write_done;
   wire                      ringbus_0_write_en;
   wire [31:0]               ringbus_0_read_data;
   wire                      ringbus_0_read_valid;
   wire                      ringbus_0_read_ready;
   wire                      ringbus_0_interrupt;
   wire                      ringbus_0_rd_of;
   wire                      ringbus_0_write_ready;

   wire                      ringbus_1_interrupt_clear;
   wire [31:0]               ringbus_1_write_data;
   wire [31:0]               ringbus_1_write_addr;
   wire                      ringbus_1_write_done;
   wire                      ringbus_1_write_en;
   wire [31:0]               ringbus_1_read_data;
   wire                      ringbus_1_read_valid;
   wire                      ringbus_1_read_ready;
   wire                      ringbus_1_interrupt;
   wire                      ringbus_1_rd_of;
   wire                      ringbus_1_write_ready;

   wire [21:0]               gpio_read;
   wire [21:0]               gpio_write;
   wire [21:0]               gpio_writeEnable;

   wire [31:0]               interrupt_mask;
   wire                      interrupt_clear;
   wire [31:0]               interrupt_interruptVector;
   wire [31:0]               interrupt_serviceInterrupt;
   wire [31:0]               timerCsr_gtimer;

   wire [17:0]               i0_scalar_vmem_addr;
   wire [31:0]               i0_scalar_vmem_data;
   wire                      i0_scalar_vmem_we;
   wire                      i0_scalar_vmem_valid;
   wire                      i0_scalar_vmem_ready;
   wire [31:0]               t0_scalar_vmem_data;
   wire                      t0_scalar_vmem_valid;
   
   wire                      nco_ncoReset;
   wire                      nco_busy;
   wire                      nco_config_valid;
   wire                      nco_config_ready;
   wire [31:0]               nco_config_payload_startAngle;
   wire [31:0]               nco_config_payload_delta;
   wire [31:0]               nco_config_payload_length;
   
   wire [3:0]                dBus_cmd_payload_mask;
   wire [9:0]                gpio_discard;

   wire [31:0]               config_payload_slice;

//   wire [3:0]                demapper_constellation;
//   wire [15:0]               demapper_two_over_sigma_sq;
   



`define CUSTOM_VERILATOR_PUBLIC_32(sig) function[31:0] get_``sig``; /*verilator public*/   begin   get_``sig`` = sig;   end endfunction
`define CUSTOM_VERILATOR_PUBLIC(sig) function[1:0] get_``sig``; /*verilator public*/   begin   get_``sig`` = sig;   end endfunction

`ifdef VERILATE_DEF
   `CUSTOM_VERILATOR_PUBLIC(xbaseband_cmd_valid)
   `CUSTOM_VERILATOR_PUBLIC(xbaseband_cmd_ready)
   `CUSTOM_VERILATOR_PUBLIC_32(xbaseband_cmd_payload_instruction)
   `CUSTOM_VERILATOR_PUBLIC_32(xbaseband_cmd_payload_rs1)
   `CUSTOM_VERILATOR_PUBLIC_32(iBus_cmd_payload_pc)
`endif





   generate if (!NO_RISCV) begin: VexRiscv
      XbbRiscv VexRiscv 
        (
         .io_asyncReset(srst),
         .io_mainClk(clk),
         
         .iBus_cmd_valid(iBus_cmd_valid),
         .iBus_cmd_ready(iBus_cmd_ready),
         .iBus_cmd_payload_pc(iBus_cmd_payload_pc),
         .iBus_rsp_ready(iBus_rsp_ready),
         .iBus_rsp_error(iBus_rsp_error),
         .iBus_rsp_inst(iBus_rsp_inst),
`ifdef EXTRA_RINGBUS      
         .io_externalInterrupt({ringbus_1_interrupt,1'b0,dma_2_interrupt,ringbus_0_interrupt,dma_1_interrupt,dma_0_interrupt}),
`else
         .io_externalInterrupt({2'b0,dma_2_interrupt,ringbus_0_interrupt,dma_1_interrupt,dma_0_interrupt}),
`endif
         .jtag_tms(jtag_tms),
         .jtag_tdi(jtag_tdi),
         .jtag_tdo(jtag_tdo),
         .jtag_tck(jtag_tck),

         //uart
         .io_uart_txd(io_uart_txd),
         .io_uart_rxd(io_uart_rxd),
         
         .scalarMemBus_cmd_valid(dBus_cmd_valid),
         .scalarMemBus_cmd_ready(dBus_cmd_ready),
         .scalarMemBus_cmd_payload_wr(dBus_cmd_payload_wr),
         .scalarMemBus_cmd_payload_address(dBus_cmd_payload_address),
         .scalarMemBus_cmd_payload_data(dBus_cmd_payload_data),
         .scalarMemBus_cmd_payload_mask(dBus_cmd_payload_mask),
         .scalarMemBus_rsp_valid(dBus_rsp_ready),
         .scalarMemBus_rsp_payload_data(dBus_rsp_data),
         
         .io_vmemBus_cmd_valid(i0_scalar_vmem_valid),
         .io_vmemBus_cmd_ready(i0_scalar_vmem_ready),
         .io_vmemBus_cmd_payload_wr(i0_scalar_vmem_we),
         .io_vmemBus_cmd_payload_address(i0_scalar_vmem_addr),
         .io_vmemBus_cmd_payload_data(i0_scalar_vmem_data),
         .io_vmemBus_cmd_payload_mask(),
         .io_vmemBus_rsp_valid(t0_scalar_vmem_valid),
         .io_vmemBus_rsp_payload_data(t0_scalar_vmem_data),
         
         .xbaseband_cmd_valid(xbaseband_cmd_valid),
         .xbaseband_cmd_ready(xbaseband_cmd_ready | ~xbaseband_cmd_valid),
         .xbaseband_cmd_payload_instruction(xbaseband_cmd_payload_instruction),
         .xbaseband_cmd_payload_rs1(xbaseband_cmd_payload_rs1),
         
         .dma_0_dmaReset(dma_0_dmaReset),
         .dma_0_status(dma_0_status),
         .dma_0_interrupt_clear(dma_0_interrupt_clear),
         .dma_0_config_valid(dma_0_config_valid),
         .dma_0_config_ready(dma_0_config_ready),
         .dma_0_config_payload_startAddr(dma_0_config_payload_startAddr),
         .dma_0_config_payload_length(dma_0_config_payload_length),
         .dma_0_config_payload_timerInit(dma_0_config_payload_timerInit),
         .dma_0_config_payload_reverse(dma_0_config_payload_reverse),
         .dma_0_config_payload_last_or_run_till_last(dma_0_config_payload_last_or_run_till_last),
         
         .dma_1_dmaReset(dma_1_dmaReset),
         .dma_1_status(dma_1_status),
         .dma_1_interrupt_clear(dma_1_interrupt_clear),
         .dma_1_config_valid(dma_1_config_valid),
         .dma_1_config_ready(dma_1_config_ready),
         .dma_1_config_payload_startAddr(dma_1_config_payload_startAddr),
         .dma_1_config_payload_length(dma_1_config_payload_length),
         .dma_1_config_payload_timerInit(dma_1_config_payload_timerInit),
         .dma_1_config_payload_slicer(dma_1_config_payload_slicer),
         .dma_1_config_payload_reverse(dma_1_config_payload_reverse),
         .dma_1_config_payload_last_or_run_till_last(dma_1_config_payload_last_or_run_till_last),
         .dma_1_config_payload_demapper_constellation(dma_1_config_payload_demapper_constellation),
         .dma_1_config_payload_demapper_two_over_sigma_sq(dma_1_config_payload_demapper_two_over_sigma_sq),
         
         .dma_2_dmaReset(dma_2_dmaReset),
         .dma_2_status(dma_2_status),
         .dma_2_interrupt_clear(dma_2_interrupt_clear),
         .dma_2_config_valid(dma_2_config_valid),
         .dma_2_config_ready(dma_2_config_ready),
         .dma_2_config_payload_startAddr(dma_2_config_payload_startAddr),
         .dma_2_config_payload_length(dma_2_config_payload_length),
         .dma_2_config_payload_timerInit(dma_2_config_payload_timerInit),
         .dma_2_config_payload_reverse(dma_2_config_payload_reverse),
         .dma_2_config_payload_last_or_run_till_last(dma_2_config_payload_last_or_run_till_last),

         .dma_3_dmaReset(dma_3_dmaReset),
         .dma_3_status(dma_3_status),
         .dma_3_interrupt_clear(dma_3_interrupt_clear),
         .dma_3_config_valid(dma_3_config_valid),
         .dma_3_config_ready(dma_3_config_ready),
         .dma_3_config_payload_startAddr(dma_3_config_payload_startAddr),
         .dma_3_config_payload_length(dma_3_config_payload_length),
         .dma_3_config_payload_timerInit(dma_3_config_payload_timerInit),
         .dma_3_config_payload_reverse(dma_3_config_payload_reverse),
         .dma_3_config_payload_last_or_run_till_last(dma_3_config_payload_last_or_run_till_last),

         .dma_4_dmaReset(dma_4_dmaReset),
         .dma_4_status(dma_4_status),
         .dma_4_interrupt_clear(dma_4_interrupt_clear),
         .dma_4_config_valid(dma_4_config_valid),
         .dma_4_config_ready(dma_4_config_ready),
         .dma_4_config_payload_startAddr(dma_4_config_payload_startAddr),
         .dma_4_config_payload_length(dma_4_config_payload_length),
         .dma_4_config_payload_timerInit(dma_4_config_payload_timerInit),
         .dma_4_config_payload_reverse(dma_4_config_payload_reverse),
         .dma_4_config_payload_last_or_run_till_last(dma_4_config_payload_last_or_run_till_last),
         
         .io_timerStatus_gtimer(timerCsr_gtimer),
         
         .ringbus_0_interrupt_clear(ringbus_0_interrupt_clear),
         .ringbus_0_config_valid(ringbus_0_write_en),
         .ringbus_0_config_ready(ringbus_0_write_ready),
         .ringbus_0_config_payload_write_data(ringbus_0_write_data),
         .ringbus_0_config_payload_write_addr(ringbus_0_write_addr),
         .ringbus_0_read_payload_read_data(ringbus_0_read_data),
         .ringbus_0_read_valid(ringbus_0_read_valid),
         .ringbus_0_read_ready(ringbus_0_read_ready),
         .ringbus_0_write_done(ringbus_0_write_done),

         .ringbus_1_interrupt_clear(ringbus_1_interrupt_clear),
         .ringbus_1_config_valid(ringbus_1_write_en),
         .ringbus_1_config_ready(ringbus_1_write_ready),
         .ringbus_1_config_payload_write_data(ringbus_1_write_data),
         .ringbus_1_config_payload_write_addr(ringbus_1_write_addr),
         .ringbus_1_read_payload_read_data(ringbus_1_read_data),
         .ringbus_1_read_valid(ringbus_1_read_valid),
         .ringbus_1_read_ready(ringbus_1_read_ready),
         .ringbus_1_write_done(ringbus_1_write_done),

         .nco_ncoReset(nco_ncoReset),
         .nco_busy(nco_busy),
         .nco_config_valid(nco_config_valid),
         .nco_config_ready(nco_config_ready),
         .nco_config_payload_startAngle(nco_config_payload_startAngle),
         .nco_config_payload_delta(nco_config_payload_delta),
         .nco_config_payload_length(nco_config_payload_length),

         .mapmov_mover_active(mapmov_mover_active),
         .mapmov_trim_start(mapmov_trim_start),
         .mapmov_trim_end(mapmov_trim_end),
         .mapmov_pilot_ram_addr(mapmov_pilot_ram_addr),
         .mapmov_pilot_ram_wdata(mapmov_pilot_ram_wdata),
         .mapmov_pilot_ram_we(mapmov_pilot_ram_we),
         .mapmov_reset(mapmov_reset),
         .mapmov_one_value(mapmov_one_value),
         .mapmov_zero_value(mapmov_zero_value),

/* -----\/----- EXCLUDED -----\/-----
         .demapper_constellation(demapper_constellation),
         .demapper_two_over_sigma_sq(demapper_two_over_sigma_sq),
 -----/\----- EXCLUDED -----/\----- */
         
         .satDetect_satDetect(sat_detect),
         .control_control(control),
         .status_status(status),
         .slicer_value(config_payload_slice),
         .io_gpio({gpio_discard,gpio})
         );
   end else begin
      assign ringbus_0_interrupt_clear=1'b1;
      assign ringbus_1_interrupt_clear=1'b1;
   end endgenerate // else: !if(!NO_RISCV)

   scalar_memory
     #(.AWIDTH     (AWIDTH),
       .DEPTH      (DEPTH),
       .SCALAR_MEM_0(SCALAR_MEM_0),
       .SCALAR_MEM_1 (SCALAR_MEM_1),
       .SCALAR_MEM_2 (SCALAR_MEM_2),
       .SCALAR_MEM_3 (SCALAR_MEM_3)

       ) 
   mem (
        .clk        (clk),
        .srst       (srst),
        .t0_valid   (iBus_cmd_valid),
        .t0_ready   (iBus_cmd_ready),
        .t0_we      (1'b0),
        .t0_mask    (4'h0),
        .t0_addr    (iBus_cmd_payload_pc),
        .t0_data    (32'b0),

        .i0_valid   (iBus_rsp_ready),
        .i0_ready   (1'b1),
        .i0_data    (iBus_rsp_inst),
      
        .t1_valid   (dBus_cmd_valid),
        .t1_ready   (dBus_cmd_ready),
        .t1_we      (dBus_cmd_payload_wr),
        .t1_mask    (dBus_cmd_payload_mask),
        .t1_addr    (dBus_cmd_payload_address),
        .t1_data    (dBus_cmd_payload_data),
      
        .i1_valid   (dBus_rsp_ready),
        .i1_ready   (1'b1),
        .i1_data    (dBus_rsp_data)
        );

   wire [15:0]           i0_dma_in_addr;
   wire [31:0]           i0_dma_in_data;
   wire                  i0_dma_in_valid;
   wire                  i0_dma_in_ready;
   
   wire                  t0_mem0_ready;

   wire [31:0]           intr_vector;
   
   dma_in dma_in_0
     (.clk(clk),
      .srst(srst),
      .config_valid(dma_0_config_valid),
      .config_ready(dma_0_config_ready),
      .config_payload_startAddr(dma_0_config_payload_startAddr),
      .config_payload_length(dma_0_config_payload_length),
      .config_payload_timerInit(dma_0_config_payload_timerInit),
      .config_payload_reverse(dma_0_config_payload_reverse),
      .config_payload_run_till_last(dma_0_config_payload_last_or_run_till_last),
      .dmaReset(dma_0_dmaReset),
      .ctimer(timerCsr_gtimer),
      //.busy(dma_0_status_busy),
      .t0_data(t0_data),//32'hA55A1234),//t0_data),
      .t0_last(t0_last),
      .t0_valid(t0_valid),
      .t0_ready(t0_ready),
      //mem port
      .i0_addr(i0_dma_in_addr),//t_crossbar_addr[0]),
      .i0_data(i0_dma_in_data),//t_crossbar_data[0]),
      .i0_valid(i0_dma_in_valid),//t_crossbar_valid[0]),
      .i0_ready(i0_dma_in_ready),//t_crossbar_ready[0]),
      .status(dma_0_status),
      .strobe_complete(intr_vector[0]),
      .interrupt(dma_0_interrupt),
      .interrupt_clear(dma_0_interrupt_clear)
      );
   

   wire [31:0]           i0_dma_out_data;
   wire                  i0_dma_out_last;
   wire                  i0_dma_out_valid;
   wire                  i0_dma_out_ready;

   wire [15:0]           i1_dma_out_addr;
   wire                  i1_dma_out_valid;
   wire                  i1_dma_out_ready;

   
   wire [31:0]           t0_dma_out_data;
   wire                  t0_dma_out_valid;
   
   
   wire                  t0_mem1_ready;

   wire                  slicer_config_valid;
   wire                  slicer_busy;

   wire [31:0]           i0_demapper_data;
   wire                  i0_demapper_last;
   wire                  i0_demapper_valid;
   wire                  i0_demapper_ready;

   
   slicer slicer_0
     (
      .clk(clk),
      .srst(srst),
      .config_payload_slice(dma_1_config_payload_slicer),//config_payload_slice),
      .config_payload_length(dma_1_config_payload_length),
      .config_payload_demapper_constellation(dma_1_config_payload_demapper_constellation),
      .config_valid(slicer_config_valid),
      .slicer_busy(slicer_busy),
      .dmaReset(dma_1_dmaReset),
      //.config_payload_slice(config_payload_slice),
      // t0 stream -> comes from demapper
      .t0_data(i0_demapper_data),
      .t0_last(i0_demapper_last),
      .t0_valid(i0_demapper_valid),
      .t0_ready(i0_demapper_ready),
      //outputs -> goes to other modules through crossbar
      .i0_data(i0_data),
      .i0_last(i0_last),
      .i0_valid(i0_valid),
      .i0_ready(i0_ready)
      );

   demapper demapper_0
     (.t_data(i0_dma_out_data),
      .t_last(i0_dma_out_last),
      .t_valid(i0_dma_out_valid),
      .t_ready(i0_dma_out_ready),
      .i_data(i0_demapper_data),
      .i_last(i0_demapper_last),
      .i_valid(i0_demapper_valid),
      .i_ready(i0_demapper_ready),
      .constellation(dma_1_config_payload_demapper_constellation),
      .two_over_sigma_sq(dma_1_config_payload_demapper_two_over_sigma_sq),
      .clk(clk),
      .rstf(~srst)
      );
   
   
   dma_out dma_out_0
     (.clk(clk),
      .srst(srst),
      .config_valid(dma_1_config_valid),
      .config_ready(dma_1_config_ready),
      .config_payload_startAddr(dma_1_config_payload_startAddr),
      .config_payload_length(dma_1_config_payload_length),
      .config_payload_timerInit(dma_1_config_payload_timerInit),
      .config_payload_reverse(dma_1_config_payload_reverse),
      .config_payload_last(dma_1_config_payload_last_or_run_till_last),
      .slicer_config_valid(slicer_config_valid),
      .slicer_busy(slicer_busy),
      //      .config_payload_slicer(dma_1_config_payload_slicer),
      .dmaReset(dma_1_dmaReset),
      .ctimer(timerCsr_gtimer),
      // t0 stream -> comes from memory
      .t0_data       (t0_dma_out_data),//i_data[1]),
      .t0_valid      (t0_dma_out_valid),//i_valid[1]),
      .t0_ready      (),
      //outputs -> goes to other modules through crossbar
      .i1_data    (i0_dma_out_data),
      .i1_last    (i0_dma_out_last),
      .i1_valid      (i0_dma_out_valid),
      .i1_ready      (i0_dma_out_ready),
      //mem port
      .i0_addr(i1_dma_out_addr),//t_crossbar_addr[1]),
      .i0_valid(i1_dma_out_valid),//t_crossbar_valid[1]),
      .i0_ready(i1_dma_out_ready),//t_crossbar_ready[1]),
      .status(dma_1_status),
      .strobe_complete(intr_vector[1]),
      .interrupt(dma_1_interrupt),
      .interrupt_clear(dma_1_interrupt_clear)
      );

   wire [15:0]           i0_dma_nco_addr;
   wire [31:0]           i0_dma_nco_data;
   wire                  i0_dma_nco_valid;
   wire                  i0_dma_nco_ready;

   wire [31:0]           i_nco_data;
   wire                  i_nco_valid;
   wire                  i_nco_ready;
   
`ifndef NO_NCO
   
   nco_gen nco_gen_inst
     (.config_payload_startAngle(nco_config_payload_startAngle),
      .config_payload_delta(nco_config_payload_delta),
      .config_payload_length(nco_config_payload_length),
      .config_valid(nco_config_valid),
      .config_ready(nco_config_ready),

      .ncoReset(nco_ncoReset),
      .busy(nco_busy),

      .i_nco_data(i_nco_data),
      .i_nco_valid(i_nco_valid),
      .i_nco_ready(i_nco_ready),
      .clk(clk),
      .srst(srst)
      );
   

   dma_in dma_in_2
     (.clk(clk),
      .srst(srst),
      .config_valid(dma_2_config_valid),
      .config_ready(dma_2_config_ready),
      .config_payload_startAddr(dma_2_config_payload_startAddr),
      .config_payload_length(dma_2_config_payload_length),
      .config_payload_timerInit(dma_2_config_payload_timerInit),
      .config_payload_reverse(dma_2_config_payload_reverse),
      .config_payload_run_till_last(1'b0),//dma_2_config_payload_last_or_run_till_last),
      .dmaReset(dma_2_dmaReset),
      .ctimer(timerCsr_gtimer),
      //t0
      .t0_data(i_nco_data),
      .t0_last(1'b0),
      .t0_valid(i_nco_valid),
      .t0_ready(i_nco_ready),
      //mem port
      .i0_addr(i0_dma_nco_addr),//t_crossbar_addr[0]),
      .i0_data(i0_dma_nco_data),//t_crossbar_data[0]),
      .i0_valid(i0_dma_nco_valid),//t_crossbar_valid[0]),
      .i0_ready(i0_dma_nco_ready),//t_crossbar_ready[0]),
      .status(dma_2_status),
      .strobe_complete(intr_vector[0]),
      .interrupt(dma_2_interrupt),
      .interrupt_clear(dma_2_interrupt_clear)
      );

`endif

   // FIR filter: DMA_3 streams VMEM -> fir_filter (piston DMA port 4, reads),
   // DMA_4 streams fir_filter -> VMEM (piston DMA port 5, writes). Ports 4/5
   // exist only on the Xilinx 6-DMA VMEM; elsewhere the CSRs are tied off.
   wire [31:0]           i0_dma_firrd_addr;
   wire                  i0_dma_firrd_valid;
   wire                  i0_dma_firrd_ready;
   wire [31:0]           t0_dma_firrd_data;
   wire                  t0_dma_firrd_valid;
   wire                  t0_dma_firrd_ready;
   wire [31:0]           i0_dma_firwr_addr;
   wire [31:0]           i0_dma_firwr_data;
   wire                  i0_dma_firwr_valid;
   wire                  i0_dma_firwr_ready;

`ifdef HIGGS_FPGA_XILINX
`ifndef NO_FIR
   `define Q_ENGINE_HAS_FIR
`endif
`endif

`ifdef Q_ENGINE_HAS_FIR
   // Phase 2 (doc/add-fir/PLAN.md): DMA_3 -> router -> {port0 FIR, port1 xcorr}
   // -> merge (tag word per packet) -> DMA_4.  stream_stall shims are wires
   // unless QSTREAM_STALL_INJECT is defined (simulation only).
   wire [31:0]           i_dma3_data;
   wire                  i_dma3_last;
   wire                  i_dma3_valid;
   wire                  i_dma3_ready;
   wire [31:0]           i_rtin_data;
   wire                  i_rtin_last;
   wire                  i_rtin_valid;
   wire                  i_rtin_ready;
   wire [2*32-1:0]       i_rt_data;
   wire [1:0]            i_rt_last;
   wire [1:0]            i_rt_valid;
   wire [1:0]            i_rt_ready;
   wire [31:0]           i_firfeed_data;
   wire                  i_firfeed_last;
   wire                  i_firfeed_valid;
   wire                  i_firfeed_ready;
   wire [31:0]           i_firout_data;
   wire                  i_firout_last;
   wire                  i_firout_valid;
   wire                  i_firout_ready;
   wire [2*32-1:0]       i_mg_data;
   wire [1:0]            i_mg_last;
   wire [1:0]            i_mg_valid;
   wire [1:0]            i_mg_ready;
   wire [31:0]           i_mgout_data;
   wire                  i_mgout_last;
   wire                  i_mgout_valid;
   wire                  i_mgout_ready;
   wire [31:0]           i_fir_data;
   wire                  i_fir_last;
   wire                  i_fir_valid;
   wire                  i_fir_ready;
   wire [2:0]            fir_err;
   wire                  router_err;

   dma_out_last dma_out_3
     (.clk(clk),
      .srst(srst),
      .ctimer(timerCsr_gtimer),
      .config_valid(dma_3_config_valid),
      .config_ready(dma_3_config_ready),
      .config_payload_startAddr(dma_3_config_payload_startAddr),
      .config_payload_length(dma_3_config_payload_length),
      .config_payload_timerInit(dma_3_config_payload_timerInit),
      .config_payload_reverse(dma_3_config_payload_reverse),
      .config_payload_last(dma_3_config_payload_last_or_run_till_last),
      .dmaReset(dma_3_dmaReset),
      .status(dma_3_status),
      .strobe_complete(),
      .interrupt(dma_3_interrupt),
      .interrupt_clear(dma_3_interrupt_clear),
      .t0_data(t0_dma_firrd_data),
      .t0_valid(t0_dma_firrd_valid),
      .t0_ready(t0_dma_firrd_ready),
      .i0_addr(i0_dma_firrd_addr),
      .i0_valid(i0_dma_firrd_valid),
      .i0_ready(i0_dma_firrd_ready),
      .i1_data(i_dma3_data),
      .i1_last(i_dma3_last),
      .i1_valid(i_dma3_valid),
      .i1_ready(i_dma3_ready)
      );

   stream_stall #(.SALT(1)) stall_rtin
     (.clk(clk), .srst(srst),
      .t_data(i_dma3_data), .t_last(i_dma3_last),
      .t_valid(i_dma3_valid), .t_ready(i_dma3_ready),
      .i_data(i_rtin_data), .i_last(i_rtin_last),
      .i_valid(i_rtin_valid), .i_ready(i_rtin_ready));

   stream_router #(.N(2)) stream_router_inst
     (.clk(clk),
      .srst(srst),
      .t_data(i_rtin_data),
      .t_last(i_rtin_last),
      .t_valid(i_rtin_valid),
      .t_ready(i_rtin_ready),
      .i_data(i_rt_data),
      .i_last(i_rt_last),
      .i_valid(i_rt_valid),
      .i_ready(i_rt_ready),
      .err(router_err),
      .err_clear(1'b0)
      );

   // ---- port 0: FIR
   stream_stall #(.SALT(2)) stall_firin
     (.clk(clk), .srst(srst),
      .t_data(i_rt_data[31:0]), .t_last(i_rt_last[0]),
      .t_valid(i_rt_valid[0]), .t_ready(i_rt_ready[0]),
      .i_data(i_firfeed_data), .i_last(i_firfeed_last),
      .i_valid(i_firfeed_valid), .i_ready(i_firfeed_ready));

   fir_filter #(.NTAPS(16)) fir_filter_inst
     (.clk(clk),
      .srst(srst),
      .t_data(i_firfeed_data),
      .t_last(i_firfeed_last),
      .t_valid(i_firfeed_valid),
      .t_ready(i_firfeed_ready),
      .i_data(i_firout_data),
      .i_last(i_firout_last),
      .i_valid(i_firout_valid),
      .i_ready(i_firout_ready),
      .err(fir_err),
      .err_clear(1'b0)
      );

   stream_stall #(.SALT(3)) stall_firout
     (.clk(clk), .srst(srst),
      .t_data(i_firout_data), .t_last(i_firout_last),
      .t_valid(i_firout_valid), .t_ready(i_firout_ready),
      .i_data(i_mg_data[31:0]), .i_last(i_mg_last[0]),
      .i_valid(i_mg_valid[0]), .i_ready(i_mg_ready[0]));

   // ---- port 1: FFT overlap-save cross-correlator (N = 256)
   wire [31:0]           i_xcfeed_data;
   wire                  i_xcfeed_last;
   wire                  i_xcfeed_valid;
   wire                  i_xcfeed_ready;
   wire [31:0]           i_xcout_data;
   wire                  i_xcout_last;
   wire                  i_xcout_valid;
   wire                  i_xcout_ready;
   wire [2:0]            xcorr_err;

   stream_stall #(.SALT(4)) stall_xcin
     (.clk(clk), .srst(srst),
      .t_data(i_rt_data[63:32]), .t_last(i_rt_last[1]),
      .t_valid(i_rt_valid[1]), .t_ready(i_rt_ready[1]),
      .i_data(i_xcfeed_data), .i_last(i_xcfeed_last),
      .i_valid(i_xcfeed_valid), .i_ready(i_xcfeed_ready));

   fft_corr #(.N(256)) fft_corr_inst
     (.clk(clk),
      .srst(srst),
      .t_data(i_xcfeed_data),
      .t_last(i_xcfeed_last),
      .t_valid(i_xcfeed_valid),
      .t_ready(i_xcfeed_ready),
      .i_data(i_xcout_data),
      .i_last(i_xcout_last),
      .i_valid(i_xcout_valid),
      .i_ready(i_xcout_ready),
      .err(xcorr_err),
      .err_clear(1'b0)
      );

   stream_stall #(.SALT(5)) stall_xcout
     (.clk(clk), .srst(srst),
      .t_data(i_xcout_data), .t_last(i_xcout_last),
      .t_valid(i_xcout_valid), .t_ready(i_xcout_ready),
      .i_data(i_mg_data[63:32]), .i_last(i_mg_last[1]),
      .i_valid(i_mg_valid[1]), .i_ready(i_mg_ready[1]));

   stream_merge #(.N(2)) stream_merge_inst
     (.clk(clk),
      .srst(srst),
      .t_data(i_mg_data),
      .t_last(i_mg_last),
      .t_valid(i_mg_valid),
      .t_ready(i_mg_ready),
      .i_data(i_mgout_data),
      .i_last(i_mgout_last),
      .i_valid(i_mgout_valid),
      .i_ready(i_mgout_ready)
      );

   stream_stall #(.SALT(6)) stall_mgout
     (.clk(clk), .srst(srst),
      .t_data(i_mgout_data), .t_last(i_mgout_last),
      .t_valid(i_mgout_valid), .t_ready(i_mgout_ready),
      .i_data(i_fir_data), .i_last(i_fir_last),
      .i_valid(i_fir_valid), .i_ready(i_fir_ready));

   dma_in dma_in_4
     (.clk(clk),
      .srst(srst),
      .config_valid(dma_4_config_valid),
      .config_ready(dma_4_config_ready),
      .config_payload_startAddr(dma_4_config_payload_startAddr),
      .config_payload_length(dma_4_config_payload_length),
      .config_payload_timerInit(dma_4_config_payload_timerInit),
      .config_payload_reverse(dma_4_config_payload_reverse),
      .config_payload_run_till_last(1'b0),
      .dmaReset(dma_4_dmaReset),
      .ctimer(timerCsr_gtimer),
      .t0_data(i_fir_data),
      .t0_last(i_fir_last),
      .t0_valid(i_fir_valid),
      .t0_ready(i_fir_ready),
      .i0_addr(i0_dma_firwr_addr),
      .i0_data(i0_dma_firwr_data),
      .i0_valid(i0_dma_firwr_valid),
      .i0_ready(i0_dma_firwr_ready),
      .status(dma_4_status),
      .strobe_complete(),
      .interrupt(dma_4_interrupt),
      .interrupt_clear(dma_4_interrupt_clear)
      );
`else
   assign dma_3_config_ready = 1'b1;
   assign dma_3_status = 32'h0;
   assign dma_3_interrupt = 1'b0;
   assign dma_4_config_ready = 1'b1;
   assign dma_4_status = 32'h0;
   assign dma_4_interrupt = 1'b0;
   assign i0_dma_firrd_addr = 32'h0;
   assign i0_dma_firrd_valid = 1'b0;
   assign t0_dma_firrd_ready = 1'b1;
   assign i0_dma_firwr_addr = 32'h0;
   assign i0_dma_firwr_data = 32'h0;
   assign i0_dma_firwr_valid = 1'b0;
`endif
`undef Q_ENGINE_HAS_FIR


   wire [3*32-1:0]       t_piston_payload_data;
   wire [3*16-1:0]       t_piston_payload_addr;
   wire [2:0]            t_piston_payload_we;
   wire [2:0]            t_piston_valid;
   wire [2:0]            t_piston_ready;

   wire [3*32-1:0]       i_piston_payload_data;
   wire [2:0]            i_piston_valid;

   /*   assign t_piston_payload_data={i0_scalar_vmem_data,32'b0,i0_dma_in_data};
    assign t_piston_payload_addr={i0_scalar_vmem_addr,i1_dma_out_addr,i0_dma_in_addr};
    assign t_piston_payload_we={i0_scalar_vmem_we,1'b0,1'b1};
    assign t_piston_valid={i0_scalar_vmem_valid,i0_dma_out_valid,i0_dma_in_valid};
    
    assign i0_dma_in_ready=t_piston_ready[0];
    assign i0_dma_out_ready=t_piston_ready[1];
    assign i0_scalar_vmem_ready=t_piston_ready[2];


    assign t0_dma_out_data=i_piston_payload_data[32*2-1:32*1];
    assign t0_scalar_vmem_data=i_piston_payload_data[32*3-1:32*2];

    assign t0_dma_out_valid=i_piston_valid[1];
    assign t0_scalar_vmem_valid=i_piston_valid[2];
    */   
   
   piston 
     #(.NODE28_VMEM_SIZE(VMEM_DEPTH),
       .NODE28_VMEM0(VMEM0),
       .NODE28_VMEM1(VMEM1),
       .NODE28_VMEM2(VMEM2),
       .NODE28_VMEM3(VMEM3),
       .NODE28_VMEM4(VMEM4),
       .NODE28_VMEM5(VMEM5),
       .NODE28_VMEM6(VMEM6),
       .NODE28_VMEM7(VMEM7),
       .NODE28_VMEM8(VMEM8),
       .NODE28_VMEM9(VMEM9),
       .NODE28_VMEM10(VMEM10),
       .NODE28_VMEM11(VMEM11),
       .NODE28_VMEM12(VMEM12),
       .NODE28_VMEM13(VMEM13),
       .NODE28_VMEM14(VMEM14),
       .NODE28_VMEM15(VMEM15),
       .NODE28_VMEM16(VMEM16),
       .NODE28_VMEM17(VMEM17),
       .NODE28_VMEM18(VMEM18),
       .NODE28_VMEM19(VMEM19),
       .NODE28_VMEM20(VMEM20),
       .NODE28_VMEM21(VMEM21),
       .NODE28_VMEM22(VMEM22),
       .NODE28_VMEM23(VMEM23),
       .NODE28_VMEM24(VMEM24),
       .NODE28_VMEM25(VMEM25),
       .NODE28_VMEM26(VMEM26),
       .NODE28_VMEM27(VMEM27),
       .NODE28_VMEM28(VMEM28),
       .NODE28_VMEM29(VMEM29),
       .NODE28_VMEM30(VMEM30),
       .NODE28_VMEM31(VMEM31)
       )
   piston_inst
     (.t_instr_dat({xbaseband_cmd_payload_rs1,xbaseband_cmd_payload_instruction}),
      .t_instr_req(xbaseband_cmd_valid),
      .t_instr_ack(xbaseband_cmd_ready),
      .t_idma_0_dat({1'b1,i0_dma_in_addr,i0_dma_in_data}),
      .t_idma_0_req(i0_dma_in_valid),
      .t_idma_0_ack(i0_dma_in_ready),
      .t_idma_1_dat({1'b0,i1_dma_out_addr,32'b0}),
      .t_idma_1_req(i1_dma_out_valid),
      .t_idma_1_ack(i1_dma_out_ready),
      .t_idma_2_dat({i0_scalar_vmem_we,i0_scalar_vmem_addr[17:2],i0_scalar_vmem_data}),
      .t_idma_2_req(i0_scalar_vmem_valid),
      .t_idma_2_ack(i0_scalar_vmem_ready),
      .t_idma_3_dat({1'b1,i0_dma_nco_addr,i0_dma_nco_data}),
      .t_idma_3_req(i0_dma_nco_valid),
      .t_idma_3_ack(i0_dma_nco_ready),
      .i_odma_0_dat(),
      .i_odma_0_req(),
      .i_odma_0_ack(1'b1),
      .i_odma_1_dat(t0_dma_out_data),
      .i_odma_1_req(t0_dma_out_valid),
      .i_odma_1_ack(1'b1),
      .i_odma_2_dat(t0_scalar_vmem_data),
      .i_odma_2_req(t0_scalar_vmem_valid),
      .i_odma_2_ack(1'b1),
      .i_odma_3_dat(),
      .i_odma_3_req(),
      .i_odma_3_ack(1'b1),
`ifdef HIGGS_FPGA_XILINX
      .t_idma_4_dat({1'b0,i0_dma_firrd_addr[15:0],32'b0}),
      .t_idma_4_req(i0_dma_firrd_valid),
      .t_idma_4_ack(i0_dma_firrd_ready),
      .t_idma_5_dat({1'b1,i0_dma_firwr_addr[15:0],i0_dma_firwr_data}),
      .t_idma_5_req(i0_dma_firwr_valid),
      .t_idma_5_ack(i0_dma_firwr_ready),
      .i_odma_4_dat(t0_dma_firrd_data),
      .i_odma_4_req(t0_dma_firrd_valid),
      .i_odma_4_ack(t0_dma_firrd_ready),
      .i_odma_5_dat(),
      .i_odma_5_req(),
      .i_odma_5_ack(1'b1),
`endif
      .clk(clk),
      .reset_n(~srst)
      );
   

   wire                  ringbus_0_buf_empty;
   wire                  ringbus_1_buf_empty;

   assign ringbus_0_interrupt = ~ringbus_0_buf_empty;
   assign ringbus_1_interrupt = ~ringbus_1_buf_empty;
   
   ring_bus ring_bus_inst
     (.i_sysclk(clk),         // 125 MHz
      .i_srst(srst),

      .i_wr_data(ringbus_0_write_data),
      .i_wr_addr(ringbus_0_write_addr),
      .o_done_wr(ringbus_0_write_done),
      .i_start_wr(ringbus_0_write_en),
      .o_write_ready(ringbus_0_write_ready),
      
      .o_rd_data(ringbus_0_read_data),
      .o_rd_valid(ringbus_0_read_valid),
      .i_rd_ready(ringbus_0_read_ready),
      .o_rd_buf_empty(ringbus_0_buf_empty),
      .o_rd_of(ringbus_0_rd_of),
      .i_clear_flags(ringbus_0_interrupt_clear), //clears all flags

      .o_serial_bus(o_ringbus_0),
      .i_serial_bus(i_ringbus_0)
      );

`ifdef EXTRA_RINGBUS
   ring_bus ring_bus_inst_2
     (.i_sysclk(clk),         // 125 MHz
      .i_srst(srst),

      .i_wr_data(ringbus_1_write_data),
      .i_wr_addr(ringbus_1_write_addr),
      .o_done_wr(ringbus_1_write_done),
      .i_start_wr(ringbus_1_write_en),
      .o_write_ready(ringbus_1_write_ready),
      
      .o_rd_data(ringbus_1_read_data),
      .o_rd_valid(ringbus_1_read_valid),
      .i_rd_ready(ringbus_1_read_ready),
      .o_rd_buf_empty(ringbus_1_buf_empty),
      .o_rd_of(ringbus_1_rd_of),
      .i_clear_flags(ringbus_1_interrupt_clear), //clears all flags

      .o_serial_bus(o_ringbus_1),
      .i_serial_bus(i_ringbus_1)
      );
`else // !`ifdef EXTRA_RINGBUS
   assign ringbus_1_buf_empty=1;
`endif //  `ifdef EXTRA_RINGBUS

endmodule
