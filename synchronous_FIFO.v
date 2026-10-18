
`timescale 1ns / 1ps
module synchronous_FIFO(clk, rst, wr_en, rd_en, din, dout, full, empty);

input clk, rst, wr_en, rd_en;
input [7:0] din;

output reg [7:0] dout;
output full, empty;

reg [7:0] memory [0:7];
reg [2:0] wr_ptr, rd_ptr;
reg [3:0] count;

assign full = (count == 8);
assign empty = (count == 0);

always @(posedge clk)
begin
    if (rst)
    begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
        dout <= 0;
    end
    else
    begin
        if (wr_en && !full)
        begin
            memory[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;
        end

        if (rd_en && !empty)
        begin
            dout <= memory[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end

        if (wr_en && !full && !(rd_en && !empty))
        begin
            count <= count + 1;
        end
        else if (rd_en && !empty && !(wr_en && !full))
        begin
            count <= count - 1;
        end
    end
end

endmodule
