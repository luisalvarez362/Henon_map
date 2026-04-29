module mult_a_const (
    X,
    Y
);
    input  signed [31:0] X;
    output signed [31:0] Y;

    wire signed [43:0]
        w1,
        w512,
        w511,
        w64,
        w575,
        w8,
        w567,
        w2300,
        w2867,
        w5734;

    assign w1    = X;
    assign w512  = w1   << 9;
    assign w511  = w512 - w1;
    assign w64   = w1   << 6;
    assign w575  = w511 + w64;
    assign w8    = w1   << 3;
    assign w567  = w575 - w8;
    assign w2300 = w575 << 2;
    assign w2867 = w567 + w2300;
    assign w5734 = w2867 << 1;

    assign Y = w5734[43:12];   

endmodule
