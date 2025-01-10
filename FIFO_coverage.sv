package FIFO_coverage_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_coverage extends uvm_component;
	`uvm_component_utils(FIFO_coverage)

	uvm_analysis_export #(seq_item_FIFO) cov_export;
	uvm_tlm_analysis_fifo #(seq_item_FIFO) cov_fifo;
	seq_item_FIFO seq_item_cov;

	//covergroup
    covergroup cg;
    w_en: coverpoint seq_item_cov.wr_en{option.weight = 0;}
    r_en: coverpoint seq_item_cov.rd_en{option.weight = 0;}
    w_ack: coverpoint seq_item_cov.wr_ack{option.weight = 0;}
    overFlow: coverpoint seq_item_cov.overflow{option.weight = 0;}
    Full: coverpoint seq_item_cov.full{option.weight = 0;}
    Empty: coverpoint seq_item_cov.empty{option.weight = 0;}
    almostFull: coverpoint seq_item_cov.almostfull{option.weight = 0;}
    almostEmpty: coverpoint seq_item_cov.almostempty{option.weight = 0;}
    underFlow: coverpoint seq_item_cov.underflow{option.weight = 0;}

    c_w_ack:cross w_en,r_en,w_ack;
    c_overFlow:cross w_en ,r_en,overFlow;
    c_Full:cross w_en,r_en,Full;
    c_Empty:cross w_en,r_en,Empty;
    c_almostFull:cross w_en,r_en,almostFull;
    c_almostEmpty:cross w_en,r_en,almostEmpty;
    c_underFlow:cross w_en,r_en,underFlow;

  endgroup : cg
   

	function new(string name ="FIFO_coverage",uvm_component parent = null);
		super.new(name,parent);
		cg=new();
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		cov_export=new("cov_export",this);
		cov_fifo=new("cov_fifo",this);
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		cov_export.connect(cov_fifo.analysis_export);
	endfunction

	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		forever begin
			cov_fifo.get(seq_item_cov);
			cg.sample();
		end
	endtask : run_phase


endclass : FIFO_coverage
endpackage : FIFO_coverage_pkg