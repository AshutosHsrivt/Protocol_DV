//class : memory_agent

class memory_agent extends uvm_agent;

  `uvm_component_utils_begin(memory_agent)

    `uvm_field_enum(uvm_active_passive_enum, is_active,UVM_ALL_ON)

  `uvm_component_utils_end

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  memory_monitor monitor;

  memory_sequencer sequencer;

  memory_driver driver;

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    //construct the monitor, driver and sequencer

    //factory monitor = new("monitor",this);

    monitor = memory_monitor::type_id::create("monitor",this);

    if(is_active == UVM_ACTIVE) begin

      sequencer = memory_sequencer::type_id::create("sequencer",this);

      driver = memory_driver::type_id::create("driver",this);

      //NG driver = new("driver", this);

    end

  endfunction

  function void connect_phase(uvm_phase phase);

    if(is_active == UVM_ACTIVE)

      driver.seq_item_port.connect(sequencer.seq_item_export);

  endfunction

  function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info(get_type_name(),{"Start of simulation for ",get_full_name()}, UVM_HIGH)

  endfunction

endclass : memory_agent