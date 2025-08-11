
//class: memory_tb

class memory_tb extends uvm_env;

  //component macro

  `uvm_component_utils(memory_tb)

  //constructor

  function new (string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  //memory UVC

  memory_env env;

  //memory scoreboard

//  memory_scoreboard memory_sb;

  //uvm build phase

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    `uvm_info("MSG","Testbench build phase executed",UVM_HIGH)

    env = memory_env::type_id::create("env",this);

//    memory_sb = memory_scoreboard::type_id::create("memory_sb",this);

  endfunction : build_phase

//  function void connect_phase(uvm_phase phase);

//    //connect the TLM ports

//    env.agent.monitor.item_collected_port.connect(memory_sb.sb_monitor_in);

//    env.agent.driver.item_collected_port.connect(memory_sb.sb_driver_in);

//  endfunction

  function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info(get_type_name(),{"Start of simulation for ",get_full_name()}, UVM_HIGH)

  endfunction

endclass : memory_tb