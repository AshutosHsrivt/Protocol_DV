//import the uvm library
`include "uvm_macros.svh"

//class : memory_sequencer

class memory_sequencer extends uvm_sequencer #(memory_packet);

  `uvm_component_utils(memory_sequencer)

  function new(string name, uvm_component parent);

    super.new(name,parent);

  endfunction

  function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info(get_type_name(),{"Start of Simulation for", get_full_name()}, UVM_HIGH)

  endfunction

endclass : memory_sequencer