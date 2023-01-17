module ram(
input wire w_clk,
input wire r_clk,
input wire en_write,
input wire en_read,
input wire [ADDR_WIDTH - 1:0] w_addr,
input wire [ADDR_WIDTH - 1:0] r_addr,
input wire [RAM_WIDTH - 1:0] w_data,
output reg [RAM_WIDTH - 1:0] r_data
);

reg [RAM_WIDTH - 1:0] memory[RAM_HIGH - 1:0];

parameter ADDR_WIDTH = 4;
parameter RAM_HIGH = 16;
parameter RAM_WIDTH = 8;

always @(posedge r_clk)begin
    if(en_read)begin
        r_data <= memory[r_addr];
    end
end

always @(posedge w_clk)begin
    if(en_write)begin
        memory[w_addr] <= w_data;
    end
end 

endmodule