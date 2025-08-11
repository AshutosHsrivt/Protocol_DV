//import the uvm library

`include "uvm_macros.svh"

//class memory_seqs

class memory_base_seq extends uvm_sequence #(memory_packet);

  `uvm_object_utils(memory_base_seq)

  function new(string name="memory_base_seq");

    super.new(name);

  endfunction

  task pre_body();

    uvm_phase phase;

    phase = get_starting_phase();

    if(phase != null) begin

      phase.raise_objection(this, get_type_name());

      `uvm_info(get_type_name(), "raise_objection", UVM_MEDIUM)

    end

  endtask 

  task post_body();

    uvm_phase phase;

    phase = get_starting_phase();

    if(phase != null) begin

      phase.drop_objection(this, get_type_name());

      `uvm_info(get_type_name(),"drop_objection",UVM_MEDIUM)

    end

  endtask

endclass : memory_base_seq

//

// SEQUENCE : memory_5_packet

//

class memory_5_packet extends memory_base_seq;

  `uvm_object_utils(memory_5_packet)

  function new(string name="memory_5_packet");

    super.new(name);

  endfunction

  virtual task body();

    `uvm_info(get_type_name(),"Executing memory_5_packet", UVM_LOW)

    repeat(5)

      `uvm_do(req)

  endtask

endclass : memory_5_packet

//

// SEQUENCE : write_transactions

//

class memory_write_transactions extends memory_base_seq;

  `uvm_object_utils(memory_write_transactions)

  function new(string name="memory_write_transactions");

    super.new(name);

  endfunction

  virtual task body();

    `uvm_info(get_type_name(), "Executing memory_write_transactions", UVM_LOW)

    repeat(5)

    `uvm_do_with(req, {req.wr_en==1;})

  endtask

endclass

//

// SEQUENCE : read_transactions

//

class memory_read_transactions extends memory_base_seq;

  `uvm_object_utils(memory_read_transactions)

  function new(string name="memory_read_transactions");

    super.new(name);

  endfunction

  virtual task body();

    `uvm_info(get_type_name(), "Executing memory_read_transactions", UVM_LOW)

    repeat(5)

    `uvm_do_with(req, {req.wr_en==0;})

  endtask

endclass

class memory_write_then_read_transactions extends memory_base_seq;

  `uvm_object_utils(memory_write_then_read_transactions)

  function new(string name="memory_write_then_read_transactions");

    super.new(name);

  endfunction

  virtual task body();

    `uvm_info(get_type_name(), "Executing memory_write_then_read_transactions",UVM_LOW)

    for(int i=0;i<15;i=i+1) begin

      `uvm_do_with(req, {req.addr==i+1; req.wdata==i*2; req.wr_en==1;})

      `uvm_do_with(req, {req.addr==i+1; req.wdata==i*2; req.wr_en==0;})

    end

  endtask

endclass