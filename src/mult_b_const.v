module mult_b_const (
    X,
    Y
);
    input  signed [31:0] X;
    output signed [31:0] Y;

    wire signed [43:0]
        w1,
        w4,
        w5,
        w8,
        w13,
        w320,
        w307,
        w1228;

    assign w1    = X;
    assign w4    = w1   << 2;
    assign w5    = w1   + w4;
    assign w8    = w1   << 3;
    assign w13   = w5   + w8;
    assign w320  = w5   << 6;
    assign w307  = w320 - w13;
    assign w1228 = w307 << 2;

    assign Y = w1228[43:12];   // >> 12  (built-in Q4.12 rescale)

endmodule
