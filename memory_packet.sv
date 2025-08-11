//import the uvm library
import uvm_pkg::*;
`include "uvm_macros.svh"

typedef enum bit {WRITE, READ} mode_t;

//class: memory_packet

class memory_packet extends uvm_sequence_item;

  rand bit [3:0] addr;

  rand bit [7:0] wdata;

  rand bit wr_en;

  mode_t mode;

  bit [7:0]rdata;

  `uvm_object_utils_begin(memory_packet)

    `uvm_field_int(addr, UVM_ALL_ON)

    `uvm_field_int(wdata, UVM_ALL_ON)

    `uvm_field_int(wr_en, UVM_ALL_ON)

    `uvm_field_int(rdata, UVM_ALL_ON)

    `uvm_field_enum(mode_t,mode, UVM_ALL_ON)

  `uvm_object_utils_end

  //constructor

  function new(string name="memory_packet");

    super.new(name);

  endfunction

  //constraints

  constraint default_addr {addr < 16;} //addr constraint

  constraint default_data {wdata < 256;} //data constraint

  constraint default_enable {wr_en dist {0:= 1, 1:=1}; }

//  constraint default_mode {

//    if(wr_en == 1) mode == WRITE;

//    else mode == READ;

//    } //mode constraint

  

  function bit calc_mode(wr_en);

    if(wr_en)

      mode = WRITE;

    else

      mode = READ;

  endfunction

  function void post_randomize();

    calc_mode(wr_en);

  endfunction

endclass : memory_packet