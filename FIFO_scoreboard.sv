package FIFO_scoreboard_pkg;

import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(FIFO_scoreboard)

	uvm_analysis_export #(seq_item_FIFO) sb_export;
	uvm_tlm_analysis_fifo #(seq_item_FIFO) sb_fifo;
	seq_item_FIFO seq_item_sb;

	parameter FIFO_W = 16;
    parameter FIFO_D = 8;
    localparam max_fifo_addr = $clog2(FIFO_D);
    
    logic [FIFO_W-1:0] dataout_ref;
    logic [max_fifo_addr:0] counter;
    logic [FIFO_W-1:0] queue[$];
	int error_count=0 , correct_count=0;

	function new(string name ="FIFO_scoreboard",uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb_export=new("sb_export",this);
		sb_fifo=new("sb_fifo",this);
	endfunction

	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		sb_export.connect(sb_fifo.analysis_export);
	endfunction

	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		forever begin
			sb_fifo.get(seq_item_sb);
			ref_model(seq_item_sb);
			if(seq_item_sb.data_out != dataout_ref) begin
				`uvm_error("run_phase",$sformatf("comparison failed , transaction received by DUT :%s while the reference out : 0b%0b"
					,seq_item_sb.convert2string(), dataout_ref));
				error_count++;
			end
			else begin
				`uvm_info("run_phase", $sformatf("correct shift register out:%s",seq_item_sb.convert2string()),UVM_HIGH);
				correct_count++;
			end
		    
		end
	endtask : run_phase


	task ref_model(seq_item_FIFO seq_item_chk);
		if(!seq_item_chk.rst_n) begin
			dataout_ref=0;
		    counter=0;
		    queue.delete();
		end    
		else begin
			case ({seq_item_chk.wr_en, seq_item_chk.rd_en})
				2'b01: begin
				if (counter!=0) begin
					dataout_ref=queue.pop_front();
					counter=queue.size();				
				end
			    end
				2'b10:begin
				if (counter<FIFO_D) begin
					queue.push_back(seq_item_chk.data_in);
					counter=queue.size();				
				end
			    end
				2'b11: begin
				if (counter==FIFO_D) begin
					dataout_ref=queue.pop_front();
					counter=queue.size();
				end	
				else if (counter==0) begin
					queue.push_back(seq_item_chk.data_in);
					counter=queue.size();				
				end	
				else begin
					dataout_ref=queue.pop_front();
					queue.push_back(seq_item_chk.data_in);             
				    counter=queue.size();
				end			
				end
				default:
				counter=queue.size();						
			endcase
		end


	endtask

	function void report_phase (uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("report_phase", $sformatf("total successful transactions:%0d",correct_count),UVM_MEDIUM);
		`uvm_info("report_phase", $sformatf("total failed transactions:%0d",error_count),UVM_MEDIUM);
	endfunction

endclass : FIFO_scoreboard
endpackage : FIFO_scoreboard_pkg