//import the uvm library
`include "uvm_macros.svh"
`include "memory_pkg.sv"
module top();

//  `include "memory_scoreboard.sv" 
	import memory_pkg::*;
  `include "memory_tb.sv"

  `include "memory_test_lib.sv"
  virtual memory_if vif;
  initial begin
  // mem_vif_config::set(null,"*.tb.env.agent.*","vif", hw_top.mem_intf);
    uvm_config_db#(virtual memory_if)::set(null,"*.tb.env.agent.*","vif", hw_top.mem_intf);
   run_test();
  end

//  memory_packet packet;

//

//  int ok;

//

//  initial begin

//    for(int i=0; i<10;i++) begin

//      packet = new($sformatf("packet_%0d",i));

//      ok=packet.randomize();

//      packet.print();

//    end

//  end

endmodule : top