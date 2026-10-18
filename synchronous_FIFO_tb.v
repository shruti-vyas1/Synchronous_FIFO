`timescale 1ns / 1ps

module synchronous_FIFO_tb();

reg clk, rst, wr_en, rd_en;
reg [7:0] din;

wire [7:0] dout;
wire full, empty;

synchronous_FIFO uut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 0;

    #10;
    rst = 0;

    // Write data
    @(posedge clk);
    wr_en = 1;
    din = 8'h11;

    @(posedge clk);
    din = 8'h22;

    @(posedge clk);
    din = 8'h33;

    @(posedge clk);
    wr_en = 0;
    rd_en = 1;

    // Read data
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    rd_en = 0;

    #10;
    $finish;
end

endmodule
