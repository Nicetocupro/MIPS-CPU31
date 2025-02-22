`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 14:00:35
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    //output [7:0]  o_seg,//输出内容
    //output [7:0]  o_sel //片选信号
);
    //wire [31:0] inst;
    //wire [31:0] pc;

    //wire clk_cpu;

    wire DM_cs , DM_rw , IM_R;
    wire [31:0] DM_wdata, DM_rdata;
    wire [31:0] instr, res;
    wire [10:0] DM_addr_calc; // 内部用于计算的地址线网
    wire [31:0] IM_addr_calc; // 内部用于计算的地址线网
    wire [10:0] DM_addr;
    wire [10:0] IM_addr;

    assign inst = instr;
    assign IM_addr = IM_addr_calc[12:2]; // 确保地址位宽匹配存储器位宽要求
    assign DM_addr = DM_addr_calc;

    IMEM imemory(
        .address(IM_addr),
        .read_enable(IM_R),
        .instruction(instr)
    );

    assign IM_addr_calc = pc - 32'h0040_0000;
    assign DM_addr_calc = (res - 32'h10010000) / 4;
    DMEM dmemory(
        .clk(clk_in),
        .cs(DM_cs),
        .rw(DM_rw),
        .DM_addr(DM_addr[10:0]),
        .DM_wdata(DM_wdata),
        .DM_rdata(DM_rdata)
    );

    CPU sccpu(
        .clk(clk_in),
        .ena(1'b1), 
        .rst(reset), 
        .IM_inst(instr), 
        .DM_rdata(DM_rdata),
        .DM_rw(DM_rw),
        .IM_R(IM_R),
        .DM_wdata(DM_wdata), 
        .DM_cs(DM_cs), 
        .PC_out(pc), 
        .address(res)
    );
/*
    seg7x16 seg7x16_inst(
        .clk(clk_in),
        .reset(reset),
        .cs(1'b1),
        .i_data(instr),
        .o_seg(o_seg),
        .o_sel(o_sel)
        );
    
    Divider Divider_inst(
        .clk(clk_in),                   //系统时钟
        .rst_n(~reset),                 //复位信号
        .clk_out(clk_cpu)               //输出适配CPU的时钟
        );
*/
endmodule
