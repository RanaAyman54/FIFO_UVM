package FIFO_sequencer_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_sequencer extends uvm_sequencer#(seq_item_FIFO);
	`uvm_component_utils(FIFO_sequencer)

	function new(string name ="FIFO_sequencer",uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

endclass : FIFO_sequencer

endpackage : FIFO_sequencer_pkg