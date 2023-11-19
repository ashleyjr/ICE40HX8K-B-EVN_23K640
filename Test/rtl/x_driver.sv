module x_driver #(
   parameter p_width = 16
)(
   input    logic          i_clk,
   input    logic          i_rst, 
   // Tester Side
   input    logic          i_test_valid,
   input    logic [7:0]    i_test_data,
   output   logic          o_test_valid,
   output   logic [7:0]    o_test_data,
   // Clock frequency
   output   logic [7:0]    o_period,
   // 23K640 Side,
   output   logic          o_rd_n_wr,
   output   logic [15:0]   o_addr,
   output   logic [7:0]    o_wdata,
   // 23K640 Valid Muxed
   output   logic [15:0]   o_valid,
   input    logic [15:0]   i_accept,
   input    logic [15:0]   i_ready,
   input    logic [7:0]    i_rdata_0,
   input    logic [7:0]    i_rdata_1,
   input    logic [7:0]    i_rdata_2,
   input    logic [7:0]    i_rdata_3,
   input    logic [7:0]    i_rdata_4,
   input    logic [7:0]    i_rdata_5,
   input    logic [7:0]    i_rdata_6,
   input    logic [7:0]    i_rdata_7,
   input    logic [7:0]    i_rdata_8,
   input    logic [7:0]    i_rdata_9,
   input    logic [7:0]    i_rdata_A,
   input    logic [7:0]    i_rdata_B,
   input    logic [7:0]    i_rdata_C,
   input    logic [7:0]    i_rdata_D,
   input    logic [7:0]    i_rdata_E,
   input    logic [7:0]    i_rdata_F
);
   
   parameter valid_w  = 16;
   parameter addr_w   = 16;
   parameter r_n_wr_w = 1;
   parameter wdata_w  = 8;
   parameter cmd_w    = valid_w + r_n_wr_w + wdata_w + addr_w;

   logic                any_accept;

   logic [valid_w-1:0]  cmd_valid;
   logic [r_n_wr_w-1:0] cmd_rd_n_wr;
   logic [wdata_w-1:0]  cmd_wdata;
   logic [addr_w-1:0]   cmd_addr;
   logic [cmd_w-1:0]    cmd_d;
   logic [cmd_w-1:0]    cmd_q;

   logic                valid_en;
   logic [valid_w-1:0]  valid_d;
   logic [valid_w-1:0]  valid_q;

   logic                rd_n_wr_en;
   logic                rd_n_wr_d;
   logic                rd_n_wr_q;

   logic                wdata_en;
   logic [wdata_w-1:0]  wdata_d;
   logic [wdata_w-1:0]  wdata_q;

   logic                addr_en;
   logic [addr_w-1:0]   addr_d;
   logic [addr_w-1:0]   addr_q;

   logic                top;
   logic [6:0]          top_d;
   logic [6:0]          top_q;

   logic                cmd_en;
   logic                top_en;
   logic                exe_en;

   // Helpers
   assign any_accept = |i_accept;

   // Commands
   assign cmd_d = {cmd_q[cmd_w-4-1:0],i_test_data[7:4]}; 

   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         cmd_q <= 'd0;
      else if(cmd_en)   cmd_q <= cmd_d;
   end   

   assign {cmd_rd_n_wr, cmd_valid, cmd_addr, cmd_wdata} = cmd_q;
   
   // Hold valid and drop on accept 
   assign valid_d = (any_accept) ? (~i_accept & valid_q) : cmd_valid;

   assign valid_en = exe_en | any_accept;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)            valid_q <= 'd0;
      else if(valid_en)    valid_q <= valid_d;
   end   
   
   // Hold r_n_wr 
   assign rd_n_wr_d = cmd_rd_n_wr;

   assign rd_n_wr_en = exe_en;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)            rd_n_wr_q <= 'd0;
      else if(rd_n_wr_en)  rd_n_wr_q <= rd_n_wr_d;
   end   
   
   // Hold wdata 
   assign wdata_d = cmd_wdata;

   assign wdata_en = exe_en;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         wdata_q <= 'd0;
      else if(wdata_en) wdata_q <= wdata_d;
   end   
    
   // Hold address
   assign addr_d = cmd_addr;

   assign addr_en = exe_en;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         addr_q <= 'd0;
      else if(addr_en)  addr_q <= addr_d;
   end   

   // Advance strobe 
   assign top_d = i_test_data[7:1];
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)       top_q <= 'h7F;
      else if(top_en) top_q <= top_d;
   end    

   // Decode test driver 
   assign top_en = (i_test_data[0] == 1'b1) & i_test_valid;
   assign cmd_en = (i_test_data[1] == 1'b1) & i_test_valid;
   assign exe_en = (i_test_data[2] == 1'b1) & i_test_valid;

   // Drive Valid
   assign o_period = {1'b0,top_q};  

   // Drive Valid
   assign o_valid = valid_q;  

   // Drive r_n_wr
   assign o_rd_n_wr = rd_n_wr_q;

   // Drive write data
   assign o_wdata = wdata_q;
    
   // Drive address
   assign o_addr = addr_q;
  
endmodule
