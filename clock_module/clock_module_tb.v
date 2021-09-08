module clock_module_tb ();

    reg clk_generator, manual_en, adv_clk, halt;
    wire clk;

    clock_module inst (clk_generator, manual_en, adv_clk, halt, clk);

    initial begin
        clk_generator = 0;
        repeat(50) #5 clk_generator = ~clk_generator;
    end

    initial begin
        manual_en = 0;
        halt = 0;
        adv_clk = 0;
        #10 halt = 1;
        #10
        halt = 0;
        manual_en = 1;
        #2 adv_clk = 1;
        #1 adv_clk = 0;
        #2 halt = 1;
        #5 adv_clk = 1;
        #1 adv_clk = 0;


    end

    initial
        $dumpvars(0, clk_generator, manual_en, adv_clk, halt, clk);

endmodule
