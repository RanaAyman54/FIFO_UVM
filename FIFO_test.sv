package FIFO_test_pkg;
     
import FIFO_env_pkg::*;
import FIFO_config_pkg::*;
import FIFO_reset_seq_pkg::*;
import FIFO_read_seq_pkg::*;
import FIFO_write_seq_pkg::*;
import FIFO_read_write_seq_pkg::*;
import FIFO_random_seq_pkg::*;
import uvm_pkg::*;
 `include "uvm_macros.svh"

class FIFO_test extends uvm_test;
  `uvm_component_utils(FIFO_test)

	FIFO_env env;
	FIFO_config FIFO_cfg;
	FIFO_reset_sequence reset_seq;
	FIFO_read_sequence read_seq;
	FIFO_write_sequence write_seq;
	FIFO_read_write_sequence read_write_seq;
	FIFO_random_sequence random_seq;


	function new(string name ="FIFO_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = FIFO_env::type_id::create("env",this);
		FIFO_cfg=FIFO_config::type_id::create("FIFO_cfg",this);
		reset_seq= FIFO_reset_sequence::type_id::create("reset_seq",this);
		read_seq=FIFO_read_sequence::type_id::create("read_seq",this);
		write_seq=FIFO_write_sequence::type_id::create("write_seq",this);
		read_write_seq=FIFO_read_write_sequence::type_id::create("read_write_seq",this);
		random_seq=FIFO_random_sequence::type_id::create("random_seq",this);

		if(!uvm_config_db#(virtual FIFO_if)::get(this, "" ,"FIFO_IF", FIFO_cfg.FIFO_vif ))
			`uvm_fatal("build_phase","test - unable to get the virtual interface of the fifo from the uvm_config_db");

		uvm_config_db#(FIFO_config)::set(this, "*", "CFG",FIFO_cfg );
	endfunction

	task run_phase (uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);

		 `uvm_info("run_phase","reset asserted",UVM_LOW);
		 reset_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","reset deasserted",UVM_LOW);

		  `uvm_info("run_phase","stimulus generation started",UVM_LOW);
		  random_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","stimulus generation ended",UVM_LOW);

		 `uvm_info("run_phase","stimulus generation started",UVM_LOW);  
		  write_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","stimulus generation ended",UVM_LOW);

		 `uvm_info("run_phase","stimulus generation started",UVM_LOW);
		  read_write_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","stimulus generation ended",UVM_LOW);

		 `uvm_info("run_phase","stimulus generation started",UVM_LOW);
		  read_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","stimulus generation ended",UVM_LOW);

		

		 


		 

		phase.drop_objection(this);
	endtask : run_phase
endclass : FIFO_test
endpackage : FIFO_test_pkg