module alu(
    input [7:0] a, b,
    input sub, en, flag_clk, flag_clr, flag_en,
    output reg [7:0] ans, 
    output reg carry, is_zero
);

    integer ans_wcarry;

    always @(*) begin
        case (sub)
            1 : ans_wcarry = a - b;
            0 : ans_wcarry = a + b;
        endcase

        if (en)
            ans = ans_wcarry[7:0];
        else
            ans = 8'bz;
    end

    always @(posedge flag_clk or posedge flag_clr) begin
        if (flag_clr) begin
            carry = 0;
            is_zero = 0;
        end
        else if (flag_en) begin
            carry = ans_wcarry[8];
            is_zero = (ans_wcarry  == 0);
        end
    end

endmodule
