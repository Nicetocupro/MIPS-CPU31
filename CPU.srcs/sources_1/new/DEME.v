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
    output [31:0] DM_rdata  // �޸�Ϊreg���ͣ���Ϊ��Ҫ��always���и�ֵ
);
    reg [31:0] D_mem[0:2047];  // ��չ�ڴ��С��ƥ��11λ��ַ
    assign DM_rdata = !cs ? ( rw ? 32'h00000000 : D_mem[DM_addr]) : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

    always @(posedge clk) begin
        if (!cs) begin  // ����оƬѡ��ʱ���в���
            if (rw) begin
                D_mem[DM_addr] <= DM_wdata;  // д����
            end
        end
    end
endmodule
