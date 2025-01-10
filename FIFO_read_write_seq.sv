package FIFO_read_write_seq_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_read_write_sequence extends uvm_sequence #(seq_item_FIFO);
	`uvm_object_utils(FIFO_read_write_sequence)

	seq_item_FIFO seq_item;

	function new(string name="FIFO_read_write_sequence");
 	 super.new(name);
     endfunction : new

     task body;
     	repeat(10000) begin
     	seq_item=seq_item_FIFO::type_id::create("seq_item");
     	start_item(seq_item);
     	assert(seq_item.randomize());
		seq_item.rd_en=1;
		seq_item.wr_en=1;
     	finish_item(seq_item);
        end
     endtask : body

endclass : FIFO_read_write_sequence
endpackage : FIFO_read_write_seq_pkg