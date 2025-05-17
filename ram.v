module ram (
    input wire clk,
    input wire we,               // Write Enable
    input wire re,               // Read Enable
    input wire [3:0] addr,       // 4-bit Address (16 locations)
    input wire [7:0] din,        // Data input
    output reg [7:0] dout        // Data output
);

    // 16 x 8-bit RAM
    reg [7:0] mem [15:0];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;
        if (re)
            dout <= mem[addr];
    end
endmodule
