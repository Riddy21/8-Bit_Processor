module clock_module (
    input clk_generator, manual_en, adv_clk, halt,
    output reg clk);

    initial
        clk = 0;

    always @(*) begin
        if (halt)
            clk = 1'b0;
        else if (manual_en) begin
            if (adv_clk) begin
                clk = 1'b1;
                #5 clk = 1'b0;
            end
            else
                clk = 1'b0;
        end
        else
            clk = clk_generator;
    end


endmodule
