
S0000:   ; xref 01C0 01C9 06A5
0000  21 3F E0      LD HL,E03Fh
0003  36 CC         LD (HL),CCh
0005  C3 47 11      JP L1147
0008  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0018  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0028  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................

S0038:
0038  C3 44 11      JP L1144
003B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
004B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
005B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
006B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
007B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
008B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
009B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00AB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00BB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00FB  db FF FF FF FF FF                                   ; .....

S0100:   ; xref 012A 1D01
0100  21 2C A0      LD HL,A02Ch
0103  06 04         LD B,4

L0105:   ; xref 0108
0105  36 00         LD (HL),0
0107  23            INC HL
0108  10 FB         DJNZ L0105
010A  06 18         LD B,18h

L010C:   ; xref 0127
010C  21 0B A0      LD HL,A00Bh
010F  0E 03         LD C,3
0111  AF            XOR A

L0112:   ; xref 0116
0112  CB 16         RL (HL)
0114  23            INC HL
0115  0D            DEC C
0116  C2 12 01      JP nz,L0112
0119  21 2C A0      LD HL,A02Ch
011C  0E 04         LD C,4

L011E:   ; xref 0124
011E  7E            LD A,(HL)
011F  8E            ADC A,(HL)
0120  27            DAA
0121  77            LD (HL),A
0122  23            INC HL
0123  0D            DEC C
0124  C2 1E 01      JP nz,L011E
0127  10 E3         DJNZ L010C
0129  C9            RET

S012A:   ; xref 0328 038A 03A3 045C 046D 047E 048F 04A0
012A  CD 00 01      CALL S0100
012D  21 28 A0      LD HL,A028h
0130  36 00         LD (HL),0

L0132:   ; xref 01D8
0132  21 2E A0      LD HL,A02Eh
0135  7E            LD A,(HL)
0136  E6 0F         AND 15
0138  CD 04 02      CALL S0204
013B  CD 0F 02      CALL S020F
013E  2B            DEC HL
013F  7E            LD A,(HL)
0140  CB 3F         SRL A
0142  CB 3F         SRL A
0144  CB 3F         SRL A
0146  CB 3F         SRL A
0148  CD 04 02      CALL S0204
014B  CD 0F 02      CALL S020F
014E  7E            LD A,(HL)
014F  E6 0F         AND 15
0151  CD 04 02      CALL S0204
0154  CD 0F 02      CALL S020F
0157  2B            DEC HL
0158  7E            LD A,(HL)
0159  CB 3F         SRL A
015B  CB 3F         SRL A
015D  CB 3F         SRL A
015F  CB 3F         SRL A
0161  CD 04 02      CALL S0204
0164  CD 0F 02      CALL S020F
0167  7E            LD A,(HL)
0168  E6 0F         AND 15
016A  CD 04 02      CALL S0204
016D  CD 0F 02      CALL S020F
0170  3E 0A         LD A,10
0172  CD 04 02      CALL S0204
0175  CD 0F 02      CALL S020F
0178  21 11 A0      LD HL,A011h
017B  CB 46         BIT 0,(HL)
017D  C2 F9 01      JP nz,L01F9
0180  C5            PUSH BC
0181  06 00         LD B,0

L0183:   ; xref 0188 01E3
0183  21 10 C0      LD HL,C010h
0186  CB 76         BIT 6,(HL)
0188  C2 83 01      JP nz,L0183
018B  3A 20 C0      LD A,(C020h)
018E  FE D0         CP D0h
0190  20 03         JR nz,L0195
0192  C1            POP BC
0193  18 51         JR L01E6

L0195:   ; xref 0190
0195  FE 90         CP 90h
0197  28 12         JR z,L01AB
0199  04            INC B
019A  21 28 A0      LD HL,A028h
019D  3E 00         LD A,0
019F  BE            CP (HL)
01A0  28 04         JR z,L01A6
01A2  3E 66         LD A,66h
01A4  18 02         JR L01A8

L01A6:   ; xref 01A0
01A6  3E FF         LD A,FFh

L01A8:   ; xref 01A4
01A8  B8            CP B
01A9  20 30         JR nz,L01DB

L01AB:   ; xref 0197
01AB  21 28 A0      LD HL,A028h
01AE  34            INC (HL)
01AF  3E 03         LD A,3
01B1  BE            CP (HL)
01B2  20 1B         JR nz,L01CF
01B4  FD 4E 03      LD C,(IY+3)
01B7  FD 46 04      LD B,(IY+4)
01BA  21 88 90      LD HL,9088h
01BD  A7            AND A
01BE  ED 42         SBC HL,BC
01C0  DA 00 00      JP c,S0000
01C3  21 00 00      LD HL,0
01C6  A7            AND A
01C7  ED 42         SBC HL,BC
01C9  D2 00 00      JP nc,S0000
01CC  C1            POP BC
01CD  18 17         JR L01E6

L01CF:   ; xref 01B2
01CF  21 2C A0      LD HL,A02Ch
01D2  7E            LD A,(HL)
01D3  C6 01         ADD A,1
01D5  27            DAA
01D6  77            LD (HL),A
01D7  C1            POP BC
01D8  C3 32 01      JP L0132

L01DB:   ; xref 01A9 01E0
01DB  21 10 C0      LD HL,C010h
01DE  CB 76         BIT 6,(HL)
01E0  CA DB 01      JP z,L01DB
01E3  C3 83 01      JP L0183

L01E6:   ; xref 0193 01CD 0201
01E6  21 08 A0      LD HL,A008h
01E9  CB D6         SET 2,(HL)
01EB  CB 66         BIT 4,(HL)
01ED  CA F8 01      JP z,L01F8
01F0  3E 0B         LD A,11
01F2  CD 04 02      CALL S0204
01F5  CD 0F 02      CALL S020F

L01F8:   ; xref 01ED
01F8  C9            RET

L01F9:   ; xref 017D 01FE
01F9  21 10 C0      LD HL,C010h
01FC  CB 7E         BIT 7,(HL)
01FE  C2 F9 01      JP nz,L01F9
0201  C3 E6 01      JP L01E6

S0204:   ; xref 0138 0148 0151 0161 016A 0172 01F2 02B6
0204  E5            PUSH HL
0205  21 00 11      LD HL,1100h
0208  6F            LD L,A
0209  7E            LD A,(HL)
020A  32 21 A0      LD (A021h),A
020D  E1            POP HL
020E  C9            RET

S020F:   ; xref 013B 014B 0154 0164 016D 0175 01F5 02B9
020F  E5            PUSH HL
0210  21 11 A0      LD HL,A011h
0213  CB 46         BIT 0,(HL)
0215  E1            POP HL
0216  C2 6E 02      JP nz,L026E
0219  E5            PUSH HL
021A  C5            PUSH BC
021B  3A 21 A0      LD A,(A021h)
021E  47            LD B,A
021F  3E FF         LD A,FFh
0221  32 21 A0      LD (A021h),A
0224  CD 31 02      CALL S0231
0227  78            LD A,B
0228  32 21 A0      LD (A021h),A
022B  CD 31 02      CALL S0231
022E  C1            POP BC
022F  E1            POP HL
0230  C9            RET

S0231:   ; xref 0224 022B
0231  E5            PUSH HL
0232  3A 21 A0      LD A,(A021h)
0235  32 20 E0      LD (E020h),A

L0238:   ; xref 023D
0238  21 10 C0      LD HL,C010h
023B  CB 76         BIT 6,(HL)
023D  C2 38 02      JP nz,L0238

L0240:   ; xref 0245
0240  21 10 C0      LD HL,C010h
0243  CB 76         BIT 6,(HL)
0245  CA 40 02      JP z,L0240
0248  21 20 A0      LD HL,A020h
024B  CB AE         RES 5,(HL)
024D  CB BE         RES 7,(HL)
024F  7E            LD A,(HL)
0250  32 08 E0      LD (E008h),A

L0253:   ; xref 0258
0253  21 10 C0      LD HL,C010h
0256  CB 7E         BIT 7,(HL)
0258  C2 53 02      JP nz,L0253

L025B:   ; xref 0260
025B  21 10 C0      LD HL,C010h
025E  CB 7E         BIT 7,(HL)
0260  CA 5B 02      JP z,L025B
0263  21 20 A0      LD HL,A020h
0266  CB EE         SET 5,(HL)
0268  7E            LD A,(HL)
0269  32 08 E0      LD (E008h),A
026C  E1            POP HL
026D  C9            RET

L026E:   ; xref 0216
026E  E5            PUSH HL
026F  21 20 A0      LD HL,A020h
0272  CB BE         RES 7,(HL)
0274  7E            LD A,(HL)
0275  32 08 E0      LD (E008h),A
0278  3A 21 A0      LD A,(A021h)
027B  32 20 E0      LD (E020h),A
027E  21 20 A0      LD HL,A020h
0281  CB AE         RES 5,(HL)
0283  7E            LD A,(HL)
0284  32 08 E0      LD (E008h),A
0287  CB B6         RES 6,(HL)
0289  7E            LD A,(HL)
028A  32 08 E0      LD (E008h),A
028D  CD A7 02      CALL S02A7
0290  21 20 A0      LD HL,A020h
0293  CB F6         SET 6,(HL)
0295  7E            LD A,(HL)
0296  32 08 E0      LD (E008h),A
0299  CD A7 02      CALL S02A7
029C  21 20 A0      LD HL,A020h
029F  CB EE         SET 5,(HL)
02A1  7E            LD A,(HL)
02A2  32 08 E0      LD (E008h),A
02A5  E1            POP HL
02A6  C9            RET

S02A7:   ; xref 028D 0299
02A7  11 FF FF      LD DE,FFFFh
02AA  21 F6 0D      LD HL,0DF6h

L02AD:   ; xref 02AE
02AD  19            ADD HL,DE
02AE  38 FD         JR c,L02AD
02B0  C9            RET
02B1  db C9 C9 C9                                         ; ...

S02B4:   ; xref 1732
02B4  3E 0C         LD A,12
02B6  CD 04 02      CALL S0204
02B9  CD 0F 02      CALL S020F
02BC  C9            RET

S02BD:   ; xref 122E 1231
02BD  3E 0B         LD A,11
02BF  CD 04 02      CALL S0204
02C2  CD 0F 02      CALL S020F
02C5  C9            RET
02C6  db 3E 16 CD 04 02 CD 0F 02 C9                       ; >........

S02CF:   ; xref 1C0F 1C2A
02CF  3E 10         LD A,10h
02D1  CD 04 02      CALL S0204
02D4  CD 0F 02      CALL S020F
02D7  C9            RET

S02D8:   ; xref 1C12 1C2D
02D8  3E 11         LD A,11h
02DA  CD 04 02      CALL S0204
02DD  CD 0F 02      CALL S020F
02E0  C9            RET

S02E1:   ; xref 123E 1288
02E1  CD B1 06      CALL S06B1
02E4  CB 77         BIT 6,A
02E6  28 16         JR z,L02FE
02E8  21 11 A0      LD HL,A011h
02EB  CB 46         BIT 0,(HL)
02ED  C2 F9 02      JP nz,L02F9
02F0  3E 14         LD A,14h

L02F2:   ; xref 02FB
02F2  CD 04 02      CALL S0204
02F5  CD 0F 02      CALL S020F
02F8  C9            RET

L02F9:   ; xref 02ED
02F9  3E 17         LD A,17h
02FB  C3 F2 02      JP L02F2

L02FE:   ; xref 02E6
02FE  21 11 A0      LD HL,A011h
0301  CB 46         BIT 0,(HL)
0303  C2 0F 03      JP nz,L030F
0306  3E 15         LD A,15h

L0308:   ; xref 0311
0308  CD 04 02      CALL S0204
030B  CD 0F 02      CALL S020F
030E  C9            RET

L030F:   ; xref 0303
030F  3E 18         LD A,18h
0311  C3 08 03      JP L0308

L0314:   ; xref 1A76
0314  F3            DI
0315  31 FF A7      LD SP,A7FFh
0318  21 02 00      LD HL,2
031B  22 0B A0      LD (A00Bh),HL
031E  3E 00         LD A,0
0320  32 0D A0      LD (A00Dh),A
0323  21 08 A0      LD HL,A008h
0326  CB A6         RES 4,(HL)
0328  CD 2A 01      CALL S012A
032B  CD 99 05      CALL S0599
032E  21 00 A0      LD HL,A000h
0331  11 01 A0      LD DE,A001h
0334  01 FF 07      LD BC,07FFh
0337  36 55         LD (HL),55h
0339  ED B0         LDIR
033B  21 00 A0      LD HL,A000h
033E  01 00 08      LD BC,0800h
0341  3E 55         LD A,55h

L0343:   ; xref 0348
0343  ED A1         CPI
0345  C2 77 03      JP nz,L0377
0348  EA 43 03      JP pe,L0343
034B  21 00 A0      LD HL,A000h
034E  11 01 A0      LD DE,A001h
0351  01 FF 07      LD BC,07FFh
0354  36 AA         LD (HL),AAh
0356  ED B0         LDIR
0358  21 00 A0      LD HL,A000h
035B  01 00 08      LD BC,0800h
035E  3E AA         LD A,AAh

L0360:   ; xref 0365
0360  ED A1         CPI
0362  C2 77 03      JP nz,L0377
0365  EA 60 03      JP pe,L0360
0368  CD A8 06      CALL S06A8
036B  32 10 A0      LD (A010h),A
036E  CD B1 06      CALL S06B1
0371  32 11 A0      LD (A011h),A
0374  C3 90 03      JP L0390

L0377:   ; xref 0345 0362
0377  31 FF A7      LD SP,A7FFh
037A  21 14 00      LD HL,14h
037D  22 0B A0      LD (A00Bh),HL
0380  3E 00         LD A,0
0382  32 00 A0      LD (A000h),A
0385  21 08 A0      LD HL,A008h
0388  CB A6         RES 4,(HL)
038A  CD 2A 01      CALL S012A

L038D:   ; xref 038D 045F 0470 0481 0492 04A3
038D  C3 8D 03      JP L038D

L0390:   ; xref 0374
0390  31 FF A7      LD SP,A7FFh
0393  21 05 00      LD HL,5
0396  22 0B A0      LD (A00Bh),HL
0399  3E 00         LD A,0
039B  32 0D A0      LD (A00Dh),A
039E  21 08 A0      LD HL,A008h
03A1  CB A6         RES 4,(HL)
03A3  CD 2A 01      CALL S012A
03A6  CD 99 05      CALL S0599
03A9  11 10 04      LD DE,0410h
03AC  3E 20         LD A,20h
03AE  32 22 A0      LD (A022h),A
03B1  CD 15 04      CALL S0415
03B4  ED 5B 23 A0   LD DE,(A023h)
03B8  21 0B F5      LD HL,F50Bh
03BB  CD 2F 04      CALL S042F
03BE  11 00 20      LD DE,2000h
03C1  3E 40         LD A,40h
03C3  32 22 A0      LD (A022h),A
03C6  CD 15 04      CALL S0415
03C9  ED 5B 23 A0   LD DE,(A023h)
03CD  21 8E 35      LD HL,358Eh
03D0  CD 2F 04      CALL S042F
03D3  11 00 40      LD DE,4000h
03D6  3E 60         LD A,60h
03D8  32 22 A0      LD (A022h),A
03DB  CD 15 04      CALL S0415
03DE  ED 5B 23 A0   LD DE,(A023h)
03E2  21 3D 90      LD HL,903Dh
03E5  CD 2F 04      CALL S042F
03E8  11 00 60      LD DE,6000h
03EB  3E 80         LD A,80h
03ED  32 22 A0      LD (A022h),A
03F0  CD 15 04      CALL S0415
03F3  ED 5B 23 A0   LD DE,(A023h)
03F7  21 71 C7      LD HL,C771h
03FA  CD 2F 04      CALL S042F
03FD  11 00 80      LD DE,8000h
0400  3E A0         LD A,A0h
0402  32 22 A0      LD (A022h),A
0405  CD 15 04      CALL S0415
0408  ED 5B 23 A0   LD DE,(A023h)
040C  21 DC C6      LD HL,C6DCh
040F  CD 2F 04      CALL S042F
0412  C3 A6 04      JP L04A6

S0415:   ; xref 03B1 03C6 03DB 03F0 0405
0415  21 00 00      LD HL,0
0418  22 23 A0      LD (A023h),HL

L041B:   ; xref 042C
041B  06 00         LD B,0
041D  EB            EX DE,HL
041E  4E            LD C,(HL)
041F  EB            EX DE,HL
0420  2A 23 A0      LD HL,(A023h)
0423  09            ADD HL,BC
0424  22 23 A0      LD (A023h),HL
0427  13            INC DE
0428  3A 22 A0      LD A,(A022h)
042B  BA            CP D
042C  20 ED         JR nz,L041B
042E  C9            RET

S042F:   ; xref 03BB 03D0 03E5 03FA 040F
042F  7A            LD A,D
0430  BC            CP H
0431  C2 3A 04      JP nz,L043A
0434  7B            LD A,E
0435  BD            CP L
0436  C2 3A 04      JP nz,L043A
0439  C9            RET

L043A:   ; xref 0431 0436
043A  3A 22 A0      LD A,(A022h)
043D  FE 40         CP 40h
043F  CA 62 04      JP z,L0462
0442  FE 60         CP 60h
0444  CA 73 04      JP z,L0473
0447  FE 80         CP 80h
0449  CA 84 04      JP z,L0484
044C  FE A0         CP A0h
044E  CA 95 04      JP z,L0495
0451  21 17 00      LD HL,17h
0454  22 0B A0      LD (A00Bh),HL
0457  3E 00         LD A,0
0459  32 0D A0      LD (A00Dh),A
045C  CD 2A 01      CALL S012A
045F  C3 8D 03      JP L038D

L0462:   ; xref 043F
0462  21 1A 00      LD HL,1Ah
0465  22 0B A0      LD (A00Bh),HL
0468  3E 00         LD A,0
046A  32 0D A0      LD (A00Dh),A
046D  CD 2A 01      CALL S012A
0470  C3 8D 03      JP L038D

L0473:   ; xref 0444
0473  21 1D 00      LD HL,1Dh
0476  22 0B A0      LD (A00Bh),HL
0479  3E 00         LD A,0
047B  32 0D A0      LD (A00Dh),A
047E  CD 2A 01      CALL S012A
0481  C3 8D 03      JP L038D

L0484:   ; xref 0449
0484  21 20 00      LD HL,20h
0487  22 0B A0      LD (A00Bh),HL
048A  3E 00         LD A,0
048C  32 0D A0      LD (A00Dh),A
048F  CD 2A 01      CALL S012A
0492  C3 8D 03      JP L038D

L0495:   ; xref 044E
0495  21 23 00      LD HL,23h
0498  22 0B A0      LD (A00Bh),HL
049B  3E 00         LD A,0
049D  32 0D A0      LD (A00Dh),A
04A0  CD 2A 01      CALL S012A
04A3  C3 8D 03      JP L038D

L04A6:   ; xref 0412
04A6  21 08 00      LD HL,8
04A9  22 0B A0      LD (A00Bh),HL
04AC  3E 00         LD A,0
04AE  32 0D A0      LD (A00Dh),A
04B1  CD 2A 01      CALL S012A
04B4  C3 B7 04      JP L04B7

L04B7:   ; xref 04B4
04B7  CD 50 05      CALL S0550
04BA  3E 07         LD A,7
04BC  32 10 E0      LD (E010h),A
04BF  3E 3E         LD A,3Eh
04C1  32 00 E0      LD (E000h),A
04C4  3E 08         LD A,8
04C6  32 10 E0      LD (E010h),A
04C9  3E 0F         LD A,15
04CB  32 00 E0      LD (E000h),A
04CE  3E 00         LD A,0
04D0  32 10 E0      LD (E010h),A
04D3  CD 1A 05      CALL S051A
04D6  CD 50 05      CALL S0550
04D9  3E 07         LD A,7
04DB  32 10 E0      LD (E010h),A
04DE  3E 3D         LD A,3Dh
04E0  32 00 E0      LD (E000h),A
04E3  3E 09         LD A,9
04E5  32 10 E0      LD (E010h),A
04E8  3E 0F         LD A,15
04EA  32 00 E0      LD (E000h),A
04ED  3E 02         LD A,2
04EF  32 10 E0      LD (E010h),A
04F2  CD 1A 05      CALL S051A
04F5  CD 50 05      CALL S0550
04F8  3E 07         LD A,7
04FA  32 10 E0      LD (E010h),A
04FD  3E 3B         LD A,3Bh
04FF  32 00 E0      LD (E000h),A
0502  3E 0A         LD A,10
0504  32 10 E0      LD (E010h),A
0507  3E 0F         LD A,15
0509  32 00 E0      LD (E000h),A
050C  3E 04         LD A,4
050E  32 10 E0      LD (E010h),A
0511  CD 1A 05      CALL S051A
0514  CD 50 05      CALL S0550
0517  C3 62 05      JP L0562

S051A:   ; xref 04D3 04F2 0511
051A  3E FE         LD A,FEh
051C  32 00 E0      LD (E000h),A
051F  3E D6         LD A,D6h
0521  32 00 E0      LD (E000h),A
0524  CD A3 05      CALL S05A3
0527  3E BE         LD A,BEh
0529  32 00 E0      LD (E000h),A
052C  CD A3 05      CALL S05A3
052F  3E AA         LD A,AAh
0531  32 00 E0      LD (E000h),A
0534  CD A3 05      CALL S05A3
0537  3E A0         LD A,A0h
0539  32 00 E0      LD (E000h),A
053C  CD A3 05      CALL S05A3
053F  3E 8F         LD A,8Fh
0541  32 00 E0      LD (E000h),A
0544  CD A3 05      CALL S05A3
0547  3E 7F         LD A,7Fh
0549  32 00 E0      LD (E000h),A
054C  CD A3 05      CALL S05A3
054F  C9            RET

S0550:   ; xref 04B7 04D6 04F5 0514
0550  3E 00         LD A,0
0552  0E 00         LD C,0
0554  21 00 E0      LD HL,E000h

L0557:   ; xref 055F
0557  32 10 E0      LD (E010h),A
055A  3C            INC A
055B  FE 10         CP 10h
055D  C8            RET z
055E  71            LD (HL),C
055F  C3 57 05      JP L0557

L0562:   ; xref 0517
0562  21 0B 00      LD HL,11
0565  22 0B A0      LD (A00Bh),HL
0568  3E 00         LD A,0
056A  32 0D A0      LD (A00Dh),A
056D  CD 2A 01      CALL S012A
0570  CD 99 05      CALL S0599
0573  3E 00         LD A,0

L0575:   ; xref 0596
0575  32 27 A0      LD (A027h),A
0578  21 3A 11      LD HL,113Ah
057B  3A 27 A0      LD A,(A027h)
057E  85            ADD A,L
057F  6F            LD L,A
0580  7E            LD A,(HL)
0581  21 30 E0      LD HL,E030h
0584  06 10         LD B,10h

L0586:   ; xref 0588
0586  77            LD (HL),A
0587  23            INC HL
0588  10 FC         DJNZ L0586
058A  CD 99 05      CALL S0599
058D  3A 27 A0      LD A,(A027h)
0590  3C            INC A
0591  FE 0A         CP 10
0593  CA AD 05      JP z,L05AD
0596  C3 75 05      JP L0575

S0599:   ; xref 032B 03A6 0570 058A 068C
0599  11 FF FF      LD DE,FFFFh
059C  21 FF FF      LD HL,FFFFh

L059F:   ; xref 05A0
059F  19            ADD HL,DE
05A0  38 FD         JR c,L059F
05A2  C9            RET

S05A3:   ; xref 0524 052C 0534 053C 0544 054C
05A3  11 FF FF      LD DE,FFFFh
05A6  21 00 60      LD HL,6000h

L05A9:   ; xref 05AA
05A9  19            ADD HL,DE
05AA  38 FD         JR c,L05A9
05AC  C9            RET

L05AD:   ; xref 0593
05AD  21 0F 00      LD HL,15
05B0  22 0B A0      LD (A00Bh),HL
05B3  3E 00         LD A,0
05B5  32 0D A0      LD (A00Dh),A
05B8  CD 2A 01      CALL S012A
05BB  3E FF         LD A,FFh
05BD  21 30 E0      LD HL,E030h
05C0  06 10         LD B,10h

L05C2:   ; xref 05C4
05C2  77            LD (HL),A
05C3  23            INC HL
05C4  10 FC         DJNZ L05C2
05C6  21 FF FF      LD HL,FFFFh
05C9  22 25 A0      LD (A025h),HL

L05CC:   ; xref 064E
05CC  3A 08 C0      LD A,(C008h)
05CF  CB 47         BIT 0,A
05D1  21 3D E0      LD HL,E03Dh
05D4  CA 51 06      JP z,L0651
05D7  36 FF         LD (HL),FFh

L05D9:   ; xref 0653
05D9  3A 08 C0      LD A,(C008h)
05DC  CB 4F         BIT 1,A
05DE  21 3C E0      LD HL,E03Ch
05E1  CA 56 06      JP z,L0656
05E4  36 FF         LD (HL),FFh

L05E6:   ; xref 0658
05E6  3A 08 C0      LD A,(C008h)
05E9  CB 57         BIT 2,A
05EB  21 3B E0      LD HL,E03Bh
05EE  CA 5B 06      JP z,L065B
05F1  36 FF         LD (HL),FFh

L05F3:   ; xref 065D
05F3  3A 08 C0      LD A,(C008h)
05F6  CB 5F         BIT 3,A
05F8  21 3A E0      LD HL,E03Ah
05FB  CA 60 06      JP z,L0660
05FE  36 FF         LD (HL),FFh

L0600:   ; xref 0662
0600  3A 08 C0      LD A,(C008h)
0603  CB 67         BIT 4,A
0605  21 39 E0      LD HL,E039h
0608  CA 65 06      JP z,L0665
060B  36 FF         LD (HL),FFh

L060D:   ; xref 0667
060D  3A 10 C0      LD A,(C010h)
0610  CB 57         BIT 2,A
0612  21 32 E0      LD HL,E032h
0615  CA 6A 06      JP z,L066A
0618  36 FF         LD (HL),FFh

L061A:   ; xref 066C
061A  3A 10 C0      LD A,(C010h)
061D  CB 47         BIT 0,A
061F  21 31 E0      LD HL,E031h
0622  CA 6F 06      JP z,L066F
0625  36 FF         LD (HL),FFh

L0627:   ; xref 0671
0627  3A 10 C0      LD A,(C010h)
062A  CB 4F         BIT 1,A
062C  21 30 E0      LD HL,E030h
062F  CA 74 06      JP z,L0674
0632  36 FF         LD (HL),FFh

L0634:   ; xref 067B
0634  3A 10 C0      LD A,(C010h)
0637  CB 5F         BIT 3,A
0639  21 33 E0      LD HL,E033h
063C  CA 79 06      JP z,L0679
063F  36 FF         LD (HL),FFh

L0641:   ; xref 0676
0641  2A 25 A0      LD HL,(A025h)
0644  11 FF FF      LD DE,FFFFh
0647  19            ADD HL,DE
0648  D2 7E 06      JP nc,L067E
064B  22 25 A0      LD (A025h),HL
064E  C3 CC 05      JP L05CC

L0651:   ; xref 05D4
0651  36 00         LD (HL),0
0653  C3 D9 05      JP L05D9

L0656:   ; xref 05E1
0656  36 00         LD (HL),0
0658  C3 E6 05      JP L05E6

L065B:   ; xref 05EE
065B  36 00         LD (HL),0
065D  C3 F3 05      JP L05F3

L0660:   ; xref 05FB
0660  36 00         LD (HL),0
0662  C3 00 06      JP L0600

L0665:   ; xref 0608
0665  36 00         LD (HL),0
0667  C3 0D 06      JP L060D

L066A:   ; xref 0615
066A  36 00         LD (HL),0
066C  C3 1A 06      JP L061A

L066F:   ; xref 0622
066F  36 00         LD (HL),0
0671  C3 27 06      JP L0627

L0674:   ; xref 062F
0674  36 00         LD (HL),0
0676  C3 41 06      JP L0641

L0679:   ; xref 063C
0679  36 00         LD (HL),0
067B  C3 34 06      JP L0634

L067E:   ; xref 0648
067E  21 11 00      LD HL,11h
0681  22 0B A0      LD (A00Bh),HL
0684  3E 00         LD A,0
0686  32 0D A0      LD (A00Dh),A
0689  CD 2A 01      CALL S012A
068C  CD 99 05      CALL S0599
068F  21 A0 8C      LD HL,8CA0h
0692  22 0B A0      LD (A00Bh),HL
0695  3E 00         LD A,0
0697  32 0D A0      LD (A00Dh),A
069A  CD 2A 01      CALL S012A

L069D:   ; xref 06A2
069D  CD B1 06      CALL S06B1
06A0  E6 80         AND 80h
06A2  CA 9D 06      JP z,L069D
06A5  C3 00 00      JP S0000

S06A8:   ; xref 0368 1165 1291
06A8  3E 0E         LD A,14
06AA  32 10 E0      LD (E010h),A
06AD  3A 00 C0      LD A,(C000h)
06B0  C9            RET

S06B1:   ; xref 02E1 036E 069D 116B 128B
06B1  3E 0F         LD A,15
06B3  32 10 E0      LD (E010h),A
06B6  3A 00 C0      LD A,(C000h)
06B9  C9            RET

S06BA:   ; xref 1250
06BA  3E 0F         LD A,15
06BC  CD 04 02      CALL S0204
06BF  CD 0F 02      CALL S020F
06C2  C9            RET

S06C3:   ; xref 1C02
06C3  3E A3         LD A,A3h
06C5  32 21 A0      LD (A021h),A
06C8  CD 0F 02      CALL S020F
06CB  C9            RET

S06CC:   ; xref 1C1D
06CC  3E A0         LD A,A0h
06CE  32 21 A0      LD (A021h),A
06D1  CD 0F 02      CALL S020F
06D4  C9            RET
06D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
06E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
06F5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0705  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0715  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0725  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0735  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0745  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0755  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0765  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0775  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0785  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0795  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07A5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07B5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07C5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07F5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0805  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0815  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0825  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0835  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0845  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0855  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0865  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0875  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0885  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0895  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08A5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08B5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08C5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08F5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0905  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0915  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0925  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0935  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0945  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0955  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0965  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0975  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0985  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0995  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09A5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09B5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09C5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09F5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AD5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BD5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CD5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DD5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0ED5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F05  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F15  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F25  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F35  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F45  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F55  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F65  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F75  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F85  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F95  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FA5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FB5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FC5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FD5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FE5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FF5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1005  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1015  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1025  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1035  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1045  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1055  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1065  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1075  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1085  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
1095  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10A5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10B5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10C5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10F5  db FF FF FF FF FF FF FF FF FF FF FF 3F 0F 8F 4F 2F  ; ...........?..O/
1105  db AF 6F 1F 9F 5F F7 FD FB DF EF F1 F4 FC A3 A0 CD  ; .o.._...........
1115  db CE FA E1 E0 3E 0C CD 04 02 CD 0F 02 3E 0D CD 04  ; ....>.......>...
1125  db 02 CD 0F 02 3E 0E CD 04 02 CD 0F 02 3E 0F CD 04  ; ....>.......>...
1135  db 02 CD 0F 02 00 00 11 22 33 44 55 66 77 88 99     ; ......."3DUfw..

L1144:   ; xref 0038
1144  C3 C4 18      JP L18C4

L1147:   ; xref 0005
1147  31 FF A3      LD SP,A3FFh
114A  21 00 A0      LD HL,A000h
114D  11 01 A0      LD DE,A001h
1150  01 FF 03      LD BC,03FFh
1153  36 00         LD (HL),0
1155  ED B0         LDIR
1157  CD D0 1C      CALL S1CD0
115A  3A 20 A0      LD A,(A020h)
115D  CB E7         SET 4,A
115F  32 20 A0      LD (A020h),A
1162  32 08 E0      LD (E008h),A
1165  CD A8 06      CALL S06A8
1168  32 10 A0      LD (A010h),A
116B  CD B1 06      CALL S06B1
116E  32 11 A0      LD (A011h),A
1171  CB 5F         BIT 3,A
1173  20 17         JR nz,L118C
1175  3A 10 A0      LD A,(A010h)
1178  47            LD B,A
1179  E6 F0         AND F0h
117B  CB 3F         SRL A
117D  4F            LD C,A
117E  CB 3F         SRL A
1180  CB 3F         SRL A
1182  81            ADD A,C
1183  4F            LD C,A
1184  78            LD A,B
1185  E6 0F         AND 15
1187  81            ADD A,C
1188  F6 80         OR 80h
118A  18 03         JR L118F

L118C:   ; xref 1173
118C  3A 6E 20      LD A,(206Eh)

L118F:   ; xref 118A
118F  32 18 A0      LD (A018h),A
1192  21 10 A0      LD HL,A010h
1195  CB 4E         BIT 1,(HL)
1197  28 07         JR z,L11A0
1199  3E C3         LD A,C3h
119B  32 15 A0      LD (A015h),A
119E  18 05         JR L11A5

L11A0:   ; xref 1197
11A0  3E C5         LD A,C5h
11A2  32 15 A0      LD (A015h),A

L11A5:   ; xref 119E
11A5  16 00         LD D,0
11A7  01 00 00      LD BC,0
11AA  ED 56         IM 1
11AC  FB            EI
11AD  06 05         LD B,5

L11AF:   ; xref 11B8
11AF  11 FF FF      LD DE,FFFFh
11B2  21 FF FF      LD HL,FFFFh

L11B5:   ; xref 11B6
11B5  19            ADD HL,DE
11B6  38 FD         JR c,L11B5
11B8  10 F5         DJNZ L11AF

L11BA:   ; xref 11C2 11CF 11D4
11BA  21 01 A0      LD HL,A001h
11BD  CB 4E         BIT 1,(HL)
11BF  20 03         JR nz,L11C4
11C1  03            INC BC
11C2  18 F6         JR L11BA

L11C4:   ; xref 11BF
11C4  CB 8E         RES 1,(HL)
11C6  14            INC D
11C7  3E 30         LD A,30h
11C9  BA            CP D
11CA  38 05         JR c,L11D1
11CC  01 00 00      LD BC,0
11CF  18 E9         JR L11BA

L11D1:   ; xref 11CA
11D1  3E 32         LD A,32h
11D3  BA            CP D
11D4  20 E4         JR nz,L11BA
11D6  79            LD A,C
11D7  32 35 E0      LD (E035h),A
11DA  CB 3F         SRL A
11DC  CB 3F         SRL A
11DE  CB 3F         SRL A
11E0  CB 3F         SRL A
11E2  32 34 E0      LD (E034h),A
11E5  78            LD A,B
11E6  32 33 E0      LD (E033h),A
11E9  CB 3F         SRL A
11EB  CB 3F         SRL A
11ED  CB 3F         SRL A
11EF  CB 3F         SRL A
11F1  32 32 E0      LD (E032h),A
11F4  3E 0A         LD A,10
11F6  B8            CP B
11F7  38 06         JR c,L11FF
11F9  CB DE         SET 3,(HL)
11FB  3E 01         LD A,1
11FD  18 07         JR L1206

L11FF:   ; xref 11F7
11FF  3E 15         LD A,15h
1201  B8            CP B
1202  38 0B         JR c,L120F
1204  3E 02         LD A,2

L1206:   ; xref 11FD
1206  CB C6         SET 0,(HL)

L1208:   ; xref 1213
1208  32 38 E0      LD (E038h),A
120B  CB D6         SET 2,(HL)
120D  18 06         JR L1215

L120F:   ; xref 1202
120F  CB 86         RES 0,(HL)
1211  3E 03         LD A,3
1213  18 F3         JR L1208

L1215:   ; xref 120D
1215  3E 01         LD A,1
1217  CD 3E 1B      CALL S1B3E
121A  3E F0         LD A,F0h
121C  CD 6C 1C      CALL S1C6C
121F  21 30 E0      LD HL,E030h
1222  06 10         LD B,10h

L1224:   ; xref 1227
1224  36 0A         LD (HL),10
1226  23            INC HL
1227  10 FB         DJNZ L1224
1229  21 3F E0      LD HL,E03Fh
122C  36 CC         LD (HL),CCh
122E  CD BD 02      CALL S02BD
1231  CD BD 02      CALL S02BD
1234  3E 01         LD A,1
1236  CD 3E 1B      CALL S1B3E
1239  3E F0         LD A,F0h
123B  CD 6C 1C      CALL S1C6C
123E  CD E1 02      CALL S02E1
1241  CD FB 1B      CALL S1BFB
1244  3E 00         LD A,0
1246  CD 3E 1B      CALL S1B3E
1249  3A 11 A0      LD A,(A011h)
124C  CB 77         BIT 6,A
124E  20 03         JR nz,L1253
1250  CD BA 06      CALL S06BA

L1253:   ; xref 124E 1596 1E21
1253  21 0E A0      LD HL,A00Eh
1256  3A 6D 20      LD A,(206Dh)
1259  77            LD (HL),A
125A  2E 0F         LD L,15
125C  36 00         LD (HL),0
125E  11 30 A0      LD DE,A030h

L1261:   ; xref 12C0 12C7
1261  3A 10 A0      LD A,(A010h)
1264  CB 67         BIT 4,A
1266  28 17         JR z,L127F
1268  3A 10 A0      LD A,(A010h)
126B  CB 6F         BIT 5,A
126D  20 0B         JR nz,L127A
126F  21 06 A0      LD HL,A006h
1272  34            INC (HL)
1273  7E            LD A,(HL)
1274  E6 07         AND 7
1276  FE 00         CP 0
1278  20 05         JR nz,L127F

L127A:   ; xref 126D
127A  CD FB 1B      CALL S1BFB
127D  18 03         JR L1282

L127F:   ; xref 1266 1278
127F  CD 16 1C      CALL S1C16

L1282:   ; xref 127D 12CB 12D1
1282  CD B2 15      CALL S15B2
1285  CD 64 17      CALL S1764
1288  CD E1 02      CALL S02E1
128B  CD B1 06      CALL S06B1
128E  32 11 A0      LD (A011h),A
1291  CD A8 06      CALL S06A8
1294  32 10 A0      LD (A010h),A
1297  21 09 A0      LD HL,A009h
129A  AF            XOR A
129B  BE            CP (HL)
129C  20 44         JR nz,L12E2
129E  21 19 A0      LD HL,A019h
12A1  BE            CP (HL)
12A2  20 2F         JR nz,L12D3
12A4  3A 10 A0      LD A,(A010h)
12A7  CB 4F         BIT 1,A
12A9  20 05         JR nz,L12B0
12AB  21 72 20      LD HL,2072h
12AE  18 05         JR L12B5

L12B0:   ; xref 12A9
12B0  21 6F 20      LD HL,206Fh
12B3  18 00         JR L12B5

L12B5:   ; xref 12AE 12B3
12B5  E6 01         AND 1
12B7  FE 01         CP 1
12B9  28 07         JR z,L12C2
12BB  23            INC HL
12BC  FE 00         CP 0
12BE  28 02         JR z,L12C2
12C0  18 9F         JR L1261

L12C2:   ; xref 12B9 12BE
12C2  3A 12 A0      LD A,(A012h)
12C5  CB 7F         BIT 7,A
12C7  20 98         JR nz,L1261
12C9  FE 00         CP 0
12CB  20 B5         JR nz,L1282
12CD  7E            LD A,(HL)
12CE  32 0F A0      LD (A00Fh),A
12D1  18 AF         JR L1282

L12D3:   ; xref 12A2
12D3  ED 4B 59 20   LD BC,(2059h)
12D7  CD 35 1C      CALL S1C35

L12DA:   ; xref 12E0
12DA  21 09 A0      LD HL,A009h
12DD  3E 00         LD A,0
12DF  BE            CP (HL)
12E0  28 F8         JR z,L12DA

L12E2:   ; xref 129C 159F
12E2  ED 4B 59 20   LD BC,(2059h)
12E6  CD 35 1C      CALL S1C35
12E9  21 08 A0      LD HL,A008h
12EC  CB AE         RES 5,(HL)
12EE  CD FB 1B      CALL S1BFB

L12F1:   ; xref 13BD
12F1  21 09 A0      LD HL,A009h
12F4  3E 01         LD A,1
12F6  BE            CP (HL)
12F7  D2 92 13      JP nc,L1392
12FA  21 10 C0      LD HL,C010h
12FD  CB 4E         BIT 1,(HL)
12FF  C2 92 13      JP nz,L1392

L1302:   ; xref 177C
1302  21 38 A0      LD HL,A038h
1305  3A 18 A0      LD A,(A018h)
1308  77            LD (HL),A
1309  2E 39         LD L,39h
130B  3A 15 A0      LD A,(A015h)
130E  77            LD (HL),A
130F  32 3F E0      LD (E03Fh),A
1312  2E 3A         LD L,3Ah
1314  36 00         LD (HL),0
1316  06 05         LD B,5

L1318:   ; xref 131B
1318  36 00         LD (HL),0
131A  23            INC HL
131B  10 FB         DJNZ L1318
131D  36 01         LD (HL),1
131F  21 C8 A0      LD HL,A0C8h
1322  06 08         LD B,8

L1324:   ; xref 1327
1324  36 00         LD (HL),0
1326  23            INC HL
1327  10 FB         DJNZ L1324
1329  01 2F 00      LD BC,2Fh
132C  21 90 A0      LD HL,A090h
132F  11 91 A0      LD DE,A091h
1332  36 00         LD (HL),0
1334  ED B0         LDIR
1336  2E 11         LD L,11h
1338  CB 66         BIT 4,(HL)
133A  28 03         JR z,L133F
133C  2E 09         LD L,9
133E  35            DEC (HL)

L133F:   ; xref 133A 1399 1790
133F  21 30 A0      LD HL,A030h
1342  3A 18 A0      LD A,(A018h)
1345  77            LD (HL),A
1346  2E 31         LD L,31h
1348  3A 15 A0      LD A,(A015h)
134B  77            LD (HL),A
134C  32 3E E0      LD (E03Eh),A
134F  2E 32         LD L,32h
1351  36 00         LD (HL),0
1353  06 05         LD B,5

L1355:   ; xref 1358
1355  36 00         LD (HL),0
1357  23            INC HL
1358  10 FB         DJNZ L1355
135A  36 01         LD (HL),1
135C  21 C0 A0      LD HL,A0C0h
135F  06 08         LD B,8

L1361:   ; xref 1364
1361  36 00         LD (HL),0
1363  23            INC HL
1364  10 FB         DJNZ L1361
1366  01 2F 00      LD BC,2Fh
1369  21 60 A0      LD HL,A060h
136C  11 61 A0      LD DE,A061h
136F  36 00         LD (HL),0
1371  ED B0         LDIR
1373  2E 11         LD L,11h
1375  CB 66         BIT 4,(HL)
1377  28 03         JR z,L137C
1379  2E 09         LD L,9
137B  35            DEC (HL)

L137C:   ; xref 1377
137C  2E 08         LD L,8
137E  3E 5F         LD A,5Fh
1380  A6            AND (HL)
1381  77            LD (HL),A
1382  21 30 E0      LD HL,E030h
1385  06 0E         LD B,14

L1387:   ; xref 138A
1387  36 0A         LD (HL),10
1389  23            INC HL
138A  10 FB         DJNZ L1387
138C  CD FB 1B      CALL S1BFB
138F  C3 C0 13      JP L13C0

L1392:   ; xref 12F7 12FF
1392  21 10 C0      LD HL,C010h
1395  CB 46         BIT 0,(HL)
1397  20 02         JR nz,L139B
1399  18 A4         JR L133F

L139B:   ; xref 1397
139B  21 09 A0      LD HL,A009h
139E  3E 01         LD A,1
13A0  BE            CP (HL)
13A1  30 1A         JR nc,L13BD
13A3  2E 08         LD L,8
13A5  CB 6E         BIT 5,(HL)
13A7  C2 BD 13      JP nz,L13BD

L13AA:   ; xref 159C
13AA  ED 4B 5B 20   LD BC,(205Bh)
13AE  ED 43 0B A0   LD (A00Bh),BC
13B2  AF            XOR A
13B3  32 0D A0      LD (A00Dh),A
13B6  2E 08         LD L,8
13B8  CB EE         SET 5,(HL)
13BA  CD BB 1C      CALL S1CBB

L13BD:   ; xref 13A1 13A7
13BD  C3 F1 12      JP L12F1

L13C0:   ; xref 138F
13C0  CD B5 1F      CALL S1FB5
13C3  32 D4 A0      LD (A0D4h),A
13C6  32 DC A0      LD (A0DCh),A
13C9  CD 66 1D      CALL S1D66
13CC  3E 01         LD A,1
13CE  32 D5 A0      LD (A0D5h),A
13D1  32 DD A0      LD (A0DDh),A

L13D4:   ; xref 13EF 158D
13D4  21 08 A0      LD HL,A008h
13D7  CB 7E         BIT 7,(HL)
13D9  20 16         JR nz,L13F1

L13DB:   ; xref 13F5
13DB  2E 31         LD L,31h
13DD  CB 7E         BIT 7,(HL)
13DF  20 16         JR nz,L13F7
13E1  2E 39         LD L,39h
13E3  CB 7E         BIT 7,(HL)
13E5  CA 90 15      JP z,L1590

L13E8:   ; xref 1532
13E8  21 08 A0      LD HL,A008h
13EB  3E 80         LD A,80h
13ED  AE            XOR (HL)
13EE  77            LD (HL),A
13EF  18 E3         JR L13D4

L13F1:   ; xref 13D9
13F1  2E 39         LD L,39h
13F3  CB 7E         BIT 7,(HL)
13F5  28 E4         JR z,L13DB

L13F7:   ; xref 13DF
13F7  2D            DEC L
13F8  EB            EX DE,HL
13F9  CD D7 1C      CALL S1CD7
13FC  3E 30         LD A,30h
13FE  BB            CP E
13FF  20 05         JR nz,L1406
1401  2A D2 A0      LD HL,(A0D2h)
1404  18 03         JR L1409

L1406:   ; xref 13FF
1406  2A DA A0      LD HL,(A0DAh)

L1409:   ; xref 1404
1409  22 55 A0      LD (A055h),HL
140C  21 39 A0      LD HL,A039h
140F  CB 7E         BIT 7,(HL)
1411  28 36         JR z,L1449
1413  21 31 A0      LD HL,A031h
1416  CB 76         BIT 6,(HL)
1418  20 2F         JR nz,L1449
141A  CB 7E         BIT 7,(HL)
141C  28 2B         JR z,L1449
141E  ED 4B 65 20   LD BC,(2065h)
1422  CD 35 1C      CALL S1C35
1425  06 08         LD B,8
1427  CD A3 1B      CALL S1BA3
142A  3E 30         LD A,30h
142C  BD            CP L
142D  23            INC HL
142E  4E            LD C,(HL)
142F  20 05         JR nz,L1436
1431  21 3E E0      LD HL,E03Eh
1434  18 03         JR L1439

L1436:   ; xref 142F
1436  21 3F E0      LD HL,E03Fh

L1439:   ; xref 1434 1447
1439  3E 07         LD A,7
143B  CD 76 1C      CALL S1C76
143E  CB 40         BIT 0,B
1440  20 04         JR nz,L1446
1442  36 0A         LD (HL),10
1444  18 01         JR L1447

L1446:   ; xref 1440
1446  71            LD (HL),C

L1447:   ; xref 1444
1447  10 F0         DJNZ L1439

L1449:   ; xref 1411 1418 141C
1449  CD A3 1B      CALL S1BA3
144C  2C            INC L
144D  CB 76         BIT 6,(HL)
144F  CB B6         RES 6,(HL)
1451  20 32         JR nz,L1485
1453  21 05 00      LD HL,5
1456  19            ADD HL,DE
1457  CB 76         BIT 6,(HL)
1459  20 2A         JR nz,L1485
145B  CD A3 1B      CALL S1BA3
145E  7E            LD A,(HL)
145F  32 12 A0      LD (A012h),A
1462  CD 8C 1C      CALL S1C8C
1465  21 07 00      LD HL,7
1468  19            ADD HL,DE
1469  7E            LD A,(HL)
146A  CB 7F         BIT 7,A
146C  28 12         JR z,L1480
146E  32 12 A0      LD (A012h),A
1471  CD AB 1D      CALL S1DAB
1474  21 05 00      LD HL,5
1477  19            ADD HL,DE
1478  CB BE         RES 7,(HL)
147A  23            INC HL
147B  23            INC HL
147C  36 01         LD (HL),1
147E  18 0F         JR L148F

L1480:   ; xref 146C
1480  32 0F A0      LD (A00Fh),A
1483  18 0A         JR L148F

L1485:   ; xref 1451 1459
1485  CD A3 1B      CALL S1BA3
1488  7E            LD A,(HL)
1489  32 12 A0      LD (A012h),A
148C  CD 8C 1C      CALL S1C8C

L148F:   ; xref 147E 1483 14EB 14F4
148F  CD 24 1E      CALL S1E24

L1492:   ; xref 14B1
1492  CD B2 15      CALL S15B2
1495  CD 64 17      CALL S1764
1498  3A 11 A0      LD A,(A011h)
149B  CB 5F         BIT 3,A
149D  20 14         JR nz,L14B3
149F  3A 10 C0      LD A,(C010h)
14A2  CB 47         BIT 0,A
14A4  20 0D         JR nz,L14B3
14A6  FD 7E 02      LD A,(IY+2)
14A9  32 0E A0      LD (A00Eh),A
14AC  3E 00         LD A,0
14AE  32 0F A0      LD (A00Fh),A
14B1  18 DF         JR L1492

L14B3:   ; xref 149D 14A4
14B3  21 01 00      LD HL,1
14B6  19            ADD HL,DE
14B7  AF            XOR A
14B8  BE            CP (HL)
14B9  CA 57 15      JP z,L1557
14BC  FD CB 00 66   BIT 4,(IY)
14C0  20 35         JR nz,L14F7
14C2  FD CB 00 6E   BIT 5,(IY)
14C6  C2 A2 15      JP nz,L15A2
14C9  3A 12 A0      LD A,(A012h)
14CC  CB 7F         BIT 7,A
14CE  28 1E         JR z,L14EE
14D0  21 07 00      LD HL,7
14D3  19            ADD HL,DE
14D4  36 01         LD (HL),1
14D6  21 A4 00      LD HL,A4h
14D9  19            ADD HL,DE
14DA  7E            LD A,(HL)
14DB  FE 00         CP 0
14DD  28 03         JR z,L14E2
14DF  CD E5 1D      CALL S1DE5

L14E2:   ; xref 14DD
14E2  CD 9F 1D      CALL S1D9F
14E5  21 05 00      LD HL,5
14E8  19            ADD HL,DE
14E9  CB 9E         RES 3,(HL)
14EB  C3 8F 14      JP L148F

L14EE:   ; xref 14CE
14EE  CD 14 1F      CALL S1F14
14F1  CD 57 1F      CALL S1F57
14F4  C3 8F 14      JP L148F

L14F7:   ; xref 14C0
14F7  21 05 00      LD HL,5
14FA  19            ADD HL,DE
14FB  CB FE         SET 7,(HL)
14FD  21 A5 00      LD HL,A5h
1500  19            ADD HL,DE
1501  36 00         LD (HL),0
1503  CD A3 1B      CALL S1BA3
1506  FD 7E 02      LD A,(IY+2)
1509  77            LD (HL),A
150A  2C            INC L
150B  3A 0A A0      LD A,(A00Ah)
150E  CB 47         BIT 0,A
1510  20 0F         JR nz,L1521
1512  3A 11 A0      LD A,(A011h)
1515  CB 6F         BIT 5,A
1517  28 08         JR z,L1521
1519  3A 11 A0      LD A,(A011h)
151C  CB 5F         BIT 3,A
151E  28 01         JR z,L1521
1520  35            DEC (HL)

L1521:   ; xref 1510 1517 151E
1521  E5            PUSH HL
1522  CD D7 1C      CALL S1CD7
1525  E1            POP HL
1526  3E 3F         LD A,3Fh
1528  A6            AND (HL)
1529  CA 35 15      JP z,L1535
152C  CD B2 15      CALL S15B2
152F  CD 64 17      CALL S1764
1532  C3 E8 13      JP L13E8

L1535:   ; xref 1529
1535  21 31 A0      LD HL,A031h
1538  3E 3F         LD A,3Fh
153A  A6            AND (HL)
153B  20 1A         JR nz,L1557
153D  2E 39         LD L,39h
153F  3E 3F         LD A,3Fh
1541  A6            AND (HL)
1542  20 13         JR nz,L1557

L1544:   ; xref 1555
1544  3A 0F A0      LD A,(A00Fh)
1547  3C            INC A
1548  32 0F A0      LD (A00Fh),A
154B  CD B2 15      CALL S15B2
154E  CD 64 17      CALL S1764
1551  FD CB 00 6E   BIT 5,(IY)
1555  28 ED         JR z,L1544

L1557:   ; xref 14B9 153B 1542
1557  21 39 A0      LD HL,A039h
155A  CB 7E         BIT 7,(HL)
155C  28 1A         JR z,L1578
155E  CD A3 1B      CALL S1BA3
1561  3E 30         LD A,30h
1563  BB            CP E
1564  20 06         JR nz,L156C
1566  ED 4B 67 20   LD BC,(2067h)
156A  18 04         JR L1570

L156C:   ; xref 1564
156C  ED 4B 69 20   LD BC,(2069h)

L1570:   ; xref 156A
1570  CD 35 1C      CALL S1C35
1573  3E 20         LD A,20h
1575  CD 76 1C      CALL S1C76

L1578:   ; xref 155C
1578  CD A3 1B      CALL S1BA3
157B  2C            INC L
157C  CB BE         RES 7,(HL)

L157E:   ; xref 15B0
157E  3E 30         LD A,30h
1580  BB            CP E
1581  3E 0A         LD A,10
1583  20 05         JR nz,L158A
1585  32 3E E0      LD (E03Eh),A
1588  18 03         JR L158D

L158A:   ; xref 1583
158A  32 3F E0      LD (E03Fh),A

L158D:   ; xref 1588
158D  C3 D4 13      JP L13D4

L1590:   ; xref 13E5
1590  21 09 A0      LD HL,A009h
1593  3E 00         LD A,0
1595  BE            CP (HL)
1596  CA 53 12      JP z,L1253
1599  3E 02         LD A,2
159B  BE            CP (HL)
159C  DA AA 13      JP c,L13AA
159F  C3 E2 12      JP L12E2

L15A2:   ; xref 14C6
15A2  CD A3 1B      CALL S1BA3
15A5  2C            INC L
15A6  36 00         LD (HL),0
15A8  21 0A A0      LD HL,A00Ah
15AB  CB 86         RES 0,(HL)
15AD  CD D7 1B      CALL S1BD7
15B0  18 CC         JR L157E

S15B2:   ; xref 1282 1492 152C 154B
15B2  D9            EXX
15B3  21 08 A0      LD HL,A008h
15B6  CB 96         RES 2,(HL)
15B8  2E 0A         LD L,10
15BA  CB FE         SET 7,(HL)
15BC  21 0E A0      LD HL,A00Eh
15BF  3E 7F         LD A,7Fh
15C1  A6            AND (HL)
15C2  47            LD B,A
15C3  2E 0F         LD L,15
15C5  3E 7F         LD A,7Fh
15C7  A6            AND (HL)
15C8  4F            LD C,A
15C9  78            LD A,B
15CA  CB 27         SLA A
15CC  5F            LD E,A
15CD  16 00         LD D,0
15CF  21 83 21      LD HL,2183h
15D2  19            ADD HL,DE
15D3  CD 59 1B      CALL S1B59
15D6  79            LD A,C
15D7  CB 27         SLA A
15D9  5F            LD E,A
15DA  16 00         LD D,0
15DC  19            ADD HL,DE
15DD  CD 59 1B      CALL S1B59
15E0  3E 00         LD A,0
15E2  32 16 A0      LD (A016h),A
15E5  DD 21 D0 A0   LD IX,A0D0h

L15E9:   ; xref 1634 1664 166B
15E9  11 10 00      LD DE,10h
15EC  DD 19         ADD IX,DE
15EE  CB 7E         BIT 7,(HL)
15F0  28 7C         JR z,L166E
15F2  0E 00         LD C,0
15F4  CD 6A 1B      CALL S1B6A
15F7  23            INC HL
15F8  0C            INC C
15F9  CD 6A 1B      CALL S1B6A
15FC  23            INC HL
15FD  0C            INC C
15FE  3E 60         LD A,60h
1600  DD A6 00      AND (IX)

L1603:   ; xref 160A
1603  CD 6A 1B      CALL S1B6A
1606  23            INC HL
1607  0C            INC C
1608  D6 20         SUB 20h
160A  30 F7         JR nc,L1603
160C  DD CB 00 66   BIT 4,(IX)
1610  28 06         JR z,L1618
1612  0E 07         LD C,7
1614  CD 6A 1B      CALL S1B6A
1617  23            INC HL

L1618:   ; xref 1610
1618  3E 00         LD A,0
161A  DD 77 0E      LD (IX+14),A
161D  DD 77 0F      LD (IX+15),A
1620  3E 03         LD A,3
1622  DD A6 01      AND (IX+1)
1625  0E 0C         LD C,12

L1627:   ; xref 162E
1627  CD 6A 1B      CALL S1B6A
162A  23            INC HL
162B  0C            INC C
162C  D6 01         SUB 1
162E  30 F7         JR nc,L1627
1630  DD CB 00 66   BIT 4,(IX)
1634  28 B3         JR z,L15E9
1636  2B            DEC HL
1637  7E            LD A,(HL)
1638  23            INC HL
1639  D6 08         SUB 8
163B  30 02         JR nc,L163F
163D  3E 00         LD A,0

L163F:   ; xref 163B
163F  32 16 A0      LD (A016h),A
1642  D9            EXX
1643  21 A4 00      LD HL,A4h
1646  19            ADD HL,DE
1647  7E            LD A,(HL)
1648  21 05 00      LD HL,5
164B  19            ADD HL,DE
164C  CB 66         BIT 4,(HL)
164E  D9            EXX
164F  28 01         JR z,L1652
1651  3C            INC A

L1652:   ; xref 164F
1652  47            LD B,A
1653  CB 27         SLA A
1655  D9            EXX
1656  21 10 A0      LD HL,A010h
1659  CB 5E         BIT 3,(HL)
165B  D9            EXX
165C  20 01         JR nz,L165F
165E  80            ADD A,B

L165F:   ; xref 165C
165F  47            LD B,A
1660  3A 16 A0      LD A,(A016h)
1663  90            SUB B
1664  DA E9 15      JP c,L15E9
1667  78            LD A,B
1668  32 16 A0      LD (A016h),A
166B  C3 E9 15      JP L15E9

L166E:   ; xref 15F0
166E  CD 65 1B      CALL S1B65
1671  0E 00         LD C,0
1673  CD 7B 1B      CALL S1B7B
1676  23            INC HL
1677  0C            INC C
1678  CD 7B 1B      CALL S1B7B
167B  23            INC HL
167C  0E 0E         LD C,14
167E  CD 7B 1B      CALL S1B7B
1681  23            INC HL
1682  0C            INC C
1683  CD 7B 1B      CALL S1B7B
1686  23            INC HL
1687  0E 05         LD C,5
1689  CD 7B 1B      CALL S1B7B
168C  23            INC HL
168D  0E 03         LD C,3
168F  CD 7B 1B      CALL S1B7B
1692  23            INC HL
1693  0C            INC C
1694  CD 7B 1B      CALL S1B7B
1697  FD CB 05 6E   BIT 5,(IY+5)
169B  28 0B         JR z,L16A8
169D  23            INC HL
169E  0E 07         LD C,7
16A0  CD 7B 1B      CALL S1B7B
16A3  23            INC HL
16A4  0C            INC C
16A5  CD 7B 1B      CALL S1B7B

L16A8:   ; xref 169B
16A8  FD CB 05 76   BIT 6,(IY+5)
16AC  28 0B         JR z,L16B9
16AE  23            INC HL
16AF  0E 09         LD C,9
16B1  CD 7B 1B      CALL S1B7B
16B4  23            INC HL
16B5  0C            INC C
16B6  CD 7B 1B      CALL S1B7B

L16B9:   ; xref 16AC
16B9  D9            EXX
16BA  21 A4 00      LD HL,A4h
16BD  19            ADD HL,DE
16BE  7E            LD A,(HL)
16BF  D9            EXX
16C0  FE 01         CP 1
16C2  30 10         JR nc,L16D4
16C4  FD CB 05 46   BIT 0,(IY+5)
16C8  28 0A         JR z,L16D4
16CA  23            INC HL
16CB  7E            LD A,(HL)
16CC  00            NOP
16CD  D9            EXX
16CE  21 07 00      LD HL,7
16D1  19            ADD HL,DE
16D2  77            LD (HL),A
16D3  D9            EXX

L16D4:   ; xref 16C2 16C8
16D4  3A 0A A0      LD A,(A00Ah)
16D7  CB 67         BIT 4,A
16D9  28 16         JR z,L16F1
16DB  CB A7         RES 4,A
16DD  32 0A A0      LD (A00Ah),A
16E0  FD CB 00 66   BIT 4,(IY)
16E4  20 07         JR nz,L16ED
16E6  3E 01         LD A,1

L16E8:   ; xref 16EF
16E8  CD 31 1C      CALL S1C31
16EB  18 04         JR L16F1

L16ED:   ; xref 16E4
16ED  3E 02         LD A,2
16EF  18 F7         JR L16E8

L16F1:   ; xref 16D9 16EB
16F1  3A 0E A0      LD A,(A00Eh)
16F4  FD 77 02      LD (IY+2),A
16F7  FD 7E 03      LD A,(IY+3)
16FA  32 0B A0      LD (A00Bh),A
16FD  FD 7E 04      LD A,(IY+4)
1700  32 0C A0      LD (A00Ch),A
1703  AF            XOR A
1704  32 0D A0      LD (A00Dh),A
1707  3E 0F         LD A,15
1709  FD A6 00      AND (IY)
170C  21 15 21      LD HL,2115h
170F  CB 27         SLA A
1711  5F            LD E,A
1712  16 00         LD D,0
1714  CB 12         RL D
1716  19            ADD HL,DE
1717  CD 59 1B      CALL S1B59
171A  29            ADD HL,HL
171B  22 13 A0      LD (A013h),HL
171E  FD CB 05 66   BIT 4,(IY+5)
1722  28 14         JR z,L1738
1724  FD CB 05 5E   BIT 3,(IY+5)
1728  20 07         JR nz,L1731
172A  D9            EXX
172B  CD BB 1C      CALL S1CBB
172E  D9            EXX
172F  18 13         JR L1744

L1731:   ; xref 1728
1731  D9            EXX
1732  CD B4 02      CALL S02B4
1735  D9            EXX
1736  18 0C         JR L1744

L1738:   ; xref 1722
1738  21 08 A0      LD HL,A008h
173B  CB 4E         BIT 1,(HL)
173D  CB 8E         RES 1,(HL)
173F  20 03         JR nz,L1744
1741  CD AB 1C      CALL S1CAB

L1744:   ; xref 172F 1736 173F
1744  21 08 A0      LD HL,A008h
1747  CB D6         SET 2,(HL)
1749  D9            EXX
174A  CD D7 1B      CALL S1BD7
174D  CD 61 1C      CALL S1C61
1750  CD D0 1C      CALL S1CD0
1753  C9            RET

L1754:   ; xref 1769
1754  21 0A A0      LD HL,A00Ah
1757  CB 86         RES 0,(HL)
1759  3A 08 C0      LD A,(C008h)
175C  FE E9         CP E9h
175E  20 0B         JR nz,L176B
1760  CB C6         SET 0,(HL)
1762  18 07         JR L176B

S1764:   ; xref 1285 1495 152F 154E
1764  D9            EXX

L1765:   ; xref 17AD 17B6
1765  FD CB 00 76   BIT 6,(IY)
1769  20 E9         JR nz,L1754

L176B:   ; xref 175E 1762
176B  C3 DC 17      JP L17DC

L176E:   ; xref 1802
176E  FD CB 00 76   BIT 6,(IY)
1772  20 1F         JR nz,L1793
1774  C3 A5 17      JP L17A5

L1777:   ; xref 17A3
1777  21 10 C0      LD HL,C010h
177A  CB 4E         BIT 1,(HL)
177C  CA 02 13      JP z,L1302
177F  21 10 C0      LD HL,C010h
1782  CB 46         BIT 0,(HL)
1784  20 1F         JR nz,L17A5
1786  3E 00         LD A,0
1788  32 39 A0      LD (A039h),A
178B  3E 0A         LD A,10
178D  32 3F E0      LD (E03Fh),A
1790  C3 3F 13      JP L133F

L1793:   ; xref 1772
1793  21 19 A0      LD HL,A019h
1796  3E 00         LD A,0
1798  BE            CP (HL)
1799  C0            RET nz
179A  21 09 A0      LD HL,A009h
179D  BE            CP (HL)
179E  C0            RET nz
179F  2E 11         LD L,11h
17A1  CB 66         BIT 4,(HL)
17A3  28 D2         JR z,L1777

L17A5:   ; xref 1774 1784
17A5  CD 61 1C      CALL S1C61
17A8  3E 00         LD A,0
17AA  FD BE 0F      CP (IY+15)
17AD  C2 65 17      JP nz,L1765
17B0  3A 16 A0      LD A,(A016h)
17B3  FD BE 0E      CP (IY+14)
17B6  C2 65 17      JP nz,L1765
17B9  FD CB 05 7E   BIT 7,(IY+5)
17BD  28 11         JR z,L17D0
17BF  21 08 A0      LD HL,A008h
17C2  CB CE         SET 1,(HL)

L17C4:   ; xref 17C9 17CE
17C4  3E 00         LD A,0
17C6  FD BE 0F      CP (IY+15)
17C9  20 F9         JR nz,L17C4
17CB  FD BE 0E      CP (IY+14)
17CE  20 F4         JR nz,L17C4

L17D0:   ; xref 17BD
17D0  FD 7E 01      LD A,(IY+1)

L17D3:   ; xref 18C1
17D3  21 12 A0      LD HL,A012h
17D6  77            LD (HL),A
17D7  CD 8C 1C      CALL S1C8C
17DA  D9            EXX
17DB  C9            RET

L17DC:   ; xref 176B
17DC  FD CB 00 76   BIT 6,(IY)
17E0  20 03         JR nz,L17E5
17E2  CD 20 1D      CALL S1D20

L17E5:   ; xref 17E0
17E5  DD 21 E0 A0   LD IX,A0E0h

L17E9:   ; xref 1824
17E9  DD CB 00 7E   BIT 7,(IX)
17ED  20 16         JR nz,L1805
17EF  06 0B         LD B,11
17F1  21 40 A0      LD HL,A040h

L17F4:   ; xref 17F9
17F4  CB 7E         BIT 7,(HL)
17F6  20 05         JR nz,L17FD
17F8  23            INC HL
17F9  10 F9         DJNZ L17F4
17FB  18 05         JR L1802

L17FD:   ; xref 17F6
17FD  3E 02         LD A,2
17FF  CD 31 1C      CALL S1C31

L1802:   ; xref 17FB
1802  C3 6E 17      JP L176E

L1805:   ; xref 17ED
1805  DD 7E 01      LD A,(IX+1)
1808  E6 03         AND 3
180A  47            LD B,A
180B  DD 7E 01      LD A,(IX+1)
180E  CB 3F         SRL A
1810  CB 3F         SRL A
1812  4F            LD C,A
1813  DD E5         PUSH IX
1815  E1            POP HL
1816  7D            LD A,L
1817  C6 0C         ADD A,12
1819  6F            LD L,A
181A  3E 00         LD A,0
181C  BE            CP (HL)
181D  28 07         JR z,L1826

L181F:   ; xref 1831 183F
181F  11 10 00      LD DE,10h
1822  DD 19         ADD IX,DE
1824  18 C3         JR L17E9

L1826:   ; xref 181D 182F
1826  23            INC HL
1827  BE            CP (HL)
1828  20 09         JR nz,L1833
182A  CB 39         SRL C
182C  CB 39         SRL C
182E  05            DEC B
182F  20 F5         JR nz,L1826

L1831:   ; xref 184E
1831  18 EC         JR L181F

L1833:   ; xref 1828
1833  3E 0F         LD A,15
1835  DD A6 00      AND (IX)
1838  21 40 A0      LD HL,A040h
183B  85            ADD A,L
183C  6F            LD L,A
183D  CB 7E         BIT 7,(HL)
183F  28 DE         JR z,L181F
1841  3E 03         LD A,3
1843  A1            AND C
1844  C6 02         ADD A,2
1846  DD E5         PUSH IX
1848  E1            POP HL
1849  85            ADD A,L
184A  6F            LD L,A
184B  7E            LD A,(HL)
184C  FE FF         CP FFh
184E  28 E1         JR z,L1831
1850  22 5A A0      LD (A05Ah),HL
1853  3A 0A A0      LD A,(A00Ah)
1856  CB E7         SET 4,A
1858  32 0A A0      LD (A00Ah),A
185B  CD 61 1C      CALL S1C61
185E  DD CB 00 66   BIT 4,(IX)
1862  28 55         JR z,L18B9
1864  2A 5A A0      LD HL,(A05Ah)
1867  EB            EX DE,HL
1868  21 08 A0      LD HL,A008h
186B  7B            LD A,E
186C  E6 0F         AND 15
186E  FE 02         CP 2
1870  28 0E         JR z,L1880
1872  FE 03         CP 3
1874  28 14         JR z,L188A
1876  DD CB 07 6E   BIT 5,(IX+7)
187A  28 3D         JR z,L18B9
187C  CB CE         SET 1,(HL)
187E  18 12         JR L1892

L1880:   ; xref 1870
1880  DD CB 07 7E   BIT 7,(IX+7)
1884  28 33         JR z,L18B9
1886  CB CE         SET 1,(HL)
1888  18 08         JR L1892

L188A:   ; xref 1874
188A  DD CB 07 76   BIT 6,(IX+7)
188E  28 29         JR z,L18B9
1890  CB CE         SET 1,(HL)

L1892:   ; xref 187E 1888
1892  3A 0A A0      LD A,(A00Ah)
1895  CB 67         BIT 4,A
1897  28 0A         JR z,L18A3
1899  CB A7         RES 4,A
189B  32 0A A0      LD (A00Ah),A
189E  3E 01         LD A,1
18A0  CD 31 1C      CALL S1C31

L18A3:   ; xref 1897 18A8 18AD 18B2 18B7
18A3  3E 00         LD A,0
18A5  DD BE 0C      CP (IX+12)
18A8  20 F9         JR nz,L18A3
18AA  DD BE 0D      CP (IX+13)
18AD  20 F4         JR nz,L18A3
18AF  DD BE 0E      CP (IX+14)
18B2  20 EF         JR nz,L18A3
18B4  DD BE 0F      CP (IX+15)
18B7  20 EA         JR nz,L18A3

L18B9:   ; xref 1862 187A 1884 188E
18B9  2A 5A A0      LD HL,(A05Ah)
18BC  7E            LD A,(HL)
18BD  FD CB 00 A6   RES 4,(IY)
18C1  C3 D3 17      JP L17D3

L18C4:   ; xref 1144
18C4  F5            PUSH AF
18C5  C5            PUSH BC
18C6  D5            PUSH DE
18C7  E5            PUSH HL
18C8  08            EX AF,AF'
18C9  F5            PUSH AF
18CA  21 01 A0      LD HL,A001h
18CD  CB 56         BIT 2,(HL)
18CF  20 05         JR nz,L18D6
18D1  CB CE         SET 1,(HL)
18D3  C3 91 1A      JP L1A91

L18D6:   ; xref 18CF
18D6  21 0A A0      LD HL,A00Ah
18D9  CB F6         SET 6,(HL)
18DB  3A 0A A0      LD A,(A00Ah)
18DE  CB 6F         BIT 5,A
18E0  C2 91 1A      JP nz,L1A91
18E3  3A 11 A0      LD A,(A011h)
18E6  CB 67         BIT 4,A
18E8  CA 8D 19      JP z,L198D
18EB  21 1A A0      LD HL,A01Ah
18EE  CB 7E         BIT 7,(HL)
18F0  20 22         JR nz,L1914
18F2  3A 10 C0      LD A,(C010h)
18F5  CB 57         BIT 2,A
18F7  20 14         JR nz,L190D
18F9  3A 01 A0      LD A,(A001h)
18FC  CB 5F         BIT 3,A
18FE  28 0B         JR z,L190B
1900  3A 4C A0      LD A,(A04Ch)
1903  3C            INC A
1904  32 4C A0      LD (A04Ch),A
1907  FE 03         CP 3
1909  20 31         JR nz,L193C

L190B:   ; xref 18FE
190B  CB FE         SET 7,(HL)

L190D:   ; xref 18F7
190D  3E 00         LD A,0
190F  32 4C A0      LD (A04Ch),A
1912  18 28         JR L193C

L1914:   ; xref 18F0
1914  3A 10 C0      LD A,(C010h)
1917  CB 57         BIT 2,A
1919  28 1C         JR z,L1937
191B  3A 01 A0      LD A,(A001h)
191E  CB 5F         BIT 3,A
1920  28 0B         JR z,L192D
1922  3A 4C A0      LD A,(A04Ch)
1925  3C            INC A
1926  32 4C A0      LD (A04Ch),A
1929  FE 03         CP 3
192B  20 0F         JR nz,L193C

L192D:   ; xref 1920
192D  CB BE         RES 7,(HL)
192F  21 19 A0      LD HL,A019h
1932  34            INC (HL)
1933  21 5D A0      LD HL,A05Dh
1936  34            INC (HL)

L1937:   ; xref 1919
1937  3E 00         LD A,0
1939  32 4C A0      LD (A04Ch),A

L193C:   ; xref 1909 1912 192B
193C  21 1A A0      LD HL,A01Ah
193F  CB 76         BIT 6,(HL)
1941  20 22         JR nz,L1965
1943  3A 10 C0      LD A,(C010h)
1946  CB 5F         BIT 3,A
1948  20 14         JR nz,L195E
194A  3A 01 A0      LD A,(A001h)
194D  CB 5F         BIT 3,A
194F  28 0B         JR z,L195C
1951  3A 4D A0      LD A,(A04Dh)
1954  3C            INC A
1955  32 4D A0      LD (A04Dh),A
1958  FE 03         CP 3
195A  20 31         JR nz,L198D

L195C:   ; xref 194F
195C  CB F6         SET 6,(HL)

L195E:   ; xref 1948
195E  3E 00         LD A,0
1960  32 4D A0      LD (A04Dh),A
1963  18 28         JR L198D

L1965:   ; xref 1941
1965  3A 10 C0      LD A,(C010h)
1968  CB 5F         BIT 3,A
196A  28 1C         JR z,L1988
196C  3A 01 A0      LD A,(A001h)
196F  CB 5F         BIT 3,A
1971  28 0B         JR z,L197E
1973  3A 4D A0      LD A,(A04Dh)
1976  3C            INC A
1977  32 4D A0      LD (A04Dh),A
197A  FE 03         CP 3
197C  20 0F         JR nz,L198D

L197E:   ; xref 1971
197E  CB B6         RES 6,(HL)
1980  21 19 A0      LD HL,A019h
1983  34            INC (HL)
1984  21 5D A0      LD HL,A05Dh
1987  34            INC (HL)

L1988:   ; xref 196A
1988  3E 00         LD A,0
198A  32 4D A0      LD (A04Dh),A

L198D:   ; xref 18E8 195A 1963 197C
198D  3A 01 A0      LD A,(A001h)
1990  CB 5F         BIT 3,A
1992  28 0C         JR z,L19A0
1994  3A 5C A0      LD A,(A05Ch)
1997  3C            INC A
1998  32 5C A0      LD (A05Ch),A
199B  E6 07         AND 7
199D  C2 94 1A      JP nz,L1A94

L19A0:   ; xref 1992
19A0  3A 5D A0      LD A,(A05Dh)
19A3  FE 00         CP 0
19A5  28 15         JR z,L19BC
19A7  3A 20 A0      LD A,(A020h)
19AA  CB 67         BIT 4,A
19AC  28 0E         JR z,L19BC
19AE  3A 5D A0      LD A,(A05Dh)
19B1  3D            DEC A
19B2  32 5D A0      LD (A05Dh),A
19B5  3A 20 A0      LD A,(A020h)
19B8  CB A7         RES 4,A
19BA  18 05         JR L19C1

L19BC:   ; xref 19A5 19AC
19BC  3A 20 A0      LD A,(A020h)
19BF  CB E7         SET 4,A

L19C1:   ; xref 19BA
19C1  32 20 A0      LD (A020h),A
19C4  32 08 E0      LD (E008h),A
19C7  21 08 A0      LD HL,A008h
19CA  CB 56         BIT 2,(HL)
19CC  28 5E         JR z,L1A2C
19CE  21 01 A0      LD HL,A001h
19D1  CB 46         BIT 0,(HL)
19D3  28 04         JR z,L19D9
19D5  06 19         LD B,19h
19D7  18 02         JR L19DB

L19D9:   ; xref 19D3
19D9  06 99         LD B,99h

L19DB:   ; xref 19D7
19DB  21 00 A0      LD HL,A000h
19DE  7E            LD A,(HL)
19DF  3C            INC A
19E0  77            LD (HL),A
19E1  B8            CP B
19E2  20 05         JR nz,L19E9
19E4  AF            XOR A
19E5  77            LD (HL),A
19E6  C3 94 1A      JP L1A94

L19E9:   ; xref 19E2
19E9  01 E0 A0      LD BC,A0E0h
19EC  CD A6 1B      CALL S1BA6

L19EF:   ; xref 1A07 1A19
19EF  CB 7E         BIT 7,(HL)
19F1  28 28         JR z,L1A1B
19F3  3E 0C         LD A,12
19F5  85            ADD A,L
19F6  6F            LD L,A
19F7  3E 00         LD A,0
19F9  BE            CP (HL)
19FA  28 0D         JR z,L1A09

L19FC:   ; xref 1A12
19FC  35            DEC (HL)
19FD  CD A6 1B      CALL S1BA6
1A00  01 10 00      LD BC,10h
1A03  09            ADD HL,BC
1A04  CD A9 1B      CALL S1BA9
1A07  18 E6         JR L19EF

L1A09:   ; xref 19FA 1A14
1A09  23            INC HL
1A0A  3E 0F         LD A,15
1A0C  A5            AND L
1A0D  28 07         JR z,L1A16
1A0F  3E 00         LD A,0
1A11  BE            CP (HL)
1A12  20 E8         JR nz,L19FC
1A14  18 F3         JR L1A09

L1A16:   ; xref 1A0D
1A16  CD A9 1B      CALL S1BA9
1A19  18 D4         JR L19EF

L1A1B:   ; xref 19F1
1A1B  FD E5         PUSH IY
1A1D  E1            POP HL
1A1E  3E 0E         LD A,14
1A20  85            ADD A,L
1A21  6F            LD L,A
1A22  CD 8A 1B      CALL S1B8A
1A25  30 05         JR nc,L1A2C
1A27  36 00         LD (HL),0
1A29  23            INC HL
1A2A  36 00         LD (HL),0

L1A2C:   ; xref 19CC 1A25
1A2C  21 1F A0      LD HL,A01Fh
1A2F  3E 00         LD A,0
1A31  BE            CP (HL)
1A32  28 01         JR z,L1A35
1A34  35            DEC (HL)

L1A35:   ; xref 1A32 1A65
1A35  21 11 A0      LD HL,A011h
1A38  CB 66         BIT 4,(HL)
1A3A  20 0C         JR nz,L1A48
1A3C  3E 00         LD A,0
1A3E  32 36 E0      LD (E036h),A
1A41  3E 02         LD A,2
1A43  32 37 E0      LD (E037h),A
1A46  18 22         JR L1A6A

L1A48:   ; xref 1A3A
1A48  21 10 A0      LD HL,A010h
1A4B  3E 01         LD A,1
1A4D  A6            AND (HL)
1A4E  EE 01         XOR 1
1A50  3C            INC A
1A51  2E 19         LD L,19h
1A53  BE            CP (HL)
1A54  30 11         JR nc,L1A67
1A56  2E 09         LD L,9
1A58  34            INC (HL)
1A59  3C            INC A
1A5A  47            LD B,A
1A5B  2E 19         LD L,19h
1A5D  7E            LD A,(HL)
1A5E  90            SUB B
1A5F  77            LD (HL),A
1A60  3E 00         LD A,0
1A62  CD 3E 1B      CALL S1B3E
1A65  18 CE         JR L1A35

L1A67:   ; xref 1A54
1A67  CD 41 1C      CALL S1C41

L1A6A:   ; xref 1A46
1A6A  3E 0F         LD A,15
1A6C  32 10 E0      LD (E010h),A
1A6F  3A 00 C0      LD A,(C000h)
1A72  CB 7F         BIT 7,A
1A74  20 03         JR nz,L1A79
1A76  C3 14 03      JP L0314

L1A79:   ; xref 1A74
1A79  21 5E A0      LD HL,A05Eh
1A7C  CD 8A 1B      CALL S1B8A
1A7F  30 05         JR nc,L1A86
1A81  36 00         LD (HL),0
1A83  23            INC HL
1A84  36 00         LD (HL),0

L1A86:   ; xref 1A7F
1A86  21 DE A0      LD HL,A0DEh
1A89  CD 8A 1B      CALL S1B8A
1A8C  30 03         JR nc,L1A91
1A8E  C3 0D 1E      JP L1E0D

L1A91:   ; xref 18D3 18E0 1A8C
1A91  CD 9D 1A      CALL S1A9D

L1A94:   ; xref 199D 19E6
1A94  F1            POP AF
1A95  08            EX AF,AF'
1A96  E1            POP HL
1A97  D1            POP DE
1A98  C1            POP BC
1A99  F1            POP AF
1A9A  FB            EI
1A9B  ED 4D         RETI

S1A9D:   ; xref 1A91
1A9D  21 1C A0      LD HL,A01Ch
1AA0  CB 46         BIT 0,(HL)
1AA2  C8            RET z
1AA3  2E 1F         LD L,1Fh
1AA5  3E 00         LD A,0
1AA7  BE            CP (HL)
1AA8  C0            RET nz
1AA9  2E 1D         LD L,1Dh
1AAB  CD 59 1B      CALL S1B59
1AAE  11 1D A0      LD DE,A01Dh
1AB1  46            LD B,(HL)
1AB2  23            INC HL
1AB3  3E 03         LD A,3
1AB5  A0            AND B
1AB6  4F            LD C,A
1AB7  CB 21         SLA C
1AB9  3E FF         LD A,FFh
1ABB  CD 2C 1B      CALL S1B2C
1ABE  CB 68         BIT 5,B
1AC0  28 07         JR z,L1AC9
1AC2  3E 05         LD A,5
1AC4  0E 01         LD C,1
1AC6  CD 2C 1B      CALL S1B2C

L1AC9:   ; xref 1AC0
1AC9  3E 0C         LD A,12
1ACB  A0            AND B
1ACC  4F            LD C,A
1ACD  CB 39         SRL C
1ACF  CB 39         SRL C
1AD1  3E 07         LD A,7
1AD3  CD 2C 1B      CALL S1B2C
1AD6  CB 60         BIT 4,B
1AD8  28 0C         JR z,L1AE6
1ADA  7E            LD A,(HL)
1ADB  23            INC HL
1ADC  EB            EX DE,HL
1ADD  2E 1B         LD L,1Bh
1ADF  77            LD (HL),A
1AE0  2E 1F         LD L,1Fh
1AE2  77            LD (HL),A
1AE3  EB            EX DE,HL
1AE4  18 08         JR L1AEE

L1AE6:   ; xref 1AD8
1AE6  EB            EX DE,HL
1AE7  2E 1B         LD L,1Bh
1AE9  7E            LD A,(HL)
1AEA  2E 1F         LD L,1Fh
1AEC  77            LD (HL),A
1AED  EB            EX DE,HL

L1AEE:   ; xref 1AE4
1AEE  CB 70         BIT 6,B
1AF0  28 07         JR z,L1AF9
1AF2  3E 0A         LD A,10
1AF4  0E 02         LD C,2
1AF6  CD 2C 1B      CALL S1B2C

L1AF9:   ; xref 1AF0
1AF9  CB 7E         BIT 7,(HL)
1AFB  28 0D         JR z,L1B0A
1AFD  3E 07         LD A,7
1AFF  32 10 E0      LD (E010h),A
1B02  7E            LD A,(HL)
1B03  2F            CPL
1B04  E6 3F         AND 3Fh
1B06  32 00 E0      LD (E000h),A
1B09  23            INC HL

L1B0A:   ; xref 1AFB
1B0A  CB 78         BIT 7,B
1B0C  28 09         JR z,L1B17
1B0E  3E 0D         LD A,13
1B10  32 10 E0      LD (E010h),A
1B13  7E            LD A,(HL)
1B14  32 00 E0      LD (E000h),A

L1B17:   ; xref 1B0C
1B17  CB 6E         BIT 5,(HL)
1B19  28 0B         JR z,L1B26
1B1B  23            INC HL
1B1C  CD A9 1B      CALL S1BA9
1B1F  21 1D A0      LD HL,A01Dh
1B22  71            LD (HL),C
1B23  23            INC HL
1B24  70            LD (HL),B
1B25  C9            RET

L1B26:   ; xref 1B19
1B26  21 1C A0      LD HL,A01Ch
1B29  CB 86         RES 0,(HL)
1B2B  C9            RET

S1B2C:   ; xref 1ABB 1AC6 1AD3 1AF6 1B3B
1B2C  0D            DEC C
1B2D  FA 3D 1B      JP m,L1B3D
1B30  3C            INC A
1B31  32 10 E0      LD (E010h),A
1B34  08            EX AF,AF'
1B35  7E            LD A,(HL)
1B36  23            INC HL
1B37  32 00 E0      LD (E000h),A
1B3A  08            EX AF,AF'
1B3B  18 EF         JR S1B2C

L1B3D:   ; xref 1B2D
1B3D  C9            RET

S1B3E:   ; xref 1217 1236 1246 1A62 1C31
1B3E  21 35 21      LD HL,2135h
1B41  01 00 00      LD BC,0
1B44  4F            LD C,A
1B45  CB 21         SLA C
1B47  CB 10         RL B
1B49  09            ADD HL,BC
1B4A  7E            LD A,(HL)
1B4B  32 1D A0      LD (A01Dh),A
1B4E  23            INC HL
1B4F  7E            LD A,(HL)
1B50  32 1E A0      LD (A01Eh),A
1B53  21 1C A0      LD HL,A01Ch
1B56  CB C6         SET 0,(HL)
1B58  C9            RET

S1B59:   ; xref 15D3 15DD 1717 1AAB
1B59  5E            LD E,(HL)
1B5A  23            INC HL
1B5B  56            LD D,(HL)
1B5C  CD A3 1B      CALL S1BA3
1B5F  C9            RET
1B60  db FD E5 DD E1 C9                                   ; .....

S1B65:   ; xref 166E
1B65  DD E5         PUSH IX
1B67  FD E1         POP IY
1B69  C9            RET

S1B6A:   ; xref 15F4 15F9 1603 1614 1627
1B6A  08            EX AF,AF'
1B6B  C5            PUSH BC
1B6C  06 00         LD B,0
1B6E  DD E5         PUSH IX
1B70  DD 09         ADD IX,BC
1B72  7E            LD A,(HL)
1B73  DD 77 00      LD (IX),A
1B76  DD E1         POP IX
1B78  C1            POP BC
1B79  08            EX AF,AF'
1B7A  C9            RET

S1B7B:   ; xref 1673 1678 167E 1683 1689 168F 1694 16A0
1B7B  08            EX AF,AF'
1B7C  06 00         LD B,0
1B7E  FD E5         PUSH IY
1B80  FD 09         ADD IY,BC
1B82  7E            LD A,(HL)
1B83  FD 77 00      LD (IY),A
1B86  FD E1         POP IY
1B88  08            EX AF,AF'
1B89  C9            RET

S1B8A:   ; xref 1A22 1A7C 1A89
1B8A  4E            LD C,(HL)
1B8B  23            INC HL
1B8C  46            LD B,(HL)
1B8D  CD AC 1B      CALL S1BAC
1B90  CD A6 1B      CALL S1BA6
1B93  01 01 00      LD BC,1
1B96  A7            AND A
1B97  ED 42         SBC HL,BC
1B99  CD A9 1B      CALL S1BA9
1B9C  CD A3 1B      CALL S1BA3
1B9F  70            LD (HL),B
1BA0  2B            DEC HL
1BA1  71            LD (HL),C
1BA2  C9            RET

S1BA3:   ; xref 1427 1449 145B 1485 1503 155E 1578 15A2
1BA3  D5            PUSH DE
1BA4  E1            POP HL
1BA5  C9            RET

S1BA6:   ; xref 19EC 19FD 1B90
1BA6  C5            PUSH BC
1BA7  E1            POP HL
1BA8  C9            RET

S1BA9:   ; xref 1A04 1A16 1B1C 1B99
1BA9  E5            PUSH HL
1BAA  C1            POP BC
1BAB  C9            RET

S1BAC:   ; xref 1B8D
1BAC  E5            PUSH HL
1BAD  D1            POP DE
1BAE  C9            RET
1BAF  db D9 21 13 A0 D5 CD 8A 1B D1 30 08 21 00 00 22 13  ; .!.......0.!..".
1BBF  db A0 18 13 CD A3 1B 2C 2C 34 20 06 2C 34 20 02 2C  ; ......,,4 .,4 .,
1BCF  db 34 CD D7 1C 3E 03 D9 C9                          ; 4...>...

S1BD7:   ; xref 15AD 174A
1BD7  3A 13 A0      LD A,(A013h)
1BDA  FE 00         CP 0
1BDC  C8            RET z
1BDD  CD A3 1B      CALL S1BA3
1BE0  2C            INC L
1BE1  2C            INC L
1BE2  86            ADD A,(HL)
1BE3  77            LD (HL),A
1BE4  3A 14 A0      LD A,(A014h)
1BE7  2C            INC L
1BE8  8E            ADC A,(HL)
1BE9  77            LD (HL),A
1BEA  3E 00         LD A,0
1BEC  2C            INC L
1BED  8E            ADC A,(HL)
1BEE  77            LD (HL),A
1BEF  CD D7 1C      CALL S1CD7
1BF2  21 00 00      LD HL,0
1BF5  22 13 A0      LD (A013h),HL
1BF8  3E 03         LD A,3
1BFA  C9            RET

S1BFB:   ; xref 1241 127A 12EE 138C
1BFB  21 11 A0      LD HL,A011h
1BFE  CB 46         BIT 0,(HL)
1C00  28 04         JR z,L1C06
1C02  CD C3 06      CALL S06C3
1C05  C9            RET

L1C06:   ; xref 1C00
1C06  21 07 A0      LD HL,A007h
1C09  7E            LD A,(HL)
1C0A  FE 00         CP 0
1C0C  C8            RET z
1C0D  36 00         LD (HL),0
1C0F  CD CF 02      CALL S02CF
1C12  CD D8 02      CALL S02D8
1C15  C9            RET

S1C16:   ; xref 127F
1C16  21 11 A0      LD HL,A011h
1C19  CB 46         BIT 0,(HL)
1C1B  28 04         JR z,L1C21
1C1D  CD CC 06      CALL S06CC
1C20  C9            RET

L1C21:   ; xref 1C1B
1C21  21 07 A0      LD HL,A007h
1C24  7E            LD A,(HL)
1C25  FE 00         CP 0
1C27  C0            RET nz
1C28  36 FF         LD (HL),FFh
1C2A  CD CF 02      CALL S02CF
1C2D  CD D8 02      CALL S02D8
1C30  C9            RET

S1C31:   ; xref 16E8 17FF 18A0 201C
1C31  CD 3E 1B      CALL S1B3E
1C34  C9            RET

S1C35:   ; xref 12D7 12E6 1422 1570
1C35  ED 43 0B A0   LD (A00Bh),BC
1C39  AF            XOR A
1C3A  32 0D A0      LD (A00Dh),A
1C3D  CD BB 1C      CALL S1CBB
1C40  C9            RET

S1C41:   ; xref 1A67
1C41  3A 09 A0      LD A,(A009h)
1C44  4F            LD C,A
1C45  AF            XOR A
1C46  06 09         LD B,9

L1C48:   ; xref 1C4C
1C48  8F            ADC A,A
1C49  27            DAA
1C4A  CB 21         SLA C
1C4C  10 FA         DJNZ L1C48
1C4E  32 37 E0      LD (E037h),A
1C51  CD 58 1C      CALL S1C58
1C54  32 36 E0      LD (E036h),A
1C57  C9            RET

S1C58:   ; xref 1C51 1D0D
1C58  CB 3F         SRL A
1C5A  CB 3F         SRL A
1C5C  CB 3F         SRL A
1C5E  CB 3F         SRL A
1C60  C9            RET

S1C61:   ; xref 174D 17A5 185B
1C61  06 0B         LD B,11
1C63  21 40 A0      LD HL,A040h

L1C66:   ; xref 1C69
1C66  CB BE         RES 7,(HL)
1C68  23            INC HL
1C69  10 FB         DJNZ L1C66
1C6B  C9            RET

S1C6C:   ; xref 121C 123B
1C6C  21 00 00      LD HL,0
1C6F  6F            LD L,A
1C70  29            ADD HL,HL
1C71  22 5E A0      LD (A05Eh),HL
1C74  18 07         JR L1C7D

S1C76:   ; xref 143B 1575
1C76  32 5E A0      LD (A05Eh),A
1C79  AF            XOR A
1C7A  32 5F A0      LD (A05Fh),A

L1C7D:   ; xref 1C74 1C82
1C7D  3A 5F A0      LD A,(A05Fh)
1C80  FE 00         CP 0
1C82  20 F9         JR nz,L1C7D

L1C84:   ; xref 1C89
1C84  3A 5E A0      LD A,(A05Eh)
1C87  FE 00         CP 0
1C89  20 F9         JR nz,L1C84
1C8B  C9            RET

S1C8C:   ; xref 1462 148C 17D7 1DBB 1EC8 1F33
1C8C  21 12 A0      LD HL,A012h
1C8F  7E            LD A,(HL)
1C90  CB 7F         BIT 7,A
1C92  28 0D         JR z,L1CA1
1C94  2E 0E         LD L,14
1C96  77            LD (HL),A
1C97  2E 0F         LD L,15
1C99  36 00         LD (HL),0
1C9B  21 08 A0      LD HL,A008h
1C9E  CB 86         RES 0,(HL)
1CA0  C9            RET

L1CA1:   ; xref 1C92
1CA1  2E 0F         LD L,15
1CA3  77            LD (HL),A
1CA4  2E 0E         LD L,14
1CA6  FD 7E 02      LD A,(IY+2)
1CA9  77            LD (HL),A
1CAA  C9            RET

S1CAB:   ; xref 1741
1CAB  21 08 A0      LD HL,A008h
1CAE  CB E6         SET 4,(HL)
1CB0  CB 96         RES 2,(HL)
1CB2  CD 2A 01      CALL S012A
1CB5  21 08 A0      LD HL,A008h
1CB8  CB A6         RES 4,(HL)
1CBA  C9            RET

S1CBB:   ; xref 13BA 172B 1C3D
1CBB  D9            EXX
1CBC  21 08 A0      LD HL,A008h
1CBF  CB DE         SET 3,(HL)
1CC1  CB 96         RES 2,(HL)
1CC3  CD 2A 01      CALL S012A
1CC6  21 08 A0      LD HL,A008h
1CC9  CB 9E         RES 3,(HL)
1CCB  CD D0 1C      CALL S1CD0
1CCE  D9            EXX
1CCF  C9            RET

S1CD0:   ; xref 1157 1750 1CCB 1E1D
1CD0  21 AA 08      LD HL,08AAh
1CD3  22 DE A0      LD (A0DEh),HL
1CD6  C9            RET

S1CD7:   ; xref 13F9 1522 1BEF
1CD7  CD A3 1B      CALL S1BA3
1CDA  3E 30         LD A,30h
1CDC  BD            CP L
1CDD  23            INC HL
1CDE  20 0A         JR nz,L1CEA
1CE0  7E            LD A,(HL)
1CE1  32 3E E0      LD (E03Eh),A
1CE4  01 3D E0      LD BC,E03Dh
1CE7  C5            PUSH BC
1CE8  18 08         JR L1CF2

L1CEA:   ; xref 1CDE
1CEA  7E            LD A,(HL)
1CEB  32 3F E0      LD (E03Fh),A
1CEE  01 35 E0      LD BC,E035h
1CF1  C5            PUSH BC

L1CF2:   ; xref 1CE8
1CF2  23            INC HL
1CF3  7E            LD A,(HL)
1CF4  32 0B A0      LD (A00Bh),A
1CF7  23            INC HL
1CF8  7E            LD A,(HL)
1CF9  32 0C A0      LD (A00Ch),A
1CFC  23            INC HL
1CFD  7E            LD A,(HL)
1CFE  32 0D A0      LD (A00Dh),A
1D01  CD 00 01      CALL S0100
1D04  D9            EXX
1D05  06 03         LD B,3
1D07  D1            POP DE
1D08  21 2C A0      LD HL,A02Ch

L1D0B:   ; xref 1D14
1D0B  7E            LD A,(HL)
1D0C  12            LD (DE),A
1D0D  CD 58 1C      CALL S1C58
1D10  1B            DEC DE
1D11  12            LD (DE),A
1D12  1B            DEC DE
1D13  23            INC HL
1D14  10 F5         DJNZ L1D0B
1D16  D9            EXX
1D17  C9            RET
1D18  db 06 02 B0 32 38 E0 C9 00                          ; ...28...

S1D20:   ; xref 17E2
1D20  21 40 A0      LD HL,A040h
1D23  3A 08 C0      LD A,(C008h)
1D26  EE FF         XOR FFh
1D28  CB 67         BIT 4,A
1D2A  28 26         JR z,L1D52
1D2C  CB 6E         BIT 5,(HL)
1D2E  28 2E         JR z,L1D5E
1D30  CB 76         BIT 6,(HL)
1D32  20 04         JR nz,L1D38
1D34  CB F6         SET 6,(HL)
1D36  CB FE         SET 7,(HL)

L1D38:   ; xref 1D32 1D56 1D60
1D38  E6 0F         AND 15
1D3A  C6 40         ADD A,40h
1D3C  23            INC HL
1D3D  06 0B         LD B,11

L1D3F:   ; xref 1D4F
1D3F  BD            CP L
1D40  20 16         JR nz,L1D58
1D42  CB 6E         BIT 5,(HL)
1D44  28 1C         JR z,L1D62
1D46  CB 76         BIT 6,(HL)
1D48  20 04         JR nz,L1D4E
1D4A  CB F6         SET 6,(HL)
1D4C  CB FE         SET 7,(HL)

L1D4E:   ; xref 1D48 1D5C 1D64
1D4E  23            INC HL
1D4F  10 EE         DJNZ L1D3F
1D51  C9            RET

L1D52:   ; xref 1D2A
1D52  CB B6         RES 6,(HL)
1D54  CB AE         RES 5,(HL)
1D56  18 E0         JR L1D38

L1D58:   ; xref 1D40
1D58  CB B6         RES 6,(HL)
1D5A  CB AE         RES 5,(HL)
1D5C  18 F0         JR L1D4E

L1D5E:   ; xref 1D2E
1D5E  CB EE         SET 5,(HL)
1D60  18 D6         JR L1D38

L1D62:   ; xref 1D44
1D62  CB EE         SET 5,(HL)
1D64  18 E8         JR L1D4E

S1D66:   ; xref 13C9
1D66  21 D4 A0      LD HL,A0D4h
1D69  7E            LD A,(HL)
1D6A  6F            LD L,A
1D6B  26 00         LD H,0
1D6D  29            ADD HL,HL
1D6E  01 C5 21      LD BC,21C5h
1D71  09            ADD HL,BC
1D72  4E            LD C,(HL)
1D73  23            INC HL
1D74  46            LD B,(HL)
1D75  C5            PUSH BC
1D76  E1            POP HL
1D77  22 5A A0      LD (A05Ah),HL
1D7A  01 80 A0      LD BC,A080h
1D7D  ED 43 02 A0   LD (A002h),BC
1D81  CD 8E 1D      CALL S1D8E
1D84  21 80 A0      LD HL,A080h
1D87  22 D0 A0      LD (A0D0h),HL
1D8A  22 D8 A0      LD (A0D8h),HL
1D8D  C9            RET

S1D8E:   ; xref 1D81 1D9D
1D8E  ED 4B 02 A0   LD BC,(A002h)
1D92  7E            LD A,(HL)
1D93  23            INC HL
1D94  FE FF         CP FFh
1D96  C8            RET z
1D97  02            LD (BC),A
1D98  03            INC BC
1D99  ED 43 02 A0   LD (A002h),BC
1D9D  18 EF         JR S1D8E

S1D9F:   ; xref 14E2
1D9F  3A 12 A0      LD A,(A012h)
1DA2  CB 7F         BIT 7,A
1DA4  C8            RET z
1DA5  FD CB 05 4E   BIT 1,(IY+5)
1DA9  20 1E         JR nz,L1DC9

S1DAB:   ; xref 1471 1DCE
1DAB  3E 30         LD A,30h
1DAD  BB            CP E
1DAE  20 0F         JR nz,L1DBF
1DB0  2A D0 A0      LD HL,(A0D0h)
1DB3  7E            LD A,(HL)
1DB4  23            INC HL
1DB5  22 D0 A0      LD (A0D0h),HL

L1DB8:   ; xref 1DC7
1DB8  32 12 A0      LD (A012h),A
1DBB  CD 8C 1C      CALL S1C8C
1DBE  C9            RET

L1DBF:   ; xref 1DAE
1DBF  2A D8 A0      LD HL,(A0D8h)
1DC2  7E            LD A,(HL)
1DC3  23            INC HL
1DC4  22 D8 A0      LD (A0D8h),HL
1DC7  18 EF         JR L1DB8

L1DC9:   ; xref 1DA9
1DC9  3A 12 A0      LD A,(A012h)
1DCC  FE 8C         CP 8Ch
1DCE  20 DB         JR nz,S1DAB
1DD0  3E 30         LD A,30h
1DD2  BB            CP E
1DD3  20 08         JR nz,L1DDD
1DD5  2A D0 A0      LD HL,(A0D0h)
1DD8  2B            DEC HL
1DD9  22 D0 A0      LD (A0D0h),HL
1DDC  C9            RET

L1DDD:   ; xref 1DD3
1DDD  2A D8 A0      LD HL,(A0D8h)
1DE0  2B            DEC HL
1DE1  22 D8 A0      LD (A0D8h),HL
1DE4  C9            RET

S1DE5:   ; xref 14DF
1DE5  3A 12 A0      LD A,(A012h)
1DE8  CB 7F         BIT 7,A
1DEA  C8            RET z
1DEB  21 05 00      LD HL,5
1DEE  19            ADD HL,DE
1DEF  CB 66         BIT 4,(HL)
1DF1  C0            RET nz
1DF2  21 A5 00      LD HL,A5h
1DF5  19            ADD HL,DE
1DF6  34            INC (HL)
1DF7  3A 10 A0      LD A,(A010h)
1DFA  CB 57         BIT 2,A
1DFC  28 04         JR z,L1E02
1DFE  3E 06         LD A,6
1E00  18 02         JR L1E04

L1E02:   ; xref 1DFC
1E02  3E 04         LD A,4

L1E04:   ; xref 1E00
1E04  BE            CP (HL)
1E05  C0            RET nz
1E06  21 05 00      LD HL,5
1E09  19            ADD HL,DE
1E0A  CB E6         SET 4,(HL)
1E0C  C9            RET

L1E0D:   ; xref 1A8E
1E0D  31 FF A3      LD SP,A3FFh
1E10  21 30 A0      LD HL,A030h
1E13  11 31 A0      LD DE,A031h
1E16  01 CF 03      LD BC,03CFh
1E19  36 00         LD (HL),0
1E1B  ED B0         LDIR
1E1D  CD D0 1C      CALL S1CD0
1E20  FB            EI
1E21  C3 53 12      JP L1253

S1E24:   ; xref 148F
1E24  3A 11 A0      LD A,(A011h)
1E27  CB 5F         BIT 3,A
1E29  C8            RET z
1E2A  21 05 00      LD HL,5
1E2D  19            ADD HL,DE
1E2E  CB 7E         BIT 7,(HL)
1E30  C2 E8 1E      JP nz,L1EE8
1E33  3A 12 A0      LD A,(A012h)
1E36  CB 7F         BIT 7,A
1E38  C8            RET z
1E39  21 06 00      LD HL,6
1E3C  19            ADD HL,DE
1E3D  77            LD (HL),A
1E3E  E6 7F         AND 7Fh
1E40  32 54 A0      LD (A054h),A
1E43  3E 30         LD A,30h
1E45  BB            CP E
1E46  20 05         JR nz,L1E4D
1E48  21 60 A0      LD HL,A060h
1E4B  18 03         JR L1E50

L1E4D:   ; xref 1E46
1E4D  21 90 A0      LD HL,A090h

L1E50:   ; xref 1E4B
1E50  3A 54 A0      LD A,(A054h)
1E53  85            ADD A,L
1E54  6F            LD L,A
1E55  7C            LD A,H
1E56  CE 00         ADC A,0
1E58  67            LD H,A
1E59  22 55 A0      LD (A055h),HL
1E5C  3E 30         LD A,30h
1E5E  BB            CP E
1E5F  20 05         JR nz,L1E66
1E61  22 D2 A0      LD (A0D2h),HL
1E64  18 03         JR L1E69

L1E66:   ; xref 1E5F
1E66  22 DA A0      LD (A0DAh),HL

L1E69:   ; xref 1E64
1E69  21 05 00      LD HL,5
1E6C  19            ADD HL,DE
1E6D  CB AE         RES 5,(HL)
1E6F  21 A8 20      LD HL,20A8h
1E72  3A 54 A0      LD A,(A054h)
1E75  CB 27         SLA A
1E77  CB 27         SLA A
1E79  85            ADD A,L
1E7A  6F            LD L,A
1E7B  7C            LD A,H
1E7C  CE 00         ADC A,0
1E7E  67            LD H,A
1E7F  DD E5         PUSH IX
1E81  DD 21 50 A0   LD IX,A050h
1E85  7E            LD A,(HL)
1E86  DD 77 00      LD (IX),A
1E89  23            INC HL
1E8A  7E            LD A,(HL)
1E8B  DD 77 01      LD (IX+1),A
1E8E  23            INC HL
1E8F  7E            LD A,(HL)
1E90  DD 77 02      LD (IX+2),A
1E93  23            INC HL
1E94  7E            LD A,(HL)
1E95  DD 77 03      LD (IX+3),A
1E98  DD E1         POP IX
1E9A  2A 55 A0      LD HL,(A055h)
1E9D  AF            XOR A
1E9E  BE            CP (HL)
1E9F  20 4E         JR nz,L1EEF
1EA1  3A 52 A0      LD A,(A052h)
1EA4  E6 07         AND 7
1EA6  FE 00         CP 0
1EA8  28 5A         JR z,L1F04
1EAA  3A 52 A0      LD A,(A052h)
1EAD  E6 08         AND 8
1EAF  20 53         JR nz,L1F04
1EB1  ED 5F         LD A,R

L1EB3:   ; xref 1EFC
1EB3  E6 01         AND 1
1EB5  32 57 A0      LD (A057h),A

L1EB8:   ; xref 1F09 1F11
1EB8  2A 50 A0      LD HL,(A050h)
1EBB  3A 57 A0      LD A,(A057h)
1EBE  85            ADD A,L
1EBF  6F            LD L,A
1EC0  7C            LD A,H
1EC1  CE 00         ADC A,0
1EC3  67            LD H,A
1EC4  7E            LD A,(HL)
1EC5  32 12 A0      LD (A012h),A
1EC8  CD 8C 1C      CALL S1C8C
1ECB  21 05 00      LD HL,5
1ECE  19            ADD HL,DE
1ECF  CB 6E         BIT 5,(HL)
1ED1  28 05         JR z,L1ED8
1ED3  3E 01         LD A,1
1ED5  32 0F A0      LD (A00Fh),A

L1ED8:   ; xref 1ED1
1ED8  2A 55 A0      LD HL,(A055h)
1EDB  3A 57 A0      LD A,(A057h)
1EDE  FE 00         CP 0
1EE0  20 03         JR nz,L1EE5
1EE2  CB C6         SET 0,(HL)
1EE4  C9            RET

L1EE5:   ; xref 1EE0
1EE5  CB CE         SET 1,(HL)
1EE7  C9            RET

L1EE8:   ; xref 1E30
1EE8  21 05 00      LD HL,5
1EEB  19            ADD HL,DE
1EEC  CB BE         RES 7,(HL)
1EEE  C9            RET

L1EEF:   ; xref 1E9F
1EEF  21 05 00      LD HL,5
1EF2  19            ADD HL,DE
1EF3  CB EE         SET 5,(HL)
1EF5  2A 55 A0      LD HL,(A055h)
1EF8  7E            LD A,(HL)
1EF9  E6 0C         AND 12
1EFB  7E            LD A,(HL)
1EFC  28 B5         JR z,L1EB3
1EFE  E6 03         AND 3
1F00  FE 01         CP 1
1F02  20 08         JR nz,L1F0C

L1F04:   ; xref 1EA8 1EAF
1F04  3E 00         LD A,0
1F06  32 57 A0      LD (A057h),A
1F09  C3 B8 1E      JP L1EB8

L1F0C:   ; xref 1F02
1F0C  3E 01         LD A,1
1F0E  32 57 A0      LD (A057h),A
1F11  C3 B8 1E      JP L1EB8

S1F14:   ; xref 14EE
1F14  21 05 00      LD HL,5
1F17  19            ADD HL,DE
1F18  CB 6E         BIT 5,(HL)
1F1A  28 25         JR z,L1F41
1F1C  FD CB 05 6E   BIT 5,(IY+5)
1F20  C8            RET z
1F21  2A 55 A0      LD HL,(A055h)
1F24  CB 5E         BIT 3,(HL)
1F26  20 05         JR nz,L1F2D
1F28  CB 56         BIT 2,(HL)
1F2A  20 10         JR nz,L1F3C
1F2C  C9            RET

L1F2D:   ; xref 1F26
1F2D  FD 7E 08      LD A,(IY+8)

L1F30:   ; xref 1F3F
1F30  32 12 A0      LD (A012h),A
1F33  CD 8C 1C      CALL S1C8C
1F36  21 08 A0      LD HL,A008h
1F39  CB 8E         RES 1,(HL)
1F3B  C9            RET

L1F3C:   ; xref 1F2A
1F3C  FD 7E 07      LD A,(IY+7)
1F3F  18 EF         JR L1F30

L1F41:   ; xref 1F1A
1F41  2A 55 A0      LD HL,(A055h)
1F44  FD CB 05 5E   BIT 3,(IY+5)
1F48  20 07         JR nz,L1F51
1F4A  FD CB 05 56   BIT 2,(IY+5)
1F4E  20 04         JR nz,L1F54
1F50  C9            RET

L1F51:   ; xref 1F48
1F51  CB DE         SET 3,(HL)
1F53  C9            RET

L1F54:   ; xref 1F4E
1F54  CB D6         SET 2,(HL)
1F56  C9            RET

S1F57:   ; xref 14F1
1F57  FD CB 05 76   BIT 6,(IY+5)
1F5B  C8            RET z
1F5C  21 A4 00      LD HL,A4h
1F5F  19            ADD HL,DE
1F60  3E 00         LD A,0
1F62  BE            CP (HL)
1F63  C8            RET z
1F64  3E 01         LD A,1
1F66  BE            CP (HL)
1F67  20 0B         JR nz,L1F74
1F69  FD 7E 02      LD A,(IY+2)
1F6C  FE 8C         CP 8Ch
1F6E  C8            RET z
1F6F  FE 8D         CP 8Dh
1F71  C8            RET z
1F72  18 0D         JR L1F81

L1F74:   ; xref 1F67
1F74  3E 02         LD A,2
1F76  BE            CP (HL)
1F77  C0            RET nz
1F78  FD 7E 02      LD A,(IY+2)
1F7B  FE 84         CP 84h
1F7D  C8            RET z
1F7E  FE 85         CP 85h
1F80  C8            RET z

L1F81:   ; xref 1F72
1F81  21 05 00      LD HL,5
1F84  19            ADD HL,DE
1F85  CB 5E         BIT 3,(HL)
1F87  C0            RET nz
1F88  FD 7E 02      LD A,(IY+2)
1F8B  FD BE 09      CP (IY+9)
1F8E  28 09         JR z,L1F99
1F90  CB DE         SET 3,(HL)
1F92  21 08 A0      LD HL,A008h
1F95  CB 8E         RES 1,(HL)
1F97  18 05         JR L1F9E

L1F99:   ; xref 1F8E
1F99  21 08 A0      LD HL,A008h
1F9C  CB CE         SET 1,(HL)

L1F9E:   ; xref 1F97
1F9E  FD 7E 09      LD A,(IY+9)
1FA1  32 0E A0      LD (A00Eh),A
1FA4  FD 7E 0A      LD A,(IY+10)
1FA7  32 0F A0      LD (A00Fh),A
1FAA  21 07 00      LD HL,7
1FAD  19            ADD HL,DE
1FAE  77            LD (HL),A
1FAF  3E 00         LD A,0
1FB1  32 12 A0      LD (A012h),A
1FB4  C9            RET

S1FB5:   ; xref 13C0
1FB5  3E 49         LD A,49h
1FB7  A7            AND A
1FB8  F5            PUSH AF
1FB9  AF            XOR A
1FBA  32 5E A0      LD (A05Eh),A
1FBD  32 5F A0      LD (A05Fh),A
1FC0  32 4E A0      LD (A04Eh),A
1FC3  32 4F A0      LD (A04Fh),A
1FC6  3E 79         LD A,79h
1FC8  32 4B A0      LD (A04Bh),A

L1FCB:   ; xref 1FEA 2018 2024
1FCB  CD 34 20      CALL S2034
1FCE  3A 4B A0      LD A,(A04Bh)
1FD1  FE 00         CP 0
1FD3  28 32         JR z,L2007
1FD5  3A 4E A0      LD A,(A04Eh)
1FD8  FE 00         CP 0
1FDA  28 2F         JR z,L200B
1FDC  3A 4F A0      LD A,(A04Fh)
1FDF  FE 00         CP 0
1FE1  28 37         JR z,L201A
1FE3  3A 08 C0      LD A,(C008h)
1FE6  E6 E0         AND E0h
1FE8  FE E0         CP E0h
1FEA  28 DF         JR z,L1FCB
1FEC  CB 6F         BIT 5,A
1FEE  20 04         JR nz,L1FF4
1FF0  3E 01         LD A,1
1FF2  18 0A         JR L1FFE

L1FF4:   ; xref 1FEE
1FF4  CB 77         BIT 6,A
1FF6  20 04         JR nz,L1FFC
1FF8  3E 02         LD A,2
1FFA  18 02         JR L1FFE

L1FFC:   ; xref 1FF6
1FFC  3E 04         LD A,4

L1FFE:   ; xref 1FF2 1FFA 2009
1FFE  CD 26 20      CALL S2026
2001  C1            POP BC
2002  E6 07         AND 7
2004  CB 3F         SRL A
2006  C9            RET

L2007:   ; xref 1FD3
2007  3E 01         LD A,1
2009  18 F3         JR L1FFE

L200B:   ; xref 1FDA
200B  F1            POP AF
200C  17            RLA
200D  F5            PUSH AF
200E  E6 07         AND 7
2010  CD 26 20      CALL S2026
2013  3E 03         LD A,3
2015  32 4E A0      LD (A04Eh),A
2018  18 B1         JR L1FCB

L201A:   ; xref 1FE1
201A  3E 01         LD A,1
201C  CD 31 1C      CALL S1C31
201F  3E 0F         LD A,15
2021  32 4F A0      LD (A04Fh),A
2024  18 A5         JR L1FCB

S2026:   ; xref 1FFE 2010
2026  21 3F E0      LD HL,E03Fh
2029  36 CC         LD (HL),CCh
202B  F5            PUSH AF
202C  ED 44         NEG
202E  85            ADD A,L
202F  6F            LD L,A
2030  36 CC         LD (HL),CCh
2032  F1            POP AF
2033  C9            RET

S2034:   ; xref 1FCB
2034  3A 5E A0      LD A,(A05Eh)
2037  FE 00         CP 0
2039  C0            RET nz
203A  3E 01         LD A,1
203C  32 5E A0      LD (A05Eh),A
203F  21 4B A0      LD HL,A04Bh
2042  CD 52 20      CALL S2052
2045  21 4E A0      LD HL,A04Eh
2048  CD 52 20      CALL S2052
204B  21 4F A0      LD HL,A04Fh
204E  CD 52 20      CALL S2052
2051  C9            RET

S2052:   ; xref 2042 2048 204E
2052  7E            LD A,(HL)
2053  FE 00         CP 0
2055  C8            RET z
2056  3D            DEC A
2057  77            LD (HL),A
2058  C9            RET
2059  db 7C 04 7C 04 4D 00 50 00 94 00 59 00 68 00 53 00  ; |.|.M.P...Y.h.S.
2069  db 56 00 7C 04 80 81 01 02 03 04 05 06 08 08 09 E6  ; V.|.............
2079  db 00 EF 00 EC 00 F5 00 E6 00 EF 00 F5 00 F5 00 E6  ; ................
2089  db 00 EF 00 FE 00 F5 00 02 01 0B 01 08 01 11 01 02  ; ................
2099  db 01 0B 01 11 01 11 01 02 01 0B 01 19 01 11 01 00  ; ................
20A9  db 00 00 00 F4 20 00 00 F5 20 01 00 F7 20 01 00 F9  ; .... ... ... ...
20B9  db 20 01 00 FB 20 01 00 FD 20 01 00 FF 20 01 00 01  ;  ... ... ... ...
20C9  db 21 01 00 03 21 01 00 05 21 01 00 07 21 01 00 09  ; !...!...!...!...
20D9  db 21 01 00 0B 21 00 00 0C 21 09 00 0E 21 01 00 10  ; !...!...!...!...
20E9  db 21 01 00 12 21 01 00 14 21 00 00 81 82 83 84 85  ; !...!...!.......
20F9  db 86 87 88 89 8A 8B 8C 8D 8E 8F 90 91 92 93 94 95  ; ................
2109  db 96 97 98 99 9A 9B 9C 9D 9E 9F A0 9A 00 00 03 00  ; ................
2119  db 34 00 C9 00 FA 00 2C 01 F4 01 BC 02 09 03 20 03  ; 4.....,....... .
2129  db E8 03 EB 03 DC 05 DE 05 C0 07 D1 07 3D 21 4F 21  ; ............=!O!
2139  db 61 21 73 21 DF 66 01 0C 01 EF 00 10 10 10 06 00  ; a!s!.f..........
2149  db 0F 87 20 00 80 00 DF D5 00 D5 00 D5 00 10 10 10  ; .. .............
2159  db 06 00 03 87 20 00 80 00 DF 99 05 99 05 99 05 0A  ; .... ...........
2169  db 0A 0A 03 00 07 87 20 00 80 00 1F 90 00 90 00 90  ; ...... .........
2179  db 00 0A 0A 0A 01 87 20 00 80 00 D4 9C F0 21 57 25  ; ...... ......!W%
2189  db 79 2B 9B 31 A4 35 AD 39 D0 3E F3 43 AC 48 65 4D  ; y+.1.5.9.>.C.HeM
2199  db 1D 52 D5 56 E1 5A ED 5E 30 63 73 67 4B 6C 23 71  ; .R.V.Z.^0csgKl#q
21A9  db 2D 76 37 7B 17 80 F7 84 88 8B 19 92 97 9B 36 9C  ; -v7{..........6.
21B9  db 97 25 B9 2B F7 39 1A 3F 4D 85 DE 8B CB 21 D6 21  ; .%.+.9.?M....!.!
21C9  db E2 21 82 83 90 85 89 8A 8B 91 8E 8D FF 8F 83 84  ; .!..............
21D9  db 85 87 89 8A 8B 91 8E 8D FF 8F 83 84 85 86 87 88  ; ................
21E9  db 89 8A 8B 8C 8E 8D FF 34 22 3B 22 3B 22 53 22 69  ; .......4";";"S"i
21F9  db 22 7B 22 97 22 B9 22 E0 22 FD 22 2F 23 50 23 6C  ; "{"."."."."/#P#l
2209  db 23 A1 23 BC 23 E8 23 FA 23 0C 24 2F 24 61 24 95  ; #.#.#.#.#.$/$a$.
2219  db 24 CC 24 03 25 0A 25 11 25 18 25 1F 25 26 25 2D  ; $.$.%.%.%.%.%&%-
2229  db 25 34 25 3B 25 42 25 50 25 49 25 00 02 80 00 80  ; %4%;%B%P%I%.....
2239  db 8A 04 81 01 1B 00 3B 98 01 03 80 04 36 84 01 FF  ; ......;.....6...
2249  db 00 04 03 18 3B 00 01 F2 04 05 89 01 18 07 13 88  ; ....;...........
2259  db 01 18 07 13 84 01 FF 07 13 03 04 1B 00 80 22 05  ; ..............".
2269  db 81 01 1B 00 25 98 01 05 80 00 25 03 05 25 00 80  ; ....%.....%..%..
2279  db 38 05 8A 01 1B 3B 34 82 01 1B 3B 34 86 01 1B 3B  ; 8....;4...;4...;
2289  db 34 94 01 06 80 3B 34 03 18 6F 00 00 56 05 88 01  ; 4....;4..o..V...
2299  db 18 11 35 8A 01 1B 00 46 82 01 1B 00 46 86 01 1B  ; ..5....F....F...
22A9  db 00 46 94 01 07 80 11 35 03 18 46 00 01 B0 05 07  ; .F.....5..F.....
22B9  db A8 12 18 1B 00 01 27 8A 01 1B 00 01 C2 93 1B FF  ; ......'.........
22C9  db 10 00 01 09 1D 86 01 1B 00 01 90 01 08 80 0B 1D  ; ................
22D9  db 03 10 28 00 00 E9 05 8A 01 1E 3B 11 82 01 1E 3B  ; ..(.......;....;
22E9  db 11 86 01 1E 3B 11 90 01 09 80 3B 2B 04 19 66 00  ; ....;.....;+..f.
22F9  db 01 0A 06 0F 81 01 1E 00 46 89 01 1E 00 46 B8 12  ; ........F....F..
2309  db 1E 0A 40 00 27 1F 8A 01 1E 00 46 82 01 1E 00 46  ; ..@.'.....F....F
2319  db 86 01 1E 00 46 84 01 1E 00 46 85 01 1E 00 46 04  ; ....F....F....F.
2329  db 1E 46 00 00 5D 06 81 01 1E 09 20 89 01 1E 09 20  ; .F..]..... .... 
2339  db 88 01 1E 09 20 94 01 0B 80 16 13 80 01 1D 09 20  ; .... .......... 
2349  db 04 1F 2A 00 00 96 06 81 01 1E 0D 1A 89 01 1E 0D  ; ..*.............
2359  db 1A 98 01 0C 80 0D 1A 80 01 1D 0D 1A 04 1F 27 00  ; ..............'.
2369  db 00 B8 06 81 01 1E 0D 12 89 01 1E 0D 12 88 01 1E  ; ................
2379  db 0D 12 8A 01 1E 0D 12 82 01 1E 0D 12 86 01 1E 0D  ; ................
2389  db 12 84 01 1E 0D 12 85 01 1E 0D 12 90 01 0D 80 0D  ; ................
2399  db 12 04 1F 20 00 00 D8 06 81 01 1E 00 0E 89 01 1E  ; ... ............
23A9  db 00 0E 88 01 1E 00 0E 80 01 FF 00 0E 04 0E 0E 00  ; ................
23B9  db 80 F2 06 81 01 1E 00 1D 89 01 1E 00 1D 88 01 1E  ; ................
23C9  db 00 1D 82 01 1E 1D 3B 86 01 1E 1D 3B 94 01 0F 80  ; ......;....;....
23D9  db 1D 3B 95 01 0F 80 1D 3B 04 1E 59 00 00 FE 06 81  ; .;.....;..Y.....
23E9  db 01 1E 23 17 82 01 1E 23 17 04 10 3B 00 81 46 07  ; ..#....#...;..F.
23F9  db 0F 81 01 FF 00 18 85 01 FF 00 18 03 11 18 00 81  ; ................
2409  db 76 07 16 88 01 1B 4A 10 8A 01 1B 4A 10 82 01 1B  ; v.....J....J....
2419  db 0B 4F 86 01 1B 0B 4F B4 12 1C 12 40 0B 3F 10 03  ; .O....O....@.?..
2429  db 1A 5A 00 00 8A 07 81 01 1B 00 44 89 01 1B 00 44  ; .Z........D....D
2439  db 88 01 1B 00 44 8A 01 1B 00 44 82 01 1B 00 44 86  ; ....D....D....D.
2449  db 01 1B 00 44 B4 12 1C 13 40 00 30 13 85 01 1B 00  ; ...D....@.0.....
2459  db 44 03 1A 44 00 00 D3 07 81 01 1B 00 41 89 01 1B  ; D..D........A...
2469  db 00 41 A8 12 1B 1C 00 2F 12 8A 01 1B 00 41 82 01  ; .A...../.....A..
2479  db 1B 00 41 86 01 1B 00 41 B4 12 1C 14 40 00 2F 12  ; ..A....A....@./.
2489  db 85 01 1B 00 41 03 1A 41 00 00 0A 08 81 01 1B 00  ; ....A..A........
2499  db 44 89 01 1B 00 44 A8 12 1C 1B 00 30 13 8A 01 1B  ; D....D.....0....
24A9  db 00 44 82 01 1B 00 44 86 01 1B 00 44 B4 12 1C 16  ; .D....D....D....
24B9  db 40 00 30 13 B5 12 1B 16 40 00 30 13 03 15 44 00  ; @.0.....@.0...D.
24C9  db 80 3F 08 81 01 1B 00 30 89 01 1B 00 30 A8 12 1C  ; .?.....0....0...
24D9  db 1B 00 18 17 8A 01 1B 00 30 82 01 1B 00 30 86 01  ; ........0....0..
24E9  db 1B 00 30 B4 12 1C 16 40 00 18 17 B5 12 1B 1B 40  ; ..0....@.......@
24F9  db 00 18 17 03 1A 30 00 00 76 08 03 82 74 00 00 9D  ; .....0..v...t...
2509  db 08 03 82 32 00 00 AD 19 10 20 24 00 00 02 09 10  ; ...2..... $.....
2519  db 20 33 00 00 26 09 10 20 42 00 00 56 09 10 20 22  ;  3..&.. B..V.. "
2529  db 00 00 70 09 10 20 29 00 00 92 09 10 20 6A 00 00  ; ..p.. )..... j..
2539  db BA 09 10 20 33 00 00 16 0A 10 20 51 00 00 CE 09  ; ... 3..... Q....
2549  db 20 21 34 00 00 43 0A 20 21 32 00 00 2A 0F D7 25  ;  !4..C. !2..*..%
2559  db DE 25 DE 25 29 26 63 26 96 26 D7 26 41 27 91 27  ; .%.%)&c&.&.&A'.'
2569  db D0 27 0D 28 6C 28 AC 28 B3 28 E5 28 32 29 72 29  ; .'.(l(.(.(.(2)r)
2579  db 79 29 80 29 87 29 8E 29 95 29 9C 29 A3 29 AA 29  ; y).).).).).).).)
2589  db B1 29 B8 29 29 2A BF 29 29 2A 74 2A 7D 2A C8 2A  ; .).))*.))*t*}*.*
2599  db C8 2A CF 2A 29 26 63 26 96 26 D7 26 41 27 91 27  ; .*.*)&c&.&.&A'.'
25A9  db D0 27 1A 2B 6C 28 AC 28 B3 28 E5 28 32 29 72 29  ; .'.+l(.(.(.(2)r)
25B9  db 79 29 80 29 87 29 8E 29 95 29 9C 29 A3 29 AA 29  ; y).).).).).).).)
25C9  db B1 29 B8 29 29 2A BF 29 29 2A 74 2A 7D 2A 00 02  ; .).))*.))*t*}*..
25D9  db 7C 01 80 76 0A D1 93 FF 12 03 20 00 07 0E 20 D9  ; |..v...... ... .
25E9  db 93 11 FF 03 20 00 07 0E 20 B8 12 11 03 40 00 07  ; .... ... ....@..
25F9  db 2F CA 93 11 FF 10 00 07 0E 20 A2 12 11 10 07 0E  ; /........ ......
2609  db 20 C6 93 12 FF 10 00 07 0E 20 84 01 12 00 07 C5  ;  ........ ......
2619  db 93 12 FF 10 00 07 0E 20 03 10 36 00 01 AA 0B 02  ; ....... ..6.....
2629  db C1 93 10 FF 15 00 0C 13 1F 89 01 10 0C 32 B8 12  ; .............2..
2639  db 10 04 40 00 0C 32 8A 01 10 00 3F A2 12 10 15 00  ; ..@..2....?.....
2649  db 20 1F A6 12 10 11 00 20 1F 84 01 12 00 3F 85 01  ;  ...... .....?..
2659  db 10 00 3F 03 10 3F 00 00 D6 0B B1 12 10 05 40 00  ; ..?..?........@.
2669  db 0B 0B 89 01 10 00 0B 98 01 05 80 00 16 8A 01 10  ; ................
2679  db 00 16 82 01 11 00 16 86 01 10 00 16 84 01 10 00  ; ................
2689  db 16 85 01 10 00 16 03 05 16 00 80 09 0C D1 93 13  ; ................
2699  db 10 06 20 00 08 09 20 B9 12 10 06 40 00 12 20 88  ; .. ... ....@.. .
26A9  db 01 15 12 20 AA 12 10 0D 00 12 20 C2 93 14 11 0D  ; ... ...... .....
26B9  db 00 08 09 20 86 01 10 00 32 A4 12 10 11 00 08 09  ; ... ....2.......
26C9  db 85 01 10 00 32 03 10 32 00 20 1B 0C 1A 1B C1 93  ; ....2..2. ......
26D9  db FF FF 15 09 09 11 1D C9 93 16 FF 13 09 0E 0C 1D  ; ................
26E9  db C8 93 15 16 FF 00 09 0E 0C 88 01 13 25 1D CA 93  ; ............%...
26F9  db 15 16 FF 00 09 0E 0C 8A 01 15 25 1D C2 93 15 FF  ; ..........%.....
2709  db 13 00 09 1B 1D C6 93 17 FF 13 09 0E 0C 1D C4 93  ; ................
2719  db 15 17 FF 00 09 0E 0C 84 01 13 25 1D C5 93 15 17  ; ..........%.....
2729  db FF 00 09 0E 0C 85 01 13 25 1D 90 01 07 80 13 2F  ; ........%....../
2739  db 03 13 42 00 09 44 0C 0A C1 93 15 FF 10 07 0D 22  ; ..B..D........."
2749  db 1D B9 12 FF 08 80 07 30 1D 98 01 08 80 37 1D CA  ; .......0.....7..
2759  db 93 15 13 15 07 21 0E 1D C2 93 13 15 FF 07 0D 13  ; .....!..........
2769  db 0E 82 01 15 37 1D C6 93 13 15 17 07 0D 13 2C C4  ; ....7.........,.
2779  db 93 13 15 17 07 0D 13 2C C5 93 13 15 17 07 0D 13  ; .......,........
2789  db 2C 03 15 55 00 00 7A 0C 81 01 15 00 27 A9 12 15  ; ,..U..z.....'...
2799  db 13 00 09 1D 88 01 13 09 1D 8A 01 15 00 27 A2 12  ; .............'..
27A9  db 16 13 00 09 1D A6 12 15 13 00 09 1D A4 12 17 13  ; ................
27B9  db 00 09 1D A5 12 15 13 00 09 1D 90 01 09 80 09 1D  ; ................
27C9  db 03 13 27 00 00 BF 0C C1 93 15 FF 12 07 0D 13 2C  ; ..'............,
27D9  db C9 93 15 FF 10 07 0D 13 2C 88 01 15 28 2C BA 12  ; ........,...(,..
27E9  db 15 0A 40 07 21 2C B2 12 15 0A 40 08 20 2C 86 01  ; ..@.!,....@. ,..
27F9  db 15 15 40 84 01 15 15 13 85 01 15 15 40 03 10 55  ; ..@.........@..U
2809  db 00 00 DF 0C A1 12 15 FF 00 09 09 81 01 12 2A 1D  ; ..............*.
2819  db C9 93 15 FF 10 00 1D 0C 1D C8 93 15 FF 13 00 1D  ; ................
2829  db 0C 1D CA 93 15 FF 13 09 13 0C 1D 82 01 15 2A 1D  ; ..............*.
2839  db 86 01 10 00 09 C6 93 15 FF 15 09 13 0C 1D 84 01  ; ................
2849  db 10 00 09 C4 93 15 FF 10 09 13 0C 1D A5 12 10 15  ; ................
2859  db 00 09 13 90 01 0B 80 13 34 03 13 47 00 41 24 0D  ; ........4..G.A$.
2869  db 82 1E 83 A1 12 15 FF 07 0C 1D A9 12 15 10 07 0C  ; ................
2879  db 1D C8 93 FF 10 FF 07 0C 1D 27 CA 93 FF FF FF 07  ; .........'......
2889  db 0C 1D 27 C2 93 15 FF 14 07 0C 1D 27 C6 93 15 10  ; ..'........'....
2899  db 14 07 0C 1D 27 A4 12 15 10 07 0C 1D 03 83 51 00  ; ....'.........Q.
28A9  db 00 5E 0D 00 83 33 00 00 3E 14 A1 12 15 10 00 0E  ; .^...3..>.......
28B9  db 1F A9 12 15 16 00 0E 1F B8 12 15 0E 40 00 0E 1F  ; ............@...
28C9  db 8A 01 15 0E 1F 82 01 15 0E 1F 86 01 15 00 2D 84  ; ..............-.
28D9  db 01 15 00 2D 03 15 2D 00 05 A6 0D 0E D1 93 10 FF  ; ...-..-.........
28E9  db 0F 20 00 0D 13 2A D9 93 10 FF 0F 20 00 0D 13 2A  ; . ...*..... ...*
28F9  db B8 12 11 0F 40 0D 13 2A 8A 01 15 00 4B C2 93 15  ; ....@..*....K...
2909  db FF 15 00 0D 13 2A C6 93 16 15 16 00 0D 13 2A A4  ; .....*........*.
2919  db 12 10 12 00 0D 13 C5 93 10 FF 15 00 0D 13 2A 03  ; ..............*.
2929  db 10 4B 00 41 CB 0D 83 1F 0F 81 01 FF 20 27 89 01  ; .K.A........ '..
2939  db FF 20 27 C8 93 15 FF FF 00 0C 13 27 CA 93 15 FF  ; . '........'....
2949  db FF 00 0C 13 27 C2 93 15 FF 14 00 0C 13 27 C6 93  ; ....'........'..
2959  db 15 FF 14 00 0C 13 27 84 01 15 00 0C 85 01 15 00  ; ......'.........
2969  db 0C 03 83 3F 00 01 08 0E 0F 10 18 29 00 00 42 0E  ; ...?.......)..B.
2979  db 10 18 2D 00 00 6A 0E 10 18 2F 00 00 95 0E 10 18  ; ..-..j.../......
2989  db 2E 00 00 CE 0E 10 18 33 00 00 FA 0E 10 18 0E 00  ; .......3........
2999  db 00 58 0E 10 18 1E 00 00 76 0E 10 18 1E 00 00 A2  ; .X......v.......
29A9  db 0E 20 19 32 00 00 2A 0F 20 19 33 00 00 45 0A 00  ; . .2..*. .3..E..
29B9  db 1D 00 00 00 44 0C C1 93 FF FF 15 00 09 11 1D C9  ; ....D...........
29C9  db 93 16 FF 13 00 0E 0C 1D C8 93 15 16 FF 00 00 0E  ; ................
29D9  db 0C 88 01 13 1B 1D CA 93 15 16 FF 00 00 0E 0C 8A  ; ................
29E9  db 01 15 1B 1D C2 93 15 FF 13 00 00 1B 1D C6 93 17  ; ................
29F9  db FF 13 00 0E 0C 1D C4 93 15 17 FF 00 00 0E 0C 84  ; ................
2A09  db 01 13 1B 1D C5 93 15 17 FF 00 00 0E 0C 85 01 13  ; ................
2A19  db 1B 1D 90 01 07 80 09 2F 03 13 39 00 01 4C 0C 08  ; ......./..9..L..
2A29  db D1 93 10 FF 0F 20 00 00 13 2A D9 93 10 FF 0F 20  ; ..... ...*..... 
2A39  db 00 00 13 2A B8 12 11 0F 40 00 13 2A 8A 01 15 00  ; ...*....@..*....
2A49  db 3E C2 93 15 FF 15 00 00 13 2A C6 93 16 15 16 00  ; >........*......
2A59  db 00 13 2A A4 12 10 12 00 00 13 C5 93 10 FF 15 00  ; ..*.............
2A69  db 00 13 2A 03 10 3E 00 01 D6 0D 0F 00 1E 0A 00 40  ; ..*..>.........@
2A79  db 5E 0D 83 1F D1 93 FF 12 03 20 07 07 0E 20 D9 93  ; ^........ ... ..
2A89  db 11 FF 03 20 07 07 0E 20 B8 12 11 03 40 07 07 2F  ; ... ... ....@../
2A99  db CA 93 11 FF 10 07 07 0E 20 A2 12 11 10 0E 0E 20  ; ........ ...... 
2AA9  db C6 93 12 FF 10 07 07 0E 20 84 01 12 07 07 C5 93  ; ........ .......
2AB9  db 12 FF 10 07 07 0E 20 03 10 3E 00 01 A4 0B 05 00  ; ...... ..>......
2AC9  db 02 41 00 00 76 0A D1 93 FF 12 03 20 07 07 0E 20  ; .A..v...... ... 
2AD9  db D9 93 11 FF 03 20 07 07 0E 20 B8 12 11 03 40 07  ; ..... ... ....@.
2AE9  db 07 2F CA 93 11 FF 10 07 07 0E 20 A2 12 11 10 0E  ; ./........ .....
2AF9  db 0E 20 C6 93 12 FF 10 07 07 0E 20 84 01 12 07 07  ; . ........ .....
2B09  db C5 93 12 FF 10 07 07 0E 20 03 10 3E 00 01 A4 0B  ; ........ ..>....
2B19  db 02 A1 12 15 FF 00 09 09 81 01 12 2A 1D C9 93 15  ; ...........*....
2B29  db FF 10 00 1D 0C 1D C8 93 15 FF 13 00 1D 0C 1D CA  ; ................
2B39  db 93 15 FF 13 09 13 0C 1D 82 01 15 2A 1D 86 01 10  ; ...........*....
2B49  db 00 09 C6 93 15 FF 15 09 13 0C 1D 84 01 10 00 09  ; ................
2B59  db C4 93 15 FF 10 09 13 0C 1D A5 12 10 15 00 09 13  ; ................
2B69  db 90 01 0B 80 13 34 03 13 47 00 41 24 0D 9B 1E 83  ; .....4..G.A$....
2B79  db F9 2B 00 2C 00 2C 4B 2C 85 2C B8 2C F9 2C 63 2D  ; .+.,.,K,.,.,.,c-
2B89  db B3 2D F2 2D 2F 2E 8E 2E CE 2E D5 2E 07 2F 54 2F  ; .-.-/......../T/
2B99  db 94 2F 9B 2F A2 2F A9 2F B0 2F B7 2F BE 2F C5 2F  ; ././././././././
2BA9  db CC 2F D3 2F DA 2F 4B 30 E1 2F 4B 30 96 30 9F 30  ; ./././K0./K0.0.0
2BB9  db EA 30 EA 30 F1 30 4B 2C 85 2C B8 2C F9 2C 63 2D  ; .0.0.0K,.,.,.,c-
2BC9  db B3 2D F2 2D 3C 31 8E 2E CE 2E D5 2E 07 2F 54 2F  ; .-.-<1......./T/
2BD9  db 94 2F 9B 2F A2 2F A9 2F B0 2F B7 2F BE 2F C5 2F  ; ././././././././
2BE9  db CC 2F D3 2F DA 2F 4B 30 E1 2F 4B 30 96 30 9F 30  ; ./././K0./K0.0.0
2BF9  db 00 02 7C 01 80 5A 0F D1 93 FF 12 03 20 00 07 0E  ; ..|..Z...... ...
2C09  db 20 D5 93 11 FF 03 20 00 07 0E 20 B4 12 11 03 40  ;  ..... ... ....@
2C19  db 00 07 2F C6 93 11 FF 10 00 07 0E 20 A2 12 11 10  ; ../........ ....
2C29  db 07 0E 20 CA 93 12 FF 10 00 07 0E 20 88 01 12 00  ; .. ........ ....
2C39  db 07 C9 93 12 FF 10 00 07 0E 20 03 10 36 00 01 8E  ; ......... ..6...
2C49  db 10 02 C1 93 10 FF 15 00 0C 13 1F 85 01 10 0C 32  ; ...............2
2C59  db B4 12 10 04 40 00 0C 32 86 01 10 00 3F A2 12 10  ; ....@..2....?...
2C69  db 15 00 20 1F AA 12 10 11 00 20 1F 88 01 12 00 3F  ; .. ...... .....?
2C79  db 89 01 10 00 3F 03 10 3F 00 00 BA 10 B1 12 10 05  ; ....?..?........
2C89  db 40 00 0B 0B 85 01 10 00 0B 94 01 05 80 00 16 86  ; @...............
2C99  db 01 10 00 16 82 01 11 00 16 8A 01 10 00 16 88 01  ; ................
2CA9  db 10 00 16 89 01 10 00 16 03 05 16 00 80 ED 10 D1  ; ................
2CB9  db 93 13 10 06 20 00 08 09 20 B5 12 10 06 40 00 12  ; .... ... ....@..
2CC9  db 20 84 01 15 12 20 A6 12 10 0D 00 12 20 C2 93 14  ;  .... ...... ...
2CD9  db 11 0D 00 08 09 20 8A 01 10 00 32 A8 12 10 11 00  ; ..... ....2.....
2CE9  db 08 09 89 01 10 00 32 03 10 32 00 20 FF 10 1A 1B  ; ......2..2. ....
2CF9  db C1 93 FF FF 15 09 09 11 1D C5 93 16 FF 13 09 0E  ; ................
2D09  db 0C 1D C4 93 15 16 FF 00 09 0E 0C 84 01 13 25 1D  ; ..............%.
2D19  db C6 93 15 16 FF 00 09 0E 0C 86 01 15 25 1D C2 93  ; ............%...
2D29  db 15 FF 13 00 09 1B 1D CA 93 17 FF 13 09 0E 0C 1D  ; ................
2D39  db C8 93 15 17 FF 00 09 0E 0C 88 01 13 25 1D C9 93  ; ............%...
2D49  db 15 17 FF 00 09 0E 0C 89 01 13 25 1D 90 01 07 80  ; ..........%.....
2D59  db 13 2F 03 13 42 00 09 28 11 0A C1 93 15 FF 10 07  ; ./..B..(........
2D69  db 0D 22 1D B5 12 FF 08 80 07 30 1D 94 01 08 80 37  ; .".......0.....7
2D79  db 1D C6 93 15 13 15 07 21 0E 1D C2 93 13 15 FF 07  ; .......!........
2D89  db 0D 13 0E 82 01 15 37 1D CA 93 13 15 17 07 0D 13  ; ......7.........
2D99  db 2C C8 93 13 15 17 07 0D 13 2C C9 93 13 15 17 07  ; ,........,......
2DA9  db 0D 13 2C 03 15 55 00 00 5E 11 81 01 15 00 27 A5  ; ..,..U..^.....'.
2DB9  db 12 15 13 00 09 1D 84 01 13 09 1D 86 01 15 00 27  ; ...............'
2DC9  db A2 12 16 13 00 09 1D AA 12 15 13 00 09 1D A8 12  ; ................
2DD9  db 17 13 00 09 1D A9 12 15 13 00 09 1D 90 01 09 80  ; ................
2DE9  db 09 1D 03 13 27 00 00 A3 11 C1 93 15 FF 12 07 0D  ; ....'...........
2DF9  db 13 2C C5 93 15 FF 10 07 0D 13 2C 84 01 15 28 2C  ; .,........,...(,
2E09  db B6 12 15 0A 40 07 21 2C B2 12 15 0A 40 08 20 2C  ; ....@.!,....@. ,
2E19  db 8A 01 15 15 40 88 01 15 15 13 89 01 15 15 40 03  ; ....@.........@.
2E29  db 10 55 00 00 C3 11 A1 12 15 FF 00 09 09 81 01 12  ; .U..............
2E39  db 2A 1D C5 93 15 FF 10 00 1D 0C 1D C4 93 15 FF 13  ; *...............
2E49  db 00 1D 0C 1D C6 93 15 FF 13 09 13 0C 1D 82 01 15  ; ................
2E59  db 2A 1D 8A 01 10 00 09 CA 93 15 FF 15 09 13 0C 1D  ; *...............
2E69  db 88 01 10 00 09 C8 93 15 FF 10 09 13 0C 1D A9 12  ; ................
2E79  db 10 15 00 09 13 90 01 0B 80 13 34 03 13 47 00 41  ; ..........4..G.A
2E89  db 08 12 83 1E 84 A1 12 15 FF 07 0C 1D A5 12 15 10  ; ................
2E99  db 07 0C 1D C4 93 FF 10 FF 07 0C 1D 27 C6 93 FF FF  ; ...........'....
2EA9  db FF 07 0C 1D 27 C2 93 15 FF 14 07 0C 1D 27 CA 93  ; ....'........'..
2EB9  db 15 10 14 07 0C 1D 27 A8 12 15 10 07 0C 1D 03 83  ; ......'.........
2EC9  db 51 00 00 42 12 00 83 33 00 00 3E 14 A1 12 15 10  ; Q..B...3..>.....
2ED9  db 00 0E 1F A5 12 15 16 00 0E 1F B4 12 15 0E 40 00  ; ..............@.
2EE9  db 0E 1F 86 01 15 0E 1F 82 01 15 0E 1F 8A 01 15 00  ; ................
2EF9  db 2D 88 01 15 00 2D 03 15 2D 00 05 8A 12 0E D1 93  ; -....-..-.......
2F09  db 10 FF 0F 20 00 0D 13 2A D5 93 10 FF 0F 20 00 0D  ; ... ...*..... ..
2F19  db 13 2A B4 12 11 0F 40 0D 13 2A 86 01 15 00 4B C2  ; .*....@..*....K.
2F29  db 93 15 FF 15 00 0D 13 2A CA 93 16 15 16 00 0D 13  ; .......*........
2F39  db 2A A8 12 10 12 00 0D 13 C9 93 10 FF 15 00 0D 13  ; *...............
2F49  db 2A 03 10 4B 00 41 AF 12 82 1F 0F 81 01 FF 20 27  ; *..K.A........ '
2F59  db 85 01 FF 20 27 C4 93 15 FF FF 00 0C 13 27 C6 93  ; ... '........'..
2F69  db 15 FF FF 00 0C 13 27 C2 93 15 FF 14 00 0C 13 27  ; ......'........'
2F79  db CA 93 15 FF 14 00 0C 13 27 88 01 15 00 0C 89 01  ; ........'.......
2F89  db 15 00 0C 03 83 3F 00 01 EC 12 0F 10 18 29 00 00  ; .....?.......)..
2F99  db 26 13 10 18 2D 00 00 4E 13 10 18 2F 00 00 79 13  ; &...-..N.../..y.
2FA9  db 10 18 2E 00 00 B2 13 10 18 33 00 00 DE 13 10 18  ; .........3......
2FB9  db 0E 00 00 3C 13 10 18 1E 00 00 5A 13 10 18 1E 00  ; ...<......Z.....
2FC9  db 00 86 13 20 19 32 00 00 2A 0F 20 19 33 00 00 45  ; ... .2..*. .3..E
2FD9  db 0A 00 1D 00 00 00 28 11 C1 93 FF FF 15 00 09 11  ; ......(.........
2FE9  db 1D C5 93 16 FF 13 00 0E 0C 1D C4 93 15 16 FF 00  ; ................
2FF9  db 00 0E 0C 84 01 13 1B 1D C6 93 15 16 FF 00 00 0E  ; ................
3009  db 0C 86 01 15 1B 1D C2 93 15 FF 13 00 00 1B 1D CA  ; ................
3019  db 93 17 FF 13 00 0E 0C 1D C8 93 15 17 FF 00 00 0E  ; ................
3029  db 0C 88 01 13 1B 1D C9 93 15 17 FF 00 00 0E 0C 89  ; ................
3039  db 01 13 1B 1D 90 01 07 80 09 2F 03 13 39 00 01 30  ; ........./..9..0
3049  db 11 08 D1 93 10 FF 0F 20 00 00 13 2A D5 93 10 FF  ; ....... ...*....
3059  db 0F 20 00 00 13 2A B4 12 11 0F 40 00 13 2A 86 01  ; . ...*....@..*..
3069  db 15 00 3E C2 93 15 FF 15 00 00 13 2A CA 93 16 15  ; ..>........*....
3079  db 16 00 00 13 2A A8 12 10 12 00 00 13 C9 93 10 FF  ; ....*...........
3089  db 15 00 00 13 2A 03 10 3E 00 01 BA 12 0F 00 1E 0A  ; ....*..>........
3099  db 00 40 42 12 82 1F D1 93 FF 12 03 20 07 07 0E 20  ; .@B........ ... 
30A9  db D5 93 11 FF 03 20 07 07 0E 20 B4 12 11 03 40 07  ; ..... ... ....@.
30B9  db 07 2F C6 93 11 FF 10 07 07 0E 20 A2 12 11 10 0E  ; ./........ .....
30C9  db 0E 20 CA 93 12 FF 10 07 07 0E 20 88 01 12 07 07  ; . ........ .....
30D9  db C9 93 12 FF 10 07 07 0E 20 03 10 3E 00 01 88 10  ; ........ ..>....
30E9  db 05 00 02 41 00 00 5A 0F D1 93 FF 12 03 20 07 07  ; ...A..Z...... ..
30F9  db 0E 20 D5 93 11 FF 03 20 07 07 0E 20 B4 12 11 03  ; . ..... ... ....
3109  db 40 07 07 2F C6 93 11 FF 10 07 07 0E 20 A2 12 11  ; @../........ ...
3119  db 10 0E 0E 20 CA 93 12 FF 10 07 07 0E 20 88 01 12  ; ... ........ ...
3129  db 07 07 C9 93 12 FF 10 07 07 0E 20 03 10 3E 00 01  ; .......... ..>..
3139  db 88 10 02 A1 12 15 FF 00 09 09 81 01 12 2A 1D C5  ; .............*..
3149  db 93 15 FF 10 00 1D 0C 1D C4 93 15 FF 13 00 1D 0C  ; ................
3159  db 1D C6 93 15 FF 13 09 13 0C 1D 82 01 15 2A 1D 8A  ; .............*..
3169  db 01 10 00 09 CA 93 15 FF 15 09 13 0C 1D 88 01 10  ; ................
3179  db 00 09 C8 93 15 FF 10 09 13 0C 1D A9 12 10 15 00  ; ................
3189  db 09 13 90 01 0B 80 13 34 03 13 47 00 41 08 12 9C  ; .......4..G.A...
3199  db 1E 83 DF 31 E6 31 E6 31 00 32 23 32 5C 32 88 32  ; ...1.1.1.2#2\2.2
31A9  db A5 32 E0 32 0B 33 2F 33 60 33 9C 33 CA 33 DE 33  ; .2.2.3/3`3.3.3.3
31B9  db 0B 34 12 34 4E 34 88 34 C2 34 EA 34 F1 34 F8 34  ; .4.4N4.4.4.4.4.4
31C9  db FF 34 06 35 0D 35 19 34 DE 33 14 35 1B 35 22 35  ; .4.5.5.4.3.5.5"5
31D9  db 64 35 29 35 6B 35 00 02 3B 00 80 3E 14 91 01 03  ; d5)5k5..;..>....
31E9  db 80 00 27 99 01 03 80 00 27 95 01 03 80 00 27 04  ; ..'.....'.....'.
31F9  db 17 27 00 01 6E 14 05 8A 01 17 0B 39 82 01 17 0B  ; .'..n......9....
3209  db 39 86 01 17 0B 39 94 01 04 80 20 23 95 01 04 80  ; 9....9.... #....
3219  db 20 23 04 17 44 00 01 8E 14 04 B1 12 FF 05 40 0B  ;  #..D.........@.
3229  db 0E 20 99 01 05 80 1A 20 98 01 05 80 1A 20 8A 01  ; . ..... ..... ..
3239  db 17 00 3A C2 93 17 FF 17 00 0B 0E 20 86 01 17 00  ; ..:........ ....
3249  db 3A 84 01 17 1A 20 85 01 17 1A 20 04 17 3A 00 01  ; :.... .... ..:..
3259  db C5 14 05 91 01 06 80 20 34 B9 12 FF 06 40 0C 13  ; ....... 4....@..
3269  db 34 88 01 FF 0C 13 82 01 17 20 34 86 01 17 20 34  ; 4........ 4... 4
3279  db 84 01 17 0C 13 04 17 54 00 21 F4 14 1E 1A 05 8A  ; .......T.!......
3289  db 01 1A 07 18 82 01 1A 07 18 86 01 1A 07 18 90 01  ; ................
3299  db 07 80 07 2C 04 1A 34 00 01 38 15 05 81 01 15 79  ; ...,..4..8.....y
32A9  db 22 89 01 15 79 22 88 01 15 79 22 8A 01 15 79 22  ; "...y"...y"...y"
32B9  db C2 93 17 FF 15 00 2C 4C 22 86 01 15 79 22 94 01  ; ......,L"...y"..
32C9  db 08 80 79 22 95 01 08 80 79 22 80 01 14 79 22 05  ; ..y"....y"...y".
32D9  db 15 9C 00 09 62 15 08 A1 12 FF 16 0E 13 27 88 01  ; ....b........'..
32E9  db 18 00 0E 8A 01 18 00 22 A2 12 18 16 00 22 27 85  ; ......."....."'.
32F9  db 01 FF 0E 12 90 01 09 80 22 27 05 16 4A 00 01 E0  ; ........"'..J...
3309  db 15 0C 91 01 0A 80 1D 2A 99 01 0A 80 1D 2A 98 01  ; .......*.....*..
3319  db 0A 80 1D 2A 82 01 15 1D 2A 80 01 14 1D 2A 05 15  ; ...*....*....*..
3329  db 47 00 01 1C 16 0B 91 01 0B 80 25 27 89 01 FF 11  ; G.........%'....
3339  db 13 88 01 FF 11 13 AA 12 18 15 11 13 27 A2 12 18  ; ............'...
3349  db 15 00 25 27 A6 12 18 15 00 25 27 80 01 14 25 27  ; ..%'.....%'...%'
3359  db 05 15 4C 00 00 56 16 81 01 19 13 27 89 01 19 13  ; ..L..V.....'....
3369  db 27 88 01 19 27 13 8A 01 18 13 27 82 01 18 13 27  ; '...'.....'....'
3379  db 86 01 18 13 27 C4 93 18 FF 19 00 13 13 13 85 01  ; ....'...........
3389  db 19 13 27 B0 12 FF 0C 40 13 00 27 05 16 3B 00 01  ; ..'....@..'..;..
3399  db 94 16 0C 91 01 0D 80 60 2A 88 01 17 60 2A 8A 01  ; .......`*...`*..
33A9  db 17 60 2A 82 01 17 60 2A 86 01 17 60 2A 94 01 0D  ; .`*...`*...`*...
33B9  db 80 60 2A 95 01 0D 80 60 2A 05 17 83 00 01 C4 16  ; .`*....`*.......
33C9  db 0D 88 01 17 00 0C 8A 01 17 00 0C 05 1B 0C 00 C1  ; ................
33D9  db 34 17 85 21 1B 89 01 10 59 2B 88 01 10 59 2B 8A  ; 4..!....Y+...Y+.
33E9  db 01 17 59 2B 82 01 17 59 2B 86 01 17 59 2B 94 01  ; ..Y+...Y+...Y+..
33F9  db 0F 80 59 2B 95 01 0F 80 59 2B 05 17 84 00 01 3E  ; ..Y+....Y+.....>
3409  db 17 86 05 85 1F 00 00 A9 17 05 85 24 00 00 CA 17  ; ...........$....
3419  db B1 12 FF 11 40 0E 17 18 99 01 11 80 26 18 98 01  ; ....@.......&...
3429  db 11 80 26 18 8A 01 17 0E 30 82 01 17 26 18 86 01  ; ..&.....0...&...
3439  db 17 26 18 84 01 17 26 18 85 01 FF 0E 17 04 17 3F  ; .&....&........?
3449  db 00 05 EE 17 11 91 01 12 80 1F 30 B9 12 FF 12 40  ; ..........0....@
3459  db 0B 13 30 88 01 FF 0B 13 AA 12 FF 17 0B 13 30 C2  ; ..0...........0.
3469  db 93 17 FF 17 00 0B 13 30 86 01 17 00 4F 84 01 17  ; .......0....O...
3479  db 0B 13 85 01 17 0B 13 04 17 4F 00 01 21 18 12 81  ; .........O..!...
3489  db 01 17 0B 18 89 01 17 0B 18 88 01 17 0B 18 AA 12  ; ................
3499  db FF 17 0B 18 20 A2 12 FF 17 0B 18 20 A6 12 FF 17  ; .... ...... ....
34A9  db 0B 18 20 94 01 13 80 23 20 95 01 13 80 23 20 04  ; .. ....# ....# .
34B9  db 17 44 00 41 61 18 85 21 13 81 01 1B 0C 2B 89 01  ; .D.Aa..!.....+..
34C9  db 1B 0C 2B A8 12 17 1B 00 0C 2B 8A 01 17 0C 2B 82  ; ..+......+....+.
34D9  db 01 17 0C 2B 86 01 17 0C 2B 04 17 2F 00 01 98 18  ; ...+....+../....
34E9  db 1B 10 1C 5B 00 00 C6 18 10 1C 3D 00 00 DE 18 10  ; ...[......=.....
34F9  db 1C 7A 00 00 17 19 10 1C 2D 00 00 81 19 10 1C 2F  ; .z......-....../
3509  db 00 00 E9 18 10 1C 66 00 00 27 19 20 1D 33 00 00  ; ......f..'. .3..
3519  db AC 19 20 1D 33 00 00 45 0A 00 20 04 00 00 38 15  ; .. .3..E.. ...8.
3529  db 81 01 15 5B 22 89 01 15 5B 22 88 01 15 5B 22 8A  ; ...["...["...[".
3539  db 01 15 5B 22 C2 93 17 FF 15 00 0E 4C 22 86 01 15  ; ..[".......L"...
3549  db 5B 22 94 01 08 80 5B 22 95 01 08 80 5B 22 80 01  ; ["....["....["..
3559  db 14 5B 22 05 15 7E 00 01 7A 15 08 00 1A 04 00 00  ; .["..~..z.......
3569  db 38 15 B1 12 FF 05 40 00 0E 20 99 01 05 80 0E 20  ; 8.....@.. ..... 
3579  db 98 01 05 80 0E 20 8A 01 17 00 2F C2 93 17 FF 17  ; ..... ..../.....
3589  db 00 00 0E 20 86 01 17 00 2F 84 01 17 0E 20 85 01  ; ... ..../.... ..
3599  db 17 0E 20 04 17 2F 00 01 CE 14 05 E8 35 EF 35 EF  ; .. ../......5.5.
35A9  db 35 09 36 2C 36 65 36 91 36 AE 36 E9 36 14 37 38  ; 5.6,6e6.6.6.6.78
35B9  db 37 69 37 A5 37 D3 37 E7 37 14 38 1B 38 57 38 91  ; 7i7.7.7.7.8.8W8.
35C9  db 38 CB 38 F3 38 FA 38 01 39 08 39 0F 39 16 39 22  ; 8.8.8.8.9.9.9.9"
35D9  db 38 E7 37 1D 39 24 39 2B 39 6D 39 32 39 74 39 00  ; 8.7.9$9+9m929t9.
35E9  db 02 3B 00 80 DD 19 91 01 03 80 00 27 95 01 03 80  ; .;.........'....
35F9  db 00 27 99 01 03 80 00 27 04 17 27 00 01 0D 1A 05  ; .'.....'..'.....
3609  db 86 01 17 0B 39 82 01 17 0B 39 8A 01 17 0B 39 98  ; ....9....9....9.
3619  db 01 04 80 20 23 99 01 04 80 20 23 04 17 44 00 01  ; ... #.... #..D..
3629  db 2D 1A 04 B1 12 FF 05 40 0B 0E 20 95 01 05 80 1A  ; -......@.. .....
3639  db 20 94 01 05 80 1A 20 86 01 17 00 3A C2 93 17 FF  ;  ..... ....:....
3649  db 17 00 0B 0E 20 8A 01 17 00 3A 88 01 17 1A 20 89  ; .... ....:.... .
3659  db 01 17 1A 20 04 17 3A 00 01 64 1A 05 91 01 06 80  ; ... ..:..d......
3669  db 20 34 B5 12 FF 06 40 0C 13 34 84 01 FF 0C 13 82  ;  4....@..4......
3679  db 01 17 20 34 8A 01 17 20 34 88 01 17 0C 13 04 17  ; .. 4... 4.......
3689  db 54 00 21 93 1A 1E 1A 05 86 01 1A 07 18 82 01 1A  ; T.!.............
3699  db 07 18 8A 01 1A 07 18 90 01 07 80 07 2C 04 1A 34  ; ............,..4
36A9  db 00 01 D7 1A 05 81 01 15 79 22 85 01 15 79 22 84  ; ........y"...y".
36B9  db 01 15 79 22 86 01 15 79 22 C2 93 17 FF 15 00 2C  ; ..y"...y"......,
36C9  db 4C 22 8A 01 15 79 22 98 01 08 80 79 22 99 01 08  ; L"...y"....y"...
36D9  db 80 79 22 80 01 14 79 22 05 15 9C 00 09 01 1B 08  ; .y"...y"........
36E9  db A1 12 FF 16 0E 13 27 84 01 18 00 0E 86 01 18 00  ; ......'.........
36F9  db 22 A2 12 18 16 00 22 27 89 01 FF 0E 12 90 01 09  ; "....."'........
3709  db 80 22 27 05 16 4A 00 01 7F 1B 0C 91 01 0A 80 1D  ; ."'..J..........
3719  db 2A 95 01 0A 80 1D 2A 94 01 0A 80 1D 2A 82 01 15  ; *.....*.....*...
3729  db 1D 2A 80 01 14 1D 2A 05 15 47 00 01 BB 1B 0B 91  ; .*....*..G......
3739  db 01 0B 80 25 27 85 01 FF 11 13 84 01 FF 11 13 A6  ; ...%'...........
3749  db 12 18 15 11 13 27 A2 12 18 15 00 25 27 AA 12 18  ; .....'.....%'...
3759  db 15 00 25 27 80 01 14 25 27 05 15 4C 00 00 F5 1B  ; ..%'...%'..L....
3769  db 81 01 19 13 27 85 01 19 13 27 84 01 19 27 13 86  ; ....'....'...'..
3779  db 01 18 13 27 82 01 18 13 27 8A 01 18 13 27 C8 93  ; ...'....'....'..
3789  db 18 FF 19 00 13 13 13 89 01 19 13 27 B0 12 FF 0C  ; ...........'....
3799  db 40 13 00 27 05 16 3B 00 01 33 1C 0C 91 01 0D 80  ; @..'..;..3......
37A9  db 60 2A 84 01 17 60 2A 86 01 17 60 2A 82 01 17 60  ; `*...`*...`*...`
37B9  db 2A 8A 01 17 60 2A 98 01 0D 80 60 2A 99 01 0D 80  ; *...`*....`*....
37C9  db 60 2A 05 17 83 00 01 63 1C 0D 84 01 17 00 0C 86  ; `*.....c........
37D9  db 01 17 00 0C 05 1B 0C 00 C1 D3 1C 84 21 1B 85 01  ; ............!...
37E9  db 10 59 2B 84 01 10 59 2B 86 01 17 59 2B 82 01 17  ; .Y+...Y+...Y+...
37F9  db 59 2B 8A 01 17 59 2B 98 01 0F 80 59 2B 99 01 0F  ; Y+...Y+....Y+...
3809  db 80 59 2B 05 17 84 00 01 DD 1C 86 05 85 1F 00 00  ; .Y+.............
3819  db 48 1D 05 85 24 00 00 69 1D B1 12 FF 11 40 0E 17  ; H...$..i.....@..
3829  db 18 95 01 11 80 26 18 94 01 11 80 26 18 86 01 17  ; .....&.....&....
3839  db 0E 30 82 01 17 26 18 8A 01 17 26 18 88 01 17 26  ; .0...&....&....&
3849  db 18 89 01 FF 0E 17 04 17 3F 00 05 8D 1D 11 91 01  ; ........?.......
3859  db 12 80 1F 30 B5 12 FF 12 40 0B 13 30 84 01 FF 0B  ; ...0....@..0....
3869  db 13 A6 12 FF 17 0B 13 30 C2 93 17 FF 17 00 0B 13  ; .......0........
3879  db 30 8A 01 17 00 4F 88 01 17 0B 13 89 01 17 0B 13  ; 0....O..........
3889  db 04 17 4F 00 01 C0 1D 12 81 01 17 0B 18 85 01 17  ; ..O.............
3899  db 0B 18 84 01 17 0B 18 A6 12 FF 17 0B 18 20 A2 12  ; ............. ..
38A9  db FF 17 0B 18 20 AA 12 FF 17 0B 18 20 98 01 13 80  ; .... ...... ....
38B9  db 23 20 99 01 13 80 23 20 04 17 44 00 41 00 1E 84  ; # ....# ..D.A...
38C9  db 21 13 81 01 1B 0C 2B 85 01 1B 0C 2B A4 12 17 1B  ; !.....+....+....
38D9  db 00 0C 2B 86 01 17 0C 2B 82 01 17 0C 2B 8A 01 17  ; ..+....+....+...
38E9  db 0C 2B 04 17 2F 00 01 37 1E 1B 10 1C 5B 00 00 65  ; .+../..7....[..e
38F9  db 1E 10 1C 3D 00 00 7D 1E 10 1C 7A 00 00 B6 1E 10  ; ...=..}...z.....
3909  db 1C 2D 00 00 20 1F 10 1C 2F 00 00 88 1E 10 1C 66  ; .-.. .../......f
3919  db 00 00 C6 1E 20 1D 33 00 00 AC 19 20 1D 33 00 00  ; .... .3.... .3..
3929  db 45 0A 00 20 04 00 00 D7 1A 81 01 15 5B 22 85 01  ; E.. ........["..
3939  db 15 5B 22 84 01 15 5B 22 86 01 15 5B 22 C2 93 17  ; .["...["...["...
3949  db FF 15 00 0E 4C 22 8A 01 15 5B 22 98 01 08 80 5B  ; ....L"...["....[
3959  db 22 99 01 08 80 5B 22 80 01 14 5B 22 05 15 7E 00  ; "....["...["..~.
3969  db 01 19 1B 08 00 1A 04 00 00 D7 1A B1 12 FF 05 40  ; ...............@
3979  db 00 0E 20 95 01 05 80 0E 20 94 01 05 80 0E 20 86  ; .. ..... ..... .
3989  db 01 17 00 2F C2 93 17 FF 17 00 00 0E 20 8A 01 17  ; .../........ ...
3999  db 00 2F 88 01 17 0E 20 89 01 17 0E 20 04 17 2F 00  ; ./.... .... ../.
39A9  db 01 6D 1A 05 41 3A 41 3A 41 3A 68 3A A0 3A DB 3A  ; .m..A:A:A:h:.:.:
39B9  db 02 3B 38 3B 6E 3B A6 3B DB 3B 10 3C 43 3C 78 3C  ; .;8;n;.;.;.<C<x<
39C9  db AD 3C F4 3C FB 3C 02 3D 09 3D 3C 3D 6F 3D A1 3D  ; .<.<.<.=.=<=o=.=
39D9  db D3 3D 0B 3E 12 3E 19 3E 20 3E 27 3E 2E 3E 35 3E  ; .=.>.>.> >'>.>5>
39E9  db 3C 3E 43 3E 4A 3E 51 3E 87 3E 51 3E 87 3E 8E 3E  ; <>C>J>Q>.>Q>.>.>
39F9  db 8E 3E 95 3E 68 3A 95 3E DB 3A 02 3B 38 3B 6E 3B  ; .>.>h:.>.:.;8;n;
3A09  db A6 3B DB 3B 10 3C 43 3C 78 3C AD 3C F4 3C FB 3C  ; .;.;.<C<x<.<.<.<
3A19  db 02 3D 09 3D 3C 3D 6F 3D A1 3D D3 3D 0B 3E 12 3E  ; .=.=<=o=.=.=.>.>
3A29  db 19 3E 20 3E 27 3E 2E 3E 35 3E 3C 3E 43 3E 4A 3E  ; .> >'>.>5><>C>J>
3A39  db 51 3E 87 3E 51 3E 87 3E 81 01 1E 13 4E 89 01 1E  ; Q>.>Q>.>....N...
3A49  db 13 4E 98 01 03 80 42 1F 84 01 1E 13 4E 85 01 1E  ; .N....B.....N...
3A59  db 13 4E 80 01 1D 42 1F 04 1E 61 00 01 9C 1F 03 D1  ; .N...B...a......
3A69  db 93 FF 1E 04 20 0B 16 20 1A 89 01 1E 21 3A 88 01  ; .... .. ....!:..
3A79  db 1E 21 3A 84 01 1E 21 3A 84 01 1E 21 3A 84 01 1E  ; .!:...!:...!:...
3A89  db 21 3A B5 12 1E 04 40 21 20 1A 80 01 1D 21 3A 04  ; !:....@! ....!:.
3A99  db 1E 5B 00 01 EB 1F 04 81 01 1E 49 12 89 01 1E 49  ; .[........I....I
3AA9  db 12 88 01 1B 49 12 CA 93 1E FF 1B 00 30 18 12 82  ; ....I.......0...
3AB9  db 01 1E 00 30 86 01 1E 00 30 84 01 11 49 12 85 01  ; ...0....0...I...
3AC9  db 1E 49 12 80 01 1D 49 12 04 05 5B 00 A1 35 20 21  ; .I....I...[..5 !
3AD9  db 22 04 81 01 1E 00 13 89 01 1E 00 13 88 01 1B 00  ; "...............
3AE9  db 13 8A 01 1B 00 13 85 01 1E 00 13 90 01 06 80 00  ; ................
3AF9  db 13 04 1E 13 00 01 7F 20 02 81 01 1C 46 2C 89 01  ; ....... ....F,..
3B09  db 1C 46 2C 88 01 1A 46 2C 8A 01 1A 46 2C 82 01 1A  ; .F,...F,...F,...
3B19  db 46 2C 86 01 1A 46 2C 84 01 1A 46 2C 85 01 1C 46  ; F,...F,...F,...F
3B29  db 2C 90 01 07 80 46 2C 05 1C 73 00 09 8F 20 08 81  ; ,....F,..s... ..
3B39  db 01 1A 2A 2D B9 12 1A 08 40 2A 1A 13 B8 12 1A 08  ; ..*-....@*......
3B49  db 40 2A 1A 13 8A 01 1A 2A 2D 82 01 1A 2A 2D 86 01  ; @*.....*-...*-..
3B59  db 1A 2A 2D 84 01 1A 2A 2D 85 01 1A 2A 2D 05 1A 58  ; .*-...*-...*-..X
3B69  db 00 01 EC 20 0A B1 12 1A 09 40 0D 09 15 89 01 1A  ; ... .....@......
3B79  db 0D 1F 88 01 1A 0D 1F 8A 01 1A 0D 1F 82 01 1A 0D  ; ................
3B89  db 1F 86 01 1A 0D 1F 84 01 1A 0D 1F 85 01 1A 0D 1F  ; ................
3B99  db 80 01 19 17 15 05 1C 2C 00 01 33 21 0A 81 01 1A  ; .......,..3!....
3BA9  db 08 0D 89 01 1A 08 0D 88 01 1A 08 0D 8A 01 1A 08  ; ................
3BB9  db 0D 82 01 1A 08 0D 86 01 1A 08 0D 84 01 1A 08 0D  ; ................
3BC9  db 85 01 1A 08 0D 90 01 0A 80 08 0D 05 1C 16 00 00  ; ................
3BD9  db 57 21 81 01 1A 2B 2D 89 01 1A 2B 2D 88 01 1A 2B  ; W!...+-...+-...+
3BE9  db 2D 8A 01 1A 2B 2D 82 01 1A 2B 2D 86 01 1A 2B 2D  ; -...+-...+-...+-
3BF9  db 84 01 1A 2B 2D 85 01 1A 2B 2D 90 01 0B 80 47 11  ; ...+-...+-....G.
3C09  db 05 1C 59 00 00 69 21 81 01 1A 00 28 89 01 1A 00  ; ..Y..i!....(....
3C19  db 28 B8 12 1A 0C 40 00 1C 0C 8A 01 1A 00 28 82 01  ; (....@.......(..
3C29  db 1A 00 28 86 01 1A 00 28 84 01 1A 00 28 85 01 1A  ; ..(....(....(...
3C39  db 00 28 05 1A 28 00 01 B1 21 0E 81 01 1A 12 5B 89  ; .(..(...!.....[.
3C49  db 01 1A 12 5B 88 01 1A 12 5B 8A 01 1A 12 5B 82 01  ; ...[....[....[..
3C59  db 1A 12 5B 86 01 1A 12 5B 84 01 1A 12 5B 85 01 1A  ; ..[....[....[...
3C69  db 12 5B 90 01 0D 80 4E 20 05 1C 6E 00 00 D2 21 81  ; .[....N ..n...!.
3C79  db 01 1A 1F 3B 89 01 1A 1F 3B 88 01 1A 1F 3B 8A 01  ; ...;....;....;..
3C89  db 1A 1F 3B 82 01 1A 1F 3B 86 01 1A 1F 3B 84 01 1A  ; ..;....;....;...
3C99  db 1F 3B 85 01 1A 1F 3B 90 01 0E 80 4B 0E 05 1C 5A  ; .;....;....K...Z
3CA9  db 00 00 2B 22 A1 12 1A 1E 1C 47 12 B9 12 1A 0F 40  ; ..+".....G.....@
3CB9  db 1C 47 12 B8 12 1A 0F 40 1C 47 12 AA 12 1A 1B 1C  ; .G.....@.G......
3CC9  db 47 12 A2 12 1A 1B 1C 47 12 A6 12 1A 1B 1C 47 12  ; G......G......G.
3CD9  db A4 12 1A 10 1C 47 12 A5 12 1A 10 1C 47 12 80 01  ; .....G......G...
3CE9  db 1D 64 12 05 1B 77 00 01 74 22 0F 05 87 14 00 00  ; .d...w..t"......
3CF9  db D4 22 05 87 14 00 00 EC 22 04 12 1C 00 84 04 23  ; ."......"......#
3D09  db 81 01 1B 00 35 89 01 1B 00 35 B8 12 1B 13 40 00  ; ....5....5....@.
3D19  db 1A 1B 8A 01 1B 00 35 82 01 1B 00 35 86 01 1B 00  ; ......5....5....
3D29  db 35 84 01 1B 00 35 85 01 1B 00 35 04 1B 35 00 01  ; 5....5....5..5..
3D39  db 1B 23 12 81 01 1B 11 25 89 01 1B 11 25 88 01 1B  ; .#.....%....%...
3D49  db 11 25 8A 01 1B 11 25 82 01 1B 11 25 86 01 1B 11  ; .%....%....%....
3D59  db 25 B4 12 1B 14 40 11 13 11 85 01 1B 11 25 04 1B  ; %....@.......%..
3D69  db 36 00 01 46 23 16 B1 12 1B 15 40 10 08 11 89 01  ; 6..F#.....@.....
3D79  db 1B 10 1A 88 01 1B 10 1A 8A 01 1B 10 1A 82 01 1B  ; ................
3D89  db 10 1A 86 01 1B 10 1A 84 01 1B 10 1A 85 01 1B 10  ; ................
3D99  db 1A 04 1B 2A 00 00 72 23 81 01 1B 13 1A 89 01 1B  ; ...*..r#........
3DA9  db 13 1A 88 01 1B 13 1A 8A 01 1B 13 1A 82 01 1B 13  ; ................
3DB9  db 1A 86 01 1B 13 1A B4 12 1B 16 40 13 0D 0C 85 01  ; ..........@.....
3DC9  db 1B 13 1A 04 1B 2D 00 00 94 23 81 01 1B 16 22 A9  ; .....-...#....".
3DD9  db 12 1B 18 16 11 11 A8 12 1B 18 16 11 11 8A 01 1B  ; ................
3DE9  db 16 22 82 01 1B 16 22 86 01 1B 16 22 A4 12 1B 17  ; ."...."...."....
3DF9  db 16 11 11 A5 12 1B 17 16 11 11 04 1B 31 00 01 B9  ; ............1...
3E09  db 23 10 04 87 14 00 00 EC 22 04 87 14 00 00 D4 22  ; #......."......"
3E19  db 10 1F 41 00 00 E8 23 10 1F 5C 00 00 24 24 10 1F  ; ..A...#..\..$$..
3E29  db 23 00 00 52 24 10 1F 23 00 00 76 24 10 1F 31 00  ; #..R$..#..v$..1.
3E39  db 00 9A 24 10 1F 1E 00 00 EE 24 20 20 32 00 00 0E  ; ..$......$  2...
3E49  db 25 20 20 33 00 00 4F 38 81 01 1C 45 2C 89 01 1C  ; %  3..O8...E,...
3E59  db 45 2C 88 01 1A 45 2C 8A 01 1A 45 2C 82 01 1A 45  ; E,...E,...E,...E
3E69  db 2C 86 01 1A 45 2C 84 01 1A 45 2C 85 01 1C 45 2C  ; ,...E,...E,...E,
3E79  db 90 01 07 80 45 2C 05 1C 72 00 01 90 20 08 04 12  ; ....E,..r... ...
3E89  db 1C 00 80 04 23 00 02 0A 00 00 9C 1F 81 01 1E 40  ; ....#..........@
3E99  db 12 89 01 1E 40 12 88 01 1B 40 12 CA 93 1E FF 1B  ; ....@....@......
3EA9  db 00 27 18 12 82 01 1E 00 27 86 01 1E 00 27 84 01  ; .'......'....'..
3EB9  db 11 40 12 85 01 1E 40 12 80 01 1D 40 12 04 05 53  ; .@....@....@...S
3EC9  db 00 A1 3C 20 21 22 04 64 3F 64 3F 64 3F 8B 3F C3  ; ..< !".d?d?d?.?.
3ED9  db 3F FE 3F 25 40 5B 40 91 40 C9 40 FE 40 33 41 66  ; ?.?%@[@.@.@.@3Af
3EE9  db 41 9B 41 D0 41 17 42 1E 42 25 42 2C 42 5F 42 92  ; A.A.A.B.B%B,B_B.
3EF9  db 42 C4 42 F6 42 2E 43 35 43 3C 43 43 43 4A 43 51  ; B.B.B.C5C<CCCJCQ
3F09  db 43 58 43 5F 43 66 43 6D 43 74 43 AA 43 74 43 AA  ; CXC_CfCmCtC.CtC.
3F19  db 43 B1 43 B1 43 B8 43 8B 3F B8 43 FE 3F 25 40 5B  ; C.C.C.C.?.C.?%@[
3F29  db 40 91 40 C9 40 FE 40 33 41 66 41 9B 41 D0 41 17  ; @.@.@.@3AfA.A.A.
3F39  db 42 1E 42 25 42 2C 42 5F 42 92 42 C4 42 F6 42 2E  ; B.B%B,B_B.B.B.B.
3F49  db 43 35 43 3C 43 43 43 4A 43 51 43 58 43 5F 43 66  ; C5C<CCCJCQCXC_Cf
3F59  db 43 6D 43 74 43 AA 43 74 43 AA 43 81 01 1E 13 4E  ; CmCtC.CtC.C....N
3F69  db 85 01 1E 13 4E 94 01 03 80 42 1F 88 01 1E 13 4E  ; ....N....B.....N
3F79  db 89 01 1E 13 4E 80 01 1D 42 1F 04 1E 61 00 01 5E  ; ....N...B...a..^
3F89  db 25 03 D1 93 FF 1E 04 20 0B 16 20 1A 85 01 1E 21  ; %...... .. ....!
3F99  db 3A 84 01 1E 21 3A 88 01 1E 21 3A 88 01 1E 21 3A  ; :...!:...!:...!:
3FA9  db 88 01 1E 21 3A B9 12 1E 04 40 21 20 1A 80 01 1D  ; ...!:....@! ....
3FB9  db 21 3A 04 1E 5B 00 01 AD 25 04 81 01 1E 49 12 85  ; !:..[...%....I..
3FC9  db 01 1E 49 12 84 01 1B 49 12 C6 93 1E FF 1B 00 30  ; ..I....I.......0
3FD9  db 18 12 82 01 1E 00 30 8A 01 1E 00 30 88 01 11 49  ; ......0....0...I
3FE9  db 12 89 01 1E 49 12 80 01 1D 49 12 04 05 5B 00 A1  ; ....I....I...[..
3FF9  db F7 25 21 22 04 81 01 1E 00 13 85 01 1E 00 13 84  ; .%!"............
4009  db 01 1B 00 13 86 01 1B 00 13 89 01 1E 00 13 90 01  ; ................
4019  db 06 80 00 13 04 1E 13 00 01 41 26 02 81 01 1C 46  ; .........A&....F
4029  db 2C 85 01 1C 46 2C 84 01 1A 46 2C 86 01 1A 46 2C  ; ,...F,...F,...F,
4039  db 82 01 1A 46 2C 8A 01 1A 46 2C 88 01 1A 46 2C 89  ; ...F,...F,...F,.
4049  db 01 1C 46 2C 90 01 07 80 46 2C 05 1C 73 00 09 51  ; ..F,....F,..s..Q
4059  db 26 08 81 01 1A 2A 2D B5 12 1A 08 40 2A 1A 13 B4  ; &....*-....@*...
4069  db 12 1A 08 40 2A 1A 13 86 01 1A 2A 2D 82 01 1A 2A  ; ...@*.....*-...*
4079  db 2D 8A 01 1A 2A 2D 88 01 1A 2A 2D 89 01 1A 2A 2D  ; -...*-...*-...*-
4089  db 05 1A 58 00 01 AE 26 0A B1 12 1A 09 40 0D 09 15  ; ..X...&.....@...
4099  db 85 01 1A 0D 1F 84 01 1A 0D 1F 86 01 1A 0D 1F 82  ; ................
40A9  db 01 1A 0D 1F 8A 01 1A 0D 1F 88 01 1A 0D 1F 89 01  ; ................
40B9  db 1A 0D 1F 80 01 19 17 15 05 1C 2C 00 01 F5 26 0A  ; ..........,...&.
40C9  db 81 01 1A 08 0D 85 01 1A 08 0D 84 01 1A 08 0D 86  ; ................
40D9  db 01 1A 08 0D 82 01 1A 08 0D 8A 01 1A 08 0D 88 01  ; ................
40E9  db 1A 08 0D 89 01 1A 08 0D 90 01 0A 80 08 0D 05 1C  ; ................
40F9  db 16 00 00 19 27 81 01 1A 2B 2D 85 01 1A 2B 2D 84  ; ....'...+-...+-.
4109  db 01 1A 2B 2D 86 01 1A 2B 2D 82 01 1A 2B 2D 8A 01  ; ..+-...+-...+-..
4119  db 1A 2B 2D 88 01 1A 2B 2D 89 01 1A 2B 2D 90 01 0B  ; .+-...+-...+-...
4129  db 80 47 11 05 1C 59 00 00 2B 27 81 01 1A 00 28 85  ; .G...Y..+'....(.
4139  db 01 1A 00 28 B4 12 1A 0C 40 00 1C 0C 86 01 1A 00  ; ...(....@.......
4149  db 28 82 01 1A 00 28 8A 01 1A 00 28 88 01 1A 00 28  ; (....(....(....(
4159  db 89 01 1A 00 28 05 1A 28 00 01 73 27 0E 81 01 1A  ; ....(..(..s'....
4169  db 12 5B 85 01 1A 12 5B 84 01 1A 12 5B 86 01 1A 12  ; .[....[....[....
4179  db 5B 82 01 1A 12 5B 8A 01 1A 12 5B 88 01 1A 12 5B  ; [....[....[....[
4189  db 89 01 1A 12 5B 90 01 0D 80 4E 20 05 1C 6E 00 00  ; ....[....N ..n..
4199  db 94 27 81 01 1A 1F 3B 85 01 1A 1F 3B 84 01 1A 1F  ; .'....;....;....
41A9  db 3B 86 01 1A 1F 3B 82 01 1A 1F 3B 8A 01 1A 1F 3B  ; ;....;....;....;
41B9  db 88 01 1A 1F 3B 89 01 1A 1F 3B 90 01 0E 80 4B 0E  ; ....;....;....K.
41C9  db 05 1C 5A 00 00 ED 27 A1 12 1A 1E 1C 47 12 B5 12  ; ..Z...'.....G...
41D9  db 1A 0F 40 1C 47 12 B4 12 1A 0F 40 1C 47 12 A6 12  ; ..@.G.....@.G...
41E9  db 1A 1B 1C 47 12 A2 12 1A 1B 1C 47 12 AA 12 1A 1B  ; ...G......G.....
41F9  db 1C 47 12 A8 12 1A 10 1C 47 12 A9 12 1A 10 1C 47  ; .G......G......G
4209  db 12 80 01 1D 64 12 05 1B 77 00 01 36 28 0F 05 87  ; ....d...w..6(...
4219  db 14 00 00 96 28 05 87 14 00 00 AE 28 04 12 1C 00  ; ....(......(....
4229  db 84 C6 28 81 01 1B 00 35 85 01 1B 00 35 B4 12 1B  ; ..(....5....5...
4239  db 13 40 00 1A 1B 86 01 1B 00 35 82 01 1B 00 35 8A  ; .@.......5....5.
4249  db 01 1B 00 35 88 01 1B 00 35 89 01 1B 00 35 04 1B  ; ...5....5....5..
4259  db 35 00 01 DD 28 12 81 01 1B 11 25 85 01 1B 11 25  ; 5...(.....%....%
4269  db 84 01 1B 11 25 86 01 1B 11 25 82 01 1B 11 25 8A  ; ....%....%....%.
4279  db 01 1B 11 25 B8 12 1B 14 40 11 13 11 89 01 1B 11  ; ...%....@.......
4289  db 25 04 1B 36 00 01 08 29 16 B1 12 1B 15 40 10 08  ; %..6...).....@..
4299  db 11 85 01 1B 10 1A 84 01 1B 10 1A 86 01 1B 10 1A  ; ................
42A9  db 82 01 1B 10 1A 8A 01 1B 10 1A 88 01 1B 10 1A 89  ; ................
42B9  db 01 1B 10 1A 04 1B 2A 00 00 34 29 81 01 1B 13 1A  ; ......*..4).....
42C9  db 85 01 1B 13 1A 84 01 1B 13 1A 86 01 1B 13 1A 82  ; ................
42D9  db 01 1B 13 1A 8A 01 1B 13 1A B8 12 1B 16 40 13 0D  ; .............@..
42E9  db 0C 89 01 1B 13 1A 04 1B 2D 00 00 56 29 81 01 1B  ; ........-..V)...
42F9  db 16 22 A5 12 1B 18 16 11 11 A4 12 1B 18 16 11 11  ; ."..............
4309  db 86 01 1B 16 22 82 01 1B 16 22 8A 01 1B 16 22 A8  ; ...."...."....".
4319  db 12 1B 17 16 11 11 A9 12 1B 17 16 11 11 04 1B 31  ; ...............1
4329  db 00 01 7B 29 10 04 87 14 00 00 AE 28 04 87 14 00  ; ..{).......(....
4339  db 00 96 28 10 1F 41 00 00 AA 29 10 1F 5C 00 00 E6  ; ..(..A...)..\...
4349  db 29 10 1F 23 00 00 14 2A 10 1F 23 00 00 38 2A 10  ; )..#...*..#..8*.
4359  db 1F 31 00 00 5C 2A 10 1F 1E 00 00 B0 2A 20 20 32  ; .1..\*......*  2
4369  db 00 00 0E 25 20 20 33 00 00 4F 38 81 01 1C 45 2C  ; ...%  3..O8...E,
4379  db 85 01 1C 45 2C 84 01 1A 45 2C 86 01 1A 45 2C 82  ; ...E,...E,...E,.
4389  db 01 1A 45 2C 8A 01 1A 45 2C 88 01 1A 45 2C 89 01  ; ..E,...E,...E,..
4399  db 1C 45 2C 90 01 07 80 45 2C 05 1C 72 00 01 52 26  ; .E,....E,..r..R&
43A9  db 08 04 12 1C 00 80 C6 28 00 02 0A 00 00 5E 25 81  ; .......(.....^%.
43B9  db 01 1E 40 12 85 01 1E 40 12 84 01 1B 40 12 C6 93  ; ..@....@....@...
43C9  db 1E FF 1B 00 27 18 12 82 01 1E 00 27 8A 01 1E 00  ; ....'......'....
43D9  db 27 88 01 11 40 12 89 01 1E 40 12 80 01 1D 40 12  ; '...@....@....@.
43E9  db 04 05 53 00 A1 FE 25 21 22 04 2B 44 2B 44 2B 44  ; ..S...%!".+D+D+D
43F9  db 64 44 94 44 DA 44 27 45 5D 45 9B 45 EC 45 21 46  ; dD.D.D'E]E.E.E!F
4409  db 58 46 90 46 DD 46 02 47 3C 47 92 47 E4 47 29 48  ; XF.F.F.G<G.G.G)H
4419  db 30 48 37 48 3E 48 45 48 4C 48 53 48 5A 48 A5 48  ; 0H7H>HEHLHSHZH.H
4429  db 9E 48 B1 12 15 03 40 00 22 27 89 01 15 00 22 88  ; .H....@."'....".
4439  db 01 16 22 27 AA 12 FF 15 00 22 27 A2 12 FF 15 00  ; .."'....."'.....
4449  db 22 27 A6 12 FF 15 00 22 27 84 01 16 22 27 85 01  ; "'....."'..."'..
4459  db 15 00 22 04 16 4A 00 01 00 2B 05 81 01 16 0E 27  ; .."..J...+.....'
4469  db 89 01 16 0E 27 88 01 16 00 36 8A 01 16 00 36 82  ; ....'....6....6.
4479  db 01 16 00 36 86 01 16 00 36 B4 12 16 04 40 00 0E  ; ...6....6....@..
4489  db 27 04 16 36 00 21 3C 2B 19 1A 05 A1 12 16 14 00  ; '..6.!<+........
4499  db 13 27 D9 93 16 FF 05 20 00 13 0E 18 D8 93 16 FF  ; .'..... ........
44A9  db 05 20 00 13 0E 18 AA 12 16 14 00 13 27 A2 12 16  ; . ..........'...
44B9  db 14 00 13 27 A6 12 16 14 00 13 27 84 01 14 13 27  ; ...'......'....'
44C9  db A5 12 16 14 00 13 27 04 14 3B 00 21 68 2B 19 1A  ; ......'..;.!h+..
44D9  db 05 C1 93 14 15 0E 00 13 13 27 89 01 14 27 27 88  ; .........'...''.
44E9  db 01 14 27 27 CA 93 14 FF 14 00 13 13 27 C2 93 14  ; ..''........'...
44F9  db FF 14 00 13 13 27 C6 93 14 FF 14 00 13 13 27 C4  ; .....'........'.
4509  db 93 14 FF 14 00 13 13 27 C5 93 14 FF 14 00 13 13  ; .......'........
4519  db 27 80 01 06 13 13 04 14 47 00 01 98 2B 0E 81 01  ; '.......G...+...
4529  db 13 7C 22 89 01 13 7C 22 98 01 07 80 7C 22 8A 01  ; .|"...|"....|"..
4539  db 13 7C 22 82 01 13 7C 22 86 01 13 7C 22 84 01 13  ; .|"...|"...|"...
4549  db 7C 22 85 01 13 7C 22 80 01 12 7C 22 05 13 9E 00  ; |"...|"...|"....
4559  db 09 D8 2B 0A 81 01 13 00 39 89 01 13 0E 2A 88 01  ; ..+.....9....*..
4569  db 13 0E 2A 8A 01 13 0E 2A 82 01 13 00 39 86 01 13  ; ..*....*....9...
4579  db 00 39 D4 93 13 FF 08 20 00 0E 13 16 C5 93 13 FF  ; .9..... ........
4589  db 13 00 0E 13 16 80 01 12 0E 2A 05 13 39 00 01 58  ; .........*..9..X
4599  db 2C 0C C1 93 13 FF 14 00 11 13 13 C9 93 13 FF 14  ; ,...............
45A9  db 00 11 13 13 88 01 13 00 11 CA 93 13 FF 14 00 11  ; ................
45B9  db 13 13 C2 93 13 FF 14 00 11 13 13 C6 93 13 FF 14  ; ................
45C9  db 00 11 13 13 84 01 14 25 13 C5 93 13 FF 14 00 11  ; .......%........
45D9  db 13 13 D0 93 12 FF 09 20 00 11 13 13 05 14 39 00  ; ....... ......9.
45E9  db 00 86 2C 81 01 13 22 2F 89 01 13 22 2F 88 01 13  ; ..,..."/..."/...
45F9  db 22 2F 8A 01 13 22 2F 82 01 13 22 2F 86 01 13 22  ; "/..."/..."/..."
4609  db 2F 94 01 0A 80 22 2F 85 01 13 22 2F 80 01 12 22  ; /...."/..."/..."
4619  db 2F 05 13 51 00 00 B4 2C 81 01 13 00 34 89 01 13  ; /..Q...,....4...
4629  db 00 34 88 01 13 00 34 8A 01 13 00 34 82 01 13 00  ; .4....4....4....
4639  db 34 86 01 13 00 34 84 01 13 0C 27 85 01 13 00 34  ; 4....4....'....4
4649  db B0 12 12 0B 40 00 0C 27 05 13 34 00 00 F6 2C 81  ; ....@..'..4...,.
4659  db 01 13 22 2C 89 01 13 22 2C 88 01 13 22 2C 8A 01  ; ..",...",...",..
4669  db 13 22 2C 82 01 13 22 2C B6 12 FF 0C 40 22 13 18  ; .",...",....@"..
4679  db 94 01 0C 80 36 18 85 01 13 22 2C 80 01 12 22 2C  ; ....6....",...",
4689  db 05 13 4F 00 00 20 2D D1 93 13 FF 0D 20 00 36 27  ; ..O.. -..... .6'
4699  db 13 89 01 13 00 36 88 01 13 00 36 CA 93 13 FF 14  ; .....6....6.....
46A9  db 00 36 27 13 C2 93 13 FF 14 00 36 27 13 C6 93 13  ; .6'.......6'....
46B9  db FF 14 0E 27 27 13 C4 93 FF FF 14 0E 27 27 13 C5  ; ...''.......''..
46C9  db 93 13 FF 14 00 0E 4F 13 80 01 12 00 36 05 14 72  ; ......O.....6..r
46D9  db 00 00 60 2D 81 01 FF 00 58 88 01 14 00 58 8A 01  ; ..`-....X....X..
46E9  db 14 00 58 82 01 14 00 58 86 01 14 00 58 84 01 14  ; ..X....X....X...
46F9  db 00 58 05 8A 50 00 00 BC 2D A1 12 FF 16 00 1D 16  ; .X..P...-.......
4709  db A9 12 FF 16 00 1D 16 98 01 0F 80 1D 16 8A 01 16  ; ................
4719  db 1D 16 82 01 16 1D 16 86 01 16 1D 16 84 01 16 1D  ; ................
4729  db 16 85 01 16 1D 16 80 01 16 1D 16 04 16 34 00 05  ; .............4..
4739  db 04 2E 0F C1 93 16 FF 16 00 11 1B 13 C9 93 16 FF  ; ................
4749  db 16 00 11 1B 13 88 01 16 2C 13 CA 93 16 FF 16 00  ; ........,.......
4759  db 11 1B 13 C2 93 16 FF 16 00 11 1B 13 C6 93 16 FF  ; ................
4769  db 16 00 11 1B 13 D4 93 16 FF 10 20 00 11 1B 13 C5  ; .......... .....
4779  db 93 16 FF 16 00 11 1B 13 C0 93 16 FF 16 00 11 1B  ; ................
4789  db 13 04 16 40 00 01 2E 2E 0D D1 93 16 FF 11 20 00  ; ...@.......... .
4799  db 0C 13 13 A9 12 16 FF 00 0C 13 C8 93 16 FF 15 00  ; ................
47A9  db 0C 13 13 CA 93 16 FF 15 00 0C 13 13 C2 93 16 FF  ; ................
47B9  db 15 00 0C 13 13 C6 93 16 FF 15 00 0C 13 13 84 01  ; ................
47C9  db 15 20 13 A5 12 16 FF 00 0C 13 C0 93 16 FF 15 00  ; . ..............
47D9  db 0C 13 13 04 15 34 00 01 62 2E 11 A1 12 FF 0D 0E  ; .....4..b.......
47E9  db 13 11 C8 93 15 FF 16 00 0E 13 11 CA 93 15 FF 14  ; ................
47F9  db 00 0E 13 11 C2 93 15 FF 14 00 0E 13 11 C6 93 15  ; ................
4809  db FF 15 00 0E 13 11 C4 93 15 FF 15 00 0E 13 11 C0  ; ................
4819  db 93 15 FF 14 00 0E 13 11 04 14 2C 00 01 8C 2E 0D  ; ..........,.....
4829  db 10 17 23 00 00 B8 2E 10 17 23 00 00 DC 2E 10 17  ; ..#......#......
4839  db 32 00 00 00 2F 10 17 1E 00 00 10 2F 10 17 1B 00  ; 2.../....../....
4849  db 00 30 2F 20 17 31 00 00 4E 2F 20 18 33 00 00 4F  ; .0/ .1..N/ .3..O
4859  db 38 A1 12 16 14 00 13 27 D9 93 16 FF 1B 20 00 13  ; 8......'..... ..
4869  db 0E 18 D8 93 16 FF 1B 20 00 13 0E 18 AA 12 16 14  ; ....... ........
4879  db 00 13 27 A2 12 16 14 00 13 27 A6 12 16 14 00 13  ; ..'......'......
4889  db 27 84 01 14 13 27 A5 12 16 14 00 13 27 04 14 3B  ; '....'......'..;
4899  db 00 01 68 2B 1B 04 06 0B 00 00 98 2B 00 0E 0A 00  ; ..h+.......+....
48A9  db 00 68 2B E4 48 E4 48 E4 48 1D 49 4D 49 93 49 E0  ; .h+.H.H.H.IMI.I.
48B9  db 49 16 4A 54 4A A5 4A DA 4A 11 4B 49 4B 96 4B BB  ; I.JTJ.J.J.KIK.K.
48C9  db 4B F5 4B 4B 4C 9D 4C E2 4C E9 4C F0 4C F7 4C FE  ; K.KKL.L.L.L.L.L.
48D9  db 4C 05 4D 0C 4D 13 4D 5E 4D 57 4D B1 12 15 03 40  ; L.M.M.M^MWM....@
48E9  db 00 22 27 85 01 15 00 22 84 01 16 22 27 A6 12 FF  ; ."'...."..."'...
48F9  db 15 00 22 27 A2 12 FF 15 00 22 27 AA 12 FF 15 00  ; .."'....."'.....
4909  db 22 27 88 01 16 22 27 89 01 15 00 22 04 16 4A 00  ; "'..."'...."..J.
4919  db 01 7E 2F 05 81 01 16 0E 27 85 01 16 0E 27 84 01  ; .~/.....'....'..
4929  db 16 00 36 86 01 16 00 36 82 01 16 00 36 8A 01 16  ; ..6....6....6...
4939  db 00 36 B8 12 16 04 40 00 0E 27 04 16 36 00 21 BA  ; .6....@..'..6.!.
4949  db 2F 19 1A 05 A1 12 16 14 00 13 27 D5 93 16 FF 05  ; /.........'.....
4959  db 20 00 13 0E 18 D4 93 16 FF 05 20 00 13 0E 18 A6  ;  ......... .....
4969  db 12 16 14 00 13 27 A2 12 16 14 00 13 27 AA 12 16  ; .....'......'...
4979  db 14 00 13 27 88 01 14 13 27 A9 12 16 14 00 13 27  ; ...'....'......'
4989  db 04 14 3B 00 21 E6 2F 19 1A 05 C1 93 14 15 0E 00  ; ..;.!./.........
4999  db 13 13 27 85 01 14 27 27 84 01 14 27 27 C6 93 14  ; ..'...''...''...
49A9  db FF 14 00 13 13 27 C2 93 14 FF 14 00 13 13 27 CA  ; .....'........'.
49B9  db 93 14 FF 14 00 13 13 27 C8 93 14 FF 14 00 13 13  ; .......'........
49C9  db 27 C9 93 14 FF 14 00 13 13 27 80 01 06 13 13 04  ; '........'......
49D9  db 14 47 00 01 16 30 0E 81 01 13 7C 22 85 01 13 7C  ; .G...0....|"...|
49E9  db 22 94 01 07 80 7C 22 86 01 13 7C 22 82 01 13 7C  ; "....|"...|"...|
49F9  db 22 8A 01 13 7C 22 88 01 13 7C 22 89 01 13 7C 22  ; "...|"...|"...|"
4A09  db 80 01 12 7C 22 05 13 9E 00 09 56 30 0A 81 01 13  ; ...|".....V0....
4A19  db 00 39 85 01 13 0E 2A 84 01 13 0E 2A 86 01 13 0E  ; .9....*....*....
4A29  db 2A 82 01 13 00 39 8A 01 13 00 39 D8 93 13 FF 08  ; *....9....9.....
4A39  db 20 00 0E 13 16 C9 93 13 FF 13 00 0E 13 16 80 01  ;  ...............
4A49  db 12 0E 2A 05 13 39 00 01 D6 30 0C C1 93 13 FF 14  ; ..*..9...0......
4A59  db 00 11 13 13 C5 93 13 FF 14 00 11 13 13 84 01 13  ; ................
4A69  db 00 11 C6 93 13 FF 14 00 11 13 13 C2 93 13 FF 14  ; ................
4A79  db 00 11 13 13 CA 93 13 FF 14 00 11 13 13 88 01 14  ; ................
4A89  db 25 13 C9 93 13 FF 14 00 11 13 13 D0 93 12 FF 09  ; %...............
4A99  db 20 00 11 13 13 05 14 39 00 00 04 31 81 01 13 22  ;  ......9...1..."
4AA9  db 2F 85 01 13 22 2F 84 01 13 22 2F 86 01 13 22 2F  ; /..."/..."/..."/
4AB9  db 82 01 13 22 2F 8A 01 13 22 2F 98 01 0A 80 22 2F  ; ..."/..."/...."/
4AC9  db 89 01 13 22 2F 80 01 12 22 2F 05 13 51 00 00 32  ; ..."/..."/..Q..2
4AD9  db 31 81 01 13 00 34 85 01 13 00 34 84 01 13 00 34  ; 1....4....4....4
4AE9  db 86 01 13 00 34 82 01 13 00 34 8A 01 13 00 34 88  ; ....4....4....4.
4AF9  db 01 13 0C 27 89 01 13 00 34 B0 12 12 0B 40 00 0C  ; ...'....4....@..
4B09  db 27 05 13 34 00 00 74 31 81 01 13 22 2C 85 01 13  ; '..4..t1...",...
4B19  db 22 2C 84 01 13 22 2C 86 01 13 22 2C 82 01 13 22  ; ",...",...",..."
4B29  db 2C BA 12 FF 0C 40 22 13 18 98 01 0C 80 36 18 89  ; ,....@"......6..
4B39  db 01 13 22 2C 80 01 12 22 2C 05 13 4F 00 00 9E 31  ; ..",...",..O...1
4B49  db D1 93 13 FF 0D 20 00 36 27 13 85 01 13 00 36 84  ; ..... .6'.....6.
4B59  db 01 13 00 36 C6 93 13 FF 14 00 36 27 13 C2 93 13  ; ...6......6'....
4B69  db FF 14 00 36 27 13 CA 93 13 FF 14 0E 27 27 13 C8  ; ...6'.......''..
4B79  db 93 FF FF 14 0E 27 27 13 C9 93 13 FF 14 00 0E 4F  ; .....''........O
4B89  db 13 80 01 12 00 36 05 14 72 00 00 DE 31 81 01 FF  ; .....6..r...1...
4B99  db 00 58 84 01 14 00 58 86 01 14 00 58 82 01 14 00  ; .X....X....X....
4BA9  db 58 8A 01 14 00 58 88 01 14 00 58 05 8A 50 00 00  ; X....X....X..P..
4BB9  db 3A 32 A1 12 FF 16 00 1D 16 A5 12 FF 16 00 1D 16  ; :2..............
4BC9  db 94 01 0F 80 1D 16 86 01 16 1D 16 82 01 16 1D 16  ; ................
4BD9  db 8A 01 16 1D 16 88 01 16 1D 16 89 01 16 1D 16 80  ; ................
4BE9  db 01 16 1D 16 04 16 34 00 05 82 32 0F C1 93 16 FF  ; ......4...2.....
4BF9  db 16 00 11 1B 13 C5 93 16 FF 16 00 11 1B 13 84 01  ; ................
4C09  db 16 2C 13 C6 93 16 FF 16 00 11 1B 13 C2 93 16 FF  ; .,..............
4C19  db 16 00 11 1B 13 CA 93 16 FF 16 00 11 1B 13 D8 93  ; ................
4C29  db 16 FF 10 20 00 11 1B 13 C9 93 16 FF 16 00 11 1B  ; ... ............
4C39  db 13 C0 93 16 FF 16 00 11 1B 13 04 16 40 00 01 AC  ; ............@...
4C49  db 32 0D D1 93 16 FF 11 20 00 0C 13 13 A5 12 16 FF  ; 2...... ........
4C59  db 00 0C 13 C4 93 16 FF 15 00 0C 13 13 C6 93 16 FF  ; ................
4C69  db 15 00 0C 13 13 C2 93 16 FF 15 00 0C 13 13 CA 93  ; ................
4C79  db 16 FF 15 00 0C 13 13 88 01 15 20 13 A9 12 16 FF  ; .......... .....
4C89  db 00 0C 13 C0 93 16 FF 15 00 0C 13 13 04 15 34 00  ; ..............4.
4C99  db 01 E0 32 11 A1 12 FF 0D 0E 13 11 C4 93 15 FF 16  ; ..2.............
4CA9  db 00 0E 13 11 C6 93 15 FF 14 00 0E 13 11 C2 93 15  ; ................
4CB9  db FF 14 00 0E 13 11 CA 93 15 FF 15 00 0E 13 11 C8  ; ................
4CC9  db 93 15 FF 15 00 0E 13 11 C0 93 15 FF 14 00 0E 13  ; ................
4CD9  db 11 04 14 2C 00 01 0A 33 0D 10 17 23 00 00 36 33  ; ...,...3...#..63
4CE9  db 10 17 23 00 00 5A 33 10 17 32 00 00 7E 33 10 17  ; ..#..Z3..2..~3..
4CF9  db 1E 00 00 8E 33 10 17 1B 00 00 AE 33 20 17 31 00  ; ....3......3 .1.
4D09  db 00 4E 2F 20 18 33 00 00 4F 38 A1 12 16 14 00 13  ; .N/ .3..O8......
4D19  db 27 D5 93 16 FF 1B 20 00 13 0E 18 D4 93 16 FF 1B  ; '..... .........
4D29  db 20 00 13 0E 18 A6 12 16 14 00 13 27 A2 12 16 14  ;  ..........'....
4D39  db 00 13 27 AA 12 16 14 00 13 27 88 01 14 13 27 A9  ; ..'......'....'.
4D49  db 12 16 14 00 13 27 04 14 3B 00 01 E6 2F 1B 04 06  ; .....'..;.../...
4D59  db 0B 00 00 16 30 00 0E 0A 00 00 E6 2F B1 4D B1 4D  ; ....0....../.M.M
4D69  db B1 4D D8 4D 09 4E 41 4E 6C 4E A8 4E E5 4E 1A 4F  ; .M.M.NANlN.N.N.O
4D79  db 52 4F 91 4F D5 4F DC 4F EF 4F 20 50 53 50 85 50  ; RO.O.O.O.O PSP.P
4D89  db B7 50 EA 50 F1 50 2C 51 39 51 40 51 47 51 4E 51  ; .P.P.P,Q9Q@QGQNQ
4D99  db 55 51 5C 51 63 51 78 51 71 51 6A 51 7F 51 C2 51  ; UQ\QcQxQqQjQ.Q.Q
4DA9  db 86 51 C9 51 14 52 DC 51 8A 01 18 23 12 82 01 18  ; .Q.Q.R.Q...#....
4DB9  db 23 12 86 01 18 23 12 84 01 18 23 12 85 01 18 23  ; #....#....#....#
4DC9  db 12 90 01 03 80 36 0E 05 16 45 00 01 FC 33 03 81  ; .....6...E...3..
4DD9  db 01 18 13 13 89 01 18 13 13 98 01 04 80 13 13 8A  ; ................
4DE9  db 01 18 13 13 82 01 18 13 13 86 01 18 13 13 84 01  ; ................
4DF9  db 18 13 13 85 01 18 13 13 05 17 27 00 01 34 34 04  ; ..........'..44.
4E09  db B1 12 18 05 40 00 27 1C B9 12 18 05 40 22 04 1C  ; ....@.'.....@"..
4E19  db 88 01 18 22 21 8A 01 18 22 21 82 01 18 00 44 86  ; ..."!..."!....D.
4E29  db 01 18 00 44 84 01 18 00 44 85 01 18 00 44 05 17  ; ...D....D....D..
4E39  db 44 00 21 54 34 20 21 05 89 01 0D 28 27 88 01 0D  ; D.!T4 !....('...
4E49  db 28 27 82 01 18 28 27 86 01 18 28 27 84 01 18 28  ; ('...('...('...(
4E59  db 27 85 01 18 28 27 90 01 06 80 28 27 05 16 50 00  ; '...('....('..P.
4E69  db 00 8B 34 81 01 1F 22 20 89 01 1F 22 20 88 01 1F  ; ..4..." ..." ...
4E79  db 22 20 8A 01 1F 22 20 82 01 1F 22 20 86 01 1F 22  ; " ..." ..." ..."
4E89  db 20 A4 12 1F 1C 22 0C 13 A5 12 1F 1C 22 0C 13 B0  ;  ...."......"...
4E99  db 12 1B 07 40 22 0C 13 05 1A 42 00 09 CC 34 09 A1  ; ...@"....B...4..
4EA9  db 12 1F 1C 00 11 27 89 01 1F 00 39 D8 93 1F FF 08  ; .....'....9.....
4EB9  db 20 00 11 15 12 8A 01 1F 00 39 82 01 1F 00 39 86  ;  ........9....9.
4EC9  db 01 1F 00 39 84 01 1C 00 39 A5 12 1C 1F 00 11 27  ; ...9....9......'
4ED9  db 80 01 1B 11 27 05 1C 39 00 00 02 35 81 01 1F 2A  ; ....'..9...5...*
4EE9  db 0E 89 01 1F 2A 0E 88 01 1C 2A 0E 8A 01 1C 2A 0E  ; ....*....*....*.
4EF9  db 82 01 1F 2A 0E 86 01 1F 2A 0E 84 01 1A 2A 0E 85  ; ...*....*....*..
4F09  db 01 1A 2A 0E 90 01 09 80 2A 0E 05 1A 39 00 00 30  ; ..*.....*...9..0
4F19  db 35 81 01 1F 00 2B 89 01 1F 00 2B 88 01 1C 00 2B  ; 5....+....+....+
4F29  db 8A 01 1F 00 2B 82 01 1F 00 2B 86 01 1F 00 2B B4  ; ....+....+....+.
4F39  db 12 1F 0A 40 00 0C 1F 85 01 1F 00 2B 80 01 1B 0C  ; ...@.......+....
4F49  db 1F 05 1F 2B 00 01 5E 35 08 A1 12 FF 1A 0D 08 15  ; ...+..^5........
4F59  db A9 12 FF 1A 0D 08 15 88 01 1F 0D 1D 8A 01 1C 0D  ; ................
4F69  db 1D 82 01 1C 0D 1D A6 12 1F 1C 0D 08 15 84 01 1F  ; ................
4F79  db 0D 1D A5 12 FF 1A 0D 08 15 B0 12 1B 0B 40 0D 08  ; .............@..
4F89  db 15 05 1A 2B 00 00 81 35 B1 12 FF 0C 40 1D 04 27  ; ...+...5....@..'
4F99  db B9 12 FF 0C 40 1D 04 27 B8 12 FF 0C 40 1D 04 27  ; ....@..'....@..'
4FA9  db AA 12 1C 17 1D 04 27 A2 12 1C 17 1D 04 27 A6 12  ; ......'......'..
4FB9  db 1F 18 1D 04 27 A4 12 1F 18 1D 04 27 A5 12 1F 18  ; ....'......'....
4FC9  db 1D 04 27 05 17 4A 00 40 A4 35 8A 24 05 8B 0F 00  ; ..'..J.@.5.$....
4FD9  db 00 E0 35 82 01 FF 09 11 90 01 0E 80 1B 10 05 16  ; ..5.............
4FE9  db 2B 00 05 F8 35 0F 81 01 18 1A 1A 89 01 18 1A 1A  ; +...5...........
4FF9  db 98 01 0F 80 1A 1A 8A 01 18 1A 1A 82 01 18 1A 1A  ; ................
5009  db 86 01 17 1A 1A 84 01 17 1A 1A 85 01 17 1A 1A 05  ; ................
5019  db 17 34 00 01 1B 36 14 81 01 18 1C 2A 89 01 18 1C  ; .4...6.....*....
5029  db 2A 88 01 18 1C 2A 8A 01 18 1C 2A 82 01 18 1C 2A  ; *....*....*....*
5039  db 86 01 18 1C 2A 94 01 10 80 1C 2A 95 01 10 80 1C  ; ....*.....*.....
5049  db 2A 05 17 46 00 40 45 36 8B 25 91 01 11 80 0C 0B  ; *..F.@E6.%......
5059  db 89 01 18 0C 0B 88 01 18 0C 0B 8A 01 18 0C 0B 82  ; ................
5069  db 01 18 0C 0B 86 01 18 0C 0B 94 01 11 80 0C 0B 95  ; ................
5079  db 01 11 80 0C 0B 05 17 17 00 00 7E 36 91 01 12 80  ; ..........~6....
5089  db 03 0C 99 01 12 80 03 0C 98 01 12 80 03 0C 8A 01  ; ................
5099  db 18 03 0C 82 01 18 03 0C 86 01 18 03 0C 84 01 18  ; ................
50A9  db 03 0C 85 01 18 03 0C 05 17 10 00 00 91 36 91 01  ; .............6..
50B9  db 13 80 04 0C 99 01 13 80 04 0C 98 01 13 80 04 0C  ; ................
50C9  db 8A 01 18 04 0C 82 01 18 04 0C 86 01 18 04 0C 84  ; ................
50D9  db 01 18 04 0C 85 01 18 04 0C 05 17 11 00 01 9E 36  ; ...............6
50E9  db 14 05 14 01 00 00 AC 36 B1 12 FF 15 40 00 10 15  ; .......6....@...
50F9  db B9 12 FF 15 40 00 10 15 B8 12 FF 15 40 00 10 15  ; ....@.......@...
5109  db 8A 01 18 00 25 A2 12 17 18 00 10 15 86 01 18 00  ; ....%...........
5119  db 25 84 01 18 00 25 85 01 18 00 25 05 17 25 00 01  ; %....%....%..%..
5129  db C2 35 15 81 01 FF 00 17 05 8C 0F 00 01 E0 35 8C  ; .5............5.
5139  db 10 1D 5D 00 00 D4 36 10 1D 24 00 00 27 37 10 1D  ; ..]...6..$..'7..
5149  db 23 00 00 4C 37 10 1D 36 00 00 70 37 10 1D 24 00  ; #..L7..6..p7..$.
5159  db 00 A3 37 10 1D 36 00 00 C8 37 10 1D 23 00 00 FB  ; ..7..6...7..#...
5169  db 37 10 1D 33 00 00 1F 38 20 1D 33 00 00 4F 38 20  ; 7..3...8 .3..O8 
5179  db 1E 33 00 00 87 40 00 22 15 00 00 93 34 81 01 1F  ; .3...@."....4...
5189  db 22 20 89 01 1F 22 20 88 01 1F 22 20 8A 01 1F 22  ; " ..." ..." ..."
5199  db 20 82 01 1F 22 20 86 01 1F 22 20 A4 12 1F 1C 22  ;  ..." ..." ...."
51A9  db 0C 13 A5 12 1F 1C 22 0C 13 B0 12 1B 07 40 22 0C  ; ......"......@".
51B9  db 13 05 1A 42 00 01 CC 34 09 00 23 15 00 00 93 34  ; ...B...4..#....4
51C9  db 82 01 FF 09 11 90 01 0E 80 1B 10 05 16 2B 00 01  ; .............+..
51D9  db F8 35 0F B1 12 18 05 40 11 27 1C B9 12 18 05 40  ; .5.....@.'.....@
51E9  db 34 04 1C 88 01 18 34 21 8A 01 18 34 21 82 01 18  ; 4.....4!...4!...
51F9  db 11 44 86 01 18 11 44 84 01 18 11 44 85 01 18 11  ; .D....D....D....
5209  db 44 05 17 55 00 21 46 34 20 21 05 00 24 0F 00 40  ; D..U.!F4 !..$..@
5219  db E0 35 8B 02 69 52 69 52 69 52 90 52 C1 52 F9 52  ; .5..iRiRiR.R.R.R
5229  db 24 53 60 53 9D 53 D2 53 0A 54 49 54 8D 54 94 54  ; $S`S.S.S.TIT.T.T
5239  db A7 54 D8 54 0B 55 3D 55 6F 55 A2 55 A9 55 E4 55  ; .T.T.U=UoU.U.U.U
5249  db F1 55 F8 55 FF 55 06 56 0D 56 14 56 1B 56 30 56  ; .U.U.U.V.V.V.V0V
5259  db 29 56 22 56 37 56 7A 56 3E 56 81 56 CC 56 94 56  ; )V"V7VzV>V.V.V.V
5269  db 86 01 18 23 12 82 01 18 23 12 8A 01 18 23 12 88  ; ...#....#....#..
5279  db 01 18 23 12 89 01 18 23 12 90 01 03 80 36 0E 05  ; ..#....#.....6..
5289  db 16 45 00 01 80 38 03 81 01 18 13 13 85 01 18 13  ; .E...8..........
5299  db 13 94 01 04 80 13 13 86 01 18 13 13 82 01 18 13  ; ................
52A9  db 13 8A 01 18 13 13 88 01 18 13 13 89 01 18 13 13  ; ................
52B9  db 05 17 27 00 01 B8 38 04 B1 12 18 05 40 00 27 1C  ; ..'...8.....@.'.
52C9  db B5 12 18 05 40 22 04 1C 84 01 18 22 21 86 01 18  ; ....@"....."!...
52D9  db 22 21 82 01 18 00 44 8A 01 18 00 44 88 01 18 00  ; "!....D....D....
52E9  db 44 89 01 18 00 44 05 17 44 00 21 D8 38 20 21 05  ; D....D..D.!.8 !.
52F9  db 85 01 0D 28 27 84 01 0D 28 27 82 01 18 28 27 8A  ; ...('...('...('.
5309  db 01 18 28 27 88 01 18 28 27 89 01 18 28 27 90 01  ; ..('...('...('..
5319  db 06 80 28 27 05 16 50 00 00 0F 39 81 01 1F 22 20  ; ..('..P...9..." 
5329  db 85 01 1F 22 20 84 01 1F 22 20 86 01 1F 22 20 82  ; ..." ..." ..." .
5339  db 01 1F 22 20 8A 01 1F 22 20 A8 12 1F 1C 22 0C 13  ; .." ..." ...."..
5349  db A9 12 1F 1C 22 0C 13 B0 12 1B 07 40 22 0C 13 05  ; ...."......@"...
5359  db 1A 42 00 09 50 39 09 A1 12 1F 1C 00 11 27 85 01  ; .B..P9.......'..
5369  db 1F 00 39 D4 93 1F FF 08 20 00 11 15 12 86 01 1F  ; ..9..... .......
5379  db 00 39 82 01 1F 00 39 8A 01 1F 00 39 88 01 1C 00  ; .9....9....9....
5389  db 39 A9 12 1C 1F 00 11 27 80 01 1B 11 27 05 1C 39  ; 9......'....'..9
5399  db 00 00 86 39 81 01 1F 2A 0E 85 01 1F 2A 0E 84 01  ; ...9...*....*...
53A9  db 1C 2A 0E 86 01 1C 2A 0E 82 01 1F 2A 0E 8A 01 1F  ; .*....*....*....
53B9  db 2A 0E 88 01 1A 2A 0E 89 01 1A 2A 0E 90 01 09 80  ; *....*....*.....
53C9  db 2A 0E 05 1A 39 00 00 B4 39 81 01 1F 00 2B 85 01  ; *...9...9....+..
53D9  db 1F 00 2B 84 01 1C 00 2B 86 01 1F 00 2B 82 01 1F  ; ..+....+....+...
53E9  db 00 2B 8A 01 1F 00 2B B8 12 1F 0A 40 00 0C 1F 89  ; .+....+....@....
53F9  db 01 1F 00 2B 80 01 1B 0C 1F 05 1F 2B 00 01 E2 39  ; ...+.......+...9
5409  db 08 A1 12 FF 1A 0D 08 15 A5 12 FF 1A 0D 08 15 84  ; ................
5419  db 01 1F 0D 1D 86 01 1C 0D 1D 82 01 1C 0D 1D AA 12  ; ................
5429  db 1F 1C 0D 08 15 88 01 1F 0D 1D A9 12 FF 1A 0D 08  ; ................
5439  db 15 B0 12 1B 0B 40 0D 08 15 05 1A 2B 00 00 05 3A  ; .....@.....+...:
5449  db B1 12 FF 0C 40 1D 04 27 B5 12 FF 0C 40 1D 04 27  ; ....@..'....@..'
5459  db B4 12 FF 0C 40 1D 04 27 A6 12 1C 17 1D 04 27 A2  ; ....@..'......'.
5469  db 12 1C 17 1D 04 27 AA 12 1F 18 1D 04 27 A8 12 1F  ; .....'......'...
5479  db 18 1D 04 27 A9 12 1F 18 1D 04 27 05 17 4A 00 40  ; ...'......'..J.@
5489  db 28 3A 8B 24 05 8B 0F 00 00 64 3A 82 01 FF 09 11  ; (:.$.....d:.....
5499  db 90 01 0E 80 1B 10 05 16 2B 00 05 7C 3A 0F 81 01  ; ........+..|:...
54A9  db 18 1A 1A 85 01 18 1A 1A 94 01 0F 80 1A 1A 86 01  ; ................
54B9  db 18 1A 1A 82 01 18 1A 1A 8A 01 17 1A 1A 88 01 17  ; ................
54C9  db 1A 1A 89 01 17 1A 1A 05 17 34 00 01 9F 3A 14 81  ; .........4...:..
54D9  db 01 18 1C 2A 85 01 18 1C 2A 84 01 18 1C 2A 86 01  ; ...*....*....*..
54E9  db 18 1C 2A 82 01 18 1C 2A 8A 01 18 1C 2A 98 01 10  ; ..*....*....*...
54F9  db 80 1C 2A 99 01 10 80 1C 2A 05 17 46 00 40 C9 3A  ; ..*.....*..F.@.:
5509  db 8A 25 91 01 11 80 0C 0B 85 01 18 0C 0B 84 01 18  ; .%..............
5519  db 0C 0B 86 01 18 0C 0B 82 01 18 0C 0B 8A 01 18 0C  ; ................
5529  db 0B 98 01 11 80 0C 0B 99 01 11 80 0C 0B 05 17 17  ; ................
5539  db 00 00 02 3B 91 01 12 80 03 0C 95 01 12 80 03 0C  ; ...;............
5549  db 94 01 12 80 03 0C 86 01 18 03 0C 82 01 18 03 0C  ; ................
5559  db 8A 01 18 03 0C 88 01 18 03 0C 89 01 18 03 0C 05  ; ................
5569  db 17 10 00 00 15 3B 91 01 13 80 04 0C 95 01 13 80  ; .....;..........
5579  db 04 0C 94 01 13 80 04 0C 86 01 18 04 0C 82 01 18  ; ................
5589  db 04 0C 8A 01 18 04 0C 88 01 18 04 0C 89 01 18 04  ; ................
5599  db 0C 05 17 11 00 01 22 3B 14 05 14 01 00 00 30 3B  ; ......";......0;
55A9  db B1 12 FF 15 40 00 10 15 B5 12 FF 15 40 00 10 15  ; ....@.......@...
55B9  db B4 12 FF 15 40 00 10 15 86 01 18 00 25 A2 12 17  ; ....@.......%...
55C9  db 18 00 10 15 8A 01 18 00 25 88 01 18 00 25 89 01  ; ........%....%..
55D9  db 18 00 25 05 17 25 00 01 46 3A 15 81 01 FF 00 17  ; ..%..%..F:......
55E9  db 05 8C 0F 00 01 64 3A 8C 10 1D 5D 00 00 58 3B 10  ; .....d:...]..X;.
55F9  db 1D 24 00 00 AB 3B 10 1D 23 00 00 D0 3B 10 1D 36  ; .$...;..#...;..6
5609  db 00 00 F4 3B 10 1D 24 00 00 27 3C 10 1D 36 00 00  ; ...;..$..'<..6..
5619  db 4C 3C 10 1D 23 00 00 7F 3C 10 1D 33 00 00 A3 3C  ; L<..#...<..3...<
5629  db 20 1D 33 00 00 4F 38 20 1E 33 00 00 87 40 00 22  ;  .3..O8 .3...@."
5639  db 15 00 00 17 39 81 01 1F 22 20 85 01 1F 22 20 84  ; ....9..." ..." .
5649  db 01 1F 22 20 86 01 1F 22 20 82 01 1F 22 20 8A 01  ; .." ..." ..." ..
5659  db 1F 22 20 A8 12 1F 1C 22 0C 13 A9 12 1F 1C 22 0C  ; ." ...."......".
5669  db 13 B0 12 1B 07 40 22 0C 13 05 1A 42 00 01 50 39  ; .....@"....B..P9
5679  db 09 00 23 15 00 00 17 39 82 01 FF 09 11 90 01 0E  ; ..#....9........
5689  db 80 1B 10 05 16 2B 00 01 7C 3A 0F B1 12 18 05 40  ; .....+..|:.....@
5699  db 11 27 1C B5 12 18 05 40 34 04 1C 84 01 18 34 21  ; .'.....@4.....4!
56A9  db 86 01 18 34 21 82 01 18 11 44 8A 01 18 11 44 88  ; ...4!....D....D.
56B9  db 01 18 11 44 89 01 18 11 44 05 17 55 00 21 CA 38  ; ...D....D..U.!.8
56C9  db 20 21 05 00 24 0F 00 40 64 3A 8A 02 0D 57 0D 57  ;  !..$..@d:...W.W
56D9  db 0D 57 55 57 B2 57 DE 57 01 58 35 58 65 58 9B 58  ; .WUW.W.W.X5XeX.X
56E9  db DD 58 15 59 58 59 9C 59 C2 59 F6 59 3A 5A 65 5A  ; .X.YXY.Y.Y.Y:ZeZ
56F9  db 6C 5A 73 5A 7A 5A 81 5A 88 5A 8F 5A 9D 5A 96 5A  ; lZsZzZ.Z.Z.Z.Z.Z
5709  db D8 5A A4 5A 81 01 12 00 1D D9 93 12 13 03 20 00  ; .Z.Z.......... .
5719  db 1D 09 1D D8 93 12 13 03 20 00 1D 09 1D AA 12 12  ; ........ .......
5729  db 13 00 1D 27 C2 93 12 17 13 00 1D 09 1D C6 93 12  ; ...'............
5739  db FF 17 00 1D 09 1D C4 93 12 FF 17 00 1D 09 1D 85  ; ................
5749  db 01 12 00 1D 07 17 45 00 01 04 3D 03 81 01 FF 3B  ; ......E...=....;
5759  db 1D B1 12 12 04 40 72 09 13 C9 93 FF FF 12 3B 1D  ; .....@r.......;.
5769  db 18 09 C8 93 FF FF 12 3B 1D 18 09 CA 93 16 FF 12  ; .......;........
5779  db 3B 1D 18 09 82 01 11 72 09 C6 93 16 FF 12 3B 1D  ; ;......r......;.
5789  db 18 09 84 01 16 3B 1D B4 12 12 04 40 72 09 13 85  ; .....;.....@r...
5799  db 01 12 3B 40 B5 12 12 04 40 72 09 13 80 01 12 72  ; ..;@....@r.....r
57A9  db 09 07 11 8F 00 01 3C 3D 09 89 01 12 00 13 8A 01  ; ......<=........
57B9  db FF 00 13 82 01 FF 00 13 86 01 FF 00 13 B4 12 12  ; ................
57C9  db 05 40 00 13 13 B5 12 12 05 40 00 13 13 07 11 27  ; .@.......@.....'
57D9  db 00 01 B0 3D 09 89 01 12 00 13 88 01 12 00 13 8A  ; ...=............
57E9  db 01 12 00 13 94 01 06 80 13 13 95 01 06 80 13 13  ; ................
57F9  db 07 11 27 00 01 D0 3D 06 89 01 12 00 3B 88 01 12  ; ..'...=.....;...
5809  db 00 3B 8A 01 11 1D 1D 82 01 11 1D 1D 86 01 11 1D  ; .;..............
5819  db 1D A4 12 FF 12 00 1D 1D A5 12 FF 12 00 1D 1D 90  ; ................
5829  db 01 07 80 2F 0C 07 11 3B 00 00 F0 3D 89 01 12 00  ; .../...;...=....
5839  db 27 88 01 12 00 27 8A 01 11 00 27 82 01 11 00 27  ; '....'....'....'
5849  db 86 01 11 00 27 84 01 12 00 27 85 01 12 00 27 90  ; ....'....'....'.
5859  db 01 08 80 13 13 07 11 27 00 00 20 3E 91 01 09 80  ; .......'.. >....
5869  db 13 12 89 01 12 00 26 88 01 12 00 26 AA 12 11 12  ; ......&....&....
5879  db 00 13 12 A2 12 11 12 00 13 12 A6 12 11 12 00 13  ; ................
5889  db 12 84 01 12 00 26 85 01 12 00 26 07 16 26 00 00  ; .....&....&..&..
5899  db 40 3E C1 93 FF FF 15 0B 1D 08 17 89 01 15 31 17  ; @>............1.
58A9  db A8 12 FF 15 28 08 17 BA 12 13 0A 40 0B 26 17 B2  ; ....(......@.&..
58B9  db 12 13 0A 40 0B 26 17 A6 12 13 15 0B 26 17 A4 12  ; ...@.&......&...
58C9  db 14 15 0B 1D 20 A5 12 14 15 0B 1D 20 07 14 49 00  ; .... ...... ..I.
58D9  db 01 5F 3E 0F B1 12 12 0B 40 07 09 13 B9 12 12 0B  ; ._>.....@.......
58E9  db 40 07 09 13 B8 12 12 0B 40 07 09 13 8A 01 12 07  ; @.......@.......
58F9  db 09 82 01 11 07 09 86 01 12 07 09 84 01 12 07 09  ; ................
5909  db 85 01 12 07 09 07 11 25 00 00 9A 3E 81 01 FF 00  ; .......%...>....
5919  db 09 A9 12 FF 13 00 09 1D A8 12 12 13 00 09 1D AA  ; ................
5929  db 12 12 13 00 09 1D A2 12 12 11 00 09 1D A6 12 12  ; ................
5939  db 13 00 09 1D A4 12 12 13 00 09 1D 85 01 13 09 1D  ; ................
5949  db B0 12 11 0C 40 09 0E 0E 07 11 27 00 00 B8 3E 91  ; ....@.....'...>.
5959  db 01 0D 80 09 20 A9 12 13 15 00 09 20 A8 12 13 15  ; .... ...... ....
5969  db 00 09 20 AA 12 13 15 00 09 20 B2 12 11 0D 40 00  ; .. ...... ....@.
5979  db 09 20 A6 12 13 15 00 09 20 A4 12 13 15 00 09 20  ; . ...... ...... 
5989  db A5 12 13 15 00 09 20 80 01 15 09 20 07 15 2A 00  ; ...... .... ..*.
5999  db 00 D8 3E 88 01 14 25 0B 8A 01 14 25 0B 82 01 14  ; ..>...%....%....
59A9  db 25 0B 86 01 14 25 0B 84 01 14 25 0B 90 01 0E 80  ; %....%....%.....
59B9  db 25 0B 07 14 31 00 00 FA 3E 91 01 0F 80 09 1A 99  ; %...1...>.......
59C9  db 01 0F 80 09 1A B8 12 14 0F 80 00 09 1A 8A 01 14  ; ................
59D9  db 00 09 82 01 14 00 09 A6 12 14 11 00 09 1A A4 12  ; ................
59E9  db 14 11 00 09 1A 07 11 23 00 01 22 3F 0F 81 01 FF  ; .......#.."?....
59F9  db 0D 20 A9 12 16 13 0D 20 18 A8 12 16 13 0D 20 18  ; . ..... ...... .
5A09  db AA 12 11 13 0D 20 18 82 01 11 0D 39 A6 12 11 13  ; ..... .....9....
5A19  db 0D 20 18 A4 12 16 13 0D 20 18 A5 12 FF 13 0D 20  ; . ...... ...... 
5A29  db 18 90 01 10 80 37 0E 07 11 46 00 41 3F 3F 8C 1A  ; .....7...F.A??..
5A39  db 0D 89 01 13 00 09 88 01 13 00 09 8A 01 13 00 09  ; ................
5A49  db 82 01 11 00 09 86 01 13 00 09 84 01 13 00 09 85  ; ................
5A59  db 01 13 00 09 07 8D 1E 00 01 78 3F 8E 10 18 1E 00  ; .........x?.....
5A69  db 00 98 3F 10 18 28 00 00 B8 3F 10 18 23 00 00 E0  ; ..?..(...?..#...
5A79  db 3F 10 18 1E 00 00 04 40 10 18 1E 00 00 24 40 10  ; ?......@.....$@.
5A89  db 18 23 00 00 44 40 10 18 1E 00 00 68 40 20 18 33  ; .#..D@.....h@ .3
5A99  db 00 00 BB 47 20 19 33 00 00 87 40 89 01 12 00 31  ; ...G .3...@....1
5AA9  db 88 01 12 00 31 8A 01 11 13 1D 82 01 11 13 1D 86  ; ....1...........
5AB9  db 01 11 13 1D A4 12 FF 12 00 13 1D A5 12 FF 12 00  ; ................
5AC9  db 13 1D 90 01 07 80 25 0C 07 11 31 00 00 F8 3D 00  ; ......%...1...=.
5AD9  db 1A 0A 00 40 70 3F 8D 1B 19 5B 19 5B 19 5B 61 5B  ; ...@p?...[.[.[a[
5AE9  db BE 5B EA 5B 0D 5C 41 5C 71 5C A7 5C E9 5C 21 5D  ; .[.[.\A\q\.\.\!]
5AF9  db 64 5D A8 5D CE 5D 02 5E 46 5E 71 5E 78 5E 7F 5E  ; d].].].^F^q^x^.^
5B09  db 86 5E 8D 5E 94 5E 9B 5E A9 5E A2 5E E4 5E B0 5E  ; .^.^.^.^.^.^.^.^
5B19  db 81 01 12 00 1D D5 93 12 13 03 20 00 1D 09 1D D4  ; .......... .....
5B29  db 93 12 13 03 20 00 1D 09 1D A6 12 12 13 00 1D 27  ; .... ..........'
5B39  db C2 93 12 17 13 00 1D 09 1D CA 93 12 FF 17 00 1D  ; ................
5B49  db 09 1D C8 93 12 FF 17 00 1D 09 1D 89 01 12 00 1D  ; ................
5B59  db 07 17 45 00 01 B8 40 03 81 01 FF 3B 1D B1 12 12  ; ..E...@....;....
5B69  db 04 40 72 09 13 C5 93 FF FF 12 3B 1D 18 09 C4 93  ; .@r.......;.....
5B79  db FF FF 12 3B 1D 18 09 C6 93 16 FF 12 3B 1D 18 09  ; ...;........;...
5B89  db 82 01 11 72 09 CA 93 16 FF 12 3B 1D 18 09 88 01  ; ...r......;.....
5B99  db 16 3B 1D B8 12 12 04 40 72 09 13 89 01 12 3B 40  ; .;.....@r.....;@
5BA9  db B9 12 12 04 40 72 09 13 80 01 12 72 09 07 11 8F  ; ....@r.....r....
5BB9  db 00 01 F0 40 09 85 01 12 00 13 86 01 FF 00 13 82  ; ...@............
5BC9  db 01 FF 00 13 8A 01 FF 00 13 B8 12 12 05 40 00 13  ; .............@..
5BD9  db 13 B9 12 12 05 40 00 13 13 07 11 27 00 01 64 41  ; .....@.....'..dA
5BE9  db 09 85 01 12 00 13 84 01 12 00 13 86 01 12 00 13  ; ................
5BF9  db 98 01 06 80 13 13 99 01 06 80 13 13 07 11 27 00  ; ..............'.
5C09  db 01 84 41 06 85 01 12 00 3B 84 01 12 00 3B 86 01  ; ..A.....;....;..
5C19  db 11 1D 1D 82 01 11 1D 1D 8A 01 11 1D 1D A8 12 FF  ; ................
5C29  db 12 00 1D 1D A9 12 FF 12 00 1D 1D 90 01 07 80 2F  ; .............../
5C39  db 0C 07 11 3B 00 00 A4 41 85 01 12 00 27 84 01 12  ; ...;...A....'...
5C49  db 00 27 86 01 11 00 27 82 01 11 00 27 8A 01 11 00  ; .'....'....'....
5C59  db 27 88 01 12 00 27 89 01 12 00 27 90 01 08 80 13  ; '....'....'.....
5C69  db 13 07 11 27 00 00 D4 41 91 01 09 80 13 12 85 01  ; ...'...A........
5C79  db 12 00 26 84 01 12 00 26 A6 12 11 12 00 13 12 A2  ; ..&....&........
5C89  db 12 11 12 00 13 12 AA 12 11 12 00 13 12 88 01 12  ; ................
5C99  db 00 26 89 01 12 00 26 07 16 26 00 00 F4 41 C1 93  ; .&....&..&...A..
5CA9  db FF FF 15 0B 1D 08 17 85 01 15 31 17 A4 12 FF 15  ; ..........1.....
5CB9  db 28 08 17 B6 12 13 0A 40 0B 26 17 B2 12 13 0A 40  ; (......@.&.....@
5CC9  db 0B 26 17 AA 12 13 15 0B 26 17 A8 12 14 15 0B 1D  ; .&......&.......
5CD9  db 20 A9 12 14 15 0B 1D 20 07 14 49 00 01 13 42 0F  ;  ...... ..I...B.
5CE9  db B1 12 12 0B 40 07 09 13 B5 12 12 0B 40 07 09 13  ; ....@.......@...
5CF9  db B4 12 12 0B 40 07 09 13 86 01 12 07 09 82 01 11  ; ....@...........
5D09  db 07 09 8A 01 12 07 09 88 01 12 07 09 89 01 12 07  ; ................
5D19  db 09 07 11 25 00 00 4E 42 81 01 FF 00 09 A5 12 FF  ; ...%..NB........
5D29  db 13 00 09 1D A4 12 12 13 00 09 1D A6 12 12 13 00  ; ................
5D39  db 09 1D A2 12 12 11 00 09 1D AA 12 12 13 00 09 1D  ; ................
5D49  db A8 12 12 13 00 09 1D 89 01 13 09 1D B0 12 11 0C  ; ................
5D59  db 40 09 0E 0E 07 11 27 00 00 6C 42 91 01 0D 80 09  ; @.....'..lB.....
5D69  db 20 A5 12 13 15 00 09 20 A4 12 13 15 00 09 20 A6  ;  ...... ...... .
5D79  db 12 13 15 00 09 20 B2 12 11 0D 40 00 09 20 AA 12  ; ..... ....@.. ..
5D89  db 13 15 00 09 20 A8 12 13 15 00 09 20 A9 12 13 15  ; .... ...... ....
5D99  db 00 09 20 80 01 15 09 20 07 15 2A 00 00 8C 42 84  ; .. .... ..*...B.
5DA9  db 01 14 25 0B 86 01 14 25 0B 82 01 14 25 0B 8A 01  ; ..%....%....%...
5DB9  db 14 25 0B 88 01 14 25 0B 90 01 0E 80 25 0B 07 14  ; .%....%.....%...
5DC9  db 31 00 00 AE 42 91 01 0F 80 09 1A 95 01 0F 80 09  ; 1...B...........
5DD9  db 1A B4 12 14 0F 80 00 09 1A 86 01 14 00 09 82 01  ; ................
5DE9  db 14 00 09 AA 12 14 11 00 09 1A A8 12 14 11 00 09  ; ................
5DF9  db 1A 07 11 23 00 01 D6 42 0F 81 01 FF 0D 20 A5 12  ; ...#...B..... ..
5E09  db 16 13 0D 20 18 A4 12 16 13 0D 20 18 A6 12 11 13  ; ... ...... .....
5E19  db 0D 20 18 82 01 11 0D 39 AA 12 11 13 0D 20 18 A8  ; . .....9..... ..
5E29  db 12 16 13 0D 20 18 A9 12 FF 13 0D 20 18 90 01 10  ; .... ...... ....
5E39  db 80 37 0E 07 11 46 00 41 F3 42 8D 1A 0D 85 01 13  ; .7...F.A.B......
5E49  db 00 09 84 01 13 00 09 86 01 13 00 09 82 01 11 00  ; ................
5E59  db 09 8A 01 13 00 09 88 01 13 00 09 89 01 13 00 09  ; ................
5E69  db 07 8D 1E 00 01 2C 43 8E 10 18 1E 00 00 4C 43 10  ; .....,C......LC.
5E79  db 18 28 00 00 6C 43 10 18 23 00 00 94 43 10 18 1E  ; .(..lC..#...C...
5E89  db 00 00 B8 43 10 18 1E 00 00 D8 43 10 18 23 00 00  ; ...C......C..#..
5E99  db F8 43 10 18 1E 00 00 1C 44 20 18 33 00 00 BB 47  ; .C......D .3...G
5EA9  db 20 19 33 00 00 87 40 85 01 12 00 31 84 01 12 00  ;  .3...@....1....
5EB9  db 31 86 01 11 13 1D 82 01 11 13 1D 8A 01 11 13 1D  ; 1...............
5EC9  db A8 12 FF 12 00 13 1D A9 12 FF 12 00 13 1D 90 01  ; ................
5ED9  db 07 80 25 0C 07 11 31 00 00 AC 41 00 1A 0A 00 40  ; ..%...1...A....@
5EE9  db 24 43 8C 1B 2B 5F 2B 5F 2B 5F 5C 5F 8E 5F CD 5F  ; $C..+_+_+_\_._._
5EF9  db 0A 60 3B 60 71 60 AD 60 E2 60 1F 61 49 61 61 61  ; .`;`q`.`.`.aIaaa
5F09  db 69 61 AC 61 EB 61 3A 62 41 62 48 62 4F 62 56 62  ; ia.a.a:bAbHbObVb
5F19  db 5D 62 64 62 72 62 AA 62 72 62 AA 62 1E 63 27 63  ; ]bdbrb.brb.b.c'c
5F29  db ED 62 91 01 03 80 6D 15 89 01 12 6D 15 88 01 12  ; .b....m....m....
5F39  db 6D 15 8A 01 13 6D 15 82 01 13 6D 15 86 01 13 6D  ; m....m....m....m
5F49  db 15 84 01 13 6D 15 80 01 11 6D 15 05 03 82 00 01  ; ....m....m......
5F59  db 6C 44 04 88 01 12 21 13 AA 12 13 12 00 21 13 A2  ; lD....!......!..
5F69  db 12 13 12 00 21 13 A6 12 13 12 00 0D 13 94 01 04  ; ....!...........
5F79  db 80 21 13 95 01 04 80 21 13 80 01 11 00 35 05 12  ; .!.....!.....5..
5F89  db 35 00 00 D5 44 A1 12 FF 13 0E 09 13 B9 12 FF 05  ; 5...D...........
5F99  db 40 0E 09 13 98 01 05 80 18 13 8A 01 12 00 2C 82  ; @.............,.
5FA9  db 01 12 00 2C 86 01 12 00 2C A4 12 12 13 0E 09 13  ; ...,....,.......
5FB9  db 85 01 13 18 13 80 01 11 0E 1D 05 12 2C 00 21 00  ; ............,.!.
5FC9  db 45 18 19 05 81 01 12 1B 2F 89 01 0E 1B 2F 88 01  ; E......./..../..
5FD9  db 0E 1B 2F AA 12 12 13 00 1B 2F A2 12 12 13 00 1B  ; ../....../......
5FE9  db 2F A6 12 12 13 00 1B 2F 84 01 13 1B 2F 85 01 12  ; /....../..../...
5FF9  db 1B 2F B0 12 11 06 40 00 1B 2F 05 12 4A 00 00 24  ; ./....@../..J..$
6009  db 45 81 01 15 18 13 89 01 15 18 13 88 01 15 18 13  ; E...............
6019  db 8A 01 15 18 13 82 01 15 18 13 86 01 15 18 13 85  ; ................
6029  db 01 15 18 13 90 01 07 80 18 13 06 15 2C 00 09 60  ; ............,..`
6039  db 45 08 81 01 15 16 27 99 01 08 80 16 27 98 01 08  ; E.....'.....'...
6049  db 80 16 27 8A 01 15 16 27 82 01 15 16 27 86 01 15  ; ..'....'....'...
6059  db 16 27 84 01 15 16 27 85 01 15 16 27 80 01 15 16  ; .'....'....'....
6069  db 27 06 15 3C 00 00 84 45 A1 12 FF 15 0E 0D 1A 89  ; '..<...E........
6079  db 01 15 1C 1A 88 01 15 1C 1A 8A 01 15 00 36 82 01  ; .............6..
6089  db 15 00 36 86 01 15 00 36 D4 93 15 FF 09 20 00 0E  ; ..6....6..... ..
6099  db 0D 1A D5 93 15 FF 09 20 00 0E 0D 1A 06 15 36 00  ; ....... ......6.
60A9  db 01 B6 45 09 81 01 14 22 13 89 01 15 22 13 88 01  ; ..E...."...."...
60B9  db 15 00 36 8A 01 15 00 22 82 01 14 22 13 86 01 14  ; ..6...."..."....
60C9  db 22 13 84 01 14 22 13 85 01 15 22 13 90 01 0A 80  ; "...."....".....
60D9  db 22 13 06 15 36 00 00 E2 45 A1 12 FF 15 16 09 0C  ; "...6...E.......
60E9  db 89 01 15 20 0C A8 12 15 14 00 16 16 8A 01 15 16  ; ... ............
60F9  db 16 A2 12 14 15 00 16 16 A6 12 14 15 00 16 16 84  ; ................
6109  db 01 14 00 2C 85 01 14 16 16 90 01 0B 80 20 0C 06  ; ...,......... ..
6119  db 15 2C 00 00 0E 46 81 01 12 1B 1B 89 01 12 1B 1B  ; .,...F..........
6129  db 88 01 12 1B 1B 8A 01 12 1B 1B 84 01 12 1B 1B 85  ; ................
6139  db 01 12 1B 1B 80 01 0C 1B 1B 06 12 2E 00 00 32 46  ; ..............2F
6149  db 89 01 12 00 11 88 01 12 00 11 8A 01 12 00 11 06  ; ................
6159  db 0D 11 00 C0 5E 46 8E 1C 05 8F 47 00 01 6C 46 90  ; ....^F....G..lF.
6169  db A1 12 12 13 00 0E 1D B9 12 FF 0F 40 00 0E 1D B8  ; ...........@....
6179  db 12 FF 0F 40 00 0E 1D 8A 01 12 00 2C 82 01 12 00  ; ...@.......,....
6189  db 2C A6 12 12 13 00 0E 1D A4 12 12 13 00 0E 1D A5  ; ,...............
6199  db 12 12 13 00 0E 1D 80 01 11 00 2C 05 13 2C 00 05  ; ..........,..,..
61A9  db AC 46 0F 81 01 12 00 36 A9 12 FF 12 00 0E 27 A8  ; .F.....6......'.
61B9  db 12 FF 12 00 0E 27 8A 01 12 00 36 82 01 12 00 36  ; .....'....6....6
61C9  db 86 01 12 00 36 B4 12 12 10 40 00 0E 27 B5 12 12  ; ....6....@..'...
61D9  db 10 40 00 0E 27 80 01 11 00 36 05 12 36 00 01 D0  ; .@..'....6..6...
61E9  db 46 10 C1 93 12 FF 12 00 0E 13 13 C9 93 12 FF 12  ; F...............
61F9  db 00 0E 13 13 C8 93 12 FF 12 00 0E 13 13 8A 01 12  ; ................
6209  db 00 36 82 01 12 00 36 86 01 12 00 36 C4 93 FF FF  ; .6....6....6....
6219  db 12 00 0E 13 13 C5 93 FF FF 12 00 0E 13 13 C0 93  ; ................
6229  db 11 FF 0D 00 0E 13 13 05 12 2E 00 41 FC 46 8E 1D  ; ...........A.F..
6239  db 10 10 16 2E 00 00 28 47 10 16 24 00 00 30 47 10  ; ......(G..$..0G.
6249  db 16 1F 00 00 54 47 10 16 29 00 00 74 47 10 16 1F  ; ....TG..)..tG...
6259  db 00 00 9C 47 20 16 34 00 00 BB 47 20 17 33 00 00  ; ...G .4...G .3..
6269  db 4F 38 00 1A FB FF 00 34 45 81 01 15 18 13 89 01  ; O8.....4E.......
6279  db 15 18 13 88 01 15 18 13 8A 01 15 18 13 82 01 15  ; ................
6289  db 18 13 86 01 15 18 13 85 01 15 18 13 90 01 07 80  ; ................
6299  db 18 13 06 15 2C 00 01 60 45 08 00 1B 05 00 00 2C  ; ....,..`E......,
62A9  db 45 A1 12 12 13 00 0E 1D B9 12 FF 0F 40 00 0E 1D  ; E...........@...
62B9  db B8 12 FF 0F 40 00 0E 1D 8A 01 12 00 2C 82 01 12  ; ....@.......,...
62C9  db 00 2C A6 12 12 13 00 0E 1D A4 12 12 13 00 0E 1D  ; .,..............
62D9  db A5 12 12 13 00 0E 1D 80 01 11 00 2C 05 13 2C 00  ; ...........,..,.
62E9  db 01 AC 46 0F 91 01 03 80 0D 15 89 01 12 0D 15 88  ; ..F.............
62F9  db 01 12 0D 15 8A 01 13 0D 15 82 01 13 0D 15 86 01  ; ................
6309  db 13 0D 15 84 01 13 0D 15 80 01 11 0D 15 05 12 22  ; ..............."
6319  db 00 01 B9 44 04 00 1C 0A 00 40 6C 46 8F 1E 00 1D  ; ...D.....@lF....
6329  db 00 00 40 28 47 8F 1E 6E 63 6E 63 6E 63 9F 63 D1  ; ..@(G..ncncnc.c.
6339  db 63 10 64 4D 64 7E 64 B4 64 F0 64 25 65 62 65 8C  ; c.dMd~d.d.d%ebe.
6349  db 65 A4 65 AC 65 EF 65 2E 66 7D 66 84 66 8B 66 92  ; e.e.e.e.f}f.f.f.
6359  db 66 99 66 A0 66 A7 66 B5 66 ED 66 B5 66 ED 66 61  ; f.f.f.f.f.f.f.fa
6369  db 67 6A 67 30 67 91 01 03 80 6D 15 85 01 12 6D 15  ; gjg0g....m....m.
6379  db 84 01 12 6D 15 86 01 13 6D 15 82 01 13 6D 15 8A  ; ...m....m....m..
6389  db 01 13 6D 15 88 01 13 6D 15 80 01 11 6D 15 05 03  ; ..m....m....m...
6399  db 82 00 01 EC 47 04 84 01 12 21 13 A6 12 13 12 00  ; ....G....!......
63A9  db 21 13 A2 12 13 12 00 21 13 AA 12 13 12 00 0D 13  ; !......!........
63B9  db 98 01 04 80 21 13 99 01 04 80 21 13 80 01 11 00  ; ....!.....!.....
63C9  db 35 05 12 35 00 00 55 48 A1 12 FF 13 0E 09 13 B5  ; 5..5..UH........
63D9  db 12 FF 05 40 0E 09 13 94 01 05 80 18 13 86 01 12  ; ...@............
63E9  db 00 2C 82 01 12 00 2C 8A 01 12 00 2C A8 12 12 13  ; .,....,....,....
63F9  db 0E 09 13 89 01 13 18 13 80 01 11 0E 1D 05 12 2C  ; ...............,
6409  db 00 21 80 48 18 19 05 81 01 12 1B 2F 85 01 0E 1B  ; .!.H......./....
6419  db 2F 84 01 0E 1B 2F A6 12 12 13 00 1B 2F A2 12 12  ; /..../....../...
6429  db 13 00 1B 2F AA 12 12 13 00 1B 2F 88 01 13 1B 2F  ; .../....../..../
6439  db 89 01 12 1B 2F B0 12 11 06 40 00 1B 2F 05 12 4A  ; ..../....@../..J
6449  db 00 00 A4 48 81 01 15 18 13 85 01 15 18 13 84 01  ; ...H............
6459  db 15 18 13 86 01 15 18 13 82 01 15 18 13 8A 01 15  ; ................
6469  db 18 13 89 01 15 18 13 90 01 07 80 18 13 06 15 2C  ; ...............,
6479  db 00 09 E0 48 08 81 01 15 16 27 95 01 08 80 16 27  ; ...H.....'.....'
6489  db 94 01 08 80 16 27 86 01 15 16 27 82 01 15 16 27  ; .....'....'....'
6499  db 8A 01 15 16 27 88 01 15 16 27 89 01 15 16 27 80  ; ....'....'....'.
64A9  db 01 15 16 27 06 15 3C 00 00 04 49 A1 12 FF 15 0E  ; ...'..<...I.....
64B9  db 0D 1A 85 01 15 1C 1A 84 01 15 1C 1A 86 01 15 00  ; ................
64C9  db 36 82 01 15 00 36 8A 01 15 00 36 D8 93 15 FF 09  ; 6....6....6.....
64D9  db 20 00 0E 0D 1A D9 93 15 FF 09 20 00 0E 0D 1A 06  ;  ......... .....
64E9  db 15 36 00 01 36 49 09 81 01 14 22 13 85 01 15 22  ; .6..6I...."...."
64F9  db 13 84 01 15 00 36 86 01 15 00 22 82 01 14 22 13  ; .....6...."...".
6509  db 8A 01 14 22 13 88 01 14 22 13 89 01 15 22 13 90  ; ..."...."...."..
6519  db 01 0A 80 22 13 06 15 36 00 00 62 49 A1 12 FF 15  ; ..."...6..bI....
6529  db 16 09 0C 85 01 15 20 0C A4 12 15 14 00 16 16 86  ; ...... .........
6539  db 01 15 16 16 A2 12 14 15 00 16 16 AA 12 14 15 00  ; ................
6549  db 16 16 88 01 14 00 2C 89 01 14 16 16 90 01 0B 80  ; ......,.........
6559  db 20 0C 06 15 2C 00 00 8E 49 81 01 12 1B 1B 85 01  ;  ...,...I.......
6569  db 12 1B 1B 84 01 12 1B 1B 86 01 12 1B 1B 88 01 12  ; ................
6579  db 1B 1B 89 01 12 1B 1B 80 01 0C 1B 1B 06 12 2E 00  ; ................
6589  db 00 B2 49 85 01 12 00 11 84 01 12 00 11 86 01 12  ; ..I.............
6599  db 00 11 06 0D 11 00 C0 DE 49 8F 1C 05 8F 47 00 01  ; ........I....G..
65A9  db EC 49 90 A1 12 12 13 00 0E 1D B5 12 FF 0F 40 00  ; .I............@.
65B9  db 0E 1D B4 12 FF 0F 40 00 0E 1D 86 01 12 00 2C 82  ; ......@.......,.
65C9  db 01 12 00 2C AA 12 12 13 00 0E 1D A8 12 12 13 00  ; ...,............
65D9  db 0E 1D A9 12 12 13 00 0E 1D 80 01 11 00 2C 05 13  ; .............,..
65E9  db 2C 00 05 2C 4A 0F 81 01 12 00 36 A5 12 FF 12 00  ; ,..,J.....6.....
65F9  db 0E 27 A4 12 FF 12 00 0E 27 86 01 12 00 36 82 01  ; .'......'....6..
6609  db 12 00 36 8A 01 12 00 36 B8 12 12 10 40 00 0E 27  ; ..6....6....@..'
6619  db B9 12 12 10 40 00 0E 27 80 01 11 00 36 05 12 36  ; ....@..'....6..6
6629  db 00 01 50 4A 10 C1 93 12 FF 12 00 0E 13 13 C5 93  ; ..PJ............
6639  db 12 FF 12 00 0E 13 13 C4 93 12 FF 12 00 0E 13 13  ; ................
6649  db 86 01 12 00 36 82 01 12 00 36 8A 01 12 00 36 C8  ; ....6....6....6.
6659  db 93 FF FF 12 00 0E 13 13 C9 93 FF FF 12 00 0E 13  ; ................
6669  db 13 C0 93 11 FF 0D 00 0E 13 13 05 12 2E 00 41 7C  ; ..............A|
6679  db 4A 8F 1D 10 10 16 2E 00 00 A8 4A 10 16 24 00 00  ; J.........J..$..
6689  db B0 4A 10 16 1F 00 00 D4 4A 10 16 29 00 00 F4 4A  ; .J......J..)...J
6699  db 10 16 1F 00 00 1C 4B 20 16 34 00 00 BB 47 20 17  ; ......K .4...G .
66A9  db 33 00 00 4F 38 00 1A FB FF 00 B4 48 81 01 15 18  ; 3..O8......H....
66B9  db 13 85 01 15 18 13 84 01 15 18 13 86 01 15 18 13  ; ................
66C9  db 82 01 15 18 13 8A 01 15 18 13 89 01 15 18 13 90  ; ................
66D9  db 01 07 80 18 13 06 15 2C 00 01 E0 48 08 00 1B 05  ; .......,...H....
66E9  db 00 00 AC 48 A1 12 12 13 00 0E 1D B5 12 FF 0F 40  ; ...H...........@
66F9  db 00 0E 1D B4 12 FF 0F 40 00 0E 1D 86 01 12 00 2C  ; .......@.......,
6709  db 82 01 12 00 2C AA 12 12 13 00 0E 1D A8 12 12 13  ; ....,...........
6719  db 00 0E 1D A9 12 12 13 00 0E 1D 80 01 11 00 2C 05  ; ..............,.
6729  db 13 2C 00 01 2C 4A 0F 91 01 03 80 0D 15 85 01 12  ; .,..,J..........
6739  db 0D 15 84 01 12 0D 15 86 01 13 0D 15 82 01 13 0D  ; ................
6749  db 15 8A 01 13 0D 15 88 01 13 0D 15 80 01 11 0D 15  ; ................
6759  db 05 12 22 00 01 39 48 04 00 1C 0A 00 40 EC 49 8E  ; .."..9H.....@.I.
6769  db 1E 00 1D 00 00 40 A8 4A 8E 1E AF 67 AF 67 AF 67  ; .....@.J...g.g.g
6779  db EB 67 2C 68 76 68 AC 68 F4 68 2A 69 55 69 5C 69  ; .g,hvh.h.h*iUi\i
6789  db C1 69 03 6A 52 6A 93 6A C6 6A 0A 6B 9B 6B 63 6B  ; .i.jRj.j.j.k.kck
6799  db 6A 6B 71 6B 78 6B 7F 6B 86 6B 8D 6B 94 6B A2 6B  ; jkqkxk.k.k.k.k.k
67A9  db DF 6B A9 6B E6 6B 81 01 12 5B 11 89 01 12 5B 11  ; .k.k.k...[....[.
67B9  db 88 01 12 5B 11 8A 01 12 5B 11 A2 12 15 12 49 12  ; ...[....[.....I.
67C9  db 11 A6 12 15 12 49 12 11 A4 12 15 12 49 12 11 85  ; .....I......I...
67D9  db 01 12 5B 11 90 01 03 80 56 16 06 12 6D 00 01 6C  ; ..[.....V...m..l
67E9  db 4B 03 91 01 04 80 22 13 89 01 14 22 13 88 01 14  ; K....."...."....
67F9  db 22 13 8A 01 14 22 13 82 01 15 22 13 A6 12 15 14  ; "...."....".....
6809  db 0E 13 13 C4 93 12 15 12 00 0E 13 13 B5 12 15 04  ; ................
6819  db 40 0E 13 13 80 01 14 22 13 06 14 36 00 21 C4 4B  ; @......"...6.!.K
6829  db 1A 1B 04 81 01 0A 31 27 89 01 13 31 27 C8 93 15  ; ......1'...1'...
6839  db FF 13 00 0E 22 27 CA 93 14 FF 13 00 0E 22 27 C2  ; ...."'......."'.
6849  db 93 14 FF 12 00 0E 22 27 C6 93 14 FF 12 00 0E 22  ; ......"'......."
6859  db 27 C4 93 15 FF 12 00 0E 22 27 85 01 15 31 27 90  ; '......."'...1'.
6869  db 01 05 80 31 27 06 13 59 00 01 F0 4B 0A 81 01 16  ; ...1'..Y...K....
6879  db 27 17 89 01 16 27 17 88 01 16 27 17 8A 01 16 27  ; '....'....'....'
6889  db 17 82 01 16 27 17 86 01 16 27 17 84 01 16 27 17  ; ....'....'....'.
6899  db 85 01 16 27 17 90 01 06 80 27 17 08 16 3F 00 09  ; ...'.....'...?..
68A9  db 38 4C 07 81 01 16 23 4A 89 01 16 23 4A 88 01 16  ; 8L....#J...#J...
68B9  db 23 4A AA 12 17 16 23 16 34 A2 12 17 16 23 3A 10  ; #J....#.4....#:.
68C9  db C6 93 FF 17 16 23 16 23 10 C4 93 FF FF 16 23 16  ; .....#.#......#.
68D9  db 23 10 C5 93 16 FF 16 23 16 23 10 B0 12 16 07 40  ; #......#.#.....@
68E9  db 3A 02 31 08 16 6E 00 01 6B 4C 05 81 01 15 36 12  ; :.1..n..kL....6.
68F9  db 89 01 14 36 12 88 01 14 36 12 8A 01 15 36 12 82  ; ...6....6....6..
6909  db 01 15 36 12 86 01 15 36 12 94 01 08 80 36 12 85  ; ..6....6.....6..
6919  db 01 15 36 12 80 01 14 36 12 08 14 49 00 01 C4 4C  ; ..6....6...I...L
6929  db 08 81 01 14 00 0B 89 01 14 00 0B 88 01 14 00 0B  ; ................
6939  db 8A 01 14 00 0B 82 01 14 00 0B 86 01 14 00 0B 85  ; ................
6949  db 01 14 00 0B 08 09 0B 00 81 FF 4C 09 06 91 15 00  ; ..........L.....
6959  db 00 08 4D A1 12 FF 12 00 0E 13 B1 12 15 0B 40 22  ; ..M...........@"
6969  db 0E 11 D9 93 12 15 0B 20 0E 13 0E 11 C8 93 13 FF  ; ....... ........
6979  db 12 00 0E 22 11 AA 12 12 FF 00 0E 13 8A 01 12 31  ; ..."...........1
6989  db 11 A2 12 12 FF 00 0E 13 82 01 12 31 11 A6 12 12  ; ...........1....
6999  db FF 00 0E 13 A6 12 15 12 22 0E 11 C4 93 13 FF 12  ; ........".......
69A9  db 00 0E 13 20 A5 12 13 12 00 0E 34 80 01 12 31 10  ; ... ......4...1.
69B9  db 06 12 42 00 05 20 4D 0A A1 12 FF 12 00 0C 20 A9  ; ..B.. M....... .
69C9  db 12 FF 12 00 0C 20 A8 12 15 12 00 1A 12 8A 01 15  ; ..... ..........
69D9  db 00 2C A2 12 12 15 00 0C 20 C6 93 12 FF 12 00 0C  ; .,...... .......
69E9  db 0D 12 B4 12 15 0C 40 00 1A 12 B5 12 15 0C 40 00  ; ......@.......@.
69F9  db 1A 12 06 12 2C 00 01 56 4D 0C C1 93 15 FF 12 00  ; ....,..VM.......
6A09  db 0C 1D 1B C9 93 12 15 12 00 0C 1D 1B C8 93 12 15  ; ................
6A19  db 12 00 0C 1D 1B CA 93 12 13 12 00 0C 1D 1B C2 93  ; ................
6A29  db 12 13 12 00 0C 1D 1B C6 93 15 13 12 00 0C 1D 1B  ; ................
6A39  db D4 93 15 12 0D 20 0C 1D 0E 0C A5 12 15 12 0C 1D  ; ..... ..........
6A49  db 1B 06 12 45 00 01 7A 4D 0C A1 12 15 14 00 1A 15  ; ...E..zM........
6A59  db B9 12 15 0E 40 00 1A 15 B8 12 15 0E 40 00 1A 15  ; ....@.......@...
6A69  db 8A 01 15 00 2F 82 01 15 00 2F A6 12 15 14 00 1A  ; ..../..../......
6A79  db 15 84 01 14 1A 15 A5 12 15 14 00 1A 15 80 01 0E  ; ................
6A89  db 1A 15 06 14 2F 00 01 B2 4D 09 81 01 15 00 2A 89  ; ..../...M.....*.
6A99  db 01 15 00 2A 88 01 15 00 2A 8A 01 15 00 2A 82 01  ; ...*....*....*..
6AA9  db 15 00 2A 86 01 15 00 2A B4 12 15 0F 40 00 18 11  ; ..*....*....@...
6AB9  db 85 01 15 00 2A 06 14 2A 00 01 D8 4D 09 A1 12 15  ; ....*..*...M....
6AC9  db 14 00 1D 0D 89 01 15 00 2B 88 01 15 00 2B AA 12  ; ........+....+..
6AD9  db 15 14 00 1D 0D A2 12 15 14 00 1D 0D A6 12 15 14  ; ................
6AE9  db 00 1D 0D A4 12 15 14 00 1D 0D A5 12 15 14 00 1D  ; ................
6AF9  db 0D B0 12 15 10 40 00 1D 0D 06 14 2B 00 01 FA 4D  ; .....@.....+...M
6B09  db 09 C1 93 14 FF 09 00 11 11 20 C9 93 15 FF 09 00  ; ......... ......
6B19  db 11 11 20 C8 93 15 FF 15 00 11 11 20 CA 93 14 FF  ; .. ........ ....
6B29  db 15 00 11 11 20 C2 93 14 FF 13 00 11 11 20 C6 93  ; .... ........ ..
6B39  db 14 FF 13 00 11 11 20 C4 93 14 FF 12 00 11 11 20  ; ...... ........ 
6B49  db C5 93 14 FF 09 00 11 11 20 C0 93 14 FF 13 00 11  ; ........ .......
6B59  db 11 20 06 13 3A 00 01 1D 4E 09 10 18 29 00 00 53  ; . ..:...N...)..S
6B69  db 4E 10 18 2E 00 00 7B 4E 10 18 24 00 00 A7 4E 10  ; N.....{N..$...N.
6B79  db 18 24 00 00 CB 4E 10 18 24 00 00 EF 4E 10 18 1F  ; .$...N..$...N...
6B89  db 00 00 13 4F 20 18 33 00 00 32 4F 20 19 33 00 00  ; ...O .3..2O .3..
6B99  db 87 40 03 91 33 00 00 F1 57 00 1C 28 00 00 F0 4B  ; .@..3...W..(...K
6BA9  db 81 01 16 22 17 89 01 16 22 17 88 01 16 22 17 8A  ; ..."...."...."..
6BB9  db 01 16 22 17 82 01 16 22 17 86 01 16 22 17 84 01  ; .."...."...."...
6BC9  db 16 22 17 85 01 16 22 17 90 01 06 80 22 17 08 16  ; ."...."....."...
6BD9  db 3A 00 01 3C 4C 07 00 1D 28 00 00 F0 4B A1 12 FF  ; :..<L...(...K...
6BE9  db 12 00 0E 13 B1 12 15 0B 40 22 0E 11 D9 93 12 15  ; ........@"......
6BF9  db 0B 20 0E 13 0E 11 C8 93 13 FF 12 00 0E 22 11 AA  ; . ..........."..
6C09  db 12 12 FF 00 0E 13 8A 01 12 31 11 A2 12 12 FF 00  ; .........1......
6C19  db 0E 13 82 01 12 31 11 A6 12 12 FF 00 0E 13 A6 12  ; .....1..........
6C29  db 15 12 22 0E 11 C4 93 13 FF 12 00 0E 13 20 A5 12  ; ..".......... ..
6C39  db 13 12 00 0E 34 80 01 12 31 10 06 12 42 00 01 20  ; ....4...1...B.. 
6C49  db 4D 0A 87 6C 87 6C 87 6C C3 6C 04 6D 4E 6D 84 6D  ; M..l.l.l.l.mNm.m
6C59  db CC 6D 02 6E 2D 6E 34 6E 99 6E DB 6E 2A 6F 6B 6F  ; .m.n-n4n.n.n*oko
6C69  db 9E 6F E2 6F 73 70 3B 70 42 70 49 70 50 70 57 70  ; .o.osp;pBpIpPpWp
6C79  db 5E 70 65 70 6C 70 7A 70 B7 70 81 70 BE 70 81 01  ; ^peplpzp.p.p.p..
6C89  db 12 5B 11 85 01 12 5B 11 84 01 12 5B 11 86 01 12  ; .[....[....[....
6C99  db 5B 11 A2 12 15 12 49 12 11 AA 12 15 12 49 12 11  ; [.....I......I..
6CA9  db A8 12 15 12 49 12 11 89 01 12 5B 11 90 01 03 80  ; ....I.....[.....
6CB9  db 56 16 06 12 6D 00 01 63 4F 03 91 01 04 80 22 13  ; V...m..cO.....".
6CC9  db 85 01 14 22 13 84 01 14 22 13 86 01 14 22 13 82  ; ..."...."...."..
6CD9  db 01 15 22 13 AA 12 15 14 0E 13 13 C8 93 12 15 12  ; ..".............
6CE9  db 00 0E 13 13 B9 12 15 04 40 0E 13 13 80 01 14 22  ; ........@......"
6CF9  db 13 06 14 36 00 21 BB 4F 1A 1B 04 81 01 0A 31 27  ; ...6.!.O......1'
6D09  db 85 01 13 31 27 C4 93 15 FF 13 00 0E 22 27 C6 93  ; ...1'......."'..
6D19  db 14 FF 13 00 0E 22 27 C2 93 14 FF 12 00 0E 22 27  ; ....."'......."'
6D29  db CA 93 14 FF 12 00 0E 22 27 C8 93 15 FF 12 00 0E  ; ......."'.......
6D39  db 22 27 89 01 15 31 27 90 01 05 80 31 27 06 13 59  ; "'...1'....1'..Y
6D49  db 00 01 E7 4F 0A 81 01 16 27 17 85 01 16 27 17 84  ; ...O....'....'..
6D59  db 01 16 27 17 86 01 16 27 17 82 01 16 27 17 8A 01  ; ..'....'....'...
6D69  db 16 27 17 88 01 16 27 17 89 01 16 27 17 90 01 06  ; .'....'....'....
6D79  db 80 27 17 08 16 3F 00 09 2F 50 07 81 01 16 23 4A  ; .'...?../P....#J
6D89  db 85 01 16 23 4A 84 01 16 23 4A A6 12 17 16 23 16  ; ...#J...#J....#.
6D99  db 34 A2 12 17 16 23 3A 10 CA 93 FF 17 16 23 16 23  ; 4....#:......#.#
6DA9  db 10 C8 93 FF FF 16 23 16 23 10 C9 93 16 FF 16 23  ; ......#.#......#
6DB9  db 16 23 10 B0 12 16 07 40 3A 02 31 08 16 6E 00 01  ; .#.....@:.1..n..
6DC9  db 62 50 05 81 01 15 36 12 85 01 14 36 12 84 01 14  ; bP....6....6....
6DD9  db 36 12 86 01 15 36 12 82 01 15 36 12 8A 01 15 36  ; 6....6....6....6
6DE9  db 12 98 01 08 80 36 12 89 01 15 36 12 80 01 14 36  ; .....6....6....6
6DF9  db 12 08 14 49 00 01 BB 50 08 81 01 14 00 0B 85 01  ; ...I...P........
6E09  db 14 00 0B 84 01 14 00 0B 86 01 14 00 0B 82 01 14  ; ................
6E19  db 00 0B 8A 01 14 00 0B 89 01 14 00 0B 08 09 0B 00  ; ................
6E29  db 81 F6 50 09 06 91 15 00 00 FF 50 A1 12 FF 12 00  ; ..P.......P.....
6E39  db 0E 13 B1 12 15 0B 40 22 0E 11 D5 93 12 15 0B 20  ; ......@"....... 
6E49  db 0E 13 0E 11 C4 93 13 FF 12 00 0E 22 11 A6 12 12  ; ..........."....
6E59  db FF 00 0E 13 86 01 12 31 11 A2 12 12 FF 00 0E 13  ; .......1........
6E69  db 82 01 12 31 11 AA 12 12 FF 00 0E 13 AA 12 15 12  ; ...1............
6E79  db 22 0E 11 C8 93 13 FF 12 00 0E 13 20 A9 12 13 12  ; ".......... ....
6E89  db 00 0E 34 80 01 12 31 10 06 12 42 00 05 17 51 0A  ; ..4...1...B...Q.
6E99  db A1 12 FF 12 00 0C 20 A5 12 FF 12 00 0C 20 A4 12  ; ...... ...... ..
6EA9  db 15 12 00 1A 12 86 01 15 00 2C A2 12 12 15 00 0C  ; .........,......
6EB9  db 20 CA 93 12 FF 12 00 0C 0D 12 B8 12 15 0C 40 00  ;  .............@.
6EC9  db 1A 12 B9 12 15 0C 40 00 1A 12 06 12 2C 00 01 4D  ; ......@.....,..M
6ED9  db 51 0C C1 93 15 FF 12 00 0C 1D 1B C5 93 12 15 12  ; Q...............
6EE9  db 00 0C 1D 1B C4 93 12 15 12 00 0C 1D 1B C6 93 12  ; ................
6EF9  db 13 12 00 0C 1D 1B C2 93 12 13 12 00 0C 1D 1B CA  ; ................
6F09  db 93 15 13 12 00 0C 1D 1B D8 93 15 12 0D 20 0C 1D  ; ............. ..
6F19  db 0E 0C A9 12 15 12 0C 1D 1B 06 12 45 00 01 71 51  ; ...........E..qQ
6F29  db 0C A1 12 15 14 00 1A 15 B5 12 15 0E 40 00 1A 15  ; ............@...
6F39  db B4 12 15 0E 40 00 1A 15 86 01 15 00 2F 82 01 15  ; ....@......./...
6F49  db 00 2F AA 12 15 14 00 1A 15 88 01 14 1A 15 A9 12  ; ./..............
6F59  db 15 14 00 1A 15 80 01 0E 1A 15 06 14 2F 00 01 A9  ; ............/...
6F69  db 51 09 81 01 15 00 2A 85 01 15 00 2A 84 01 15 00  ; Q.....*....*....
6F79  db 2A 86 01 15 00 2A 82 01 15 00 2A 8A 01 15 00 2A  ; *....*....*....*
6F89  db B8 12 15 0F 40 00 18 11 89 01 15 00 2A 06 14 2A  ; ....@.......*..*
6F99  db 00 01 CF 51 09 A1 12 15 14 00 1D 0D 85 01 15 00  ; ...Q............
6FA9  db 2B 84 01 15 00 2B A6 12 15 14 00 1D 0D A2 12 15  ; +....+..........
6FB9  db 14 00 1D 0D AA 12 15 14 00 1D 0D A8 12 15 14 00  ; ................
6FC9  db 1D 0D A9 12 15 14 00 1D 0D B0 12 15 10 40 00 1D  ; .............@..
6FD9  db 0D 06 14 2B 00 01 F1 51 09 C1 93 14 FF 09 00 11  ; ...+...Q........
6FE9  db 11 20 C5 93 15 FF 09 00 11 11 20 C4 93 15 FF 15  ; . ........ .....
6FF9  db 00 11 11 20 C6 93 14 FF 15 00 11 11 20 C2 93 14  ; ... ........ ...
7009  db FF 13 00 11 11 20 CA 93 14 FF 13 00 11 11 20 C8  ; ..... ........ .
7019  db 93 14 FF 12 00 11 11 20 C9 93 14 FF 09 00 11 11  ; ....... ........
7029  db 20 C0 93 14 FF 13 00 11 11 20 06 13 3A 00 01 14  ;  ........ ..:...
7039  db 52 09 10 18 29 00 00 4A 52 10 18 2E 00 00 72 52  ; R...)..JR.....rR
7049  db 10 18 24 00 00 9E 52 10 18 24 00 00 C2 52 10 18  ; ..$...R..$...R..
7059  db 24 00 00 E6 52 10 18 1F 00 00 0A 53 20 18 33 00  ; $...R......S .3.
7069  db 00 32 4F 20 19 33 00 00 87 40 03 91 33 00 00 F1  ; .2O .3...@..3...
7079  db 57 00 1C 28 00 00 E7 4F 81 01 16 22 17 85 01 16  ; W..(...O..."....
7089  db 22 17 84 01 16 22 17 86 01 16 22 17 82 01 16 22  ; "...."...."...."
7099  db 17 8A 01 16 22 17 88 01 16 22 17 89 01 16 22 17  ; ...."...."....".
70A9  db 90 01 06 80 22 17 08 16 3A 00 01 33 50 07 00 1D  ; ...."...:..3P...
70B9  db 28 00 00 E7 4F A1 12 FF 12 00 0E 13 B1 12 15 0B  ; (...O...........
70C9  db 40 22 0E 11 D5 93 12 15 0B 20 0E 13 0E 11 C4 93  ; @"....... ......
70D9  db 13 FF 12 00 0E 22 11 A6 12 12 FF 00 0E 13 86 01  ; ....."..........
70E9  db 12 31 11 A2 12 12 FF 00 0E 13 82 01 12 31 11 AA  ; .1...........1..
70F9  db 12 12 FF 00 0E 13 AA 12 15 12 22 0E 11 C8 93 13  ; ..........".....
7109  db FF 12 00 0E 13 20 A9 12 13 12 00 0E 34 80 01 12  ; ..... ......4...
7119  db 31 10 06 12 42 00 01 17 51 0A 6B 71 6B 71 6B 71  ; 1...B...Q.kqkqkq
7129  db 85 71 BB 71 F3 71 29 72 60 72 AA 72 F6 72 2B 73  ; .q.q.q)r`r.r.r+s
7139  db 69 73 9F 73 D4 73 14 74 52 74 92 74 C9 74 F6 74  ; is.s.s.tRt.t.t.t
7149  db 37 75 67 75 6E 75 75 75 7C 75 83 75 8A 75 91 75  ; 7ugunuuu|u.u.u.u
7159  db 98 75 9F 75 A6 75 B4 75 AD 75 BB 75 F9 75 C2 75  ; .u.u.u.u.u.u.u.u
7169  db 00 76 98 01 03 80 3B 10 9A 01 03 80 3B 10 92 01  ; .v....;.....;...
7179  db 03 80 3B 10 05 15 4B 00 01 5A 53 03 81 01 19 4E  ; ..;...K..ZS....N
7189  db 13 89 01 19 4E 13 88 01 19 4E 13 8A 01 19 4E 13  ; ....N....N....N.
7199  db 82 01 19 4E 13 86 01 19 4E 13 84 01 19 4E 13 85  ; ...N....N....N..
71A9  db 01 19 4E 13 90 01 04 80 4E 13 05 19 61 00 01 97  ; ..N.....N...a...
71B9  db 53 04 81 01 16 1D 1A 89 01 16 1D 1A 98 01 05 80  ; S...............
71C9  db 1D 1A 8A 01 16 1D 1A 82 01 16 1D 1A 86 01 16 1D  ; ................
71D9  db 1A 84 01 16 1D 1A 85 01 16 1D 1A 80 01 16 1D 1A  ; ................
71E9  db 05 16 37 00 21 E6 53 20 21 05 81 01 17 30 18 89  ; ..7.!.S !....0..
71F9  db 01 17 30 18 88 01 17 30 18 8A 01 17 30 18 82 01  ; ..0....0....0...
7209  db 11 30 18 86 01 17 30 18 84 01 17 30 18 85 01 17  ; .0....0....0....
7219  db 30 18 90 01 06 80 30 18 05 11 42 00 01 13 54 11  ; 0.....0...B...T.
7229  db 81 01 1B 13 27 89 01 1B 13 27 88 01 1B 13 27 8A  ; ....'....'....'.
7239  db 01 1B 13 27 82 01 1B 13 27 86 01 1B 13 27 94 01  ; ...'....'....'..
7249  db 07 80 13 27 95 01 07 80 13 27 80 01 1A 13 27 09  ; ...'.....'....'.
7259  db 1A 3B 00 09 4E 54 07 C1 93 1B FF 1B 00 0E 13 16  ; .;..NT..........
7269  db C9 93 1B FF 1B 00 0E 13 16 88 01 1B 00 22 8A 01  ; ............."..
7279  db 1B 00 39 82 01 1B 00 39 86 01 1B 00 39 C4 93 1B  ; ..9....9....9...
7289  db FF 1C 00 0E 13 16 C5 93 1B FF 1C 00 0E 13 16 D0  ; ................
7299  db 93 1B 1A 08 20 00 0E 13 16 09 1C 39 00 01 7E 54  ; .... ......9..~T
72A9  db 10 C1 93 1B FF 1C 00 0C 16 15 D9 93 1B FF 09 20  ; ............... 
72B9  db 00 0C 16 15 D8 93 1B FF 09 20 00 0C 16 15 8A 01  ; ......... ......
72C9  db 1B 00 37 A2 12 1B 1C 00 22 15 A6 12 1B 1C 00 22  ; ..7....."......"
72D9  db 15 C4 93 1C 1B 1C 00 0C 16 15 A5 12 1B 1C 00 22  ; ..............."
72E9  db 15 80 01 1B 0C 16 09 1C 37 00 00 AC 54 81 01 1B  ; ........7...T...
72F9  db 0B 2A 89 01 1C 0B 2A 88 01 1C 0B 2A 8A 01 1B 0B  ; .*....*....*....
7309  db 2A 82 01 1B 0B 2A 86 01 1C 0B 2A 84 01 1C 0B 2A  ; *....*....*....*
7319  db 85 01 1C 0B 2A 90 01 0A 80 1F 16 09 1C 35 00 00  ; ....*........5..
7329  db D9 54 81 01 1B 16 25 89 01 1B 16 25 88 01 1B 16  ; .T....%....%....
7339  db 13 8A 01 1B 16 25 B2 12 1B 0B 40 16 13 11 B6 12  ; .....%....@.....
7349  db 1C 0B 40 16 13 11 A4 12 1C 1B 16 13 11 A5 12 1C  ; ..@.............
7359  db 1B 16 13 11 80 01 1A 2A 11 09 1A 3B 00 00 04 55  ; .......*...;...U
7369  db 81 01 1A 11 11 89 01 1B 11 11 88 01 1B 11 11 8A  ; ................
7379  db 01 1B 11 11 82 01 1B 11 11 96 01 0C 80 11 11 94  ; ................
7389  db 01 0C 80 11 11 85 01 1A 11 11 80 01 1A 11 11 09  ; ................
7399  db 1A 22 00 00 34 55 81 01 1A 0D 0D 89 01 1B 1B 18  ; ."..4U..........
73A9  db 88 01 1B 1B 18 8A 01 1B 0D 26 82 01 1B 0D 26 B6  ; .........&....&.
73B9  db 12 1B 0D 40 0D 0D 18 B4 12 1B 0D 40 0D 0D 18 80  ; ...@.......@....
73C9  db 01 1A 1B 18 09 1A 34 00 00 50 55 91 01 0E 80 1D  ; ......4..PU.....
73D9  db 13 B9 12 1B 0E 40 13 09 13 A8 12 FF 1B 13 09 13  ; .....@..........
73E9  db AA 12 FF 1B 13 09 13 A2 12 FF 1B 13 09 13 86 01  ; ................
73F9  db 1B 13 1D 84 01 1B 13 09 85 01 1B 13 09 A0 12 1B  ; ................
7409  db 1A 13 09 13 09 1A 31 00 00 7A 55 81 01 1B 09 27  ; ......1..zU....'
7419  db 89 01 1B 09 27 B8 12 FF 0F 40 09 09 1D BA 12 1B  ; ....'....@......
7429  db 0F 40 09 09 1D 82 01 1B 09 27 86 01 1B 09 27 84  ; .@.......'....'.
7439  db 01 1D 13 1D A5 12 1B 1D 09 09 1D A0 12 1B 1D 09  ; ................
7449  db 09 1D 09 1D 31 00 00 A2 55 B1 12 1B 10 40 00 16  ; ....1...U....@..
7459  db 13 B9 12 1B 10 40 00 16 13 A8 12 FF 1D 00 16 13  ; .....@..........
7469  db CA 93 1B FF 1B 00 0E 07 13 82 01 1B 00 2A 86 01  ; .............*..
7479  db 1B 00 2A 84 01 1D 00 2A 85 01 1D 00 2A 80 01 1D  ; ..*....*....*...
7489  db 00 2A 09 1D 2A 00 00 CA 55 81 01 FF 00 20 A9 12  ; .*..*...U.... ..
7499  db FF 1B 00 0C 13 88 01 1B 00 20 8A 01 1B 00 20 82  ; ......... .... .
74A9  db 01 1D 00 20 86 01 1B 00 20 84 01 1B 00 20 85 01  ; ... .... .... ..
74B9  db 1B 00 20 80 01 1B 00 20 09 94 67 00 01 EC 55 94  ; .. .... ..g...U.
74C9  db 99 01 12 80 31 16 98 01 12 80 31 16 8A 01 17 31  ; ....1.....1....1
74D9  db 16 82 01 17 31 16 86 01 17 31 16 84 01 17 31 16  ; ....1....1....1.
74E9  db 80 01 16 31 16 05 16 47 00 05 46 56 13 81 01 16  ; ...1...G..FV....
74F9  db 07 20 B9 12 FF 13 40 00 07 20 B8 12 FF 13 40 00  ; . ....@.. ....@.
7509  db 07 20 AA 12 16 18 00 07 20 A2 12 17 16 00 07 20  ; . ...... ...... 
7519  db A6 12 17 16 00 07 20 84 01 16 00 27 85 01 16 07  ; ...... ....'....
7529  db 20 80 01 16 00 27 05 16 27 00 01 80 56 13 89 01  ;  ....'..'...V...
7539  db FF 00 0C 88 01 FF 00 0C 8A 01 18 00 0C 82 01 18  ; ................
7549  db 00 0C 86 01 16 00 0C 84 01 16 00 0C 85 01 16 00  ; ................
7559  db 0C 80 01 16 00 0C 05 93 18 00 01 A0 56 94 00 93  ; ............V...
7569  db 33 00 00 89 63 10 1E 1F 00 00 BA 56 10 1E 1F 00  ; 3...c......V....
7579  db 00 DA 56 10 1E 1F 00 00 FA 56 10 1E 24 00 00 1A  ; ..V......V..$...
7589  db 57 10 1E 06 00 00 3E 57 10 1E 31 00 00 4A 57 10  ; W.....>W..1..JW.
7599  db 1E 1F 00 00 78 57 10 1E 2E 00 00 98 57 10 1E 31  ; ....xW......W..1
75A9  db 00 00 C4 57 20 1E 34 00 00 F1 57 20 1F 33 00 00  ; ...W .4...W .3..
75B9  db 89 63 00 22 1D 00 00 1B 54 81 01 1B 13 27 89 01  ; .c."....T....'..
75C9  db 1B 13 27 88 01 1B 13 27 8A 01 1B 13 27 82 01 1B  ; ..'....'....'...
75D9  db 13 27 86 01 1B 13 27 94 01 07 80 13 27 95 01 07  ; .'....'.....'...
75E9  db 80 13 27 80 01 1A 13 27 09 1A 3B 00 01 4E 54 07  ; ..'....'..;..NT.
75F9  db 00 23 1D 00 00 1B 54 99 01 12 80 31 16 98 01 12  ; .#....T....1....
7609  db 80 31 16 8A 01 17 31 16 82 01 17 31 16 86 01 17  ; .1....1....1....
7619  db 31 16 84 01 17 31 16 80 01 16 31 16 05 16 47 00  ; 1....1....1...G.
7629  db 01 46 56 12 75 76 75 76 75 76 8F 76 C5 76 FD 76  ; .FV.uvuvuv.v.v.v
7639  db 33 77 6A 77 B4 77 00 78 35 78 73 78 A9 78 DE 78  ; 3wjw.w.x5xsx.x.x
7649  db 1E 79 5C 79 9C 79 D3 79 00 7A 41 7A 71 7A 78 7A  ; .y\y.y.y.zAzqzxz
7659  db 7F 7A 86 7A 8D 7A 94 7A 9B 7A A2 7A A9 7A B0 7A  ; .z.z.z.z.z.z.z.z
7669  db BE 7A B7 7A C5 7A 03 7B CC 7A 0A 7B 94 01 03 80  ; .z.z.z.{.z.{....
7679  db 3B 10 96 01 03 80 3B 10 92 01 03 80 3B 10 05 15  ; ;.....;.....;...
7689  db 4B 00 01 22 58 03 81 01 19 4E 13 85 01 19 4E 13  ; K.."X....N....N.
7699  db 84 01 19 4E 13 86 01 19 4E 13 82 01 19 4E 13 8A  ; ...N....N....N..
76A9  db 01 19 4E 13 88 01 19 4E 13 89 01 19 4E 13 90 01  ; ..N....N....N...
76B9  db 04 80 4E 13 05 19 61 00 01 5F 58 04 81 01 16 1D  ; ..N...a.._X.....
76C9  db 1A 85 01 16 1D 1A 94 01 05 80 1D 1A 86 01 16 1D  ; ................
76D9  db 1A 82 01 16 1D 1A 8A 01 16 1D 1A 88 01 16 1D 1A  ; ................
76E9  db 89 01 16 1D 1A 80 01 16 1D 1A 05 16 37 00 21 AE  ; ............7.!.
76F9  db 58 20 21 05 81 01 17 30 18 85 01 17 30 18 84 01  ; X !....0....0...
7709  db 17 30 18 86 01 17 30 18 82 01 11 30 18 8A 01 17  ; .0....0....0....
7719  db 30 18 88 01 17 30 18 89 01 17 30 18 90 01 06 80  ; 0....0....0.....
7729  db 30 18 05 11 42 00 01 DB 58 11 81 01 1B 13 27 85  ; 0...B...X.....'.
7739  db 01 1B 13 27 84 01 1B 13 27 86 01 1B 13 27 82 01  ; ...'....'....'..
7749  db 1B 13 27 8A 01 1B 13 27 98 01 07 80 13 27 99 01  ; ..'....'.....'..
7759  db 07 80 13 27 80 01 1A 13 27 09 1A 3B 00 09 16 59  ; ...'....'..;...Y
7769  db 07 C1 93 1B FF 1B 00 0E 13 16 C5 93 1B FF 1B 00  ; ................
7779  db 0E 13 16 84 01 1B 00 22 86 01 1B 00 39 82 01 1B  ; ......."....9...
7789  db 00 39 8A 01 1B 00 39 C8 93 1B FF 1C 00 0E 13 16  ; .9....9.........
7799  db C9 93 1B FF 1C 00 0E 13 16 D0 93 1B 1A 08 20 00  ; .............. .
77A9  db 0E 13 16 09 1C 39 00 01 46 59 10 C1 93 1B FF 1C  ; .....9..FY......
77B9  db 00 0C 16 15 D5 93 1B FF 09 20 00 0C 16 15 D4 93  ; ......... ......
77C9  db 1B FF 09 20 00 0C 16 15 86 01 1B 00 37 A2 12 1B  ; ... ........7...
77D9  db 1C 00 22 15 AA 12 1B 1C 00 22 15 C8 93 1C 1B 1C  ; .."......"......
77E9  db 00 0C 16 15 A9 12 1B 1C 00 22 15 80 01 1B 0C 16  ; ........."......
77F9  db 09 1C 37 00 00 74 59 81 01 1B 0B 2A 85 01 1C 0B  ; ..7..tY....*....
7809  db 2A 84 01 1C 0B 2A 86 01 1B 0B 2A 82 01 1B 0B 2A  ; *....*....*....*
7819  db 8A 01 1C 0B 2A 88 01 1C 0B 2A 89 01 1C 0B 2A 90  ; ....*....*....*.
7829  db 01 0A 80 1F 16 09 1C 35 00 00 A1 59 81 01 1B 16  ; .......5...Y....
7839  db 25 85 01 1B 16 25 84 01 1B 16 13 86 01 1B 16 25  ; %....%.........%
7849  db B2 12 1B 0B 40 16 13 11 BA 12 1C 0B 40 16 13 11  ; ....@.......@...
7859  db A8 12 1C 1B 16 13 11 A9 12 1C 1B 16 13 11 80 01  ; ................
7869  db 1A 2A 11 09 1A 3B 00 00 CC 59 81 01 1A 11 11 85  ; .*...;...Y......
7879  db 01 1B 11 11 84 01 1B 11 11 86 01 1B 11 11 82 01  ; ................
7889  db 1B 11 11 9A 01 0C 80 11 11 98 01 0C 80 11 11 89  ; ................
7899  db 01 1A 11 11 80 01 1A 11 11 09 1A 22 00 00 FC 59  ; ..........."...Y
78A9  db 81 01 1A 0D 0D 85 01 1B 1B 18 84 01 1B 1B 18 86  ; ................
78B9  db 01 1B 0D 26 82 01 1B 0D 26 BA 12 1B 0D 40 0D 0D  ; ...&....&....@..
78C9  db 18 B8 12 1B 0D 40 0D 0D 18 80 01 1A 1B 18 09 1A  ; .....@..........
78D9  db 34 00 00 18 5A 91 01 0E 80 1D 13 B5 12 1B 0E 40  ; 4...Z..........@
78E9  db 13 09 13 A4 12 FF 1B 13 09 13 A6 12 FF 1B 13 09  ; ................
78F9  db 13 A2 12 FF 1B 13 09 13 8A 01 1B 13 1D 88 01 1B  ; ................
7909  db 13 09 89 01 1B 13 09 A0 12 1B 1A 13 09 13 09 1A  ; ................
7919  db 31 00 00 42 5A 81 01 1B 09 27 85 01 1B 09 27 B4  ; 1..BZ....'....'.
7929  db 12 FF 0F 40 09 09 1D B6 12 1B 0F 40 09 09 1D 82  ; ...@.......@....
7939  db 01 1B 09 27 8A 01 1B 09 27 88 01 1D 13 1D A9 12  ; ...'....'.......
7949  db 1B 1D 09 09 1D A0 12 1B 1D 09 09 1D 09 1D 31 00  ; ..............1.
7959  db 00 6A 5A B1 12 1B 10 40 00 16 13 B5 12 1B 10 40  ; .jZ....@.......@
7969  db 00 16 13 A4 12 FF 1D 00 16 13 C6 93 1B FF 1B 00  ; ................
7979  db 0E 07 13 82 01 1B 00 2A 8A 01 1B 00 2A 88 01 1D  ; .......*....*...
7989  db 00 2A 89 01 1D 00 2A 80 01 1D 00 2A 09 1D 2A 00  ; .*....*....*..*.
7999  db 00 92 5A 81 01 FF 00 20 A5 12 FF 1B 00 0C 13 84  ; ..Z.... ........
79A9  db 01 1B 00 20 86 01 1B 00 20 82 01 1D 00 20 8A 01  ; ... .... .... ..
79B9  db 1B 00 20 88 01 1B 00 20 89 01 1B 00 20 80 01 1B  ; .. .... .... ...
79C9  db 00 20 09 94 67 00 01 B4 5A 94 95 01 12 80 31 16  ; . ..g...Z.....1.
79D9  db 94 01 12 80 31 16 86 01 17 31 16 82 01 17 31 16  ; ....1....1....1.
79E9  db 8A 01 17 31 16 88 01 17 31 16 80 01 16 31 16 05  ; ...1....1....1..
79F9  db 16 47 00 05 0E 5B 13 81 01 16 07 20 B5 12 FF 13  ; .G...[..... ....
7A09  db 40 00 07 20 B4 12 FF 13 40 00 07 20 A6 12 16 18  ; @.. ....@.. ....
7A19  db 00 07 20 A2 12 17 16 00 07 20 AA 12 17 16 00 07  ; .. ...... ......
7A29  db 20 88 01 16 00 27 89 01 16 07 20 80 01 16 00 27  ;  ....'.... ....'
7A39  db 05 16 27 00 01 48 5B 13 85 01 FF 00 0C 84 01 FF  ; ..'..H[.........
7A49  db 00 0C 86 01 18 00 0C 82 01 18 00 0C 8A 01 16 00  ; ................
7A59  db 0C 88 01 16 00 0C 89 01 16 00 0C 80 01 16 00 0C  ; ................
7A69  db 05 93 18 00 01 68 5B 94 00 93 33 00 00 89 63 10  ; .....h[...3...c.
7A79  db 1E 1F 00 00 82 5B 10 1E 1F 00 00 A2 5B 10 1E 1F  ; .....[......[...
7A89  db 00 00 C2 5B 10 1E 24 00 00 E2 5B 10 1E 06 00 00  ; ...[..$...[.....
7A99  db 06 5C 10 1E 31 00 00 12 5C 10 1E 1F 00 00 40 5C  ; .\..1...\.....@\
7AA9  db 10 1E 2E 00 00 60 5C 10 1E 31 00 00 8C 5C 20 1E  ; .....`\..1...\ .
7AB9  db 34 00 00 F1 57 20 1F 33 00 00 89 63 00 22 1D 00  ; 4...W .3...c."..
7AC9  db 00 E3 58 81 01 1B 13 27 85 01 1B 13 27 84 01 1B  ; ..X....'....'...
7AD9  db 13 27 86 01 1B 13 27 82 01 1B 13 27 8A 01 1B 13  ; .'....'....'....
7AE9  db 27 98 01 07 80 13 27 99 01 07 80 13 27 80 01 1A  ; '.....'.....'...
7AF9  db 13 27 09 1A 3B 00 01 16 59 07 00 23 1D 00 00 E3  ; .'..;...Y..#....
7B09  db 58 95 01 12 80 31 16 94 01 12 80 31 16 86 01 17  ; X....1.....1....
7B19  db 31 16 82 01 17 31 16 8A 01 17 31 16 88 01 17 31  ; 1....1....1....1
7B29  db 16 80 01 16 31 16 05 16 47 00 01 0E 5B 12 7B 7B  ; ....1...G...[.{{
7B39  db 7B 7B 7B 7B AC 7B F9 7B 2F 7C 76 7C AC 7C E1 7C  ; {{{{.{.{/|v|.|.|
7B49  db 03 7D 34 7D 76 7D A7 7D DE 7D 16 7E 6A 7E 87 7E  ; .}4}v}.}.}.~j~.~
7B59  db B8 7E E1 7E 19 7F 41 7F 5D 7F A9 7F CA 7F D1 7F  ; .~.~..A.].......
7B69  db D8 7F DF 7F E6 7F ED 7F F4 7F FB 7F 02 80 10 80  ; ................
7B79  db 09 80 81 01 18 99 18 89 01 18 99 18 88 01 18 99  ; ................
7B89  db 18 8A 01 18 99 18 82 01 18 99 18 86 01 18 99 18  ; ................
7B99  db 94 01 03 80 99 18 85 01 18 99 18 09 18 B2 00 01  ; ................
7BA9  db EA 5C 03 C1 93 1A FF 17 00 13 22 1F C9 93 1A FF  ; .\........".....
7BB9  db 17 00 13 22 1F B8 12 1A 04 40 00 36 1F BA 12 1A  ; ...".....@.6....
7BC9  db 04 40 00 36 1F C2 93 1A FF 17 00 13 22 1F A6 12  ; .@.6........"...
7BD9  db 1A 17 00 36 1F A4 12 1A 17 00 36 1F A5 12 1A 17  ; ...6......6.....
7BE9  db 00 36 1F 80 01 17 36 1F 09 17 55 00 01 7A 5D 03  ; .6....6...U..z].
7BF9  db 81 01 19 1C 12 89 01 19 1C 12 88 01 19 1C 12 8A  ; ................
7C09  db 01 19 1C 12 82 01 19 1C 12 86 01 19 1C 12 84 01  ; ................
7C19  db 19 1C 12 85 01 19 1C 12 90 01 05 80 1C 12 09 19  ; ................
7C29  db 2F 00 01 BF 5D 04 81 01 15 3E 17 89 01 15 3E 17  ; /...]....>....>.
7C39  db A8 12 FF 1A 21 0E 25 AA 12 1A 15 30 0D 17 A2 12  ; ....!.%....0....
7C49  db FF FF 12 0E 0E A2 12 1A 15 30 0D 17 A6 12 1A 15  ; .........0......
7C59  db 30 0D 17 84 01 1A 30 25 85 01 1A 30 25 B0 12 1A  ; 0.....0%...0%...
7C69  db 06 40 30 0D 17 09 15 54 00 01 E5 5D 15 81 01 1C  ; .@0....T...]....
7C79  db 63 12 89 01 1C 63 12 88 01 1C 63 12 8A 01 1C 63  ; c....c....c....c
7C89  db 12 82 01 1C 63 12 86 01 1C 63 12 84 01 1C 63 12  ; ....c....c....c.
7C99  db 85 01 1C 63 12 90 01 07 80 63 12 0B 1C 75 00 01  ; ...c.....c...u..
7CA9  db 2A 5E 08 81 01 1C 2B 18 89 01 1C 2B 18 88 01 1C  ; *^....+....+....
7CB9  db 2B 18 8A 01 1C 2B 18 82 01 1C 2B 18 86 01 1C 2B  ; +....+....+....+
7CC9  db 18 84 01 1C 2B 18 85 01 1C 2B 18 90 01 08 80 2B  ; ....+....+.....+
7CD9  db 18 0B 1C 44 00 00 89 5E 98 01 09 80 3A 13 82 01  ; ...D...^....:...
7CE9  db 1C 3A 13 86 01 1C 3A 13 84 01 1C 3A 13 85 01 1C  ; .:....:....:....
7CF9  db 3A 13 0B 1C 4E 00 01 C0 5E 09 81 01 1F 49 22 A9  ; :...N...^....I".
7D09  db 12 FF 1F 0D 3B 22 A8 12 FF 1F 0D 3B 22 92 01 0A  ; ....;".....;"...
7D19  db 80 49 22 96 01 0A 80 49 22 84 01 1F 49 22 85 01  ; .I"....I"...I"..
7D29  db 1F 49 22 0B 1F 6B 00 01 FF 5E 13 A1 12 1F 1D 00  ; .I"..k...^......
7D39  db 13 13 B9 12 1F 0B 40 00 13 13 B8 12 1F 0B 40 00  ; ......@.......@.
7D49  db 13 13 AA 12 FF 1D 00 13 13 A2 12 FF 1D 00 13 13  ; ................
7D59  db A6 12 FF 1D 00 13 13 A4 12 1F 1D 00 13 13 A5 12  ; ................
7D69  db 1F 1D 00 13 13 0B 1D 27 00 01 56 5F 0B 81 01 1E  ; .......'..V_....
7D79  db 13 1D 89 01 1E 13 1D 8A 01 1E 13 1D 82 01 1E 13  ; ................
7D89  db 1D 86 01 1E 13 1D 84 01 1E 13 1D 85 01 1E 13 1D  ; ................
7D99  db 90 01 0C 80 13 1D 0B 1E 31 00 01 76 5F 0D 81 01  ; ........1..v_...
7DA9  db 1E 00 3B 89 01 1E 00 3B 88 01 FF 00 23 8A 01 1E  ; ..;....;....#...
7DB9  db 00 3B 82 01 1E 00 3B 86 01 1E 00 3B 84 01 1E 00  ; .;....;....;....
7DC9  db 3B 85 01 1E 00 3B B0 12 1E 0D 40 00 23 17 0B 1E  ; ;....;....@.#...
7DD9  db 3B 00 00 9E 5F 81 01 1E 00 42 89 01 1E 00 42 88  ; ;..._....B....B.
7DE9  db 01 FF 00 22 8A 01 1E 00 42 82 01 1E 00 42 86 01  ; ..."....B....B..
7DF9  db 1E 00 42 84 01 1E 00 42 85 01 1E 00 42 B0 12 1E  ; ..B....B....B...
7E09  db 0E 40 00 22 20 0B 1E 42 00 01 CE 5F 0F C1 93 1E  ; .@." ..B..._....
7E19  db FF 1F 00 2F 21 16 C9 93 1E FF 1F 00 16 3A 16 D8  ; .../!........:..
7E29  db 93 FF FF 0F 20 00 16 3A 16 DA 93 1E FF 0F 20 00  ; .... ..:...... .
7E39  db 16 3A 16 A2 12 1E FF 00 16 18 82 01 1F 50 16 C6  ; .:...........P..
7E49  db 93 1E FF 1F 00 16 3A 16 C4 93 1E FF 1F 00 16 3A  ; ......:........:
7E59  db 16 C5 93 1E FF 1F 00 16 3A 16 0B 1F 66 00 00 04  ; ........:...f...
7E69  db 60 81 01 1D 1A 13 89 01 1D 1A 13 85 01 1D 1A 13  ; `...............
7E79  db 90 01 10 80 1A 13 0B 1D 2D 00 01 57 60 11 81 01  ; ........-..W`...
7E89  db 1F 0C 45 89 01 1F 0C 45 8A 01 1F 39 18 D2 93 FF  ; ..E....E...9....
7E99  db FF 11 20 00 0C 2C 18 96 01 11 80 39 18 94 01 11  ; .. ..,.....9....
7EA9  db 80 39 18 85 01 1F 39 18 0B 1F 51 00 00 7C 60 81  ; .9....9...Q..|`.
7EB9  db 01 1F 3B 3B 89 01 1F 3B 3B 98 01 12 80 5E 18 9A  ; ..;;...;;....^..
7EC9  db 01 12 80 5E 18 92 01 12 80 5E 18 85 01 1F 3B 3B  ; ...^.....^....;;
7ED9  db 0B 1F 77 00 01 BE 60 13 81 01 1F 00 0E 89 01 1F  ; ..w...`.........
7EE9  db 00 0E B8 12 FF 13 40 00 0E 1D BA 12 FF 13 40 00  ; ......@.......@.
7EF9  db 0E 1D B2 12 1F 13 40 00 0E 1D 86 01 1F 00 2C 84  ; ......@.......,.
7F09  db 01 1F 00 0E 85 01 1F 00 0E 0B 1F 2C 00 00 1E 61  ; ...........,...a
7F19  db 8A 01 FF 0E 6A 82 01 FF 0E 6A A6 12 1F FF 00 0E  ; ....j....j......
7F29  db 6A 84 01 1F 00 0E 85 01 1F 00 0E 80 01 FF 0E 2F  ; j............../
7F39  db 0B 14 71 00 01 42 61 14 81 01 FF 0E 13 8A 01 FF  ; ..q..Ba.........
7F49  db 00 0E 82 01 FF 00 0E 85 01 FF 0E 13 09 95 1A 00  ; ................
7F59  db 01 A4 61 96 81 01 1A 11 13 C9 93 1A FF 1A 11 13  ; ..a.............
7F69  db 3B 12 C8 93 1A FF 1A 11 13 3B 12 DA 93 FF FF 1A  ; ;........;......
7F79  db 80 11 13 3B 12 92 01 FF 80 11 13 96 01 FF 80 11  ; ...;............
7F89  db 13 C4 93 1A FF 1A 11 13 3B 12 C5 93 1A FF 1A 11  ; ........;.......
7F99  db 13 3B 12 80 01 16 60 12 09 1A 73 00 01 C0 61 16  ; .;....`...s...a.
7FA9  db 89 01 1A 00 0B 88 01 1A 00 0B 8A 01 1A 00 0B 84  ; ................
7FB9  db 01 1A 00 0B 85 01 1A 00 0B 09 14 34 00 01 1D 62  ; ...........4...b
7FC9  db 14 10 20 1F 00 00 4E 62 10 20 1F 00 00 6E 62 10  ; .. ...Nb. ...nb.
7FD9  db 20 24 00 00 8E 62 10 20 24 00 00 B2 62 10 20 24  ;  $...b. $...b. $
7FE9  db 00 00 D6 62 10 20 24 00 00 FA 62 10 20 24 00 00  ; ...b. $...b. $..
7FF9  db 1E 63 10 20 24 00 00 42 63 10 20 24 00 00 66 63  ; .c. $..Bc. $..fc
8009  db 20 20 33 00 00 F1 57 20 21 33 00 00 89 63 5B 80  ;   3...W !3...c[.
8019  db 5B 80 5B 80 8C 80 D9 80 0F 81 56 81 8C 81 C1 81  ; [.[.......V.....
8029  db E3 81 14 82 56 82 87 82 BE 82 F6 82 4A 83 67 83  ; ....V.......J.g.
8039  db 98 83 C1 83 F9 83 21 84 3D 84 89 84 AA 84 B1 84  ; ......!.=.......
8049  db B8 84 BF 84 C6 84 CD 84 D4 84 DB 84 E2 84 F0 84  ; ................
8059  db E9 84 81 01 18 99 18 85 01 18 99 18 84 01 18 99  ; ................
8069  db 18 86 01 18 99 18 82 01 18 99 18 8A 01 18 99 18  ; ................
8079  db 98 01 03 80 99 18 89 01 18 99 18 09 18 B2 00 01  ; ................
8089  db BA 63 03 C1 93 1A FF 17 00 13 22 1F C5 93 1A FF  ; .c........".....
8099  db 17 00 13 22 1F B4 12 1A 04 40 00 36 1F B6 12 1A  ; ...".....@.6....
80A9  db 04 40 00 36 1F C2 93 1A FF 17 00 13 22 1F AA 12  ; .@.6........"...
80B9  db 1A 17 00 36 1F A8 12 1A 17 00 36 1F A9 12 1A 17  ; ...6......6.....
80C9  db 00 36 1F 80 01 17 36 1F 09 17 55 00 01 4A 64 03  ; .6....6...U..Jd.
80D9  db 81 01 19 1C 12 85 01 19 1C 12 84 01 19 1C 12 86  ; ................
80E9  db 01 19 1C 12 82 01 19 1C 12 8A 01 19 1C 12 88 01  ; ................
80F9  db 19 1C 12 89 01 19 1C 12 90 01 05 80 1C 12 09 19  ; ................
8109  db 2F 00 01 8F 64 04 81 01 15 3E 17 85 01 15 3E 17  ; /...d....>....>.
8119  db A4 12 FF 1A 21 0E 25 A6 12 1A 15 30 0D 17 A2 12  ; ....!.%....0....
8129  db FF FF 12 0E 0E A2 12 1A 15 30 0D 17 AA 12 1A 15  ; .........0......
8139  db 30 0D 17 88 01 1A 30 25 89 01 1A 30 25 B0 12 1A  ; 0.....0%...0%...
8149  db 06 40 30 0D 17 09 15 54 00 01 B5 64 15 81 01 1C  ; .@0....T...d....
8159  db 63 12 85 01 1C 63 12 84 01 1C 63 12 86 01 1C 63  ; c....c....c....c
8169  db 12 82 01 1C 63 12 8A 01 1C 63 12 88 01 1C 63 12  ; ....c....c....c.
8179  db 89 01 1C 63 12 90 01 07 80 63 12 0B 1C 75 00 01  ; ...c.....c...u..
8189  db FA 64 08 81 01 1C 2B 18 85 01 1C 2B 18 84 01 1C  ; .d....+....+....
8199  db 2B 18 86 01 1C 2B 18 82 01 1C 2B 18 8A 01 1C 2B  ; +....+....+....+
81A9  db 18 88 01 1C 2B 18 89 01 1C 2B 18 90 01 08 80 2B  ; ....+....+.....+
81B9  db 18 0B 1C 44 00 00 59 65 94 01 09 80 3A 13 82 01  ; ...D..Ye....:...
81C9  db 1C 3A 13 8A 01 1C 3A 13 88 01 1C 3A 13 89 01 1C  ; .:....:....:....
81D9  db 3A 13 0B 1C 4E 00 01 90 65 09 81 01 1F 49 22 A5  ; :...N...e....I".
81E9  db 12 FF 1F 0D 3B 22 A4 12 FF 1F 0D 3B 22 92 01 0A  ; ....;".....;"...
81F9  db 80 49 22 9A 01 0A 80 49 22 88 01 1F 49 22 89 01  ; .I"....I"...I"..
8209  db 1F 49 22 0B 1F 6B 00 01 CF 65 13 A1 12 1F 1D 00  ; .I"..k...e......
8219  db 13 13 B5 12 1F 0B 40 00 13 13 B4 12 1F 0B 40 00  ; ......@.......@.
8229  db 13 13 A6 12 FF 1D 00 13 13 A2 12 FF 1D 00 13 13  ; ................
8239  db AA 12 FF 1D 00 13 13 A8 12 1F 1D 00 13 13 A9 12  ; ................
8249  db 1F 1D 00 13 13 0B 1D 27 00 01 26 66 0B 81 01 1E  ; .......'..&f....
8259  db 13 1D 85 01 1E 13 1D 86 01 1E 13 1D 82 01 1E 13  ; ................
8269  db 1D 8A 01 1E 13 1D 88 01 1E 13 1D 89 01 1E 13 1D  ; ................
8279  db 90 01 0C 80 13 1D 0B 1E 31 00 01 46 66 0D 81 01  ; ........1..Ff...
8289  db 1E 00 3B 85 01 1E 00 3B 84 01 FF 00 23 86 01 1E  ; ..;....;....#...
8299  db 00 3B 82 01 1E 00 3B 8A 01 1E 00 3B 88 01 1E 00  ; .;....;....;....
82A9  db 3B 89 01 1E 00 3B B0 12 1E 0D 40 00 23 17 0B 1E  ; ;....;....@.#...
82B9  db 3B 00 00 6E 66 81 01 1E 00 42 85 01 1E 00 42 84  ; ;..nf....B....B.
82C9  db 01 FF 00 22 86 01 1E 00 42 82 01 1E 00 42 8A 01  ; ..."....B....B..
82D9  db 1E 00 42 88 01 1E 00 42 89 01 1E 00 42 B0 12 1E  ; ..B....B....B...
82E9  db 0E 40 00 22 20 0B 1E 42 00 01 9E 66 0F C1 93 1E  ; .@." ..B...f....
82F9  db FF 1F 00 2F 21 16 C5 93 1E FF 1F 00 16 3A 16 D4  ; .../!........:..
8309  db 93 FF FF 0F 20 00 16 3A 16 D6 93 1E FF 0F 20 00  ; .... ..:...... .
8319  db 16 3A 16 A2 12 1E FF 00 16 18 82 01 1F 50 16 CA  ; .:...........P..
8329  db 93 1E FF 1F 00 16 3A 16 C8 93 1E FF 1F 00 16 3A  ; ......:........:
8339  db 16 C9 93 1E FF 1F 00 16 3A 16 0B 1F 66 00 00 D4  ; ........:...f...
8349  db 66 81 01 1D 1A 13 85 01 1D 1A 13 89 01 1D 1A 13  ; f...............
8359  db 90 01 10 80 1A 13 0B 1D 2D 00 01 27 67 11 81 01  ; ........-..'g...
8369  db 1F 0C 45 85 01 1F 0C 45 86 01 1F 39 18 D2 93 FF  ; ..E....E...9....
8379  db FF 11 20 00 0C 2C 18 9A 01 11 80 39 18 98 01 11  ; .. ..,.....9....
8389  db 80 39 18 89 01 1F 39 18 0B 1F 51 00 00 4C 67 81  ; .9....9...Q..Lg.
8399  db 01 1F 3B 3B 85 01 1F 3B 3B 94 01 12 80 5E 18 96  ; ..;;...;;....^..
83A9  db 01 12 80 5E 18 92 01 12 80 5E 18 89 01 1F 3B 3B  ; ...^.....^....;;
83B9  db 0B 1F 77 00 01 8E 67 13 81 01 1F 00 0E 85 01 1F  ; ..w...g.........
83C9  db 00 0E B4 12 FF 13 40 00 0E 1D B6 12 FF 13 40 00  ; ......@.......@.
83D9  db 0E 1D B2 12 1F 13 40 00 0E 1D 8A 01 1F 00 2C 88  ; ......@.......,.
83E9  db 01 1F 00 0E 89 01 1F 00 0E 0B 1F 2C 00 00 EE 67  ; ...........,...g
83F9  db 86 01 FF 0E 6A 82 01 FF 0E 6A AA 12 1F FF 00 0E  ; ....j....j......
8409  db 6A 88 01 1F 00 0E 89 01 1F 00 0E 80 01 FF 0E 2F  ; j............../
8419  db 0B 14 71 00 01 12 68 14 81 01 FF 0E 13 86 01 FF  ; ..q...h.........
8429  db 00 0E 82 01 FF 00 0E 89 01 FF 0E 13 09 95 1A 00  ; ................
8439  db 01 74 68 96 81 01 1A 11 13 C5 93 1A FF 1A 11 13  ; .th.............
8449  db 3B 12 C4 93 1A FF 1A 11 13 3B 12 D6 93 FF FF 1A  ; ;........;......
8459  db 80 11 13 3B 12 92 01 FF 80 11 13 9A 01 FF 80 11  ; ...;............
8469  db 13 C8 93 1A FF 1A 11 13 3B 12 C9 93 1A FF 1A 11  ; ........;.......
8479  db 13 3B 12 80 01 16 60 12 09 1A 73 00 01 90 68 16  ; .;....`...s...h.
8489  db 85 01 1A 00 0B 84 01 1A 00 0B 86 01 1A 00 0B 88  ; ................
8499  db 01 1A 00 0B 89 01 1A 00 0B 09 14 34 00 01 ED 68  ; ...........4...h
84A9  db 14 10 20 1F 00 00 1E 69 10 20 1F 00 00 3E 69 10  ; .. ....i. ...>i.
84B9  db 20 24 00 00 5E 69 10 20 24 00 00 82 69 10 20 24  ;  $..^i. $...i. $
84C9  db 00 00 A6 69 10 20 24 00 00 CA 69 10 20 24 00 00  ; ...i. $...i. $..
84D9  db EE 69 10 20 24 00 00 12 6A 10 20 24 00 00 36 6A  ; .i. $...j. $..6j
84E9  db 20 20 33 00 00 F1 57 20 21 33 00 00 89 63 A3 85  ;   3...W !3...c..
84F9  db A3 85 A3 85 D6 85 07 86 29 86 6A 86 94 86 C9 86  ; ........).j.....
8509  db FA 86 2B 87 56 87 7C 87 A3 87 D1 87 FC 87 2E 88  ; ..+.V.|.........
8519  db 64 88 96 88 C7 88 F9 88 3F 89 91 89 C9 89 FB 89  ; d.......?.......
8529  db 32 8A 53 8A 5A 8A 8C 8A C2 8A C9 8A D0 8A D7 8A  ; 2.S.Z...........
8539  db DE 8A E5 8A EC 8A F3 8A FA 8A 01 8B 08 8B 0F 8B  ; ................
8549  db 16 8B 1D 8B 56 8B 56 8B 56 8B D6 85 07 86 29 86  ; ....V.V.V.....).
8559  db 6A 86 94 86 C9 86 FA 86 2B 87 56 87 7C 87 A3 87  ; j.......+.V.|...
8569  db D1 87 FC 87 2E 88 64 88 96 88 C7 88 F9 88 3F 89  ; ......d.......?.
8579  db 91 89 C9 89 FB 89 32 8A 53 8A 5A 8A 8C 8A C2 8A  ; ......2.S.Z.....
8589  db C9 8A D0 8A D7 8A DE 8A E5 8A EC 8A F3 8A FA 8A  ; ................
8599  db 01 8B 08 8B 0F 8B 16 8B 1D 8B 91 01 03 80 5E 2C  ; ..............^,
85A9  db 99 01 03 80 5E 2C 98 01 03 80 5E 2C 8A 01 1E 5E  ; ....^,....^,...^
85B9  db 2C 82 01 1E 5E 2C 86 01 1E 5E 2C 84 01 1E 5E 2C  ; ,...^,...^,...^,
85C9  db 85 01 1E 5E 2C 0B 1E 8A 00 01 8A 6A 04 91 01 04  ; ...^,......j....
85D9  db 80 00 12 89 01 1E 00 12 88 01 1E 00 12 8A 01 1E  ; ................
85E9  db 00 12 82 01 1E 00 12 86 01 1E 00 12 84 01 04 00  ; ................
85F9  db 12 95 01 04 80 00 12 0B 1E 12 00 00 FA 6A 89 01  ; .............j..
8609  db 1E 00 2B 88 01 1E 00 2B B6 12 1E 05 40 00 06 25  ; ..+....+....@..%
8619  db B4 12 1E 05 40 00 06 25 0B 1E 2B 00 01 09 6B 05  ; ....@..%..+...k.
8629  db C1 93 1E FF 1B 00 07 13 13 C9 93 1E FF 1B 00 07  ; ................
8639  db 13 13 A8 12 1E 1B 07 13 13 A2 12 1E FF 00 07 13  ; ................
8649  db 86 01 1E 1B 13 84 01 1E 07 27 C5 93 1E FF 1B 00  ; .........'......
8659  db 07 13 13 90 01 06 80 07 27 0B 1E 27 00 01 2C 6B  ; ........'..'..,k
8669  db 1B 81 01 21 00 23 8A 01 21 11 12 B2 12 21 07 40  ; ...!.#..!....!.@
8679  db 00 10 13 96 01 07 80 10 13 84 01 21 11 12 85 01  ; ...........!....
8689  db 21 11 12 0E 21 23 00 01 52 6B 0E 81 01 21 0D 18  ; !...!#..Rk...!..
8699  db C8 93 21 FF 21 00 03 09 18 C9 93 21 FF 21 00 03  ; ..!.!......!.!..
86A9  db 09 18 8A 01 21 00 26 82 01 21 03 09 94 01 08 80  ; ....!.&..!......
86B9  db 0D 18 95 01 08 80 0D 18 0E 1E 26 00 01 6F 6B 0E  ; ..........&..ok.
86C9  db 81 01 22 13 13 89 01 22 13 13 98 01 09 80 13 13  ; .."...."........
86D9  db 8A 01 21 13 13 82 01 21 13 13 86 01 21 13 13 84  ; ..!....!....!...
86E9  db 01 21 13 13 85 01 22 13 13 0E 21 27 00 01 8E 6B  ; .!...."...!'...k
86F9  db 0E 81 01 21 00 1C 89 01 21 00 1C 88 01 21 09 12  ; ...!....!....!..
8709  db 8A 01 21 00 1C 82 01 21 00 1C 86 01 21 00 1C 94  ; ..!....!....!...
8719  db 01 0A 80 09 12 85 01 21 00 1C 0E 21 1C 00 01 AE  ; .......!...!....
8729  db 6B 0E 91 01 0B 80 00 13 89 01 21 00 13 8A 01 21  ; k.........!....!
8739  db 00 13 82 01 21 00 13 86 01 21 00 13 84 01 21 00  ; ....!....!....!.
8749  db 13 85 01 21 00 13 0E 21 13 00 00 C5 6B 89 01 21  ; ...!...!....k..!
8759  db 00 12 98 01 0C 80 00 12 8A 01 21 00 12 86 01 21  ; ..........!....!
8769  db 00 12 84 01 21 00 12 85 01 21 00 12 0E 21 12 00  ; ....!....!...!..
8779  db 00 D5 6B 91 01 0D 80 00 12 89 01 21 00 12 88 01  ; ..k........!....
8789  db 21 00 12 8A 01 21 00 12 82 01 21 00 12 95 01 0D  ; !....!....!.....
8799  db 80 00 12 0E 21 12 00 00 E4 6B 81 01 21 10 0D 89  ; ....!....k..!...
87A9  db 01 21 00 1D 88 01 21 00 1D 8A 01 21 00 1D 86 01  ; .!....!....!....
87B9  db 21 00 1D B4 12 21 0E 40 00 0B 12 85 01 21 0B 12  ; !....!.@.....!..
87C9  db 0E 21 1D 00 01 F3 6B 0E 81 01 FF 00 0D 89 01 21  ; .!....k........!
87D9  db 00 0D 8A 01 21 00 0D 82 01 21 00 0D 86 01 21 00  ; ....!....!....!.
87E9  db 0D 84 01 21 00 0D 85 01 21 00 0D 0E 0F 0D 00 81  ; ...!....!.......
87F9  db 0B 6C 0E 81 01 24 85 32 89 01 24 85 32 88 01 24  ; .l...$.2..$.2..$
8809  db 85 32 8A 01 24 85 32 82 01 24 85 32 86 01 24 85  ; .2..$.2..$.2..$.
8819  db 32 94 01 10 80 85 32 95 01 10 80 85 32 0E 24 B8  ; 2.....2.....2.$.
8829  db 00 01 16 6C 0F 81 01 23 58 18 89 01 23 58 18 88  ; ...l...#X...#X..
8839  db 01 23 58 18 8A 01 23 58 18 82 01 23 58 18 86 01  ; .#X...#X...#X...
8849  db 23 58 18 84 01 23 58 18 85 01 23 58 18 90 01 11  ; #X...#X...#X....
8859  db 80 58 18 0E 23 70 00 01 AB 6C 10 81 01 25 4F 20  ; .X..#p...l...%O 
8869  db 98 01 12 80 4F 20 8A 01 25 4F 20 82 01 25 4F 20  ; ....O ..%O ..%O 
8879  db 86 01 25 4F 20 84 01 25 4F 20 85 01 25 4F 20 90  ; ..%O ..%O ..%O .
8889  db 01 12 80 4F 20 0E 25 6F 00 01 06 6D 11 81 01 25  ; ...O .%o...m...%
8899  db 41 1A 89 01 25 41 1A 88 01 25 41 1A 8A 01 25 41  ; A...%A...%A...%A
88A9  db 1A 92 01 13 80 41 1A 86 01 25 41 1A 84 01 25 41  ; .....A...%A...%A
88B9  db 1A 85 01 25 41 1A 0E 25 5B 00 01 60 6D 14 81 01  ; ...%A..%[..`m...
88C9  db 26 16 16 89 01 26 00 2C B8 12 26 14 40 00 16 16  ; &....&.,..&.@...
88D9  db 8A 01 26 00 2C 82 01 26 16 16 86 01 26 16 16 84  ; ..&.,..&....&...
88E9  db 01 26 16 16 85 01 26 16 16 0E 26 2C 00 00 AA 6D  ; .&....&...&,...m
88F9  db C1 93 26 FF 25 00 09 1D 21 98 01 15 80 27 21 89  ; ..&.%...!....'!.
8909  db 01 25 27 21 9A 01 15 80 27 21 D2 93 26 FF 15 20  ; .%'!....'!..&.. 
8919  db 00 09 1D 21 C6 93 26 FF 25 00 09 1D 21 C4 93 26  ; ...!..&.%...!..&
8929  db FF 25 00 09 1D 21 C5 93 26 FF 25 00 09 1D 21 0E  ; .%...!..&.%...!.
8939  db 25 49 00 00 CE 6D C1 93 26 FF 25 00 0B 1D 13 C9  ; %I...m..&.%.....
8949  db 93 26 FF 25 00 0B 1D 13 C8 93 26 FF 25 00 0B 1D  ; .&.%......&.%...
8959  db 13 CA 93 26 FF 25 00 0B 1D 13 82 01 25 28 13 C6  ; ...&.%......%(..
8969  db 93 26 FF 25 00 0B 1D 13 C4 93 26 FF 25 00 0B 1D  ; .&.%......&.%...
8979  db 13 C5 93 26 FF 25 00 0B 1D 13 90 01 16 80 28 13  ; ...&.%........(.
8989  db 0E 25 3C 00 01 09 6E 15 81 01 27 36 22 89 01 27  ; .%<...n...'6"..'
8999  db 36 22 88 01 27 36 22 8A 01 27 36 22 82 01 27 36  ; 6"..'6"..'6"..'6
89A9  db 22 86 01 27 36 22 84 01 27 36 22 85 01 27 36 22  ; "..'6"..'6"..'6"
89B9  db B0 12 FF 17 40 00 36 22 0E 27 59 00 01 3A 6E 15  ; ....@.6".'Y..:n.
89C9  db 81 01 28 18 17 89 01 28 18 17 98 01 18 80 18 17  ; ..(....(........
89D9  db 9A 01 18 80 18 17 82 01 28 18 17 86 01 28 18 17  ; ........(....(..
89E9  db 84 01 28 18 17 85 01 28 18 17 0E 28 30 00 01 82  ; ..(....(...(0...
89F9  db 6E 17 81 01 28 23 15 99 01 19 80 23 15 98 01 19  ; n...(#.....#....
8A09  db 80 23 15 8A 01 28 23 15 82 01 28 23 15 86 01 28  ; .#...(#...(#...(
8A19  db 23 15 84 01 28 23 15 85 01 28 23 15 80 01 28 23  ; #...(#...(#...(#
8A29  db 15 0E 28 39 00 01 A9 6E 19 81 01 28 00 08 82 01  ; ..(9...n...(....
8A39  db 28 00 08 86 01 28 00 08 84 01 28 00 08 85 01 28  ; (....(....(....(
8A49  db 00 08 0E 1A 00 00 01 D7 6E 1A 0B 97 32 00 00 DE  ; ........n...2...
8A59  db 6E 81 01 1F A3 1B 89 01 1F A3 1B 88 01 1F A3 1B  ; n...............
8A69  db 8A 01 1F A3 1B 82 01 1F A3 1B 96 01 1C 80 A3 1B  ; ................
8A79  db 94 01 1C 80 A3 1B 85 01 1F A3 1B 0B 1F BE 00 01  ; ................
8A89  db 0D 6F 1C 81 01 20 51 18 89 01 20 51 18 88 01 20  ; .o... Q... Q... 
8A99  db 51 18 8A 01 20 51 18 82 01 20 51 18 86 01 20 51  ; Q... Q... Q... Q
8AA9  db 18 84 01 20 51 18 85 01 20 51 18 90 01 1D 80 51  ; ... Q... Q.....Q
8AB9  db 18 0B 20 6A 00 01 A7 6F 1A 0B 1A 01 00 00 FD 6F  ; .. j...o.......o
8AC9  db 10 29 42 00 00 05 70 10 29 24 00 00 41 70 10 29  ; .)B...p.)$..Ap.)
8AD9  db 27 00 00 65 70 10 29 42 00 00 8B 70 10 29 1F 00  ; '..ep.)B...p.)..
8AE9  db 00 C7 70 10 29 27 00 00 E7 70 10 29 24 00 00 0D  ; ..p.)'...p.)$...
8AF9  db 71 10 29 33 00 00 31 71 10 29 24 00 00 61 71 10  ; q.)3..1q.)$..aq.
8B09  db 29 24 00 00 85 71 10 29 24 00 00 A9 71 20 29 33  ; )$...q.)$...q )3
8B19  db 00 00 CC 71 20 2A 33 00 00 F1 57 81 01 1F 7C 1B  ; ...q *3...W...|.
8B29  db 89 01 1F 7C 1B 88 01 1F 7C 1B 8A 01 1F 7C 1B 82  ; ...|....|....|..
8B39  db 01 1F 7C 1B 96 01 1C 80 7C 1B 94 01 1C 80 7C 1B  ; ..|.....|.....|.
8B49  db 85 01 1F 7C 1B 0B 1F 97 00 01 2D 6F 1C 81 01 24  ; ...|......-o...$
8B59  db 60 32 89 01 24 60 32 88 01 24 60 32 8A 01 24 60  ; `2..$`2..$`2..$`
8B69  db 32 82 01 24 60 32 86 01 24 60 32 94 01 10 80 60  ; 2..$`2..$`2....`
8B79  db 32 95 01 10 80 60 32 0E 24 93 00 01 34 6C 0F 34  ; 2....`2.$...4l.4
8B89  db 8C 34 8C 34 8C 67 8C 98 8C BA 8C FB 8C 25 8D 5A  ; .4.4.g.......%.Z
8B99  db 8D 8B 8D BC 8D E7 8D 0D 8E 34 8E 62 8E 8D 8E BF  ; .........4.b....
8BA9  db 8E F5 8E 27 8F 58 8F 8A 8F D0 8F 22 90 5A 90 8C  ; ...'.X.....".Z..
8BB9  db 90 C3 90 E4 90 EB 90 1D 91 53 91 5A 91 61 91 68  ; .........S.Z.a.h
8BC9  db 91 6F 91 76 91 7D 91 84 91 8B 91 92 91 99 91 A0  ; .o.v.}..........
8BD9  db 91 A7 91 AE 91 E7 91 E7 91 E7 91 67 8C 98 8C BA  ; ...........g....
8BE9  db 8C FB 8C 25 8D 5A 8D 8B 8D BC 8D E7 8D 0D 8E 34  ; ...%.Z.........4
8BF9  db 8E 62 8E 8D 8E BF 8E F5 8E 27 8F 58 8F 8A 8F D0  ; .b.......'.X....
8C09  db 8F 22 90 5A 90 8C 90 C3 90 E4 90 EB 90 1D 91 53  ; .".Z...........S
8C19  db 91 5A 91 61 91 68 91 6F 91 76 91 7D 91 84 91 8B  ; .Z.a.h.o.v.}....
8C29  db 91 92 91 99 91 A0 91 A7 91 AE 91 91 01 03 80 5E  ; ...............^
8C39  db 2C 95 01 03 80 5E 2C 94 01 03 80 5E 2C 86 01 1E  ; ,....^,....^,...
8C49  db 5E 2C 82 01 1E 5E 2C 8A 01 1E 5E 2C 88 01 1E 5E  ; ^,...^,...^,...^
8C59  db 2C 89 01 1E 5E 2C 0B 1E 8A 00 01 FD 71 04 91 01  ; ,...^,......q...
8C69  db 04 80 00 12 85 01 1E 00 12 84 01 1E 00 12 86 01  ; ................
8C79  db 1E 00 12 82 01 1E 00 12 8A 01 1E 00 12 88 01 04  ; ................
8C89  db 00 12 99 01 04 80 00 12 0B 1E 12 00 00 6D 72 85  ; .............mr.
8C99  db 01 1E 00 2B 84 01 1E 00 2B BA 12 1E 05 40 00 06  ; ...+....+....@..
8CA9  db 25 B8 12 1E 05 40 00 06 25 0B 1E 2B 00 01 7C 72  ; %....@..%..+..|r
8CB9  db 05 C1 93 1E FF 1B 00 07 13 13 C5 93 1E FF 1B 00  ; ................
8CC9  db 07 13 13 A4 12 1E 1B 07 13 13 A2 12 1E FF 00 07  ; ................
8CD9  db 13 8A 01 1E 1B 13 88 01 1E 07 27 C9 93 1E FF 1B  ; ..........'.....
8CE9  db 00 07 13 13 90 01 06 80 07 27 0B 1E 27 00 01 9F  ; .........'..'...
8CF9  db 72 1B 81 01 21 00 23 86 01 21 11 12 B2 12 21 07  ; r...!.#..!....!.
8D09  db 40 00 10 13 9A 01 07 80 10 13 88 01 21 11 12 89  ; @...........!...
8D19  db 01 21 11 12 0E 21 23 00 01 C5 72 0E 81 01 21 0D  ; .!...!#...r...!.
8D29  db 18 C4 93 21 FF 21 00 03 09 18 C5 93 21 FF 21 00  ; ...!.!......!.!.
8D39  db 03 09 18 86 01 21 00 26 82 01 21 03 09 98 01 08  ; .....!.&..!.....
8D49  db 80 0D 18 99 01 08 80 0D 18 0E 1E 26 00 01 E2 72  ; ...........&...r
8D59  db 0E 81 01 22 13 13 85 01 22 13 13 94 01 09 80 13  ; ..."....".......
8D69  db 13 86 01 21 13 13 82 01 21 13 13 8A 01 21 13 13  ; ...!....!....!..
8D79  db 88 01 21 13 13 89 01 22 13 13 0E 21 27 00 01 01  ; ..!...."...!'...
8D89  db 73 0E 81 01 21 00 1C 85 01 21 00 1C 84 01 21 09  ; s...!....!....!.
8D99  db 12 86 01 21 00 1C 82 01 21 00 1C 8A 01 21 00 1C  ; ...!....!....!..
8DA9  db 98 01 0A 80 09 12 89 01 21 00 1C 0E 21 1C 00 01  ; ........!...!...
8DB9  db 21 73 0E 91 01 0B 80 00 13 85 01 21 00 13 86 01  ; !s.........!....
8DC9  db 21 00 13 82 01 21 00 13 8A 01 21 00 13 88 01 21  ; !....!....!....!
8DD9  db 00 13 89 01 21 00 13 0E 21 13 00 00 38 73 85 01  ; ....!...!...8s..
8DE9  db 21 00 12 94 01 0C 80 00 12 86 01 21 00 12 8A 01  ; !..........!....
8DF9  db 21 00 12 88 01 21 00 12 89 01 21 00 12 0E 21 12  ; !....!....!...!.
8E09  db 00 00 48 73 91 01 0D 80 00 12 85 01 21 00 12 84  ; ..Hs........!...
8E19  db 01 21 00 12 86 01 21 00 12 82 01 21 00 12 99 01  ; .!....!....!....
8E29  db 0D 80 00 12 0E 21 12 00 00 57 73 81 01 21 10 0D  ; .....!...Ws..!..
8E39  db 85 01 21 00 1D 84 01 21 00 1D 86 01 21 00 1D 8A  ; ..!....!....!...
8E49  db 01 21 00 1D B8 12 21 0E 40 00 0B 12 89 01 21 0B  ; .!....!.@.....!.
8E59  db 12 0E 21 1D 00 01 66 73 0E 81 01 FF 00 0D 85 01  ; ..!...fs........
8E69  db 21 00 0D 86 01 21 00 0D 82 01 21 00 0D 8A 01 21  ; !....!....!....!
8E79  db 00 0D 88 01 21 00 0D 89 01 21 00 0D 0E 0F 0D 00  ; ....!....!......
8E89  db 81 7E 73 0E 81 01 24 85 32 85 01 24 85 32 84 01  ; .~s...$.2..$.2..
8E99  db 24 85 32 86 01 24 85 32 82 01 24 85 32 8A 01 24  ; $.2..$.2..$.2..$
8EA9  db 85 32 98 01 10 80 85 32 99 01 10 80 85 32 0E 24  ; .2.....2.....2.$
8EB9  db B8 00 01 89 73 0F 81 01 23 58 18 85 01 23 58 18  ; ....s...#X...#X.
8EC9  db 84 01 23 58 18 86 01 23 58 18 82 01 23 58 18 8A  ; ..#X...#X...#X..
8ED9  db 01 23 58 18 88 01 23 58 18 89 01 23 58 18 90 01  ; .#X...#X...#X...
8EE9  db 11 80 58 18 0E 23 70 00 01 1E 74 10 81 01 25 4F  ; ..X..#p...t...%O
8EF9  db 20 94 01 12 80 4F 20 86 01 25 4F 20 82 01 25 4F  ;  ....O ..%O ..%O
8F09  db 20 8A 01 25 4F 20 88 01 25 4F 20 89 01 25 4F 20  ;  ..%O ..%O ..%O 
8F19  db 90 01 12 80 4F 20 0E 25 6F 00 01 79 74 11 81 01  ; ....O .%o..yt...
8F29  db 25 41 1A 85 01 25 41 1A 84 01 25 41 1A 86 01 25  ; %A...%A...%A...%
8F39  db 41 1A 92 01 13 80 41 1A 8A 01 25 41 1A 88 01 25  ; A.....A...%A...%
8F49  db 41 1A 89 01 25 41 1A 0E 25 5B 00 01 D3 74 14 81  ; A...%A..%[...t..
8F59  db 01 26 16 16 85 01 26 00 2C B4 12 26 14 40 00 16  ; .&....&.,..&.@..
8F69  db 16 86 01 26 00 2C 82 01 26 16 16 8A 01 26 16 16  ; ...&.,..&....&..
8F79  db 88 01 26 16 16 89 01 26 16 16 0E 26 2C 00 00 1D  ; ..&....&...&,...
8F89  db 75 C1 93 26 FF 25 00 09 1D 21 94 01 15 80 27 21  ; u..&.%...!....'!
8F99  db 85 01 25 27 21 96 01 15 80 27 21 D2 93 26 FF 15  ; ..%'!....'!..&..
8FA9  db 20 00 09 1D 21 CA 93 26 FF 25 00 09 1D 21 C8 93  ;  ...!..&.%...!..
8FB9  db 26 FF 25 00 09 1D 21 C9 93 26 FF 25 00 09 1D 21  ; &.%...!..&.%...!
8FC9  db 0E 25 49 00 00 41 75 C1 93 26 FF 25 00 0B 1D 13  ; .%I..Au..&.%....
8FD9  db C5 93 26 FF 25 00 0B 1D 13 C4 93 26 FF 25 00 0B  ; ..&.%......&.%..
8FE9  db 1D 13 C6 93 26 FF 25 00 0B 1D 13 82 01 25 28 13  ; ....&.%......%(.
8FF9  db CA 93 26 FF 25 00 0B 1D 13 C8 93 26 FF 25 00 0B  ; ..&.%......&.%..
9009  db 1D 13 C9 93 26 FF 25 00 0B 1D 13 90 01 16 80 28  ; ....&.%........(
9019  db 13 0E 25 3C 00 01 7C 75 15 81 01 27 36 22 85 01  ; ..%<..|u...'6"..
9029  db 27 36 22 84 01 27 36 22 86 01 27 36 22 82 01 27  ; '6"..'6"..'6"..'
9039  db 36 22 8A 01 27 36 22 88 01 27 36 22 89 01 27 36  ; 6"..'6"..'6"..'6
9049  db 22 B0 12 FF 17 40 00 36 22 0E 27 59 00 01 AD 75  ; "....@.6".'Y...u
9059  db 15 81 01 28 18 17 85 01 28 18 17 94 01 18 80 18  ; ...(....(.......
9069  db 17 96 01 18 80 18 17 82 01 28 18 17 8A 01 28 18  ; .........(....(.
9079  db 17 88 01 28 18 17 89 01 28 18 17 0E 28 30 00 01  ; ...(....(...(0..
9089  db F5 75 17 81 01 28 23 15 95 01 19 80 23 15 94 01  ; .u...(#.....#...
9099  db 19 80 23 15 86 01 28 23 15 82 01 28 23 15 8A 01  ; ..#...(#...(#...
90A9  db 28 23 15 88 01 28 23 15 89 01 28 23 15 80 01 28  ; (#...(#...(#...(
90B9  db 23 15 0E 28 39 00 01 1C 76 19 81 01 28 00 08 82  ; #..(9...v...(...
90C9  db 01 28 00 08 8A 01 28 00 08 88 01 28 00 08 89 01  ; .(....(....(....
90D9  db 28 00 08 0E 1A 00 00 01 4A 76 1A 0B 97 32 00 00  ; (.......Jv...2..
90E9  db 51 76 81 01 1F A3 1B 85 01 1F A3 1B 84 01 1F A3  ; Qv..............
90F9  db 1B 86 01 1F A3 1B 82 01 1F A3 1B 9A 01 1C 80 A3  ; ................
9109  db 1B 98 01 1C 80 A3 1B 89 01 1F A3 1B 0B 1F BE 00  ; ................
9119  db 01 80 76 1C 81 01 20 51 18 85 01 20 51 18 84 01  ; ..v... Q... Q...
9129  db 20 51 18 86 01 20 51 18 82 01 20 51 18 8A 01 20  ;  Q... Q... Q... 
9139  db 51 18 88 01 20 51 18 89 01 20 51 18 90 01 1D 80  ; Q... Q... Q.....
9149  db 51 18 0B 20 6A 00 01 1A 77 1A 0B 1A 01 00 00 70  ; Q.. j...w......p
9159  db 77 10 29 42 00 00 78 77 10 29 24 00 00 B4 77 10  ; w.)B..xw.)$...w.
9169  db 29 27 00 00 D8 77 10 29 42 00 00 FE 77 10 29 1F  ; )'...w.)B...w.).
9179  db 00 00 3A 78 10 29 27 00 00 5A 78 10 29 24 00 00  ; ..:x.)'..Zx.)$..
9189  db 80 78 10 29 33 00 00 A4 78 10 29 24 00 00 D4 78  ; .x.)3...x.)$...x
9199  db 10 29 24 00 00 F8 78 10 29 24 00 00 1C 79 20 29  ; .)$...x.)$...y )
91A9  db 33 00 00 CC 71 20 2A 33 00 00 F1 57 81 01 1F 7C  ; 3...q *3...W...|
91B9  db 1B 85 01 1F 7C 1B 84 01 1F 7C 1B 86 01 1F 7C 1B  ; ....|....|....|.
91C9  db 82 01 1F 7C 1B 9A 01 1C 80 7C 1B 98 01 1C 80 7C  ; ...|.....|.....|
91D9  db 1B 89 01 1F 7C 1B 0B 1F 97 00 01 A0 76 1C 81 01  ; ....|.......v...
91E9  db 24 60 32 85 01 24 60 32 84 01 24 60 32 86 01 24  ; $`2..$`2..$`2..$
91F9  db 60 32 82 01 24 60 32 8A 01 24 60 32 98 01 10 80  ; `2..$`2..$`2....
9209  db 60 32 99 01 10 80 60 32 0E 24 93 00 01 A7 73 0F  ; `2....`2.$....s.
9219  db 81 92 81 92 81 92 B7 92 EC 92 59 93 95 93 CF 93  ; ..........Y.....
9229  db 08 94 41 94 75 94 AB 94 EB 94 2F 95 6C 95 C6 95  ; ..A.u...../.l...
9239  db 0F 96 56 96 8B 96 C3 96 F9 96 74 97 CE 97 2A 98  ; ..V.......t...*.
9249  db 62 98 F5 98 B2 98 30 99 7B 99 D4 99 DB 99 14 9A  ; b.....0.{.......
9259  db 4E 9A 85 9A C0 9A F5 9A 6D 9B 2E 9B 35 9B 3C 9B  ; N.......m...5.<.
9269  db 43 9B 4A 9B 51 9B 58 9B 5F 9B 66 9B 6D 9B 74 9B  ; C.J.Q.X._.f.m.t.
9279  db 7B 9B 82 9B 89 9B 90 9B 81 01 2F 0E 17 89 01 2F  ; {........./..../
9289  db 0E 17 88 01 2F 0E 17 8A 01 2F 0E 17 82 01 2F 0E  ; ..../..../..../.
9299  db 17 86 01 2F 0E 17 84 01 2F 0E 17 85 01 2F 0E 17  ; .../..../..../..
92A9  db 90 01 03 80 0E 17 0D 2F 26 00 01 3C 7A 04 81 01  ; ......./&..<z...
92B9  db 2F 00 21 89 01 2F 00 21 88 01 2F 00 21 8A 01 2F  ; /.!../.!../.!../
92C9  db 00 21 82 01 2F 00 21 86 01 2F 00 21 84 01 2F 00  ; .!../.!../.!../.
92D9  db 21 85 01 2F 00 21 90 01 04 80 00 21 0D 2F 21 00  ; !../.!.....!./!.
92E9  db 00 5B 7A C1 93 2F FF 2E 00 0C 1D 1F 89 01 2F 00  ; .[z../......../.
92F9  db 0C B9 12 2E 05 40 2A 0C 12 88 01 2F 00 0C B8 12  ; .....@*..../....
9309  db 2F 05 40 2A 0C 12 CA 93 2F FF 2E 00 0C 1D 1F C2  ; /.@*..../.......
9319  db 93 2F FF 2E 00 0C 1D 1F 86 01 2F 00 0C A6 12 2D  ; ./......../....-
9329  db 2C 2A 0C 12 84 01 2F 00 0C A4 12 2D 2C 2A 0C 12  ; ,*..../....-,*..
9339  db 85 01 2F 00 0C A5 12 2E 2C 2A 0C 12 80 01 2F 00  ; ../.....,*..../.
9349  db 0C A0 12 2D 2C 2A 0C 12 0D 2E 49 00 01 76 7A 05  ; ...-,*....I..vz.
9359  db A1 12 FF 2C 44 13 13 89 01 2E 58 13 88 01 2E 44  ; ...,D.....X....D
9369  db 27 8A 01 2C 44 27 82 01 2C 44 27 86 01 2E 44 27  ; '..,D'..,D'...D'
9379  db B4 12 2E 06 40 44 13 13 A5 12 FF 2E 44 13 13 80  ; ....@D......D...
9389  db 01 2C 58 13 0D 2C 6B 00 01 B1 7A 05 81 01 2E 00  ; .,X..,k...z.....
9399  db 31 89 01 2E 00 31 A8 12 2C 2E 00 13 1D 8A 01 2E  ; 1....1..,.......
93A9  db 00 31 82 01 2E 00 31 86 01 2E 00 31 A4 12 FF 2E  ; .1....1....1....
93B9  db 00 13 1D 85 01 2E 00 31 90 01 07 80 12 1F 0D 1E  ; .......1........
93C9  db 31 00 01 08 7B 05 91 01 08 80 3B 13 89 01 27 3B  ; 1...{.....;...';
93D9  db 13 88 01 28 3B 13 8A 01 27 3B 13 82 01 27 3B 13  ; ...(;...';...';.
93E9  db 86 01 27 3B 13 94 01 08 80 3B 13 95 01 08 80 3B  ; ..';.....;.....;
93F9  db 13 90 01 08 80 3B 13 0D 26 4F 00 01 30 7B 0A 81  ; .....;..&O..0{..
9409  db 01 28 00 3B 89 01 27 00 3B B8 12 28 09 40 00 27  ; .(.;..'.;..(.@.'
9419  db 13 8A 01 27 00 3B 82 01 27 00 3B 86 01 27 00 3B  ; ...'.;..'.;..'.;
9429  db 84 01 28 00 3B 85 01 28 00 3B A0 12 FF 28 00 27  ; ..(.;..(.;...(.'
9439  db 13 0D 26 3B 00 00 70 7B 81 01 28 00 0E 89 01 27  ; ..&;..p{..(....'
9449  db 00 0E 88 01 FF 00 0E 8A 01 27 00 0E 82 01 27 00  ; .........'....'.
9459  db 0E 86 01 27 00 0E 84 01 28 00 0E 85 01 28 00 0E  ; ...'....(....(..
9469  db 80 01 28 00 0E 0D 0A 0E 00 80 A0 7B 81 01 27 3B  ; ..(........{..';
9479  db 13 89 01 27 3B 13 88 01 28 3B 13 8A 01 27 3B 13  ; ...';...(;...';.
9489  db 82 01 27 3B 13 86 01 27 3B 13 84 01 28 3B 13 85  ; ..';...';...(;..
9499  db 01 27 3B 13 90 01 0B 80 3B 13 0D 26 4F 00 01 AC  ; .';.....;..&O...
94A9  db 7B 0B 81 01 27 00 3B 89 01 27 00 3B A8 12 FF 27  ; {...'.;..'.;...'
94B9  db 00 20 1B 8A 01 27 00 3B 82 01 27 00 3B A6 12 27  ; . ...'.;..'.;..'
94C9  db 26 00 20 1B A4 12 28 26 00 20 1B A5 12 28 26 00  ; &. ...(&. ...(&.
94D9  db 20 1B B0 12 28 0C 40 00 20 1B 0D 26 3B 00 01 EC  ;  ...(.@. ..&;...
94E9  db 7B 0C B1 12 27 0D 40 00 2A 13 B9 12 27 0D 40 00  ; {...'.@.*...'.@.
94F9  db 2A 13 B8 12 27 0D 40 00 2A 13 8A 01 27 00 3E 82  ; *...'.@.*...'.>.
9509  db 01 27 00 3E A6 12 26 27 00 2A 13 A4 12 26 28 00  ; .'.>..&'.*...&(.
9519  db 2A 13 85 01 27 00 3E A0 12 FF 26 00 2A 13 0D 26  ; *...'.>...&.*..&
9529  db 3E 00 01 1C 7C 0E 81 01 28 00 27 89 01 28 00 27  ; >...|...(.'..(.'
9539  db B8 12 28 0E 40 00 10 17 BA 12 27 0E 40 00 10 17  ; ..(.@.....'.@...
9549  db B2 12 27 0E 40 00 10 17 86 01 27 00 27 84 01 28  ; ..'.@.....'.'..(
9559  db 00 27 85 01 28 00 27 80 01 28 00 27 0D 28 27 00  ; .'..(.'..(.'.('.
9569  db 00 4E 7C C1 93 28 FF 28 00 0E 27 13 C9 93 28 FF  ; .N|..(.(..'...(.
9579  db 28 00 0E 27 13 C8 93 28 FF 28 00 0E 27 13 CA 93  ; (..'...(.(..'...
9589  db 27 FF 27 00 0E 27 13 C2 93 27 FF 27 00 0E 27 13  ; '.'..'...'.'..'.
9599  db C6 93 27 FF 27 00 0E 27 13 C4 93 28 FF 28 00 0E  ; ..'.'..'...(.(..
95A9  db 27 13 C5 93 28 FF 28 00 0E 27 13 D0 93 28 FF 0F  ; '...(.(..'...(..
95B9  db 20 00 0E 27 13 0D 28 4A 00 01 6E 7C 11 A1 12 28  ;  ..'..(J..n|...(
95C9  db 27 00 13 2C A9 12 28 27 00 13 2C D8 93 28 FF 10  ; '..,..('..,..(..
95D9  db 20 00 13 18 13 AA 12 27 28 00 2C 13 A2 12 27 28  ;  ......'(.,...'(
95E9  db 00 2C 13 A6 12 27 28 00 2C 13 A4 12 28 27 00 2C  ; .,...'(.,...('.,
95F9  db 13 A5 12 28 27 00 2C 13 A0 12 FF 28 00 13 2C 0D  ; ...('.,....(..,.
9609  db 28 40 00 00 AA 7C D1 93 27 28 11 20 00 07 0E 16  ; (@...|..'(. ....
9619  db D9 93 27 28 11 20 00 07 0E 16 D8 93 FF 28 11 20  ; ..'(. .......(. 
9629  db 00 07 0E 16 8A 01 28 00 2C C2 93 28 FF 28 00 07  ; ......(.,..(.(..
9639  db 0E 16 86 01 28 00 2C 84 01 27 00 2C 85 01 27 00  ; ....(.,..'.,..'.
9649  db 2C 80 01 28 00 2C 0D 26 2C 00 00 DE 7C 81 01 FF  ; ,..(.,.&,...|...
9659  db 00 10 89 01 FF 00 10 88 01 FF 00 10 8A 01 28 00  ; ..............(.
9669  db 10 82 01 28 00 10 86 01 28 00 10 84 01 27 00 10  ; ...(....(....'..
9679  db 85 01 27 00 10 80 01 28 00 10 0D 12 19 00 01 02  ; ..'....(........
9689  db 7D 14 81 01 27 09 25 89 01 27 09 25 A8 12 28 26  ; }...'.%..'.%..(&
9699  db 09 1D 07 8A 01 27 09 25 A2 12 27 FF 09 0C 11 86  ; .....'.%..'.....
96A9  db 01 27 09 25 84 01 26 09 25 85 01 27 09 25 80 01  ; .'.%..&.%..'.%..
96B9  db FF 16 18 0D 13 2F 00 80 1D 7D 91 01 14 80 46 13  ; ...../...}....F.
96C9  db 89 01 28 46 13 88 01 28 46 13 8A 01 28 46 13 82  ; ..(F...(F...(F..
96D9  db 01 28 46 13 86 01 28 46 13 84 01 27 46 13 95 01  ; .(F...(F...'F...
96E9  db 14 80 46 13 80 01 26 46 13 0D 26 5A 00 00 43 7D  ; ..F...&F..&Z..C}
96F9  db A1 12 FF 28 00 1B 1D 81 01 27 47 1D C9 93 28 FF  ; ...(.....'G...(.
9709  db 27 00 39 0E 1D 88 01 28 00 39 A8 12 27 29 47 09  ; '.9....(.9..')G.
9719  db 13 CA 93 28 FF 28 00 07 13 1D 8A 01 27 47 1D C2  ; ...(.(......'G..
9729  db 93 28 FF 28 00 07 13 1D 82 01 27 47 1D C6 93 28  ; .(.(......'G...(
9739  db FF 27 00 39 0E 1D C4 93 28 27 28 00 07 13 1D B4  ; .'.9....('(.....
9749  db 12 27 15 40 47 09 13 C5 93 FF 27 28 00 07 13 1D  ; .'.@G.....'(....
9759  db 85 01 27 47 1D A0 12 28 FF 00 07 31 A0 12 27 29  ; ..'G...(...1..')
9769  db 47 09 13 0D 29 65 00 01 8C 7D 15 C1 93 27 FF 2A  ; G...)e...}...'.*
9779  db 00 0E 22 1D C9 93 27 29 2A 00 0E 22 1D D8 93 29  ; .."...')*.."...)
9789  db 2A 16 20 00 31 09 13 CA 93 27 29 2A 00 0E 22 1D  ; *. .1....')*..".
9799  db C2 93 27 FF 2A 00 0E 22 1D C6 93 27 29 2A 00 0E  ; ..'.*.."...')*..
97A9  db 22 1D C4 93 27 29 2A 00 0E 22 1D C5 93 27 29 2A  ; "...')*.."...')*
97B9  db 00 0E 22 1D C0 93 27 29 2A 00 0E 22 1D 0D 2A 4F  ; .."...')*.."..*O
97C9  db 00 01 DE 7D 16 C1 93 2A FF 29 00 0E 27 1D C9 93  ; ...}...*.)..'...
97D9  db 2A FF 29 00 0E 27 1D C8 93 FF FF 29 00 0E 27 1D  ; *.)..'.....)..'.
97E9  db CA 93 2A FF 29 00 0E 27 1D C2 93 2A FF 29 00 0E  ; ..*.)..'...*.)..
97F9  db 27 1D D6 93 2A FF 17 20 00 0E 27 1D D4 93 2A FF  ; '...*.. ..'...*.
9809  db 17 20 00 0E 27 1D C5 93 2A FF 29 00 0E 27 1D D0  ; . ..'...*.)..'..
9819  db 93 2A FF 17 20 00 0E 27 1D 0D 29 54 00 01 1E 7E  ; .*.. ..'..)T...~
9829  db 16 81 01 29 00 22 89 01 29 00 22 88 01 29 00 22  ; ...)."..)."..)."
9839  db 8A 01 29 00 22 82 01 29 00 22 86 01 27 00 22 84  ; ..)."..)."..'.".
9849  db 01 27 00 22 85 01 29 00 22 B0 12 FF 18 40 00 0E  ; .'."..)."....@..
9859  db 13 0D 29 22 00 01 62 7E 16 C1 93 29 2B 27 00 0E  ; ..)"..b~...)+'..
9869  db 0E 13 C9 93 29 2B 27 00 0E 0E 13 A8 12 29 27 00  ; ....)+'......)'.
9879  db 0E 22 CA 93 29 27 29 00 0E 0E 13 82 01 29 00 31  ; ."..)')......).1
9889  db A6 12 27 29 00 0E 22 D4 93 27 FF 1A 20 00 0E 0E  ; ..').."..'.. ...
9899  db 13 A5 12 29 27 00 0E 22 C0 93 FF 29 2B 00 0E 0E  ; ...)'.."...)+...
98A9  db 13 0D 2B 31 00 01 7E 7E 1B 81 01 27 00 31 B9 12  ; ..+1..~~...'.1..
98B9  db 27 19 40 00 11 20 D8 93 2B 29 19 20 00 09 07 20  ; '.@.. ..+). ... 
98C9  db 8A 01 27 00 31 82 01 27 00 31 C6 93 27 FF 27 00  ; ..'.1..'.1..'.'.
98D9  db 09 15 12 A4 12 FF 27 00 1F 12 85 01 27 00 31 80  ; ......'.....'.1.
98E9  db 01 27 00 09 0D 27 31 00 01 A6 7E 1B 81 01 27 13  ; .'...'1...~...'.
98F9  db 1D B9 12 2B 1B 40 13 09 13 B8 12 2B 1B 40 13 09  ; ...+.@.....+.@..
9909  db 13 8A 01 27 13 1D 82 01 27 13 1D 86 01 29 13 1D  ; ...'....'....)..
9919  db 84 01 29 13 1D 85 01 27 13 1D 80 01 2B 13 1D 0D  ; ..)....'....+...
9929  db 2B 31 00 01 CE 7E 1B A1 12 27 2B 00 34 10 89 01  ; +1...~...'+.4...
9939  db 27 25 1F B8 12 29 1C 40 25 07 17 BA 12 27 1C 40  ; '%...).@%....'.@
9949  db 00 2C 17 82 01 27 00 44 A6 12 2B 27 00 25 1F C4  ; .,...'.D..+'.%..
9959  db 93 2B FF 2B 00 25 0E 10 C5 93 27 FF 27 00 25 0E  ; .+.+.%....'.'.%.
9969  db 10 C0 93 2B FF 2B 00 25 0E 10 0D 2B 44 00 01 F6  ; ...+.+.%...+D...
9979  db 7E 1C D1 93 27 FF 1D 20 00 12 13 18 C9 93 27 FF  ; ~...'.. ......'.
9989  db 27 00 12 13 18 88 01 2B 26 18 CA 93 27 FF 2B 00  ; '......+&...'.+.
9999  db 12 13 18 C2 93 27 FF 27 00 12 13 18 C6 93 27 FF  ; .....'.'......'.
99A9  db 27 00 12 13 18 D4 93 2B FF 1D 20 00 12 13 18 D5  ; '......+.. .....
99B9  db 93 27 FF 1D 20 00 12 13 18 D0 93 2B FF 1D 20 00  ; .'.. ......+.. .
99C9  db 12 13 18 0D 2B 3F 00 01 2D 7F 1C 20 00 BC 02 00  ; ....+?..-.. ....
99D9  db 60 7F 91 01 1F 80 00 23 89 01 2E 00 23 88 01 24  ; `......#....#..$
99E9  db 00 23 8A 01 2E 00 23 82 01 2E 00 23 86 01 2E 00  ; .#....#....#....
99F9  db 23 94 01 1F 80 00 23 95 01 1F 80 00 23 90 01 1F  ; #.....#.....#...
9A09  db 80 00 23 0D 24 23 00 01 A2 81 1F 81 01 24 00 2B  ; ..#.$#.......$.+
9A19  db 89 01 2E 00 2B B8 12 24 20 40 00 17 13 8A 01 2E  ; ....+..$ @......
9A29  db 00 2B 82 01 2E 00 2B 86 01 2E 00 2B 84 01 24 00  ; .+....+....+..$.
9A39  db 2B 85 01 24 00 2B A0 12 FF 24 00 0D 1D 0D 24 2B  ; +..$.+...$....$+
9A49  db 00 01 BF 81 1F 81 01 24 00 0E 89 01 2E 00 0E 88  ; .......$........
9A59  db 01 FF 00 0E 8A 01 2E 00 0E 82 01 2E 00 0E 86 01  ; ................
9A69  db 2E 00 0E 84 01 24 00 0E 85 01 24 00 0E A0 12 24  ; .....$....$....$
9A79  db 07 00 0E 13 0D 21 22 00 81 E2 81 23 81 01 2E 00  ; .....!"....#....
9A89  db 18 89 01 2E 00 18 A8 12 FF 2E 00 09 0E 8A 01 2E  ; ................
9A99  db 00 18 82 01 2E 00 18 86 01 24 00 18 84 01 24 00  ; .........$....$.
9AA9  db 18 A5 12 24 2E 00 09 0E A0 12 24 07 00 18 0E 0D  ; ...$......$.....
9AB9  db 22 27 00 81 FE 81 23 81 01 2E 00 16 89 01 2E 00  ; "'....#.........
9AC9  db 16 88 01 2E 00 16 8A 01 2E 00 16 82 01 2E 00 16  ; ................
9AD9  db 86 01 24 00 16 84 01 24 00 16 85 01 2E 00 16 90  ; ..$....$........
9AE9  db 01 23 80 00 16 0D 24 16 00 00 1E 82 81 01 2E 00  ; .#....$.........
9AF9  db 0C 89 01 2E 00 0C 88 01 2E 00 0C 8A 01 2E 00 0C  ; ................
9B09  db 82 01 2E 00 0C 86 01 24 00 0C 84 01 24 00 0C 85  ; .......$....$...
9B19  db 01 2E 00 0C C0 93 FF FF 07 00 0C 1D 13 0D 24 36  ; ..............$6
9B29  db 00 01 30 82 1F 10 32 29 00 00 76 82 10 32 2E 00  ; ..0...2)..v..2..
9B39  db 00 9E 82 10 32 1F 00 00 CA 82 10 32 33 00 00 EA  ; ....2......23...
9B49  db 82 10 32 3D 00 00 1A 83 10 32 24 00 00 52 83 10  ; ..2=.....2$..R..
9B59  db 32 5B 00 00 76 83 10 32 1F 00 00 C6 83 10 32 1F  ; 2[..v..2......2.
9B69  db 00 00 E6 83 10 32 24 00 00 06 84 10 32 3D 00 00  ; .....2$.....2=..
9B79  db 2A 84 10 32 33 00 00 62 84 10 32 24 00 00 41 70  ; *..23..b..2$..Ap
9B89  db 20 32 33 00 00 3F 79 20 33 33 00 00 F1 57 AF 9B  ;  23..?y 33...W..
9B99  db AF 9B AF 9B CD 9B E8 9B 05 9C 0C 9C 13 9C 1A 9C  ; ................
9BA9  db 21 9C 28 9C 2F 9C A1 12 08 05 1D 34 25 88 01 08  ; !.(./......4%...
9BB9  db 1D 59 82 01 09 1D 59 84 01 08 1D 59 0E 03 77 00  ; .Y....Y....Y..w.
9BC9  db 81 70 79 98 81 01 08 00 2C 88 01 08 00 2C 82 01  ; .py.....,....,..
9BD9  db 09 00 2C 84 01 06 00 2C 0C 04 2C 00 80 D0 79 81  ; ..,....,..,...y.
9BE9  db 01 08 00 2C A8 12 08 07 00 0E 1D 82 01 09 00 2C  ; ...,...........,
9BF9  db 84 01 08 00 2C 0A 09 24 00 00 F4 79 0E 8D 23 00  ; ....,..$...y..#.
9C09  db 02 18 7A 0C 8D 23 00 02 18 7A 0A 8D 23 00 02 18  ; ..z..#...z..#...
9C19  db 7A 10 0A 41 00 00 78 77 10 0A 23 00 00 B4 77 20  ; z..A..xw..#...w 
9C29  db 0A 33 00 00 40 79 20 0B 33 00 00 F1 57 4E 9C 4E  ; .3..@y .3...WN.N
9C39  db 9C 4E 9C 6B 9C 86 9C A3 9C AA 9C B1 9C B8 9C BF  ; .N.k............
9C49  db 9C C6 9C CD 9C A1 12 09 05 1D 34 25 88 01 09 1D  ; ..........4%....
9C59  db 59 82 01 08 1D 59 84 01 09 1D 59 03 03 77 00 80  ; Y....Y....Y..w..
9C69  db 70 79 81 01 09 00 2C 88 01 09 00 2C 82 01 08 00  ; py....,....,....
9C79  db 2C 84 01 06 00 2C 03 04 2C 00 80 D0 79 81 01 09  ; ,....,..,...y...
9C89  db 00 2C A8 12 09 07 00 0E 1D 82 01 08 00 2C 84 01  ; .,...........,..
9C99  db 09 00 2C 03 08 2C 00 80 F4 79 02 8D 23 00 02 18  ; ..,..,...y..#...
9CA9  db 7A 01 8D 23 00 02 18 7A 00 8D 23 00 02 18 7A 10  ; z..#...z..#...z.
9CB9  db 0A 23 00 00 B4 77 10 0A 41 00 00 78 77 20 0A 33  ; .#...w..A..xw .3
9CC9  db 00 00 40 79 20 0B 33 00 00 F1 57 EC 9C F3 9C FA  ; ..@y .3...W.....
9CD9  db 9C 01 9D 08 9D 0F 9D 16 9D 1D 9D 24 9D 2B 9D 32  ; ...........$.+.2
9CE9  db 9D 39 9D 40 00 D0 04 03 94 00 40 0A B4 00 10 29  ; .9.@......@....)
9CF9  db 00 40 0A B4 00 10 2F 00 40 0A B4 00 10 35 00 40  ; .@..../.@....5.@
9D09  db 0A B4 00 10 2C 00 40 0A B4 00 10 32 00 40 0A B4  ; ....,.@....2.@..
9D19  db 00 10 38 00 40 0A B4 00 10 5F 00 40 0A B4 00 10  ; ..8.@...._.@....
9D29  db 5C 00 40 0A B4 00 10 5C 00 40 80 B4 00 10 7C 04  ; \.@....\.@....|.
9D39  db 40 80 98 00 00 C2 84 FF FF FF FF FF FF FF FF FF  ; @...............
9D49  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9D59  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9D69  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9D79  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9D89  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9D99  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DA9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DB9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DC9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DD9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DE9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9DF9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E09  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E19  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E29  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E39  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E49  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E59  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E69  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E79  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E89  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9E99  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9EA9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9EB9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9EC9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9ED9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9EE9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9EF9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F09  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F19  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F29  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F39  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F49  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F59  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F69  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F79  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F89  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9F99  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FA9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FB9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FC9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FD9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FE9  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
9FF9  db FF FF FF FF FF FF FF                             ; .......
