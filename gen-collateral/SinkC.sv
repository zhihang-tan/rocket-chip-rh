// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

module SinkC(
  input         clock,
                reset,
                io_req_ready,
                io_c_valid,
  input  [2:0]  io_c_bits_opcode,
                io_c_bits_param,
                io_c_bits_size,
  input  [4:0]  io_c_bits_source,
  input  [31:0] io_c_bits_address,
  input  [63:0] io_c_bits_data,
  input         io_c_bits_corrupt,
  input  [2:0]  io_way,
  input         io_bs_adr_ready,
                io_rel_pop_valid,
  input  [5:0]  io_rel_pop_bits_index,
  input         io_rel_pop_bits_last,
  output        io_req_valid,
  output [2:0]  io_req_bits_opcode,
                io_req_bits_param,
                io_req_bits_size,
  output [4:0]  io_req_bits_source,
  output [11:0] io_req_bits_tag,
  output [5:0]  io_req_bits_offset,
                io_req_bits_put,
  output [9:0]  io_req_bits_set,
  output        io_resp_valid,
                io_resp_bits_last,
  output [9:0]  io_resp_bits_set,
  output [11:0] io_resp_bits_tag,
  output [4:0]  io_resp_bits_source,
  output [2:0]  io_resp_bits_param,
  output        io_resp_bits_data,
                io_c_ready,
  output [9:0]  io_set,
  output        io_bs_adr_valid,
                io_bs_adr_bits_noop,
  output [2:0]  io_bs_adr_bits_way,
  output [9:0]  io_bs_adr_bits_set,
  output [2:0]  io_bs_adr_bits_beat,
  output        io_bs_adr_bits_mask,
  output [63:0] io_bs_dat_data,
  output        io_rel_pop_ready,
  output [63:0] io_rel_beat_data,
  output        io_rel_beat_corrupt
);

  wire        _io_rel_pop_ready_output;	// @[SinkC.scala:160:43]
  wire        _putbuffer_io_push_ready;	// @[SinkC.scala:115:27]
  wire [1:0]  _putbuffer_io_valid;	// @[SinkC.scala:115:27]
  wire        _io_bs_adr_q_io_enq_ready;	// @[Decoupled.scala:375:21]
  wire        _c_io_deq_valid;	// @[Decoupled.scala:375:21]
  wire [2:0]  _c_io_deq_bits_opcode;	// @[Decoupled.scala:375:21]
  wire [2:0]  _c_io_deq_bits_param;	// @[Decoupled.scala:375:21]
  wire [2:0]  _c_io_deq_bits_size;	// @[Decoupled.scala:375:21]
  wire [4:0]  _c_io_deq_bits_source;	// @[Decoupled.scala:375:21]
  wire [31:0] _c_io_deq_bits_address;	// @[Decoupled.scala:375:21]
  wire [63:0] _c_io_deq_bits_data;	// @[Decoupled.scala:375:21]
  wire        _c_io_deq_bits_corrupt;	// @[Decoupled.scala:375:21]
  wire [12:0] _beats1_decode_T_1 = 13'h3F << _c_io_deq_bits_size;	// @[Decoupled.scala:375:21, package.scala:235:71]
  wire [2:0]  beats1 = _c_io_deq_bits_opcode[0] ? ~(_beats1_decode_T_1[5:3]) : 3'h0;	// @[Decoupled.scala:375:21, Edges.scala:102:36, :221:14, :229:27, package.scala:235:{46,71,76}]
  reg  [2:0]  counter;	// @[Edges.scala:229:27]
  wire [2:0]  counter1 = counter - 3'h1;	// @[Edges.scala:229:27, :230:28]
  wire        last = counter == 3'h1 | beats1 == 3'h0;	// @[Edges.scala:221:14, :229:27, :232:{25,33,43}]
  wire [2:0]  beat = beats1 & ~counter1;	// @[Edges.scala:221:14, :230:28, :234:{25,27}]
  wire        raw_resp = _c_io_deq_bits_opcode == 3'h4 | _c_io_deq_bits_opcode == 3'h5;	// @[Decoupled.scala:375:21, SinkC.scala:78:{34,58,75}]
  reg         resp_r;	// @[Reg.scala:19:16]
  wire        resp = _c_io_deq_valid ? raw_resp : resp_r;	// @[Decoupled.scala:375:21, Reg.scala:19:16, SinkC.scala:78:58, :79:19]
  reg  [9:0]  io_set_r;	// @[Reg.scala:19:16]
  wire [9:0]  _io_set_output = _c_io_deq_valid ? _c_io_deq_bits_address[15:6] : io_set_r;	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :216:28, Reg.scala:19:16, SinkC.scala:92:18]
  reg  [63:0] io_bs_dat_data_r;	// @[Reg.scala:19:16]
  wire        bs_adr_valid = resp & ((|counter) | _c_io_deq_valid & _c_io_deq_bits_opcode[0]);	// @[Decoupled.scala:375:21, Edges.scala:102:36, :229:27, :231:25, SinkC.scala:79:19, :99:{30,41,53}]
  reg  [2:0]  bs_adr_bits_beat_r;	// @[Reg.scala:19:16]
  reg  [1:0]  lists;	// @[SinkC.scala:116:24]
  wire [1:0]  _freeOH_T_7 = ~lists;	// @[SinkC.scala:116:24, :123:27]
  wire [1:0]  _GEN = {~(_freeOH_T_7[0]), 1'h1} & _freeOH_T_7;	// @[Edges.scala:230:28, SinkC.scala:123:{18,27,35,41}]
  wire [1:0]  freeIdx = {1'h0, _GEN[1]};	// @[Cat.scala:33:92, CircuitMath.scala:28:8, Edges.scala:230:28, SinkC.scala:123:41]
  wire        req_block = ~(|counter) & ~io_req_ready;	// @[Edges.scala:229:27, :231:25, SinkC.scala:126:{27,30}]
  wire        buf_block = _c_io_deq_bits_opcode[0] & ~_putbuffer_io_push_ready;	// @[Decoupled.scala:375:21, Edges.scala:102:36, SinkC.scala:115:27, :127:{29,32}]
  wire        set_block = _c_io_deq_bits_opcode[0] & ~(|counter) & (&lists);	// @[Decoupled.scala:375:21, Edges.scala:102:36, :229:27, :231:25, SinkC.scala:116:24, :122:23, :128:38]
  wire        _c_io_deq_ready_T_7 = raw_resp ? ~(_c_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready : ~req_block & ~buf_block & ~set_block;	// @[Decoupled.scala:375:21, Edges.scala:102:36, SinkC.scala:78:58, :107:61, :126:27, :127:29, :128:38, :134:{19,39,56,70,81,84}]
  reg  [1:0]  put_r;	// @[Reg.scala:19:16]
  wire [1:0]  put = (|counter) ? put_r : freeIdx;	// @[Cat.scala:33:92, Edges.scala:229:27, :231:25, Reg.scala:19:16, SinkC.scala:140:18]
  wire        _T_25 = _io_rel_pop_ready_output & io_rel_pop_valid;	// @[Decoupled.scala:51:35, SinkC.scala:160:43]
  wire [5:0]  _io_rel_pop_ready_T = {4'h0, _putbuffer_io_valid} >> io_rel_pop_bits_index;	// @[SinkC.scala:115:27, :151:24, :160:43]
  assign _io_rel_pop_ready_output = _io_rel_pop_ready_T[0];	// @[SinkC.scala:160:43]
  always @(posedge clock) begin
    if (reset) begin
      counter <= 3'h0;	// @[Edges.scala:229:27]
      lists <= 2'h0;	// @[SinkC.scala:116:24]
    end
    else begin
      if (_c_io_deq_ready_T_7 & _c_io_deq_valid) begin	// @[Decoupled.scala:51:35, :375:21, SinkC.scala:134:19]
        if (|counter)	// @[Edges.scala:229:27, :231:25]
          counter <= counter1;	// @[Edges.scala:229:27, :230:28]
        else if (_c_io_deq_bits_opcode[0])	// @[Decoupled.scala:375:21, Edges.scala:102:36]
          counter <= ~(_beats1_decode_T_1[5:3]);	// @[Edges.scala:229:27, package.scala:235:{46,71,76}]
        else	// @[Edges.scala:102:36]
          counter <= 3'h0;	// @[Edges.scala:229:27]
      end
      lists <= (lists | (~resp & _c_io_deq_valid & ~(|counter) & _c_io_deq_bits_opcode[0] & ~req_block & ~buf_block ? _GEN : 2'h0)) & ~(_T_25 & io_rel_pop_bits_last ? 2'h1 << io_rel_pop_bits_index[0] : 2'h0);	// @[Decoupled.scala:51:35, :375:21, Edges.scala:102:36, :229:27, :231:25, OneHot.scala:63:49, :64:12, SinkC.scala:79:19, :116:24, :118:29, :119:29, :120:{21,34,36}, :123:41, :126:27, :127:29, :134:{56,70}, :136:21, :138:{62,77,89}, :163:{27,52}, :164:17]
    end
    if (_c_io_deq_valid) begin	// @[Decoupled.scala:375:21]
      resp_r <= raw_resp;	// @[Reg.scala:19:16, SinkC.scala:78:58]
      io_set_r <= _c_io_deq_bits_address[15:6];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :216:28, Reg.scala:19:16]
      bs_adr_bits_beat_r <= beat + {2'h0, _io_bs_adr_q_io_enq_ready};	// @[Decoupled.scala:375:21, Edges.scala:234:25, Reg.scala:19:16, SinkC.scala:103:59, :116:24]
    end
    if (_io_bs_adr_q_io_enq_ready & bs_adr_valid)	// @[Decoupled.scala:51:35, :375:21, SinkC.scala:99:30]
      io_bs_dat_data_r <= _c_io_deq_bits_data;	// @[Decoupled.scala:375:21, Reg.scala:19:16]
    if (~(|counter))	// @[Edges.scala:229:27, :231:25]
      put_r <= freeIdx;	// @[Cat.scala:33:92, Reg.scala:19:16]
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin	// @[SinkC.scala:90:12]
      if (~reset & _c_io_deq_valid & _c_io_deq_bits_corrupt) begin	// @[Decoupled.scala:375:21, SinkC.scala:90:12]
        if (`ASSERT_VERBOSE_COND_)	// @[SinkC.scala:90:12]
          $error("Assertion failed: Data poisoning unavailable\n    at SinkC.scala:90 assert (!(c.valid && c.bits.corrupt), \"Data poisoning unavailable\")\n");	// @[SinkC.scala:90:12]
        if (`STOP_COND_)	// @[SinkC.scala:90:12]
          $fatal;	// @[SinkC.scala:90:12]
      end
    end // always @(posedge)
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    logic [31:0] _RANDOM_1;
    logic [31:0] _RANDOM_2;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        _RANDOM_1 = `RANDOM;
        _RANDOM_2 = `RANDOM;
        counter = _RANDOM_0[2:0];	// @[Edges.scala:229:27]
        resp_r = _RANDOM_0[3];	// @[Edges.scala:229:27, Reg.scala:19:16]
        io_set_r = _RANDOM_0[13:4];	// @[Edges.scala:229:27, Reg.scala:19:16]
        io_bs_dat_data_r = {_RANDOM_0[31:14], _RANDOM_1, _RANDOM_2[13:0]};	// @[Edges.scala:229:27, Reg.scala:19:16]
        bs_adr_bits_beat_r = _RANDOM_2[16:14];	// @[Reg.scala:19:16]
        lists = _RANDOM_2[18:17];	// @[Reg.scala:19:16, SinkC.scala:116:24]
        put_r = _RANDOM_2[20:19];	// @[Reg.scala:19:16]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  Queue_45 c (	// @[Decoupled.scala:375:21]
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_c_valid),
    .io_enq_bits_opcode  (io_c_bits_opcode),
    .io_enq_bits_param   (io_c_bits_param),
    .io_enq_bits_size    (io_c_bits_size),
    .io_enq_bits_source  (io_c_bits_source),
    .io_enq_bits_address (io_c_bits_address),
    .io_enq_bits_data    (io_c_bits_data),
    .io_enq_bits_corrupt (io_c_bits_corrupt),
    .io_deq_ready        (_c_io_deq_ready_T_7),	// @[SinkC.scala:134:19]
    .io_enq_ready        (io_c_ready),
    .io_deq_valid        (_c_io_deq_valid),
    .io_deq_bits_opcode  (_c_io_deq_bits_opcode),
    .io_deq_bits_param   (_c_io_deq_bits_param),
    .io_deq_bits_size    (_c_io_deq_bits_size),
    .io_deq_bits_source  (_c_io_deq_bits_source),
    .io_deq_bits_address (_c_io_deq_bits_address),
    .io_deq_bits_data    (_c_io_deq_bits_data),
    .io_deq_bits_corrupt (_c_io_deq_bits_corrupt)
  );
  Queue_46 io_bs_adr_q (	// @[Decoupled.scala:375:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid     (bs_adr_valid),	// @[SinkC.scala:99:30]
    .io_enq_bits_noop (~_c_io_deq_valid),	// @[Decoupled.scala:375:21, SinkC.scala:100:25]
    .io_enq_bits_way  (io_way),
    .io_enq_bits_set  (_io_set_output),	// @[SinkC.scala:92:18]
    .io_enq_bits_beat (_c_io_deq_valid ? beat : bs_adr_bits_beat_r),	// @[Decoupled.scala:375:21, Edges.scala:234:25, Reg.scala:19:16, SinkC.scala:103:28]
    .io_deq_ready     (io_bs_adr_ready),
    .io_enq_ready     (_io_bs_adr_q_io_enq_ready),
    .io_deq_valid     (io_bs_adr_valid),
    .io_deq_bits_noop (io_bs_adr_bits_noop),
    .io_deq_bits_way  (io_bs_adr_bits_way),
    .io_deq_bits_set  (io_bs_adr_bits_set),
    .io_deq_bits_beat (io_bs_adr_bits_beat),
    .io_deq_bits_mask (io_bs_adr_bits_mask)
  );
  ListBuffer_1 putbuffer (	// @[SinkC.scala:115:27]
    .clock                     (clock),
    .reset                     (reset),
    .io_push_valid             (~resp & _c_io_deq_valid & _c_io_deq_bits_opcode[0] & ~req_block & ~set_block),	// @[Decoupled.scala:375:21, Edges.scala:102:36, SinkC.scala:79:19, :126:27, :128:38, :134:{56,84}, :136:21, :137:74]
    .io_push_bits_index        (put[0]),	// @[SinkC.scala:140:18, :153:34]
    .io_push_bits_data_data    (_c_io_deq_bits_data),	// @[Decoupled.scala:375:21]
    .io_push_bits_data_corrupt (_c_io_deq_bits_corrupt),	// @[Decoupled.scala:375:21]
    .io_pop_valid              (_T_25),	// @[Decoupled.scala:51:35]
    .io_pop_bits               (io_rel_pop_bits_index[0]),	// @[SinkC.scala:158:27]
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_valid                  (_putbuffer_io_valid),
    .io_data_data              (io_rel_beat_data),
    .io_data_corrupt           (io_rel_beat_corrupt)
  );
  assign io_req_valid = ~resp & _c_io_deq_valid & ~(|counter) & ~buf_block & ~set_block;	// @[Decoupled.scala:375:21, Edges.scala:229:27, :231:25, SinkC.scala:79:19, :127:29, :128:38, :134:{70,84}, :136:{21,61}]
  assign io_req_bits_opcode = _c_io_deq_bits_opcode;	// @[Decoupled.scala:375:21]
  assign io_req_bits_param = _c_io_deq_bits_param;	// @[Decoupled.scala:375:21]
  assign io_req_bits_size = _c_io_deq_bits_size;	// @[Decoupled.scala:375:21]
  assign io_req_bits_source = _c_io_deq_bits_source;	// @[Decoupled.scala:375:21]
  assign io_req_bits_tag = _c_io_deq_bits_address[27:16];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :215:19]
  assign io_req_bits_offset = _c_io_deq_bits_address[5:0];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:216:50]
  assign io_req_bits_put = {4'h0, put};	// @[SinkC.scala:140:18, :151:24]
  assign io_req_bits_set = _c_io_deq_bits_address[15:6];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :216:28]
  assign io_resp_valid = resp & _c_io_deq_valid & (~(|counter) | last) & (~(_c_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready);	// @[Decoupled.scala:375:21, Edges.scala:102:36, :229:27, :231:25, :232:33, SinkC.scala:79:19, :107:{48,57,61,70}]
  assign io_resp_bits_last = last;	// @[Edges.scala:232:33]
  assign io_resp_bits_set = _c_io_deq_bits_address[15:6];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :216:28]
  assign io_resp_bits_tag = _c_io_deq_bits_address[27:16];	// @[Cat.scala:33:92, Decoupled.scala:375:21, Parameters.scala:214:22, :215:19]
  assign io_resp_bits_source = _c_io_deq_bits_source;	// @[Decoupled.scala:375:21]
  assign io_resp_bits_param = _c_io_deq_bits_param;	// @[Decoupled.scala:375:21]
  assign io_resp_bits_data = _c_io_deq_bits_opcode[0];	// @[Decoupled.scala:375:21, Edges.scala:102:36]
  assign io_set = _io_set_output;	// @[SinkC.scala:92:18]
  assign io_bs_dat_data = io_bs_dat_data_r;	// @[Reg.scala:19:16]
  assign io_rel_pop_ready = _io_rel_pop_ready_output;	// @[SinkC.scala:160:43]
endmodule

