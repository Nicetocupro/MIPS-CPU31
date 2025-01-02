`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:33:50
// Design Name: 
// Module Name: CPU
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

module CPU(
    input clk,
    input ena,
    input rst,
    input [31:0] IM_inst,
    input [31:0] DM_rdata,
    output DM_cs,
    output DM_rw,
    output [31:0] DM_wdata,
    output IM_R,
    output [31:0] PC_out,
    output [31:0] address
    );
    
    // 解码后的指令
    wire [31:0] D_instruction;
    // 控制信号
    wire M10 , M11 , M20 , M21 , M3 , M4 , M5;  
    // PC寄存器相关内容
    wire PC_CLK; // PC信号
    wire PC_ENA;//PC使能信号
    wire [31:0] D_PC; //PC输出信号
    // ALU信号
    wire [3:0] ALUC;//ALU控制信号
    wire [31:0] D_ALU;//ALU输出信号
    wire zero , carry , negative , overflow;//ALU其他信号
    // RegFile 信号
    wire RF_W;//寄存器堆读写信号
    wire RF_CLK;
    wire [4:0] Rdc;
    wire [4:0] Rsc;
    wire [4:0] Rtc;
    wire [31:0] Rs;
    wire [31:0] Rt;
    //多路选择器输出信号
    wire [31:0] D_MUX1;
    wire [31:0] D_MUX2;
    wire [31:0] D_MUX3;
    wire [31:0] D_MUX4;
    wire [4:0] D_MUX5;
    //II输出的数据
    wire [31:0] D_II;
    //NPC输出信号
    wire [31:0] D_NPC;
    //ADD输出信号
    wire [31:0] D_ADD;
    wire add_overflow;
    //ADD8输出信号
    wire [31:0] D_ADD8;
    //扩展位输出信号
    wire [31:0] D_EXT5;
    wire [31:0] D_EXT16;
    wire [31:0] D_EXT18;
    wire C_EXT; //控制是否进行符号扩展
    // inst[15:0] 左移两位，低位补0
    wire [17:0] shifted_input = {IM_inst[15:0], 2'b00};
    
    assign PC_ENA = 1;
    assign PC_out = D_PC;
    assign address = D_ALU;
    assign DM_wdata = Rt;
    
    // 指令译码器
    Instruction_Decoder ins_str(IM_inst ,D_instruction);
    //控制器
    Control Ctrl(clk ,IM_inst , D_instruction  , zero , M10 , M11 , M20 , M21 , M3 , M4 , M5 , PC_CLK , IM_R , RF_W , RF_CLK , ALUC , DM_cs , DM_rw , C_EXT , Rdc , Rsc , Rtc);
    //PC寄存器
    PcReg pc(clk , rst , PC_ENA ,D_MUX1 , D_PC);
    //alu
    ALU alu(D_MUX3 , D_MUX4 , ALUC , D_ALU , zero , carry , negative , overflow);
    //RegFile
    RegFile cpu_ref(ena , rst , RF_CLK , Rdc , Rsc , Rtc , D_MUX2 , Rs , Rt , RF_W);
    //mux多路选择器
    mux4 mux1(D_II , D_NPC , D_ADD , Rs , {M11 , M10} , D_MUX1);
    mux4 mux2(D_ADD8 , D_ALU , D_ALU , DM_rdata , {M21 , M20} , D_MUX2);
    mux mux3(D_EXT5 , Rs , M3 , D_MUX3);
    mux mux4(Rt , D_EXT16 , M4 , D_MUX4);
    mux5 mux5(Rs[4:0] , IM_inst[10:6] , M5 , D_MUX5);
    //数据扩展
    extend #(.WIDTH(5)) extend5(D_MUX5 ,1'd0 , D_EXT5);
    extend #(.WIDTH(16)) extend16(IM_inst[15:0] , C_EXT , D_EXT16);
    extend #(.WIDTH(18)) extend18(shifted_input , 1'd1 , D_EXT18);
    //其他计算
    add add(D_EXT18 , D_NPC , D_ADD , add_overflow);
    add8 add8(D_PC , D_ADD8);
    npc npc(D_PC , rst , D_NPC);
    II II( D_PC[31:28] , IM_inst[25:0] , D_II);
    
endmodule
