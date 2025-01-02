`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:26:30
// Design Name: 
// Module Name: Control
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


module Control(
    input clk,
    input [31:0] IM_inst,
    input [31:0] i,
    input zero,
    //多路选择器信号
    output reg M10,
    output reg M11,
    output reg M20,
    output reg M21,
    output reg M3,
    output reg M4,
    output reg M5,
    //PC信号
    output PC_CLK,
    //IMEM读取信号
    output IM_R,
    //RegFile 信号
    output RF_W,
    output RF_CLK,
    //alu信号
    output [3:0] ALUC,
    //DM控制信号
    output DM_CS,
    output DM_RW,
    //控制是否进行符号扩展
    output C_EXT,
    //寄存器地址信号
    output reg [4:0] Rdc,  // 源寄存器
    output reg [4:0] Rsc,  // 目的寄存器
    output reg [4:0] Rtc   // 目标寄存器或立即数指令的寄存器
    );

    always @* begin
        M10 = ~((i[24] & zero) | (i[25] & ~zero) | i[29] | i[30]);
        M11 = i[16] | (i[24] & zero) | (i[25] & ~zero);
        M20 = i[8] | i[9] | i[22];
        M21 = i[0] | i[1] | i[2] | i[3] | i[4] | i[5] | i[6] | i[7] | i[10] | i[11] | i[12] | i[13] | i[14] | i[15] | i[17] | i[18] | i[19] | i[20] | i[21] | i[22] | i[26] | i[27] | i[28];
        M3 = i[0] | i[1] | i[2] | i[3] | i[4] | i[5] | i[6] | i[7] | i[8] | i[9] | i[17] | i[18] | i[19] | i[20] | i[21] | i[22] | i[23] | i[24] | i[25] | i[26] | i[27];
        M4 = i[17] | i[18] | i[19] | i[20] | i[21] | i[22] | i[23] | i[26] | i[27] | i[28];
        M5 = i[10] | i[11] | i[12];
        Rsc = IM_inst[25:21];
        Rtc = IM_inst[20:16];
        
        // 假设你的设计意图是：当i[31:26]等于某特定opcode时，使用Rd
        if(i[30])begin
            Rdc = 5'd31;
        end
        else if (i[16:0] == 17'd0) begin  // 假设000000是R类型指令的opcode
            Rdc = IM_inst[20:16];
        end else begin
            Rdc = IM_inst[15:11]; // I-type 或其他类型，默认使用Rt字段
        end
    end
    
    assign PC_CLK = clk;
    assign IM_R = 1;
    assign RF_W = ~(i[16] | i[23] | i[24] | i[25] | i[29]);
    assign RF_CLK = ~clk;
    assign ALUC[0] = i[2] | i[3] | i[5] | i[7] | i[8] | i[11] | i[14] | i[20] | i[24] | i[25] | i[26];
    assign ALUC[1] = i[0] | i[2] | i[6] | i[7] | i[8] | i[9] | i[10] | i[13] | i[17] | i[21] | i[22] | i[23] | i[26] | i[27];
    assign ALUC[2] = i[4] | i[5] | i[6] | i[7] | i[10] | i[11] | i[12] | i[13] | i[14] | i[15] | i[19] | i[20] | i[21];
    assign ALUC[3] = i[8] | i[9] | i[10] | i[11] | i[12] | i[13] | i[14] | i[15] | i[26] | i[27] | i[28];
    assign DM_CS = ~(i[22] | i[23]);
    assign DM_RW = i[23];
    assign C_EXT = ~(i[19] | i[20] | i[21]);
    endmodule
