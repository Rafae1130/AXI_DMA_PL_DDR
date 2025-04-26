//////module data_transfer #(
//////    parameter N = 16,
//////    parameter DATA_WIDTH = 8
//////)(
//////    input  wire              clk,
//////    input  wire              rst,
//////    input  wire              start,
//////    input  wire [DATA_WIDTH-1:0] data_in,
//////    input  wire              valid_in,
//////    input  wire              tready_in,
//////    output reg  [DATA_WIDTH-1:0] tdata_out,
//////    output reg               tvalid_out,
//////    output reg               tready_out,
//////    output reg               tlast_out,
//////    output  reg [$clog2(N):0] counter
//////);

//////    reg active;
////////    reg [$clog2(N):0] counter;

//////    always @(posedge clk) begin
//////        if (!rst) begin
//////            active     <= 1'b0;
//////            counter    <= 0;
//////            tdata_out  <= 0;
//////            tvalid_out <= 1'b0;
//////            tready_out <= 1'b0;
//////            tlast_out  <= 1'b0;
//////        end else begin
//////            tlast_out <= 1'b0; // Default

//////            if (start) begin
//////                active     <= 1'b1;
//////                counter    <= 0;
//////                tready_out <= 1'b1;
//////            end

//////            if (active && valid_in && tready_in) begin
//////                tdata_out  <= data_in;
//////                tvalid_out <= 1'b1;
//////                counter    <= counter + 1;

//////                if (counter == N - 1) begin
//////                    active     <= 1'b0;
//////                    tready_out <= 1'b0;
//////                    tlast_out  <= 1'b1;
//////                 end
////////                end else if (!tready_in) begin
////////                    tready_out <= 1'b0;
////////                end
////////                if (counter + 1 == N || counter + 1 == N/2) begin
////////                    tlast_out  <= 1'b1;                
////////                end
//////            end else begin
//////                tvalid_out <= 1'b0;

//////                if (active && tready_in) begin
//////                    tready_out <= 1'b1;
//////                end else begin
//////                    tready_out <= 1'b0;
//////                end
//////            end
//////        end
//////    end

//////endmodule


////module data_transfer #(
////    parameter N = 16,
////    parameter DATA_WIDTH = 8
////)(
////    input  wire              clk,
////    input  wire              rst,
////    input  wire              start,
////    input  wire [DATA_WIDTH-1:0] data_in,
////    input  wire              valid_in,
////    input  wire              tready_in,
////    output reg  [DATA_WIDTH-1:0] tdata_out,
////    output reg               tvalid_out,
////    output reg               tready_out,
////    output reg               tlast_out,
////    output reg  [$clog2(N):0] counter
////);

////    reg active;
////    reg flag;
////    always @(posedge clk) begin
////        if (!rst) begin
////            active     <= 1'b0;
////            counter    <= 0;
////            tdata_out  <= 0;
////            tvalid_out <= 1'b0;
////            tready_out <= 1'b0;
////            tlast_out  <= 1'b0;
////        end else begin
////            tlast_out <= 1'b0;

////            if (start) begin
////                active     <= 1'b1;
////                counter    <= 0;
////                tready_out <= 1'b1;
////                flag <= 0;
////            end

////            if (active && valid_in && tready_in) begin
////                tdata_out  <= data_in;
////                tvalid_out <= 1'b1;
////                flag <= 1;
               
               
////                if (counter == N - 2) begin
////                    tlast_out  <= 1'b1;
////                end
////                if (counter == N - 1) begin
////                    active     <= 1'b0;
////                    tready_out <= 1'b0;
////                    tlast_out  <= 1'b0;
////                end
////                if(flag == 1) begin
////                    counter <= counter + 1;
////                end
////            end else begin
////                tvalid_out <= 1'b0;

////                if (active && tready_in) begin
////                    tready_out <= 1'b1;
////                end else begin
////                    tready_out <= 1'b0;
////                end
////            end
////        end
////    end

////endmodule
////`timescale 1ns / 1ps

////module data_transfer #(
////    parameter integer COUNT = 16,
////    parameter integer DATA_WIDTH = 32
////)(
////    input  wire                  clk,
////    input  wire                  rst,
////    input  wire                  start,
////    input  wire                  valid,
////    input  wire [DATA_WIDTH-1:0] data_in,
////    output reg  [DATA_WIDTH-1:0] tdata,
////    output reg                   tvalid,
////    output reg                   tlast,
////    output wire [DATA_WIDTH/8-1:0] tkeep,
////    input  wire                  tready,
////    output reg [$clog2(COUNT):0] counter
////);

////    localparam IDLE = 1'b0,
////               SEND = 1'b1;

////    reg state, next_state;
////    reg [$clog2(COUNT):0] counter;

////    assign tkeep = {DATA_WIDTH/8{1'b1}};

////    // FSM: state transition
////    always @(posedge clk) begin
////        if (!rst)
////            state <= IDLE;
////        else
////            state <= next_state;
////    end

////    // FSM: next state logic
////    always @(*) begin
////        case (state)
////            IDLE:
////                next_state = start ? SEND : IDLE;
////            SEND:
////                next_state = (counter == COUNT) ? IDLE : SEND;
////            default:
////                next_state = IDLE;
////        endcase
////    end

////    // Counter and outputs
////    always @(posedge clk) begin
////        if (!rst) begin
////            counter <= 0;
////            tdata   <= 0;
////            tvalid  <= 0;
////            tlast   <= 0;
////        end else begin
////            case (state)
////                IDLE: begin
////                    counter <= 0;
////                    tvalid  <= 0;
////                    tlast   <= 0;
////                end
////                SEND: begin
////                    tvalid <= valid;
////                    tlast  <= 0;
////                    if (valid && tvalid && tready) begin
////                        tdata   <= data_in;
////                        counter <= counter + 1;
////                        if (counter == COUNT - 1)
////                            tlast <= 1;
////                    end
////                end
////            endcase
////        end
////    end

////endmodule
//`timescale 1ns / 1ps

//module data_transfer #(
//    parameter N = 16,
//    parameter DATA_WIDTH = 8
//)(
//    input  wire                  clk,
//    input  wire                  rst,
//    input  wire                  start,
//    input  wire [DATA_WIDTH-1:0] data_in,
//    input  wire                  valid_in,
//    input  wire                  tready_in,
//    output reg  [DATA_WIDTH-1:0] tdata_out,
//    output reg                   tvalid_out,
//    output reg                   tready_out,
//    output reg                   tlast_out,
//    output reg [$clog2(N):0]     counter
//);

//    reg active;

//    always @(posedge clk) begin
//        if (!rst) begin
//            active      <= 1'b0;
//            counter     <= 0;
//            tdata_out   <= 0;
//            tvalid_out  <= 1'b0;
//            tready_out  <= 1'b0;
//            tlast_out   <= 1'b0;
//        end else begin
//            tlast_out <= 1'b0; // Default

//            if (start) begin
//                active      <= 1'b1;
//                counter     <= 0;
//                tready_out  <= 1'b1;
//            end

//            if (active) begin
//                if (valid_in && tready_in) begin
//                    tdata_out   <= data_in;
//                    tvalid_out  <= 1'b1;

//                    if (counter == N - 1) begin
//                        tlast_out   <= 1'b1;
//                        active      <= 1'b0;
//                        tready_out  <= 1'b0;
//                    end

//                    counter <= counter + 1;
//                end else if (tvalid_out && !tready_in) begin
//                    tvalid_out <= tvalid_out; // hold
//                end else begin
//                    tvalid_out <= 1'b0;
//                end

//                // tready_out is asserted only when active and ready to receive
//                tready_out <= active;
//            end else begin
//                tvalid_out <= 1'b0;
//                tready_out <= 1'b0;
//            end
//        end
//    end

//endmodule


// axi_stream_master.v

module data_transfer #(
    parameter DATA_WIDTH = 32
//    parameter COUNT = 16
)(
    input  wire                     clk,
    input  wire                     resetn,
    input  wire                     start,
    input  wire                     valid_in,
    input  wire [DATA_WIDTH-1:0]   data_in,
    input  wire [25:0]              count,

    // AXI Stream Master Interface
    output reg  [DATA_WIDTH-1:0]   m_axis_tdata,
    output reg                     m_axis_tvalid,
    input  wire                    m_axis_tready,
    output reg                     m_axis_tlast
);

    reg [25:0] transfer_count;
    reg sending;
    reg [25:0] count_reg;

    always @(posedge clk) begin
        if (!resetn) begin
            sending         <= 1'b0;
            transfer_count  <= 0;
            m_axis_tvalid   <= 1'b0;
            m_axis_tlast    <= 1'b0;
            m_axis_tdata    <= {DATA_WIDTH{1'b0}};
            count_reg <= count;
        end else begin
            count_reg <= count;
            if (!sending) begin
                if (start && valid_in) begin
                    sending         <= 1'b1;
                    transfer_count  <= 0;
                    m_axis_tdata    <= data_in;
                    m_axis_tvalid   <= 1'b1;
                    m_axis_tlast    <= 1'b0;
                    
                end
            end else begin
                if (m_axis_tready) begin
                    transfer_count  <= transfer_count + 1'b1;
                    m_axis_tdata    <= data_in;

                    if (transfer_count == count_reg - 2) begin
                        m_axis_tlast <= 1'b1;
                    end else begin
                        m_axis_tlast <= 1'b0;
                    end

                    if (transfer_count == count_reg - 1) begin
                        sending       <= 1'b0;
                        m_axis_tvalid <= 1'b0;
                        m_axis_tlast  <= 1'b0;
                    end
                end
            end
        end
    end

endmodule
