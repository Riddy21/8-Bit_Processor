module program_counter_tb ();

    reg clk, clr, en, load, dataout_en;
    wire [7:0] data;
    reg [7:0] data_in;
    wire [7:0] data_out;

    assign data = (dataout_en) ? 8'hz : data_in;
    assign data_out = data;

    program_counter inst (data[3:0], dataout_en, clk, clr, en, load);

    initial begin
        clk = 0;
        repeat(50) #5 clk = ~clk;
    end

    initial begin
        clr = 1;
        en = 1;
        dataout_en = 1;
        load = 0;
        data_in = 8'b0;
        #20
        clr = 0;
        #30
        en = 0;
        #56
        en = 1;
        #14
        dataout_en = 0;
        #5
        data_in = 9;
        #5
        load = 1;
        #6
        data_in = 8'bz;
        #4
        load = 0;
        dataout_en = 1;
        #10
        clr = 1;
        #4
        clr = 0;
    end

    initial
        $dumpvars(0, clk, clr, en, load, data_in, data_out, data, dataout_en);

endmodule
