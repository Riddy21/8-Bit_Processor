// IO legend
// data : Data is hooked up to the bus directly, rails for reading counter
//        value and loading value into counter
// dataout_en : Enables the datat to display data on the bas
// clk : self explanatory, default clock
// counter_clr : Clears the values in the counter and resests to 0,
//               Asynchronous
// counter_en : Enables the counter to display values, if disabled will pause
//              the counter, Asyncronous
// counter_load : Preloads the counter with the value on the bus, synchronous

module program_counter(
    inout wire [3:0] data,
    input dataout_en, clk, counter_clr, counter_en, counter_load
) ;

    reg [3:0] count;

    always @(posedge clk) begin
        if (counter_load)
            count = data;
        else if (counter_en)
            count = count + 4'd1;
    end

    always @(*) count = (counter_clr) ? 4'b0 : count;

    assign data = (dataout_en) ? count : 4'bz;
    
endmodule
