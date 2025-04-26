`timescale 1ns / 1ps

module bram_config (
    input wire clk,
    input wire rst,
    output reg [31:0] bram_addr,
    output reg [31:0] bram_din,
    output reg        bram_we,
    input [25:0] transfer_len    //for each buffer descriptor, not total
);

    reg [5:0] step;
    reg [25:0] len_in_bytes; 

    always @(posedge clk) begin
        if (!rst) begin
            step <= 0;
            bram_addr <= 0;
            bram_din  <= 0;
            bram_we   <= 0;
            len_in_bytes <= transfer_len << 1;
        end else begin
            bram_we <= 1;
            case (step)
                // MM2S DESC 1
                0:  begin bram_addr <= 32'h00000000; bram_din <= 32'hA0010200; step <= 1; end  //NXTDESC
                1:  begin bram_addr <= 32'h00000004; bram_din <= 32'h00000000; step <= 2; end  //NXTDESC_MSB
                2:  begin bram_addr <= 32'h00000008; bram_din <= 32'h80000000; step <= 3; end  //BUFFER_ADDRESS
                3:  begin bram_addr <= 32'h0000000C; bram_din <= 32'h00000000; step <= 4; end  //BUFFER_ADDRESS_MSB
//                4:  begin bram_addr <= 32'h00000018; bram_din <= 32'h08000400; step <= 5; end  //CONTROL
                4:  begin bram_addr <= 32'h00000018; bram_din <= {6'b000010, len_in_bytes}; step <= 5; end  //CONTROL
                                                                                              
                // S2MM DESC 1                                                                
                5:  begin bram_addr <= 32'h00000100; bram_din <= 32'hA0010300; step <= 6; end  //
                6:  begin bram_addr <= 32'h00000104; bram_din <= 32'h00000000; step <= 7; end  //
                7:  begin bram_addr <= 32'h00000108; bram_din <= 32'h80000000; step <= 8; end  //
                8:  begin bram_addr <= 32'h0000010C; bram_din <= 32'h00000000; step <= 9; end  //
//                9:  begin bram_addr <= 32'h00000118; bram_din <= 32'h08000400; step <= 10; end //
                9:  begin bram_addr <= 32'h00000118; bram_din <= {6'b000010, len_in_bytes}; step <= 10; end //                                                                                              
                // MM2S DESC 2                                                                
                10: begin bram_addr <= 32'h00000200; bram_din <= 32'hA0010000; step <= 11; end //
                11: begin bram_addr <= 32'h00000204; bram_din <= 32'h00000000; step <= 12; end //
                12: begin bram_addr <= 32'h00000208; bram_din <= 32'h80010000; step <= 13; end //
                13: begin bram_addr <= 32'h0000020C; bram_din <= 32'h00000000; step <= 14; end //
//                14: begin bram_addr <= 32'h00000218; bram_din <= 32'h04000400; step <= 15; end //
                14: begin bram_addr <= 32'h00000218; bram_din <= {6'b000001, len_in_bytes}; step <= 15; end //
                                                                                              
                // S2MM DESC 2                                                                
                15: begin bram_addr <= 32'h00000300; bram_din <= 32'hA0010100; step <= 16; end //
                16: begin bram_addr <= 32'h00000304; bram_din <= 32'h00000000; step <= 17; end //
                17: begin bram_addr <= 32'h00000308; bram_din <= 32'h80010000; step <= 18; end //
                18: begin bram_addr <= 32'h0000030C; bram_din <= 32'h00000000; step <= 19; end //
//                19: begin bram_addr <= 32'h00000318; bram_din <= 32'h04000400; step <= 20; end //
                19: begin bram_addr <= 32'h00000318; bram_din <= {6'b000001, len_in_bytes}; step <= 20; end //
                default: bram_we <= 0;
            endcase
        end
    end

endmodule