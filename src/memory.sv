module memory #(  
    parameter addr_p = 10,
    parameter data_width_p = 32)
(
    input logic clk_i,
    input logic rstn_i,
    input logic [addr_p-1:0] addr_i,
    input logic wr_en_i,
    input logic rd_en_i,
    input logic [data_width_p-1:0] data_i,
    output logic [data_width_p-1:0] data_o
); 
    
// Memory array 1024x32
logic [data_width_p-1:0] mem_s [2**addr_p];

MEM_PROC: always @(posedge clk) begin
    if (rstn_i == 0'b0) begin
        mem_s <= '{default: '0};
    end
    else begin
        if (wr_en == 1'b1)
        begin
            mem_s[addr_i] <= data_i;
        end
        if (rd_en_i == 1'b1)
        begin
            data_o <= mem_s[addr_i];
        end
    end
end
endmodule