#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vx_test.h"
#include "include/logger.h"
#include "include/app_driver.h"
#include "include/sram_model.h"
#include <stdio.h>

#define CYCLES 100000

int main(int argc, char** argv, char** env) {
   
   vluint64_t sim_time = 0;
   uint64_t cycle;
   Vx_test *dut = new Vx_test; 
   Verilated::traceEverOn(true);
   VerilatedVcdC *m_trace = new VerilatedVcdC; 
   
   dut->trace(m_trace, 5);
   m_trace->open("waveform.vcd");
   
   while (cycle < stop) {
      
      // Falling Edge
      dut->i_clk = 0;
    
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
 
      // Rising Edge
      dut->i_clk = 1;
      
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
      
   }
   
   m_trace->close();
   delete dut;
   exit(EXIT_SUCCESS);
}

