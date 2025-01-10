package FIFO_random_seq_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_random_sequence extends uvm_sequence #(seq_item_FIFO);
	`uvm_object_utils(FIFO_random_sequence)

	seq_item_FIFO seq_item;

	function new(string name="FIFO_random_sequence");
 	 super.new(name);
     endfunction : new

     task body;
     	repeat(10000) begin
     	seq_item=seq_item_FIFO::type_id::create("seq_item");
     	start_item(seq_item);
     	assert(seq_item.randomize());
     	finish_item(seq_item);
        end

     endtask : body

endclass : FIFO_random_sequence
endpackage : FIFO_random_seq_pkg