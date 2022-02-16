// IO legend
// addr_in : the address to be read
// addr_in_manual : manual entry poitn of the address to be read
// program_mode : the switch is to control whether using manual ram loading or
//                running mode, 1 is manual mode
// add_clr : clears the address register
// clk : self explanatory, default clock
// addr_en : Enables the input reading of the address register
// load_manual : Manual load switch used for loading a program into ram
//               manually
// load : Automatic load switch for programming loading itself
// dataout_en : Enables the data to display data on the bus
// data_in_manual : Switches for manualling loading data ** Could be taken out
//                  along with load_manual if hooking it up directly to the
//                  normal load, but I have to think about it
// data : Data is hooked up to the bus directly, rails for reading and writing
//        data in the memory

module ram (
    input [3:0] addr_in,
    input [3:0] addr_in_manual,
    input program_mode, addr_clr, clk, addr_en, load_manual, load, dataout_en,
    input [7:0] data_in_manual,
    inout wire [7:0] data
) ;

    // Declare the memory and address register
    reg [7:0] memory [16:0];
    reg [3:0] addr;

    // All the wires for controled by the choice of the program mode swich
    // Write enable is the wire that dictates the writing of the memory
    wire load_en;
    // the final data wire that muxes between the manual and bus data
    wire [7:0] data_in_final;
    // the final address wire that muxes between the manual and bus data
    wire [3:0] addr_in_final;

    // load_clked is the clk edge induced load
    reg load_clked;

    // load_en handler block
    always @(posedge clk) begin
        if (load) begin
            load_clked = 1;
            #1
            load_clked = 0;
        end
        else
            load_clked = 0;
    end

    // sets up IO according to the program mode
    assign load_en = (program_mode) ? load_manual : load_clked;
    assign data_in_final = (program_mode) ? data_in_manual : data;
    assign addr_in_final = (program_mode) ? addr_in_manual : addr;

    // addr_in handler block
    always @(posedge clk) begin
        if (addr_en)
            addr = addr_in;
    end

    always @(*) if (addr_clr) addr = 4'b0;


    // memory handler block
    always @(*)
        if (load_en) memory[addr_in_final] = data_in_final;

    assign data = (dataout_en) ? memory[addr_in_final] : 8'bz;

endmodule
