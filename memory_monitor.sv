//import the uvm library
`include "uvm_macros.svh"

// class : memory_monitor

class memory_monitor extends uvm_monitor;

  `uvm_component_utils(memory_monitor)

  function new(string name, uvm_component parent);

    super.new(name,parent);

  endfunction

  

//  uvm_analysis_port#(memory_packet) item_collected_port;

//

//  function new(string name, uvm_component parent);

//    super.new(name,parent);

//    item_colected_port = new("item_collected_port",this);

//  endfunction : new

  virtual interface memory_if vif;

  function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info(get_type_name(), {"Start of simulation for ", get_full_name()}, UVM_HIGH)

  endfunction

  function void build_phase(uvm_phase phase);

  //  if(!mem_vif_config::get(this,"","vif",vif))
    if(!(uvm_config_db#(virtual memory_if)::get(this,"","vif",vif))) begin
      `uvm_error("NOVIF","Missing virtual I/F")
    end
    else begin
      `uvm_info(get_type_name(),{"Virtual Interface connected to ",get_type_name()}, UVM_HIGH)
    end

  endfunction

  //collected data handle

  memory_packet pkt;

  

  //count pakcets collected

  int num_pkt_col;

  task run_phase(uvm_phase phase);

    @(posedge vif.rst);

    @(negedge vif.rst);

    `uvm_info(get_type_name(), "Detected Reset done",UVM_MEDIUM)

    forever begin

 //     @(posedge vif.clk);

      pkt = memory_packet::type_id::create("pkt",this);

      fork

        vif.collect_packet(pkt.addr, pkt.wdata, pkt.rdata,pkt.wr_en,pkt.mode);

        @(posedge vif.monstart) void'(begin_tr(pkt,"Monitor Memory Packet"));

      join

//      pkt.mode = (pkt.calc_mode(pkt.wr_en))? WRITE:READ;

      end_tr(pkt);

      `uvm_info(get_type_name(),$sformatf("packet collected: \n%s",pkt.sprint()),UVM_LOW)

      num_pkt_col++;

//      item_collected_port.write(pkt);

    end

  endtask : run_phase

  //UVM report phase

  function void report_phase(uvm_phase phase);

    `uvm_info(get_type_name(),$sformatf("Report: Memory monitor collected %0d packets",num_pkt_col),UVM_LOW)

  endfunction

//NG  virtual task run_phase(uvm_phase phase);

//NG    `uvm_info(get_type_name(),"Inside the run_phase",UVM_MEDIUM)

//NG  endtask

endclass : memory_monitor