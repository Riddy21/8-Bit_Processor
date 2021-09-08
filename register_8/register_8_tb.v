module register_8_tb ();

    reg clk, clr, en, load;
    reg [7:0] data_in;
    wire [7:0] data_out;

    register_8 inst (clk, clr, en, load, data_in, data_out);

    initial begin
        clk = 0;
        repeat(50) #5 clk = ~clk;
    end

    initial begin
        load = 1;
        en = 1;
        data_in = 8'd255;
        clr = 0;
        #10 load = 0;
        #10 data_in = 0;
        #10 en = 0;
        #10 en = 1;
        #10 clr = 1;
        #10 clr = 0;

    end

    initial
        $dumpvars(0, clk, clr, en, load, data_in, data_out);

endmodule
