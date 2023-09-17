module halfadder(input a, b, output s, c);

    assign s = a ^ b;

    assign c = a & b;

endmodule

module fulladder(input a, b, cin, output s, cout);

    wire t, c1, c2;

    halfadder ha1(a, b, t, c1);

    halfadder ha2(cin, t, s, c2);

    assign cout = c1 | c2;

endmodule

module tt_um_kbieganski_adder4b #( parameter MAX_COUNT = 10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire [4:0] c;

    fulladder fa1(ui_in[0], ui_in[4], 1'b0, uo_out[0], c[0]);

    fulladder fa2(ui_in[1], ui_in[5], c[0], uo_out[1], c[1]);

    fulladder fa3(ui_in[2], ui_in[6], c[1], uo_out[2], c[2]);

    fulladder fa4(ui_in[3], ui_in[7], c[2], uo_out[3], c[3]);

    assign uo_out[4] = c[3];

    assign uo_out[7:5] = 3'b0;
    assign uio_out = 7'b0;
    assign uio_oe = 7'b0;

endmodule
