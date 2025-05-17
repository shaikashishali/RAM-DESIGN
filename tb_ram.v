`timescale 1ns / 1ps

module tb_ram;

    reg clk;
    reg we;
    reg re;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    // Instantiate the RAM
    sync_ram uut (
        .clk(clk),
        .we(we),
        .re(re),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Start dumping signals to VCD
        $dumpfile("ram.vcd");
        $dumpvars(0, tb_ram);

        // Initialize inputs
        we = 0; re = 0; addr = 0; din = 0;

        // Wait a bit before starting write/read to capture in VCD
        #10;

        // Write values
        @(posedge clk); addr = 4'd1; din = 8'd55; we = 1;
        @(posedge clk); addr = 4'd2; din = 8'd100;
        @(posedge clk); addr = 4'd3; din = 8'd200;
        @(posedge clk); we = 0;

        // Read values
        @(posedge clk); addr = 4'd1; re = 1;
        @(posedge clk); addr = 4'd2;
        @(posedge clk); addr = 4'd3;
        @(posedge clk); re = 0;

        // Wait and finish
        #20;
        $display("Simulation Complete.");
        $finish;
    end
endmodule
