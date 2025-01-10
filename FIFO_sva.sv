module FIFO_sva(FIFO_if.DUT fifo_if);

      ap_full: assert property 
      	(@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===fifo_if.FIFO_DEPTH  |-> fifo_if.full);
      cp_full: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===fifo_if.FIFO_DEPTH  |-> fifo_if.full);



      ap_almost_full: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===(fifo_if.FIFO_DEPTH-1)   |-> fifo_if.almostfull);
      cp_almost_full: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===(fifo_if.FIFO_DEPTH-1)  |-> fifo_if.almostfull);


      ap_empty: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===0 |-> fifo_if.empty);
      cp_empty: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===0 |-> fifo_if.empty);


      ap_almost_empty: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===1 |-> fifo_if.almostempty);
      cp_almost_empty: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.count===1 |-> fifo_if.almostempty);


      ap_overflow: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) fifo_if.full&&fifo_if.wr_en |=> fifo_if.overflow);
      cp_overflow: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) fifo_if.full&&fifo_if.wr_en |=> fifo_if.overflow);


      ap_underflow: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) fifo_if.empty&&fifo_if.rd_en |=> fifo_if.underflow);
      cp_underflow: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) fifo_if.empty&&fifo_if.rd_en |=> fifo_if.underflow);


      ap_wr_ack: assert property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.wr_ptr===$past(DUT.wr_ptr)+1 |-> fifo_if.wr_ack);
      cp_wr_ack: cover property 
            (@(posedge fifo_if.clk) disable iff(!fifo_if.rst_n) DUT.wr_ptr===$past(DUT.wr_ptr)+1 |-> fifo_if.wr_ack);


      always_comb begin 
            if(!fifo_if.rst_n)
                  assert_rst: assert final(DUT.count===0 && DUT.wr_ptr===0 && DUT.rd_ptr===0 );
      end

endmodule 