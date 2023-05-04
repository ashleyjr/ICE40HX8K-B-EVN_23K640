module x_driver_tests (
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

   x_driver u_drv(
      .i_clk         (),
      .i_rst         (),        
      .i_test_valid  (),
      .i_test_data   (),
      .o_test_valid  (),
      .o_test_data   (),     
      .i_accept      (),
      .o_rd_n_wr     (),
      .o_addr        (),
      .o_wdata       (),  
      .o_valid       (),
      .i_ready       (),
      .i_rdata_0     (),
      .i_rdata_1     (),
      .i_rdata_2     (),
      .i_rdata_3     (),
      .i_rdata_4     (),
      .i_rdata_5     (),
      .i_rdata_6     (),
      .i_rdata_7     (),
      .i_rdata_8     (),
      .i_rdata_9     (),
      .i_rdata_A     (),
      .i_rdata_B     (),
      .i_rdata_C     (),
      .i_rdata_D     (),
      .i_rdata_E     (),
      .i_rdata_F     ()
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
      .o_ready    (ready      ),
      .o_rdata    (rdata      ),   
      .o_cs       (o_cs_0     ),
      .o_so       (o_so_0     ),
      .i_si       (i_si_0     )
   );

endmodule
