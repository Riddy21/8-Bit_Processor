module alu_tb();

    reg [7:0] a, b;
    reg sub, en, clk, clr, flag_en;
    wire [7:0] ans;
    wire carry, is_zero;

    alu inst (a, b, sub, en, clk, clr, flag_en, ans, carry, is_zero);

    initial begin
        $dumpvars(0, a, b, sub, en, clk, clr, flag_en, ans, carry, is_zero);
    end

    initial begin
        clk = 0;
        repeat(50) #5 clk = ~clk;
    end

    initial begin
        en = 0;
        sub = 0;
        a = 8'd20;
        b = 8'd10;
        flag_en = 1;
        clr = 0;
        #10 en = 1;
        #10 en = 0;
        #10 en = 1;
        #1 sub = 1;
        #10
        a = 8'd10;
        b = 8'd20;
        #10
        a = 8'd20;
        b = 8'd20;
        #5
        flag_en = 0;
        a = 8'd127;
        b = 8'd127;
        sub = 0;
        #10
        flag_en = 1;
        #10
        clr = 1;
    end
endmodule
