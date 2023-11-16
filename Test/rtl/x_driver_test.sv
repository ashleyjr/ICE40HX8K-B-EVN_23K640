module x_driver_test (
   input    logic          i_clk,
   input    logic          i_rst,
   // UART
   input    logic          i_rx,
   output   logic          o_tx,
   // SPI SRAM side - SCK
   output   logic          o_sck,
   // SPI SRAM side - 0
   output   logic          o_cs_0,
   output   logic          o_so_0,
   input    logic          i_si_0,
   // SPI SRAM side - 1
   output   logic          o_cs_1,
   output   logic          o_so_1,
   input    logic          i_si_1,
   // SPI SRAM side - 2
   output   logic          o_cs_2,
   output   logic          o_so_2,
   input    logic          i_si_2,
   // SPI SRAM side - 3
   output   logic          o_cs_3,
   output   logic          o_so_3,
   input    logic          i_si_3,
   // SPI SRAM side - 4
   output   logic          o_cs_4,
   output   logic          o_so_4,
   input    logic          i_si_4,
   // SPI SRAM side - 5
   output   logic          o_cs_5,
   output   logic          o_so_5,
   input    logic          i_si_5,
   // SPI SRAM side - 6
   output   logic          o_cs_6,
   output   logic          o_so_6,
   input    logic          i_si_6,
   // SPI SRAM side - 7
   output   logic          o_cs_7,
   output   logic          o_so_7,
   input    logic          i_si_7,
   // SPI SRAM side - 8
   output   logic          o_cs_8,
   output   logic          o_so_8,
   input    logic          i_si_8,
   // SPI SRAM side - 9
   output   logic          o_cs_9,
   output   logic          o_so_9,
   input    logic          i_si_9,
   // SPI SRAM side - A
   output   logic          o_cs_A,
   output   logic          o_so_A,
   input    logic          i_si_A,
   // SPI SRAM side - B
   output   logic          o_cs_B,
   output   logic          o_so_B,
   input    logic          i_si_B,
   // SPI SRAM side - C
   output   logic          o_cs_C,
   output   logic          o_so_C,
   input    logic          i_si_C,
   // SPI SRAM side - D
   output   logic          o_cs_D,
   output   logic          o_so_D,
   input    logic          i_si_D,
   // SPI SRAM side - E
   output   logic          o_cs_E,
   output   logic          o_so_E,
   input    logic          i_si_E,
   // SPI SRAM side - F
   output   logic          o_cs_F,
   output   logic          o_so_F,
   input    logic          i_si_F

);
   logic          rx_valid;
   logic [7:0]    rx_data;
   logic          tx_valid;
   logic [7:0]    tx_data;

   logic          advance; 
   logic          rd_n_wr;
   logic [15:0]   addr;
   logic [7:0]    wdata;
   logic [15:0]   accept;
   logic [15:0]   valid;
   logic [15:0]   ready;
   logic [7:0]    rdata_0;
   logic [7:0]    rdata_1;
   logic [7:0]    rdata_2;
   logic [7:0]    rdata_3;
   logic [7:0]    rdata_4;
   logic [7:0]    rdata_5;
   logic [7:0]    rdata_6;
   logic [7:0]    rdata_7;
   logic [7:0]    rdata_8;
   logic [7:0]    rdata_9;
   logic [7:0]    rdata_A;
   logic [7:0]    rdata_B;
   logic [7:0]    rdata_C;
   logic [7:0]    rdata_D;
   logic [7:0]    rdata_E;
   logic [7:0]    rdata_F;
   
   x_uart_rx #(
      .p_clk_hz      (12000000   ),
      .p_baud        (115200     )
   ) u_rx (
      .i_clk         (i_clk      ),
      .i_rst         (i_rst      ),
      .i_rx          (i_rx       ),
      .o_valid       (rx_valid   ),
      .o_data        (rx_data    )
   );

   x_uart_tx #(
      .p_clk_hz      (12000000   ),
      .p_baud        (115200     )
   ) u_tx (
      .i_clk         (i_clk      ),
      .i_rst         (i_rst      ),
      .i_data        (tx_data    ),
      .o_tx          (o_tx       ),
      .i_valid       (tx_valid   ),
      .o_accept      ()
   );

   x_driver u_drv(
      .i_clk         (i_clk      ),
      .i_rst         (i_rst      ),        
      .i_test_valid  (rx_valid   ),
      .i_test_data   (rx_data    ),
      .o_test_valid  (tx_valid   ),
      .o_test_data   (tx_data    ),     
      .o_advance     (advance    ),
      .i_accept      (accept     ),
      .o_rd_n_wr     (rd_n_wr    ),
      .o_addr        (addr       ),
      .o_wdata       (wdata      ),  
      .o_valid       (valid      ),
      .i_ready       (ready      ),
      .i_rdata_0     (rdata_0    ),
      .i_rdata_1     (rdata_1    ),
      .i_rdata_2     (rdata_2    ),
      .i_rdata_3     (rdata_3    ),
      .i_rdata_4     (rdata_4    ),
      .i_rdata_5     (rdata_5    ),
      .i_rdata_6     (rdata_6    ),
      .i_rdata_7     (rdata_7    ),
      .i_rdata_8     (rdata_8    ),
      .i_rdata_9     (rdata_9    ),
      .i_rdata_A     (rdata_A    ),
      .i_rdata_B     (rdata_B    ),
      .i_rdata_C     (rdata_C    ),
      .i_rdata_D     (rdata_D    ),
      .i_rdata_E     (rdata_E    ),
      .i_rdata_F     (rdata_F    )
   );

   x_23K640_sck u_s(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .o_advance  (advance    ),
      .o_sck      (o_sck      )
   );
   
   x_23K640_data u_d_0(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[0]   ),
      .o_accept   (accept[0]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[0]   ),
      .o_rdata    (rdata_0    ),   
      .o_cs       (o_cs_0     ),
      .o_so       (o_so_0     ),
      .i_si       (i_si_0     )
   );

   x_23K640_data u_d_1(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[1]   ),
      .o_accept   (accept[1]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[1]   ),
      .o_rdata    (rdata_1    ),   
      .o_cs       (o_cs_1     ),
      .o_so       (o_so_1     ),
      .i_si       (i_si_1     )
   );

   x_23K640_data u_d_2(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[2]   ),
      .o_accept   (accept[2]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[2]   ),
      .o_rdata    (rdata_2    ),   
      .o_cs       (o_cs_2     ),
      .o_so       (o_so_2     ),
      .i_si       (i_si_2     )
   );

   x_23K640_data u_d_3(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[3]   ),
      .o_accept   (accept[3]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[3]   ),
      .o_rdata    (rdata_3    ),   
      .o_cs       (o_cs_3     ),
      .o_so       (o_so_3     ),
      .i_si       (i_si_3     )
   );

   x_23K640_data u_d_4(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[4]   ),
      .o_accept   (accept[4]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[4]   ),
      .o_rdata    (rdata_4    ),   
      .o_cs       (o_cs_4     ),
      .o_so       (o_so_4     ),
      .i_si       (i_si_4     )
   );

   x_23K640_data u_d_5(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[5]   ),
      .o_accept   (accept[5]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[5]   ),
      .o_rdata    (rdata_5    ),   
      .o_cs       (o_cs_5     ),
      .o_so       (o_so_5     ),
      .i_si       (i_si_5     )
   );

   x_23K640_data u_d_6(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[6]   ),
      .o_accept   (accept[6]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[6]   ),
      .o_rdata    (rdata_6    ),   
      .o_cs       (o_cs_6     ),
      .o_so       (o_so_6     ),
      .i_si       (i_si_6     )
   );

   x_23K640_data u_d_7(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[7]   ),
      .o_accept   (accept[7]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[7]   ),
      .o_rdata    (rdata_7    ),   
      .o_cs       (o_cs_7     ),
      .o_so       (o_so_7     ),
      .i_si       (i_si_7     )
   );

   x_23K640_data u_d_8(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[8]   ),
      .o_accept   (accept[8]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[8]   ),
      .o_rdata    (rdata_8    ),   
      .o_cs       (o_cs_8     ),
      .o_so       (o_so_8     ),
      .i_si       (i_si_8     )
   );

   x_23K640_data u_d_9(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[9]   ),
      .o_accept   (accept[9]  ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[9]   ),
      .o_rdata    (rdata_9    ),   
      .o_cs       (o_cs_9     ),
      .o_so       (o_so_9     ),
      .i_si       (i_si_9     )
   );

   x_23K640_data u_d_A(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[10]  ),
      .o_accept   (accept[10] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[10]  ),
      .o_rdata    (rdata_A    ),   
      .o_cs       (o_cs_A     ),
      .o_so       (o_so_A     ),
      .i_si       (i_si_A     )
   );

   x_23K640_data u_d_B(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[11]  ),
      .o_accept   (accept[11] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[11]  ),
      .o_rdata    (rdata_B    ),   
      .o_cs       (o_cs_B     ),
      .o_so       (o_so_B     ),
      .i_si       (i_si_B     )
   );

   x_23K640_data u_d_C(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[12]  ),
      .o_accept   (accept[12] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[12]  ),
      .o_rdata    (rdata_C    ),   
      .o_cs       (o_cs_C     ),
      .o_so       (o_so_C     ),
      .i_si       (i_si_C     )
   );

   x_23K640_data u_d_D(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[13]  ),
      .o_accept   (accept[13] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[13]  ),
      .o_rdata    (rdata_D    ),   
      .o_cs       (o_cs_D     ),
      .o_so       (o_so_D     ),
      .i_si       (i_si_D     )
   );

   x_23K640_data u_d_E(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[14]  ),
      .o_accept   (accept[14] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[14]  ),
      .o_rdata    (rdata_E    ),   
      .o_cs       (o_cs_E     ),
      .o_so       (o_so_E     ),
      .i_si       (i_si_E     )
   );

   x_23K640_data u_d_F(
      .i_clk      (i_clk      ),
      .i_rst      (i_rst      ),     
      .i_advance  (advance    ),
      .i_sck      (o_sck      ),
      .i_valid    (valid[15]  ),
      .o_accept   (accept[15] ),
      .i_rd_n_wr  (rd_n_wr    ),
      .i_addr     (addr       ),
      .i_wdata    (wdata      ),
      .o_ready    (ready[15]  ),
      .o_rdata    (rdata_F    ),   
      .o_cs       (o_cs_F     ),
      .o_so       (o_so_F     ),
      .i_si       (i_si_F     )
   );
endmodule
