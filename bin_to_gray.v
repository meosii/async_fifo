//二进制转格雷码，第一位不变，其余为当前以及前一位的异或
module bin_to_gray (
input wire [WIDTH - 1:0] bin,
output wire [WIDTH - 1:0] gray
);

wire high_bit_bin = bin[WIDTH - 1] ;
reg [WIDTH - 2:0] low_bit_gray;
integer i;
parameter WIDTH = 5; //包含地址溢出位

always @(*)begin
    for(i = 0;i < WIDTH - 1;i++)begin
        low_bit_gray[i] = bin[i+1]^bin[i];
    end
end

assign gray = {high_bit_bin,low_bit_gray};
    
endmodule