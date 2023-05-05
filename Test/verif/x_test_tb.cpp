#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vx_driver_test.h"
#include <stdio.h>

#define CYCLES 100000

int main(int argc, char** argv, char** env) {
   
   vluint64_t sim_time = 0;
   uint64_t cycles;
   Vx_driver_test *dut = new Vx_driver_test; 
   Verilated::traceEverOn(true);
   VerilatedVcdC *m_trace = new VerilatedVcdC; 
   
   dut->trace(m_trace, 5);
   m_trace->open("waveform.vcd");
   cycles = 0;

   while (cycles < 20) {
      
      // Falling Edge
      dut->i_clk = 0;
    
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
      sim_time++;

      // Rising Edge
      dut->i_clk = 1;
      
      // Tick
      dut->eval();
      m_trace->dump(sim_time); 
      sim_time++;

      // Cycles
      cycles++;;
   }
   
   m_trace->close();
   delete dut;
   exit(EXIT_SUCCESS);
}

