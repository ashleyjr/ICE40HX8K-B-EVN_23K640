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
   // 23K640 Side
   input    logic          i_accept,
   output   logic          o_rd_n_wr,
   output   logic [15:0]   o_addr,
   output   logic [7:0]    o_wdata,
   // 23K640 Valid Muxed
   output   logic [15:0]   o_valid,
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
   logic          sel_en;
   logic [3:0]    sel_d;
   logic [3:0]    sel_q;
    
   logic          wdata_en;
   logic [7:0]    wdata_d, 
   logic [7:0]    wdata_q, 
   
   logic          rdata_en;
   logic [7:0]    rdata_d, 
   logic [7:0]    rdata_q, 

   logic          rd_n_wr_en;
   logic          rd_n_wr_d;
   logic          rd_n_wr_q;

   logic          addr_en;
   logic [15:0]   addr_d;
   logic [15:0]   addr_q;
 
 
   // Select
   assign sel_d = i_test_data[7:4];
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         sel_q <= 'd0;
      else if(sel_en)   sel_q <= sel_d;
   end   

   // Write Data
   assign wdata_d = {wdata_q[3:0],i_test_data[7:4]};
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)            wdata_q <= 'd0;
      else if(wdata_en)    wdata_q <= wdata_d;
   end   
 
   // Write Data
   assign rdata_en = |i_ready;

   always_comb begin 
      rdata_d = i_rdata_0;
      case(sel_q)
         4'h1: rdata_d = i_rdata_1;
         4'h2: rdata_d = i_rdata_2;
         4'h3: rdata_d = i_rdata_3;
         4'h4: rdata_d = i_rdata_4;
         4'h5: rdata_d = i_rdata_5;
         4'h6: rdata_d = i_rdata_6;
         4'h7: rdata_d = i_rdata_7;
         4'h8: rdata_d = i_rdata_8;
         4'h9: rdata_d = i_rdata_9;
         4'hA: rdata_d = i_rdata_A;
         4'hB: rdata_d = i_rdata_B;
         4'hC: rdata_d = i_rdata_C;
         4'hD: rdata_d = i_rdata_D;
         4'hE: rdata_d = i_rdata_E;
         4'hF: rdata_d = i_rdata_F;
         default:;
      endcase
   end
    
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         rdata_q <= 'd0;
      else if(rdata_en) rdata_q <= rdata_d;
   end   
    
   // rd_n_wr
   assign rd_n_wr_d = i_rd_n_wr;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)            rd_n_wr_q <= 'd0;
      else if(rd_n_wr_en)  rd_n_wr_q <= rd_n_wr_d;
   end   
   
   // Address
   assign addr_d = {addr_q[11:0],i_test_data[7:4]};
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         addr_q <= 'd0;
      else if(addr_en)  addr_q <= addr_d;
   end   
   
   // Hold valid
   assign valid_d = ~i_accept;

   assign valid_en = valid_start | i_accept;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)            valid_q <= 'd0;
      else if(valid_en)    valid_q <= valid_d;
   end   
   
   // Decode 
   assign sel_en      = (i_test_data[3:0] == 4'h0) & i_test_valid;
   assign wdata_en    = (i_test_data[3:0] == 4'h1) & i_test_valid;
   assign rdata_en    = (i_test_data[3:0] == 4'h2) & i_test_valid;
   assign addr_en     = (i_test_data[3:0] == 4'h3) & i_test_valid; 
   assign rd_n_wr_en  = (i_test_data[3:0] == 4'h4) & i_test_valid; 
   assign valid_start = (i_test_data[3:0] == 4'h5) & i_test_valid; 
   assign test_rdata  = (i_test_data[3:0] == 4'h6) & i_test_valid; 
   assign valid_read  = (i_test_data[3:0] == 4'h7) & i_test_valid; 
   
   // Drive Valid
   assign o_valid = valid_q << sel_q;  
 
   // Drive Read Not Write
   assign o_rd_n_wr = rd_n_wr_q;

   // o_test_valid
   assign o_test_valid = test_rdata | valid_read;

   // o_test_data
   assign o_test_data = (test_rdata) ? rdata_q : {7'd0, valid_q};
   
endmodule
