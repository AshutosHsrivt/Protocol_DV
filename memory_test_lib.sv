//class : base test

class base_test extends uvm_test;

  //component macros

  `uvm_component_utils(base_test)

  memory_tb tb;

  //constructor

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  //uvm build phase

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    //tb = new("tb", this);

    tb = memory_tb::type_id::create("tb",this);

//NG    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",

//NG                    "default_sequence",

//NG                    memory_5_packet::type_id::get());

    `uvm_info("MSG","Test build phase executed.",UVM_HIGH)

  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);

    uvm_top.print_topology();

  endfunction : end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info(get_type_name(),{"Start of simulation for ",get_full_name()}, UVM_HIGH)

  endfunction

  task run_phase(uvm_phase phase);

   uvm_objection obj = phase.get_objection();

   obj.set_drain_time(this, 200ns);

  endtask : run_phase

endclass : base_test

class write_only_test extends base_test;

  `uvm_component_utils(write_only_test)

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",

                    "default_sequence",

                    memory_5_packet::type_id::get());

    super.build_phase(phase);

    set_type_override_by_type(memory_5_packet::get_type(),memory_write_transactions::get_type());

  endfunction

endclass

class read_only_test extends base_test;

  `uvm_component_utils(read_only_test)

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",

                    "default_sequence",

                    memory_5_packet::type_id::get());

    super.build_phase(phase);

    set_type_override_by_type(memory_5_packet::get_type(),memory_read_transactions::get_type());

  endfunction

endclass

class write_then_read_only_test extends base_test;

  `uvm_component_utils(write_then_read_only_test)

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",

                    "default_sequence",

                    memory_5_packet::type_id::get());

    super.build_phase(phase);

    set_type_override_by_type(memory_5_packet::get_type(),memory_write_then_read_transactions::get_type());

  endfunction

endclass