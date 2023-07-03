#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vx_driver_test.h"
#include <stdio.h>
#include "../23K640/verif/include/logger.h"
#include "../23K640/verif/include/sram_model.h"
#include "../rtl-uart/verif/lib/include/uart_driver.h"
#include "../rtl-uart/verif/lib/include/uart_sink.h"

#define BAUD 115200
#define CLK 12000000
#define CYCLES 100000


void write(UartDriver * drv, uint16_t addr, uint8_t data){
   // Select (CMD == 0)
   // - Bit [15:12] of addr
   drv->send((addr >> 8) & 0xF0);
   // Load data (CMD == 1)
   drv->send((data & 0xF0) | 0x01);
   drv->send(((data << 4) & 0xF0) | 0x01);
   // Load address (CMD == 3)
   drv->send(((addr >> 4) & 0xF0) | 0x03);
   drv->send(( addr       & 0xF0) | 0x03);
   drv->send(((addr << 4) & 0xF0) | 0x03); 
   // Read Mode (CMD == 4)
   drv->send(0x4);
   // Valid (CMD == 5)
   drv->send(0x5);
}

void read(UartDriver * drv, UartSink * sink, uint16_t addr, uint8_t check){
   // Select (CMD == 0)
   // - Bit [15:12] of addr
   drv->send((addr >> 8) & 0xF0);
   // Load address (CMD == 3)
   drv->send(((addr >> 4) & 0xF0) | 0x03);
   drv->send(( addr       & 0xF0) | 0x03);
   drv->send(((addr << 4) & 0xF0) | 0x03); 
   // Write Mode (CMD == 4)
   drv->send(0x14); 
   // Valid (CMD == 5)
   drv->send(0x5);
   // Read (CMD == 7)
   drv->send(0x7);
   // Check correct data read
   sink->recieve(check);
}

int main(int argc, char** argv, char** env) {
   
   vluint64_t sim_time = 0;
   uint64_t cycles;
   Vx_driver_test *dut = new Vx_driver_test; 
   Verilated::traceEverOn(true);
   VerilatedVcdC *m_trace = new VerilatedVcdC; 
   
   UartSink sink(CLK, BAUD);
   UartDriver drv(CLK, BAUD, 2);
  
   Logger logger("logfile.txt", &sim_time);   
   
   SramModel m0(logger); 
   SramModel m1(logger); 
   SramModel m2(logger); 
   SramModel m3(logger);   
   SramModel m4(logger); 
   SramModel m5(logger); 
   SramModel m6(logger); 
   SramModel m7(logger); 
   SramModel m8(logger); 
   SramModel m9(logger); 
   SramModel mA(logger); 
   SramModel mB(logger);   
   SramModel mC(logger); 
   SramModel mD(logger); 
   SramModel mE(logger); 
   SramModel mF(logger); 

   write(&drv, 0x0000, 0xAB); 
   read(&drv, &sink, 0x0000, 0xAB);  

   // Setup
   dut->trace(m_trace, 5);
   m_trace->open("waveform.vcd");
   cycles = 0;

   dut->i_clk     = 0;
   dut->i_rst     = 0;
   dut->i_rx      = 1;
   
   // Tick
   dut->eval();
   m_trace->dump(sim_time);  
   sim_time++;
   
   // Reset
   dut->i_rst = 1;
   
   // Tick
   dut->eval();
   m_trace->dump(sim_time);  
   sim_time++;

   // Out of Reset
   dut->i_rst = 0;

   while (cycles < CYCLES) {
      
      // Falling Edge
      dut->i_clk = 0;
    
      // SRAM Models
      m0.set_inputs(
         dut->o_cs_0,
         dut->o_so_0,      
         dut->o_sck
      );
      dut->i_si_0 = m0.get_so(); 
      m1.set_inputs(
         dut->o_cs_1,
         dut->o_so_1,      
         dut->o_sck
      );
      dut->i_si_1 = m1.get_so(); 
      m2.set_inputs(
         dut->o_cs_2,
         dut->o_so_2,      
         dut->o_sck
      );
      dut->i_si_2 = m2.get_so(); 
      m3.set_inputs(
         dut->o_cs_3,
         dut->o_so_3,      
         dut->o_sck
      );
      dut->i_si_3 = m3.get_so(); 
      m4.set_inputs(
         dut->o_cs_4,
         dut->o_so_4,      
         dut->o_sck
      );
      dut->i_si_4 = m4.get_so(); 
      m5.set_inputs(
         dut->o_cs_5,
         dut->o_so_5,      
         dut->o_sck
      );
      dut->i_si_5 = m5.get_so(); 
      m6.set_inputs(
         dut->o_cs_6,
         dut->o_so_6,      
         dut->o_sck
      );
      dut->i_si_6 = m6.get_so(); 
      m7.set_inputs(
         dut->o_cs_7,
         dut->o_so_7,      
         dut->o_sck
      );
      dut->i_si_7 = m7.get_so(); 
      m8.set_inputs(
         dut->o_cs_8,
         dut->o_so_8,      
         dut->o_sck
      );
      dut->i_si_8 = m8.get_so(); 
      m9.set_inputs(
         dut->o_cs_9,
         dut->o_so_9,      
         dut->o_sck
      );
      dut->i_si_9 = m9.get_so();  
      mA.set_inputs(
         dut->o_cs_A,
         dut->o_so_A,      
         dut->o_sck
      );
      dut->i_si_A = mA.get_so(); 
      mB.set_inputs(
         dut->o_cs_B,
         dut->o_so_B,      
         dut->o_sck
      );
      dut->i_si_B = mB.get_so(); 
      mC.set_inputs(
         dut->o_cs_C,
         dut->o_so_C,      
         dut->o_sck
      );
      dut->i_si_C = mC.get_so(); 
      mD.set_inputs(
         dut->o_cs_D,
         dut->o_so_D,      
         dut->o_sck
      );
      dut->i_si_D = mD.get_so(); 
      mE.set_inputs(
         dut->o_cs_E,
         dut->o_so_E,      
         dut->o_sck
      );
      dut->i_si_E = mE.get_so(); 
      mF.set_inputs(
         dut->o_cs_F,
         dut->o_so_F,      
         dut->o_sck
      );
      dut->i_si_F = mF.get_so(); 
      
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
      sim_time++;
      
      // Sink UART
      sink.advance(dut->o_tx);

      // Rising Edge
      dut->i_clk = 1;
     
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
      sim_time++;

      // Drive in UART
      dut->i_rx = drv.advance();
     
      // Cycles
      cycles++;;
   }
   
   m_trace->close();
   delete dut;
   exit(EXIT_SUCCESS);
}

