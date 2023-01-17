`include "ram.v"
`include "syn.v"
`include "bin_to_gray.v"
`include "write_control.v"
`include "read_control.v"
`include "async_fifo.v"
`timescale 10ns/1ns
module test_top;
reg w_clk;
reg r_clk;
reg w_rst;
reg r_rst;
reg rst_n;
reg w_req;
reg r_req;
reg [RAM_WIDTH - 1:0] w_data;
wire [RAM_WIDTH - 1:0] r_data;
wire w_full;
wire r_empty;

parameter RAM_WIDTH = 8;
parameter TIME_W = 10;
parameter TIME_R = 8;
integer i;

asyn_fifo test_top(
    .w_clk(w_clk),
    .r_clk(r_clk),
    .w_rst(w_rst),
    .r_rst(r_rst),
    .rst_n(rst_n),
    .w_req(w_req),
    .r_req(r_req),
    .w_data(w_data),
    .r_data(r_data),
    .w_full(w_full),
    .r_empty(r_empty)
);

always #(TIME_W/2) begin
    w_clk = ~w_clk;
end

always #(TIME_R/2) begin
    r_clk = ~r_clk;
end

initial begin
    #0 begin
        w_clk = 0;
        r_clk = 0;
        w_rst = 1;
        r_rst = 1;
        rst_n = 1;
        w_req = 0;
        r_req = 0;
        w_data = 0;
    end 
    #2 begin
        w_rst = 0;
        r_rst = 0;
        rst_n = 0;
        w_req = 0;
        r_req = 0;
        w_data = 0;
    end
    #5 begin
        w_rst = 1;
        r_rst = 1;
        rst_n = 1;
        w_req = 0;
        r_req = 0;
        w_data = 0;
    end
    #5 begin
        for(i = 0;i < 18;i++)begin
            #(TIME_W)
            w_req = 1;
            r_req = 0;
            w_data = i;
        end
        for(i = 0;i < 18;i++)begin
            #(TIME_R)
            w_req = 0;
            r_req = 1;
            $display("%d",r_data);
        end
    end
    #5 begin
        w_rst = 1;
        r_rst = 1;
        rst_n = 1;
        w_req = 0;
        r_req = 0;
        w_data = 0;
    end

    #30 $finish;
end

initial begin
    $dumpfile("wave_top.vcd");
    $dumpvars(0,test_top);
end

endmodule