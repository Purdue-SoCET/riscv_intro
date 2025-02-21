module memory
#(  
    parameter int addr_p            = 10    ,
    parameter int data_width_p      = 32
)
(
    input   bit                     clk_i   ,
    input   bit                     rstn_i  ,
    input   bit [addr_p-1:0]        addr_i  ,
    input   btt                     wr_en_i ,
    input   bit                     rd_en_i ,
    input   bit [data_width_p-1:0]  data_i  ,
    output  bit [data_width_p-1:0]  data_o
); 
    
reg [data_width_p-1:0] rdata;

// Memory array 1024x32
reg [data_width_p-1:0] mem_r [2**addr_p];

RAM_PROC: always @(posedge clk) begin
    if (rstn_i == 0'b0) begin
        mem_r <= '{default: '0};
    end
    else begin //
        if (wr_en == 1'b1)
        begin
            mem_r[addr_i] <= data_i;
        end
        if (rd_en_i == 1'b1)
        begin
            data_o <= mem_r[addr_i];
        end
    end
end
