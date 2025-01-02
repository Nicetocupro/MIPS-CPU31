`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 15:07:52
// Design Name: 
// Module Name: test_imem
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


module test_imem(
    );
    reg [10:0] a;
    reg read_enable;
    wire [31:0] spo;
    // ÊµÀý»¯ IMEM Ä£¿é
    IMEM uut(
        .address(a),
        .read_enable(read_enable),
        .instruction(spo)
    );

    initial begin
        a = 11'b0;
        read_enable = 1;
    end

    always begin
        read_enable = 1;
        #20 a = a + 1'b1;
    end
endmodule
