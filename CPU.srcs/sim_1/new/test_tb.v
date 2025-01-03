`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 21:21:11
// Design Name: 
// Module Name: test_tb
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


module test_tb();
    reg clk;            //时钟信号
    reg rst;            //复位信号
    wire [31:0] inst;   //要执行的指令
    wire [31:0] pc;     //下一条指令的地址
    wire [7:0]  o_seg;  //输出内容
    wire [7:0]  o_sel;  //片选信号
    wire clk_cpu;
    //integer file_open;
    
    initial 
    begin
        clk = 1'b0;
        rst = 1'b1;
        #50 rst = 1'b0;
    end
    
    always  #50 clk = ~clk;
    
    sccomp_dataflow sc_inst(
        .clk_in(clk),
        .reset(rst),
        .inst(inst), //输出指令
        .pc(pc),   //执行地址
        .o_seg(o_seg),//输出内容
        .o_sel(o_sel) //片选信号
    );
endmodule
