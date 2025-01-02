`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 14:45:50
// Design Name: 
// Module Name: test
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


module test_cpu(
    );
    reg clk, rst;
    wire [31:0] inst, pc;
    reg [31:0] cnt;
    integer file_open , i;
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #0.5 rst=1'b0;
        cnt = 0;
    end

    always begin
        #0.5 clk = !clk;
    end

    always @(posedge clk) begin
        cnt <= cnt + 1'b1;
        file_open = $fopen("output.txt", "a");
        $fdisplay(file_open, "regfile0 = %h", sc.sccpu.cpu_ref. array_reg[0]);
        $fdisplay(file_open, "regfile1 = %h", sc.sccpu.cpu_ref. array_reg[1]);
        $fdisplay(file_open, "regfile2 = %h", sc.sccpu.cpu_ref. array_reg[2]);
        $fdisplay(file_open, "regfile3 = %h", sc.sccpu.cpu_ref. array_reg[3]);
        $fdisplay(file_open, "regfile4 = %h", sc.sccpu.cpu_ref. array_reg[4]);
        $fdisplay(file_open, "regfile5 = %h", sc.sccpu.cpu_ref. array_reg[5]);
        $fdisplay(file_open, "regfile6 = %h", sc.sccpu.cpu_ref. array_reg[6]);
        $fdisplay(file_open, "regfile7 = %h", sc.sccpu.cpu_ref. array_reg[7]);
        $fdisplay(file_open, "regfile8 = %h", sc.sccpu.cpu_ref. array_reg[8]);
        $fdisplay(file_open, "regfile9 = %h", sc.sccpu.cpu_ref. array_reg[9]);
        $fdisplay(file_open, "regfile10 = %h", sc.sccpu.cpu_ref. array_reg[10]);
        $fdisplay(file_open, "regfile11 = %h", sc.sccpu.cpu_ref. array_reg[11]);
        $fdisplay(file_open, "regfile12 = %h", sc.sccpu.cpu_ref. array_reg[12]);
        $fdisplay(file_open, "regfile13 = %h", sc.sccpu.cpu_ref. array_reg[13]);
        $fdisplay(file_open, "regfile14 = %h", sc.sccpu.cpu_ref. array_reg[14]);
        $fdisplay(file_open, "regfile15 = %h", sc.sccpu.cpu_ref. array_reg[15]);
        $fdisplay(file_open, "regfile16 = %h", sc.sccpu.cpu_ref. array_reg[16]);
        $fdisplay(file_open, "regfile17 = %h", sc.sccpu.cpu_ref. array_reg[17]);
        $fdisplay(file_open, "regfile18 = %h", sc.sccpu.cpu_ref. array_reg[18]);
        $fdisplay(file_open, "regfile19 = %h", sc.sccpu.cpu_ref. array_reg[19]);
        $fdisplay(file_open, "regfile20 = %h", sc.sccpu.cpu_ref. array_reg[20]);
        $fdisplay(file_open, "regfile21 = %h", sc.sccpu.cpu_ref. array_reg[21]);
        $fdisplay(file_open, "regfile22 = %h", sc.sccpu.cpu_ref. array_reg[22]);
        $fdisplay(file_open, "regfile23 = %h", sc.sccpu.cpu_ref. array_reg[23]);
        $fdisplay(file_open, "regfile24 = %h", sc.sccpu.cpu_ref. array_reg[24]);
        $fdisplay(file_open, "regfile25 = %h", sc.sccpu.cpu_ref. array_reg[25]);
        $fdisplay(file_open, "regfile26 = %h", sc.sccpu.cpu_ref. array_reg[26]);
        $fdisplay(file_open, "regfile27 = %h", sc.sccpu.cpu_ref. array_reg[27]);
        $fdisplay(file_open, "regfile28 = %h", sc.sccpu.cpu_ref. array_reg[28]);
        $fdisplay(file_open, "regfile29 = %h", sc.sccpu.cpu_ref. array_reg[29]);
        $fdisplay(file_open, "regfile30 = %h", sc.sccpu.cpu_ref. array_reg[30]);
        $fdisplay(file_open, "regfile31 = %h", sc.sccpu.cpu_ref. array_reg[31]);
        $fdisplay(file_open, "pc = %h", pc);
        $fdisplay(file_open, "cnt = %h", cnt);
        $fdisplay(file_open, "inst = %h", sc.inst);   
        $fdisplay(file_open, "D_instruction = %b", sc.sccpu.D_instruction);   
        $fdisplay(file_open, "M10 = %h", sc.sccpu.M10);
        $fdisplay(file_open, "M11 = %h", sc.sccpu.M11);
        $fdisplay(file_open, "M20 = %h", sc.sccpu.M20);
        $fdisplay(file_open, "M21 = %h", sc.sccpu.M21);
        $fdisplay(file_open, "M3 = %h", sc.sccpu.M3);
        $fdisplay(file_open, "M4 = %h", sc.sccpu.M4);
        $fdisplay(file_open, "M5 = %h", sc.sccpu.M5);
        $fdisplay(file_open, "aluc = %h", sc.sccpu.ALUC);
        $fdisplay(file_open, "D_ALU = %h", sc.sccpu.D_ALU);
        $fdisplay(file_open, "zero = %h", sc.sccpu.zero);
        $fdisplay(file_open, "negative = %h", sc.sccpu.negative);
        $fdisplay(file_open, "carry = %h", sc.sccpu.carry);
        $fdisplay(file_open, "overflow = %h", sc.sccpu.overflow);
        $fdisplay(file_open, "RF_W = %h", sc.sccpu.RF_W);
        $fdisplay(file_open, "Rdc = %d", sc.sccpu.Rdc);
        $fdisplay(file_open, "Rsc = %d", sc.sccpu.Rsc);
        $fdisplay(file_open, "Rtc = %d", sc.sccpu.Rtc);
        $fdisplay(file_open, "D_MUX1 = %h", sc.sccpu.D_MUX1);
        $fdisplay(file_open, "D_MUX2 = %h", sc.sccpu.D_MUX2);
        $fdisplay(file_open, "D_MUX3 = %h", sc.sccpu.D_MUX3);
        $fdisplay(file_open, "D_MUX4 = %h", sc.sccpu.D_MUX4);
        $fdisplay(file_open, "D_MUX5 = %h", sc.sccpu.D_MUX5);
        $fdisplay(file_open, "DM_addr = %b", sc.DM_addr);
        $fdisplay(file_open, "DM_wdata = %h", sc.DM_wdata);
        $fdisplay(file_open, "DM_rdata = %h", sc.DM_rdata);
        $fdisplay(file_open, "DM_cs = %h", sc.DM_cs);
        $fdisplay(file_open, "DM_rw = %h", sc.DM_rw);
        $fdisplay(file_open, "IM_addr = %b", sc.IM_addr);
        $fwrite(file_open, "\n");
        for (i = 0; i < 32; i = i + 1) begin
            $fdisplay(file_open, "D_mem[%0d] = %h", i, sc.dmemory.D_mem[i]);  // ´òÓ¡ÄÚ´æÄÚÈÝ
        end
        $fwrite(file_open, "\n");

        $fclose(file_open);
    end
    sccomp_dataflow sc(
        .clk_in(clk),
        .reset(rst),
        .inst(inst),
        .pc(pc)
    );
endmodule 