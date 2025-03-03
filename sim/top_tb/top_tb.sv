`include "riscv_if.svh"
module top_tb;

   //clock and reset signal declaration
   bit clock_i;
   bit resetn_i;

   //clock generation
   always #(riscv_if_inst.clk_period_p/2) clock_i = ~clock_i;

    //reset Generation
   initial begin
    #(3*riscv_if_inst.clk_period_p); resetn_i = 0;
    #(3*riscv_if_inst.clk_period_p); resetn_i = 1;
    end

    // Interface declarations
   riscv_if riscv_if_inst(
    .resetn_i   (resetn_i),
    .clock_i    (clock_i)
     );

    // DUT instance
  top  top_inst(
    .clk_i          (riscv_if.clock_i)      ,
    .resetn_i       (uart_if_inst.resetn_i) ,
    .mem_data_i     (12'd217)               ,
    .mem_data_o     (uart_if_inst.rx_din_i)    
    );


endmodule: top_tb