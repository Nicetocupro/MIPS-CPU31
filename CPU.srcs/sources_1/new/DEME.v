`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:24:12
// Design Name: 
// Module Name: DEME
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


module DMEM(
    input clk,
    input cs,
    input rw,
    input [10:0] DM_addr,
    input [31:0] DM_wdata,
    output [31:0] DM_rdata  // 修改为reg类型，因为需要在always块中赋值
);
    reg [31:0] D_mem[0:2047];  // 扩展内存大小以匹配11位地址
    assign DM_rdata = !cs ? ( rw ? 32'h00000000 : D_mem[DM_addr]) : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

    always @(posedge clk) begin
        if (!cs) begin  // 仅在芯片选中时进行操作
            if (rw) begin
                D_mem[DM_addr] <= DM_wdata;  // 写操作
            end
        end
    end
endmodule
