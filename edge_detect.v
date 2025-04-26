module edge_detector (
    input  wire clk,
    input  wire rst,
    input  wire signal_in,
    output reg  pulse_out
);

    reg signal_d;

    always @(posedge clk) begin
        if (!rst) begin
            signal_d  <= 1'b0;
            pulse_out <= 1'b0;
        end else begin
            signal_d  <= signal_in;
            pulse_out <= signal_in & ~signal_d; // High for one cycle on rising edge
        end
    end

endmodule
