module henon_map #(
    parameter WIDTH = 16,
    parameter FRAC  = 12
)(
    input                       clk,
    input                       rst_n,
    input                       en,
    output reg  signed [WIDTH-1:0]  x_out,
    output reg  signed [WIDTH-1:0]  y_out,
    output reg                      valid
);

    localparam signed [WIDTH-1:0] ONE = 16'sd4096;

 
    reg signed [WIDTH-1:0] x_reg;
    reg signed [WIDTH-1:0] y_reg;


    wire signed [31:0]     x_reg_32;
    wire signed [63:0]     x_sq_64;
    wire signed [31:0]     x_sq_32;
    wire signed [31:0]     ax_sq_32;
    wire signed [WIDTH-1:0] ax_sq;
    wire signed [31:0]     bx_32;
    wire signed [WIDTH-1:0] bx;
    wire signed [WIDTH-1:0] x_new;
    wire signed [WIDTH-1:0] y_new;

  
    mult_a_const u_mult_a (
        .X (x_sq_32),
        .Y (ax_sq_32)
    );

    mult_b_const u_mult_b (
        .X (x_reg_32),
        .Y (bx_32)
    );

   
    assign x_reg_32 = {{(32-WIDTH){x_reg[WIDTH-1]}}, x_reg};
    assign x_sq_64  = x_reg_32 * x_reg_32;
    assign x_sq_32  = x_sq_64 >>> FRAC;
    assign ax_sq    = ax_sq_32[WIDTH-1:0];
    assign bx       = bx_32[WIDTH-1:0];
    assign x_new    = ONE - ax_sq + y_reg;
    assign y_new    = bx;

    
    always @(posedge clk) begin
        if (!rst_n) begin
            x_reg <= {WIDTH{1'b0}};
            y_reg <= {WIDTH{1'b0}};
            x_out <= {WIDTH{1'b0}};
            y_out <= {WIDTH{1'b0}};
            valid <= 1'b0;
        end else if (en) begin
            x_reg <= x_new;
            y_reg <= y_new;
            x_out <= x_new;
            y_out <= y_new;
            valid <= 1'b1;
        end
    end

endmodule
