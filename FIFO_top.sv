import uvm_pkg::*;
`include "uvm_macros.svh"
import FIFO_test_pkg::*;

module FIFO_top;

bit clk;

always #1 clk=~clk;

FIFO_if fifo_if (clk);
FIFO DUT (fifo_if);
//FIFO_sva SVA (fifo_if);
bind FIFO FIFO_sva inst (fifo_if);

initial begin
		uvm_config_db#(virtual FIFO_if)::set(null, "uvm_test_top", "FIFO_IF",fifo_if );
		run_test("FIFO_test");
	end
endmodule : FIFO_top