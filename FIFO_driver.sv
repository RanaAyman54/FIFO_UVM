package FIFO_driver_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_driver extends uvm_driver#(seq_item_FIFO);
	`uvm_component_utils(FIFO_driver)

	virtual FIFO_if FIFO_vif;
	seq_item_FIFO stim_seq_item;

	function new(string name ="FIFO_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction : new


	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		forever begin
			stim_seq_item=seq_item_FIFO::type_id::create("stim_seq_item",this);
			seq_item_port.get_next_item(stim_seq_item);
			FIFO_vif.data_in=stim_seq_item.data_in;
			FIFO_vif.rst_n=stim_seq_item.rst_n;
			FIFO_vif.wr_en=stim_seq_item.wr_en;
			FIFO_vif.rd_en=stim_seq_item.rd_en;
		    @(negedge FIFO_vif.clk);
		    seq_item_port.item_done();
		    `uvm_info("run_phase", stim_seq_item.convert2string_stimulus(),UVM_HIGH);
		end
	endtask : run_phase

endclass : FIFO_driver
endpackage : FIFO_driver_pkg