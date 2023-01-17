
module asyn_fifo (
input wire w_clk,
input wire r_clk,
input wire w_rst,
input wire r_rst,
input wire rst_n,
input wire w_req,
input wire r_req,
input wire [RAM_WIDTH - 1:0] w_data,
output wire [RAM_WIDTH - 1:0] r_data,
output wire w_full,
output wire r_empty
);

wire [ADDR_WIDTH: 0] w_addr;
wire [ADDR_WIDTH: 0] r_addr;
wire [ADDR_WIDTH: 0] w_g_addr;
wire [ADDR_WIDTH: 0] r_g_addr;
wire [ADDR_WIDTH: 0] w_g_syn_addr;
wire [ADDR_WIDTH: 0] r_g_syn_addr;
wire en_write;
wire en_read;

assign en_write = (w_req && (!w_full))? 1:0;
assign en_read = (r_req && (!r_empty))? 1:0;

parameter RAM_WIDTH = 8;
parameter ADDR_WIDTH = 4;

write_control asyn_fifo_write_control(
    .w_clk(w_clk),
    .w_rst(w_rst),
    .w_req(w_req),
    .r_g_syn_addr(r_g_syn_addr),
    .w_g_addr(w_g_addr),
    .w_addr(w_addr),
    .w_full(w_full)
);

read_control asyn_fifo_read_control(
    .r_clk(r_clk),
    .r_rst(r_rst),
    .r_req(r_req),
    .r_g_addr(r_g_addr),
    .w_g_syn_addr(w_g_syn_addr),
    .r_addr(r_addr),
    .r_empty(r_empty)
);

ram asyn_fifo_ram(
    .w_clk(w_clk),
    .r_clk(r_clk),
    .en_write(en_write),
    .en_read(en_read),
    .w_addr(w_addr[ADDR_WIDTH - 1:0]),
    .r_addr(r_addr[ADDR_WIDTH - 1:0]),
    .w_data(w_data),
    .r_data(r_data)
);

syn asyn_fifo_syn_w(
    .rst_n(rst_n),
    .syn_clk(w_clk),
    .syn_data_in(r_g_addr),
    .syn_data_out(r_g_syn_addr)
);

syn asyn_fifo_syn_r(
    .rst_n(rst_n),
    .syn_clk(r_clk),
    .syn_data_in(w_g_addr),
    .syn_data_out(w_g_syn_addr)
);
//ram #(
//    .ADDR_WIDTH(ADDR_WIDTH), 可以将参数在例化时传递
//    ...
//    )
//u_ram(
//  .w_clk(w_clk),
//  ...
//);


endmodule