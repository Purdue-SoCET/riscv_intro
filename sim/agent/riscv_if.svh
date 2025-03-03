interface riscv_if
    (
    input resetn_i,
    input clock_i
 );
    parameter clk_period_p     = 10; // 100MHZ
   
    // Bus Signals
    logic [11:0] mem_data_i ;
    logic mem_data_o        ;
 
 endinterface: riscv_if