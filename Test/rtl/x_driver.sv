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
   input    logic          i_ready,
   input    logic [7:0]    i_rdata,
   // 23K640 Valid Muxed
   output   logic [15:0]   o_valid
);
   logic          sel_en;
   logic [3:0]    sel_d;
   logic [3:0]    sel_q;
    
   logic          data_en;
   logic [7:0]    data_d, 
   logic [7:0]    data_q, 
   
   logic          addrl_en;
   logic [7:0]    addrl_d;
   logic [7:0]    addrl_q;
 
   logic          addru_en;
   logic [7:0]    addru_d;
   logic [7:0]    addru_q;
 
   // Select
   assign sel_d = i_test_data[3:0];
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         sel_q <= 'd0;
      else if(sel_en)   sel_q <= sel_d;
   end   

   // Data
   assign data_d = i_test_data;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         data_q <= 'd0;
      else if(data_en)  data_q <= data_d;
   end   
   
   // Address Lower
   assign addrl_d = i_test_data;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         addrl_q <= 'd0;
      else if(addrl_en) addrl_q <= addrl_d;
   end   

   // Address Upper
   assign addru_d = i_test_data;
   
   always_ff@(posedge i_clk or posedge i_rst) begin
      if(i_rst)         addru_q <= 'd0;
      else if(addru_en) addru_q <= addru_d;
   end   

   // Decode
   always_comb begin
      sel_en      = 1'b0;
      data_en     = 1'b0;
      addrl_en    = 1'b0;
      addru_en    = 1'b0;
      valid_start = 1'b0;
      if(i_valid) begin
         case(i_test_data[3:0])
            4'h0:  sel_en      = 1'b1;
            4'h1:  data_en     = 1'b1;
            4'h2:  addrl_en    = 1'b1;
            4'h3:  addru_en    = 1'b1;
            4'hF:  valid_start = 1'b1;  
         endcase
      end
   end

   // Drive Valid
   assign o_valid = i_test_valid &
                   (i_test_data[3:0] == 4'd15)
   
endmodule
