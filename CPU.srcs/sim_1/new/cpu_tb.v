`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/23 19:08:50
// Design Name: 
// Module Name: cpu_tb
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

module cpu_tb;
    reg clk; //ʱ���ź�
    reg rst; //��λ�ź�
    wire [31:0] inst; //Ҫִ�е�ָ��
    wire [31:0] pc; //��һ��ָ��ĵ�ַ
    //integer file_open;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #50 rst = 1'b0;
    end
    
    always begin
        #50 clk = ~clk;
    end
    
    sccomp_dataflow dataflowtb(clk,rst,inst,pc);
    
endmodule