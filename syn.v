//多比特移位寄存器，打两拍，利用两级采样法使时钟同步
module syn(
input wire rst_n,
input wire syn_clk,
input wire [WIDTH - 1:0] syn_data_in,
output wire [WIDTH - 1:0] syn_data_out
);

parameter WIDTH = 5;

reg [WIDTH - 1:0] reg_0;
reg [WIDTH - 1:0] reg_1;
assign syn_data_out = reg_1;

always @(posedge syn_clk or negedge rst_n)begin
    if(!rst_n)begin
        reg_0 <= 0;
        reg_1 <= 0;
    end else begin
        reg_0 <= syn_data_in;
        reg_1 <= reg_0;
    end
end

endmodule