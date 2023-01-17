//`include "bin_to_gray.v" //将二进制转格雷码放在写控制模块内

module write_control (
input wire w_clk,
input wire w_rst,
input wire w_req,
input wire [ADDR_WIDTH: 0] r_g_syn_addr, //使用有扩展位地址
output wire [ADDR_WIDTH: 0] w_g_addr,
output reg [ADDR_WIDTH: 0] w_addr,
output wire w_full
);

parameter ADDR_WIDTH = 4;

bin_to_gray write_control(
    .bin(w_addr),
    .gray(w_g_addr)
);

always @(posedge w_clk or negedge w_rst) begin
    if(!w_rst)begin
        w_addr <= 0;
    end else if(w_req && !(w_full))begin
        w_addr <= w_addr + 'b1;
    end
end

assign w_full = (r_g_syn_addr == {~w_g_addr[ADDR_WIDTH],~w_g_addr[ADDR_WIDTH - 1],w_g_addr[ADDR_WIDTH - 2:0]})? 1:0; //此时是格雷码的比较，不是1****-0****

endmodule