//`include "bin_to_gray.v" //将二进制转格雷码放在写控制模块内

module read_control (
input wire r_clk,
input wire r_rst,
input wire r_req,
input wire [ADDR_WIDTH: 0] w_g_syn_addr, //使用有扩展位地址
output wire [ADDR_WIDTH: 0] r_g_addr,
output reg [ADDR_WIDTH: 0] r_addr,
output wire r_empty
);

parameter ADDR_WIDTH = 4;

bin_to_gray write_comtrol(
    .bin(r_addr),
    .gray(r_g_addr)
);

always @(posedge r_clk or negedge r_rst) begin
    if(!r_rst)begin
        r_addr <= 0;
    end else if(r_req && !(r_empty))begin
        r_addr <= r_addr + 'b1;
    end
end

assign r_empty = (w_g_syn_addr == r_g_addr)? 1:0;

endmodule