package FIFO_reset_seq_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_reset_sequence extends uvm_sequence #(seq_item_FIFO);
	`uvm_object_utils(FIFO_reset_sequence)

	seq_item_FIFO seq_item;

	function new(string name="FIFO_reset_sequence");
 	 super.new(name);
     endfunction : new

     task body;
     	seq_item=seq_item_FIFO::type_id::create("seq_item");
     	start_item(seq_item);
     	seq_item.data_in=0;
		seq_item.wr_en=0;
		seq_item.rd_en=0;
		seq_item.rst_n=1;
     	finish_item(seq_item);
     endtask : body

endclass : FIFO_reset_sequence
endpackage : FIFO_reset_seq_pkg