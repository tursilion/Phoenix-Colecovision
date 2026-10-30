// Behavioural models of the Spartan-6 primitives in an XST netlist
// (netgen -sim), for Verilator: enough to run the netlist the way the
// FPGA does, without the UNISIM library's timing and reset machinery.

`timescale 1ns / 1ps

module GND(output G); assign G = 1'b0; endmodule
module VCC(output P); assign P = 1'b1; endmodule
module INV(output O, input I); assign O = ~I; endmodule
module MULT_AND(output LO, input I0, input I1); assign LO = I0 & I1; endmodule
module MUXCY(output O, input CI, input DI, input S); assign O = S ? CI : DI; endmodule
module MUXF7(output O, input I0, input I1, input S); assign O = S ? I1 : I0; endmodule
module MUXF8(output O, input I0, input I1, input S); assign O = S ? I1 : I0; endmodule
module XORCY(output O, input CI, input LI); assign O = CI ^ LI; endmodule

module LUT1 #(parameter [1:0] INIT = 0) (output O, input I0);
  assign O = INIT[I0];
endmodule
module LUT2 #(parameter [3:0] INIT = 0) (output O, input I0, I1);
  assign O = INIT[{I1, I0}];
endmodule
module LUT3 #(parameter [7:0] INIT = 0) (output O, input I0, I1, I2);
  assign O = INIT[{I2, I1, I0}];
endmodule
module LUT4 #(parameter [15:0] INIT = 0) (output O, input I0, I1, I2, I3);
  assign O = INIT[{I3, I2, I1, I0}];
endmodule
module LUT5 #(parameter [31:0] INIT = 0) (output O, input I0, I1, I2, I3, I4);
  assign O = INIT[{I4, I3, I2, I1, I0}];
endmodule
module LUT6 #(parameter [63:0] INIT = 0) (output O, input I0, I1, I2, I3, I4, I5);
  assign O = INIT[{I5, I4, I3, I2, I1, I0}];
endmodule

module FD #(parameter INIT = 1'b0) (output reg Q, input C, input D);
  initial Q = INIT;
  always @(posedge C) Q <= D;
endmodule
module FDE #(parameter INIT = 1'b0) (output reg Q, input C, input CE, input D);
  initial Q = INIT;
  always @(posedge C) if (CE) Q <= D;
endmodule
module FDC #(parameter INIT = 1'b0) (output reg Q, input C, input CLR, input D);
  initial Q = INIT;
  always @(posedge C or posedge CLR) if (CLR) Q <= 0; else Q <= D;
endmodule
module FDCE #(parameter INIT = 1'b0) (output reg Q, input C, input CE, input CLR, input D);
  initial Q = INIT;
  always @(posedge C or posedge CLR) if (CLR) Q <= 0; else if (CE) Q <= D;
endmodule
module FDP #(parameter INIT = 1'b1) (output reg Q, input C, input PRE, input D);
  initial Q = INIT;
  always @(posedge C or posedge PRE) if (PRE) Q <= 1; else Q <= D;
endmodule
module FDPE #(parameter INIT = 1'b1) (output reg Q, input C, input CE, input PRE, input D);
  initial Q = INIT;
  always @(posedge C or posedge PRE) if (PRE) Q <= 1; else if (CE) Q <= D;
endmodule
module FDR #(parameter INIT = 1'b0) (output reg Q, input C, input R, input D);
  initial Q = INIT;
  always @(posedge C) if (R) Q <= 0; else Q <= D;
endmodule
module FDRE #(parameter INIT = 1'b0) (output reg Q, input C, input CE, input R, input D);
  initial Q = INIT;
  always @(posedge C) if (R) Q <= 0; else if (CE) Q <= D;
endmodule
module FDS #(parameter INIT = 1'b1) (output reg Q, input C, input S, input D);
  initial Q = INIT;
  always @(posedge C) if (S) Q <= 1; else Q <= D;
endmodule

module SRLC16E #(parameter [15:0] INIT = 0)
  (output Q, output Q15, input A0, A1, A2, A3, input CE, input CLK, input D);
  reg [15:0] sr = INIT;
  always @(posedge CLK) if (CE) sr <= {sr[14:0], D};
  assign Q   = sr[{A3, A2, A1, A0}];
  assign Q15 = sr[15];
endmodule

// Block RAM port: width w (1, 2, 4, 9, 18, 36) as data bits and parity
// bits per entry, and the low address bits it ignores.
module RAMB16BWER #(
    parameter integer DATA_WIDTH_A = 0, parameter integer DATA_WIDTH_B = 0,
    parameter integer DOA_REG = 0, parameter integer DOB_REG = 0,
    parameter EN_RSTRAM_A = "TRUE", parameter EN_RSTRAM_B = "TRUE",
    parameter [35:0] INIT_A = 0, parameter [35:0] INIT_B = 0,
    parameter RSTTYPE = "SYNC", parameter RST_PRIORITY_A = "CE", parameter RST_PRIORITY_B = "CE",
    parameter SIM_COLLISION_CHECK = "ALL", parameter SIM_DEVICE = "SPARTAN6",
    parameter [35:0] SRVAL_A = 0, parameter [35:0] SRVAL_B = 0,
    parameter WRITE_MODE_A = "WRITE_FIRST", parameter WRITE_MODE_B = "WRITE_FIRST",
    parameter INIT_FILE = "NONE"
  ) (
    output reg [31:0] DOA, output reg [3:0] DOPA, output reg [31:0] DOB, output reg [3:0] DOPB,
    input [13:0] ADDRA, input [13:0] ADDRB, input CLKA, input CLKB,
    input [31:0] DIA, input [31:0] DIB, input [3:0] DIPA, input [3:0] DIPB,
    input ENA, input ENB, input REGCEA, input REGCEB, input RSTA, input RSTB,
    input [3:0] WEA, input [3:0] WEB
  );
  localparam DWA = DATA_WIDTH_A == 36 ? 32 : DATA_WIDTH_A == 18 ? 16 : DATA_WIDTH_A == 9 ? 8 : DATA_WIDTH_A;
  localparam PWA = DATA_WIDTH_A == 36 ? 4 : DATA_WIDTH_A == 18 ? 2 : DATA_WIDTH_A == 9 ? 1 : 0;
  localparam SA  = DATA_WIDTH_A == 36 ? 5 : DATA_WIDTH_A == 18 ? 4 : DATA_WIDTH_A == 9 ? 3 :
                   DATA_WIDTH_A == 4 ? 2 : DATA_WIDTH_A == 2 ? 1 : 0;
  localparam DWB = DATA_WIDTH_B == 36 ? 32 : DATA_WIDTH_B == 18 ? 16 : DATA_WIDTH_B == 9 ? 8 : DATA_WIDTH_B;
  localparam PWB = DATA_WIDTH_B == 36 ? 4 : DATA_WIDTH_B == 18 ? 2 : DATA_WIDTH_B == 9 ? 1 : 0;
  localparam SB  = DATA_WIDTH_B == 36 ? 5 : DATA_WIDTH_B == 18 ? 4 : DATA_WIDTH_B == 9 ? 3 :
                   DATA_WIDTH_B == 4 ? 2 : DATA_WIDTH_B == 2 ? 1 : 0;

  reg [16383:0] d = 0;
  reg [2047:0]  p = 0;
  initial begin DOA = INIT_A[31:0]; DOPA = INIT_A[35:32]; DOB = INIT_B[31:0]; DOPB = INIT_B[35:32]; end

  wire [13:0] ia = ADDRA >> SA;
  wire [13:0] ib = ADDRB >> SB;

  integer k;
  always @(posedge CLKA) if (ENA && DWA > 0) begin
    if (RSTA) begin
      DOA <= SRVAL_A[31:0]; DOPA <= SRVAL_A[35:32];
    end else if (WRITE_MODE_A != "NO_CHANGE" || WEA == 0) begin
      DOA <= 0; DOPA <= 0;
      for (k = 0; k < DWA; k = k + 1) DOA[k] <= d[ia * DWA + k];
      for (k = 0; k < PWA; k = k + 1) DOPA[k] <= p[ia * PWA + k];
    end
    for (k = 0; k < DWA; k = k + 1)
      if (WEA[(k / 8) % 4]) begin
        d[ia * DWA + k] <= DIA[k];
        if (WRITE_MODE_A == "WRITE_FIRST") DOA[k] <= DIA[k];
      end
    for (k = 0; k < PWA; k = k + 1)
      if (WEA[k % 4]) begin
        p[ia * PWA + k] <= DIPA[k];
        if (WRITE_MODE_A == "WRITE_FIRST") DOPA[k] <= DIPA[k];
      end
  end

  always @(posedge CLKB) if (ENB && DWB > 0) begin
    if (RSTB) begin
      DOB <= SRVAL_B[31:0]; DOPB <= SRVAL_B[35:32];
    end else if (WRITE_MODE_B != "NO_CHANGE" || WEB == 0) begin
      DOB <= 0; DOPB <= 0;
      for (k = 0; k < DWB; k = k + 1) DOB[k] <= d[ib * DWB + k];
      for (k = 0; k < PWB; k = k + 1) DOPB[k] <= p[ib * PWB + k];
    end
    for (k = 0; k < DWB; k = k + 1)
      if (WEB[(k / 8) % 4]) begin
        d[ib * DWB + k] <= DIB[k];
        if (WRITE_MODE_B == "WRITE_FIRST") DOB[k] <= DIB[k];
      end
    for (k = 0; k < PWB; k = k + 1)
      if (WEB[k % 4]) begin
        p[ib * PWB + k] <= DIPB[k];
        if (WRITE_MODE_B == "WRITE_FIRST") DOPB[k] <= DIPB[k];
      end
  end
endmodule

module RAMB8BWER #(
    parameter integer DATA_WIDTH_A = 0, parameter integer DATA_WIDTH_B = 0,
    parameter integer DOA_REG = 0, parameter integer DOB_REG = 0,
    parameter EN_RSTRAM_A = "TRUE", parameter EN_RSTRAM_B = "TRUE",
    parameter [17:0] INIT_A = 0, parameter [17:0] INIT_B = 0,
    parameter RAM_MODE = "TDP", parameter RSTTYPE = "SYNC",
    parameter RST_PRIORITY_A = "CE", parameter RST_PRIORITY_B = "CE",
    parameter SIM_COLLISION_CHECK = "ALL",
    parameter [17:0] SRVAL_A = 0, parameter [17:0] SRVAL_B = 0,
    parameter WRITE_MODE_A = "WRITE_FIRST", parameter WRITE_MODE_B = "WRITE_FIRST",
    parameter INIT_FILE = "NONE"
  ) (
    output reg [15:0] DOADO, output reg [1:0] DOPADOP, output reg [15:0] DOBDO, output reg [1:0] DOPBDOP,
    input [12:0] ADDRAWRADDR, input [12:0] ADDRBRDADDR, input CLKAWRCLK, input CLKBRDCLK,
    input [15:0] DIADI, input [15:0] DIBDI, input [1:0] DIPADIP, input [1:0] DIPBDIP,
    input ENAWREN, input ENBRDEN, input REGCEA, input REGCEBREGCE, input RSTA, input RSTBRST,
    input [1:0] WEAWEL, input [1:0] WEBWEU
  );
  localparam DWA = DATA_WIDTH_A == 18 ? 16 : DATA_WIDTH_A == 9 ? 8 : DATA_WIDTH_A;
  localparam PWA = DATA_WIDTH_A == 18 ? 2 : DATA_WIDTH_A == 9 ? 1 : 0;
  localparam SA  = DATA_WIDTH_A == 18 ? 4 : DATA_WIDTH_A == 9 ? 3 :
                   DATA_WIDTH_A == 4 ? 2 : DATA_WIDTH_A == 2 ? 1 : 0;
  localparam DWB = DATA_WIDTH_B == 18 ? 16 : DATA_WIDTH_B == 9 ? 8 : DATA_WIDTH_B;
  localparam PWB = DATA_WIDTH_B == 18 ? 2 : DATA_WIDTH_B == 9 ? 1 : 0;
  localparam SB  = DATA_WIDTH_B == 18 ? 4 : DATA_WIDTH_B == 9 ? 3 :
                   DATA_WIDTH_B == 4 ? 2 : DATA_WIDTH_B == 2 ? 1 : 0;

  reg [8191:0] d = 0;
  reg [1023:0] p = 0;
  initial begin DOADO = INIT_A[15:0]; DOPADOP = INIT_A[17:16]; DOBDO = INIT_B[15:0]; DOPBDOP = INIT_B[17:16]; end

  wire [12:0] ia = ADDRAWRADDR >> SA;
  wire [12:0] ib = ADDRBRDADDR >> SB;

  integer k;
  always @(posedge CLKAWRCLK) if (ENAWREN && DWA > 0) begin
    if (RSTA) begin
      DOADO <= SRVAL_A[15:0]; DOPADOP <= SRVAL_A[17:16];
    end else if (WRITE_MODE_A != "NO_CHANGE" || WEAWEL == 0) begin
      DOADO <= 0; DOPADOP <= 0;
      for (k = 0; k < DWA; k = k + 1) DOADO[k] <= d[ia * DWA + k];
      for (k = 0; k < PWA; k = k + 1) DOPADOP[k] <= p[ia * PWA + k];
    end
    for (k = 0; k < DWA; k = k + 1)
      if (WEAWEL[(k / 8) % 2]) begin
        d[ia * DWA + k] <= DIADI[k];
        if (WRITE_MODE_A == "WRITE_FIRST") DOADO[k] <= DIADI[k];
      end
    for (k = 0; k < PWA; k = k + 1)
      if (WEAWEL[k % 2]) begin
        p[ia * PWA + k] <= DIPADIP[k];
        if (WRITE_MODE_A == "WRITE_FIRST") DOPADOP[k] <= DIPADIP[k];
      end
  end

  always @(posedge CLKBRDCLK) if (ENBRDEN && DWB > 0) begin
    if (RSTBRST) begin
      DOBDO <= SRVAL_B[15:0]; DOPBDOP <= SRVAL_B[17:16];
    end else if (WRITE_MODE_B != "NO_CHANGE" || WEBWEU == 0) begin
      DOBDO <= 0; DOPBDOP <= 0;
      for (k = 0; k < DWB; k = k + 1) DOBDO[k] <= d[ib * DWB + k];
      for (k = 0; k < PWB; k = k + 1) DOPBDOP[k] <= p[ib * PWB + k];
    end
    for (k = 0; k < DWB; k = k + 1)
      if (WEBWEU[(k / 8) % 2]) begin
        d[ib * DWB + k] <= DIBDI[k];
        if (WRITE_MODE_B == "WRITE_FIRST") DOBDO[k] <= DIBDI[k];
      end
    for (k = 0; k < PWB; k = k + 1)
      if (WEBWEU[k % 2]) begin
        p[ib * PWB + k] <= DIPBDIP[k];
        if (WRITE_MODE_B == "WRITE_FIRST") DOPBDOP[k] <= DIPBDIP[k];
      end
  end
endmodule

// DSP48A1 with the registers the PSG's multiplier uses (MREG only).
module DSP48A1 #(
    parameter integer A0REG = 0, parameter integer A1REG = 1, parameter integer B0REG = 0,
    parameter integer B1REG = 1, parameter integer CARRYINREG = 1, parameter integer CARRYOUTREG = 1,
    parameter CARRYINSEL = "OPMODE5", parameter integer CREG = 1, parameter integer DREG = 1,
    parameter integer MREG = 1, parameter integer OPMODEREG = 1, parameter integer PREG = 1,
    parameter RSTTYPE = "SYNC"
  ) (
    output [17:0] BCOUT, output CARRYOUT, output CARRYOUTF, output [35:0] M, output [47:0] P,
    output [47:0] PCOUT,
    input [17:0] A, input [17:0] B, input [47:0] C, input [17:0] D, input [7:0] OPMODE,
    input [47:0] PCIN, input CARRYIN, input CEA, CEB, CEC, CECARRYIN, CED, CEM, CEOPMODE, CEP,
    input CLK, input RSTA, RSTB, RSTC, RSTCARRYIN, RSTD, RSTM, RSTOPMODE, RSTP
  );
  wire [17:0] pre = OPMODE[4] ? (OPMODE[6] ? D - B : D + B) : B;
  wire [35:0] mul = $signed(A) * $signed(pre);
  reg  [35:0] mreg = 0;
  always @(posedge CLK) if (RSTM) mreg <= 0; else if (CEM) mreg <= mul;
  wire [35:0] mm = MREG ? mreg : mul;
  wire [47:0] x = OPMODE[1:0] == 2'd1 ? {{12{mm[35]}}, mm} : OPMODE[1:0] == 2'd3 ? {D[11:0], A, B} : 48'd0;
  wire [47:0] z = OPMODE[3:2] == 2'd1 ? PCIN : OPMODE[3:2] == 2'd3 ? C : 48'd0;
  assign P = OPMODE[7] ? z - (x + OPMODE[5]) : z + x + OPMODE[5];
  assign M = mm;
  assign PCOUT = P;
  assign BCOUT = B;
  assign CARRYOUT = 0;
  assign CARRYOUTF = 0;
endmodule
