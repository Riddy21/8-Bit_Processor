module register_8 (
    input clk, clr, en, load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] data;

    always @(posedge clk) begin
        if (en) begin
            if (clr)
                data = 8'b0;
            else if (load)
                data = data_in;
            data_out = data;
        end
        else
            data_out = 8'bz;
    end


endmodule
