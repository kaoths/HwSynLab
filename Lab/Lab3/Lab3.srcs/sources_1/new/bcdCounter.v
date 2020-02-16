`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 12:51:53 PM
// Design Name: 
// Module Name: bcdCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcdCounter(
    output reg [3:0] q,
    output reg cout,
    output reg bout,
    input cin,
    input bin,
    input inc,
    input dec,
    input set9,
    input set0,
    input clk
    );
initial q = 0;
always @(posedge clk)
begin
    if(set9) begin q = 4'b1001; cout = 0; bout = 0; end
    else if(set0) begin q = 4'b0000; cout = 0; bout = 0; end
    else
    begin
        if(inc)
        begin
            case(q)
                4'b1001: begin q = 4'b0000; cout = 1; bout = 0; end
                default: begin q = q + 1'b1; cout = 0; bout = 0; end
            endcase
        end
        else if(dec)
        begin
            case(q)
                4'b0000: begin q = 4'b1001; cout = 0; bout = 1; end
                default: begin q = q - 1'b1; cout = 0; bout = 0; end
            endcase
        end
        if(cin)
        begin
            case(q)
                4'b1001: begin q = 4'b0000; cout = 1; bout = 0; end
                default: begin q = q + 1'b1; cout = 0; bout = 0; end
            endcase
        end
        else if(bin)
        begin
            case(q)
                4'b0000: begin q = 4'b1001; cout = 0; bout = 1; end
                default: begin q = q - 1'b1; cout = 0; bout = 0; end
            endcase
        end
    end
end
endmodule


//case(q)
//            4'b0000: begin q = 4'b0001; cout = 0; bout = 0; end
//            4'b0001: begin q = 4'b0010; cout = 0; bout = 0; end
//            4'b0010: begin q = 4'b0011; cout = 0; bout = 0; end
//            4'b0011: begin q = 4'b0100; cout = 0; bout = 0; end
//            4'b0100: begin q = 4'b0101; cout = 0; bout = 0; end
//            4'b0101: begin q = 4'b0110; cout = 0; bout = 0; end
//            4'b0110: begin q = 4'b0111; cout = 0; bout = 0; end
//            4'b0111: begin q = 4'b1000; cout = 0; bout = 0; end
//            4'b1000: begin q = 4'b1001; cout = 0; bout = 0; end
//            4'b1001: begin q = 4'b0000; cout = 1; bout = 0; end
//            default: q = q + 1;
//        endcase
