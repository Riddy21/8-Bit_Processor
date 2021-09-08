module ram_tb ();

    reg [3:0] addr_in, addr_in_manual;
    reg program_mode, addr_clr, clk, addr_en, load_manual, load, dataout_en;
    reg [7:0] data_in_manual;
    wire [7:0] data;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire [7:0] memory;
    wire load_clked;

    assign data = (dataout_en) ? 8'hz : data_in;
    assign data_out = data;
    ram inst (addr_in, addr_in_manual, program_mode, addr_clr, clk, addr_en, load_manual, load, dataout_en, data_in_manual, data, memory, load_clked);

    initial begin
        clk = 0;
        repeat(50) #5 clk = ~clk;
    end

    initial begin
        // test manual entry mode first
        program_mode = 1;
        load_manual = 0;
        dataout_en = 0;
        data_in_manual = 0;
        addr_in_manual = 0;
        addr_clr = 0;
        #5
        data_in_manual = 8'ha;
        #1
        load_manual = 1;
        #1
        load_manual = 0;
        dataout_en = 1;
        #1
        addr_in_manual = 4'b0001;
        #1
        data_in_manual = 8'h1b;
        load_manual = 1;
        #1
        load_manual = 0;
        #1
        addr_in_manual = 4'b0;

        #10
        // Test automatic mode
        program_mode = 0;
        addr_en = 0;
        dataout_en = 0;
        load = 0;
        #1
        addr_in = 4'b1010;
        #5
        addr_en = 1;
        #5
        data_in = 8'haa;
        #1
        load = 1;
        #5
        load = 0;
        #10
        data_in = 8'hz;
        #5
        dataout_en = 1;
        #5
        addr_en = 0;
        #5
        addr_in = 4'b0001;
        #5
        addr_en = 1;
        #10
        addr_en = 0;
        #10
        addr_clr = 1;
        #1
        addr_clr = 0;
        #10
        addr_en = 1;

    end

    initial
        $dumpvars(0, addr_in, addr_in_manual, program_mode, addr_clr, clk, addr_en, load_manual, load, dataout_en, data_in_manual, data, data_in, data_out, memory, load_clked);

endmodule
