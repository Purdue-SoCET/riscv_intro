module top (
    input logic clk_i,
    input logic rstn_i,
    input logic [31:0] mem_data_i,
    output logic [31:0] mem_data_o
);
    
memory memory_inst (
    .clk_i (clk_i),
    .rstn_i (rstn_i),
    .addr_i ,
    .wr_en_i,
    .rd_en_i,
    .data_i (mem_data_i),
    .data_o (mem_data_o)
)
    
endmodule