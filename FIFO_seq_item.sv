package FIFO_seq_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq_item_FIFO extends uvm_sequence_item;
	`uvm_object_utils(seq_item_FIFO)

 parameter FIFO_WIDTH = 16;
 parameter FIFO_DEPTH = 8;
 localparam max_fifo_addr = $clog2(FIFO_DEPTH);

 bit clk;
 rand logic [FIFO_WIDTH-1:0] data_in;
 rand bit rst_n, wr_en, rd_en;
 logic [FIFO_WIDTH-1:0] data_out;
 logic wr_ack, overflow;
 logic full, empty, almostfull, almostempty, underflow;

 integer WR_EN_ON_DIST=70 ,RD_EN_ON_DIST=30;

 constraint rst {
 	rst_n dist{1:/98,0:/2};
 }

 constraint wr_enable{
    wr_en dist {1:/WR_EN_ON_DIST,0:/100-WR_EN_ON_DIST};
 }

 constraint rd_enable{
    rd_en dist {1:/RD_EN_ON_DIST,0:/100-RD_EN_ON_DIST};
 }

 function new(string name="seq_item_FIFO");
 	super.new(name);
 endfunction : new

 function string convert2string();
 	return $sformatf("%s reset=0b%0b , write enable=0b%0b , read enable=0b%0b ,wr_ack=0b%0b,overflow=0b%0b , underflow=0b%0b, full=0b%0b ,
 	empty=0b%0b , almostfull=0b%0b , almostempty=0b%0b , datain=0b%0b ,dataout=0b%0b ",super.convert2string, rst_n , wr_en , rd_en, wr_ack, 
 	overflow, underflow , full, empty , almostfull, almostempty , data_in , data_out);
 endfunction 

 function string convert2string_stimulus();
 	return $sformatf(" reset=0b%0b ,write enable=0b%0b , read enable=0b%0b  , datain=0b%0b  ", rst_n, wr_en , rd_en, data_in );
 endfunction 

endclass : seq_item_FIFO
endpackage : FIFO_seq_item_pkg