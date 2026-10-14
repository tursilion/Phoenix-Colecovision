
S0000:   ; xref 01C0 01C9 069B
0000  C3 47 11      JP L1147
0003  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0013  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0023  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0033  db FF FF FF FF FF                                   ; .....

S0038:
0038  C3 44 11      JP L1144

L003B:   ; xref 1DEC
003B  E5            PUSH HL
003C  C5            PUSH BC
003D  D9            EXX
003E  21 05 00      LD HL,5
0041  19            ADD HL,DE
0042  E5            PUSH HL
0043  D9            EXX
0044  3A 11 A0      LD A,(A011h)
0047  CB 7F         BIT 7,A
0049  20 43         JR nz,L008E
004B  3A 10 A0      LD A,(A010h)
004E  CB 57         BIT 2,A
0050  20 06         JR nz,L0058
0052  E1            POP HL
0053  E5            PUSH HL
0054  CB 66         BIT 4,(HL)
0056  28 36         JR z,L008E

L0058:   ; xref 0050
0058  ED 5F         LD A,R
005A  E6 01         AND 1
005C  FE 00         CP 0
005E  20 2E         JR nz,L008E
0060  D9            EXX
0061  3E 30         LD A,30h
0063  BB            CP E
0064  D9            EXX
0065  20 05         JR nz,L006C
0067  21 70 A0      LD HL,A070h
006A  18 03         JR L006F

L006C:   ; xref 0065
006C  21 A0 A0      LD HL,A0A0h

L006F:   ; xref 006A
006F  ED 5F         LD A,R
0071  E6 07         AND 7

L0073:   ; xref 0078
0073  FE 05         CP 5
0075  38 03         JR c,L007A
0077  3D            DEC A
0078  18 F9         JR L0073

L007A:   ; xref 0075
007A  47            LD B,A
007B  85            ADD A,L
007C  6F            LD L,A
007D  AF            XOR A
007E  8C            ADC A,H
007F  67            LD H,A

L0080:   ; xref 008C
0080  7E            LD A,(HL)
0081  FE 00         CP 0
0083  28 0F         JR z,L0094
0085  2B            DEC HL
0086  78            LD A,B
0087  FE 00         CP 0
0089  28 03         JR z,L008E
008B  05            DEC B
008C  18 F2         JR L0080

L008E:   ; xref 0049 0056 005E 0089
008E  E1            POP HL
008F  C1            POP BC
0090  E1            POP HL
0091  C3 EF 1D      JP L1DEF

L0094:   ; xref 0083
0094  CB FE         SET 7,(HL)
0096  78            LD A,B
0097  E1            POP HL
0098  CB CE         SET 1,(HL)
009A  C1            POP BC
009B  E1            POP HL
009C  01 95 20      LD BC,2095h
009F  81            ADD A,C
00A0  4F            LD C,A
00A1  AF            XOR A
00A2  88            ADC A,B
00A3  47            LD B,A
00A4  C9            RET
00A5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00B5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00C5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00D5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00E5  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
00F5  db FF FF FF FF FF FF FF FF FF FF FF                 ; ...........

S0100:   ; xref 012A 1C5E
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

S012A:   ; xref 0321 0383 039C 0452 0463 0474 0485 0496
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
017B  CB 5E         BIT 3,(HL)
017D  CA F9 01      JP z,L01F9
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
01BA  21 D4 7B      LD HL,7BD4h
01BD  A7            AND A
01BE  ED 42         SBC HL,BC
01C0  DA 00 00      JP c,S0000
01C3  21 64 00      LD HL,64h
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

S0204:   ; xref 0138 0148 0151 0161 016A 0172 01F2 02BF
0204  E5            PUSH HL
0205  21 00 11      LD HL,1100h
0208  6F            LD L,A
0209  7E            LD A,(HL)
020A  32 21 A0      LD (A021h),A
020D  E1            POP HL
020E  C9            RET

S020F:   ; xref 013B 014B 0154 0164 016D 0175 01F5 02C2
020F  E5            PUSH HL
0210  21 11 A0      LD HL,A011h
0213  CB 5E         BIT 3,(HL)
0215  E1            POP HL
0216  CA 6E 02      JP z,L026E
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
02B1  db C9 C9 C9 3E 0C CD 04 02 CD 0F 02 C9              ; ...>........

S02BD:   ; xref 1229 122C
02BD  3E 0B         LD A,11
02BF  CD 04 02      CALL S0204
02C2  CD 0F 02      CALL S020F
02C5  C9            RET
02C6  db 3E 16 CD 04 02 CD 0F 02 C9                       ; >........

S02CF:   ; xref 1B6C 1B87
02CF  3E 10         LD A,10h
02D1  CD 04 02      CALL S0204
02D4  CD 0F 02      CALL S020F
02D7  C9            RET

S02D8:   ; xref 1B6F 1B8A
02D8  3E 11         LD A,11h
02DA  CD 04 02      CALL S0204
02DD  CD 0F 02      CALL S020F
02E0  C9            RET

S02E1:   ; xref 1239 1279
02E1  21 11 A0      LD HL,A011h
02E4  CB 5E         BIT 3,(HL)
02E6  CA F2 02      JP z,L02F2
02E9  3E 14         LD A,14h

L02EB:   ; xref 02F4
02EB  CD 04 02      CALL S0204
02EE  CD 0F 02      CALL S020F
02F1  C9            RET

L02F2:   ; xref 02E6
02F2  3E 17         LD A,17h
02F4  C3 EB 02      JP L02EB
02F7  db 21 11 A0 CB 5E CA 08 03 3E 15 CD 04 02 CD 0F 02  ; !...^...>.......
0307  db C9 3E 18 C3 01 03                                ; .>....

L030D:   ; xref 19D3
030D  F3            DI
030E  31 FF A7      LD SP,A7FFh
0311  21 99 00      LD HL,99h
0314  22 0B A0      LD (A00Bh),HL
0317  3E 00         LD A,0
0319  32 0D A0      LD (A00Dh),A
031C  21 08 A0      LD HL,A008h
031F  CB A6         RES 4,(HL)
0321  CD 2A 01      CALL S012A
0324  CD 8F 05      CALL S058F
0327  21 00 A0      LD HL,A000h
032A  11 01 A0      LD DE,A001h
032D  01 FF 07      LD BC,07FFh
0330  36 55         LD (HL),55h
0332  ED B0         LDIR
0334  21 00 A0      LD HL,A000h
0337  01 00 08      LD BC,0800h
033A  3E 55         LD A,55h

L033C:   ; xref 0341
033C  ED A1         CPI
033E  C2 70 03      JP nz,L0370
0341  EA 3C 03      JP pe,L033C
0344  21 00 A0      LD HL,A000h
0347  11 01 A0      LD DE,A001h
034A  01 FF 07      LD BC,07FFh
034D  36 AA         LD (HL),AAh
034F  ED B0         LDIR
0351  21 00 A0      LD HL,A000h
0354  01 00 08      LD BC,0800h
0357  3E AA         LD A,AAh

L0359:   ; xref 035E
0359  ED A1         CPI
035B  C2 70 03      JP nz,L0370
035E  EA 59 03      JP pe,L0359
0361  CD 9E 06      CALL S069E
0364  32 10 A0      LD (A010h),A
0367  CD A7 06      CALL S06A7
036A  32 11 A0      LD (A011h),A
036D  C3 89 03      JP L0389

L0370:   ; xref 033E 035B
0370  31 FF A7      LD SP,A7FFh
0373  21 AD 00      LD HL,ADh
0376  22 0B A0      LD (A00Bh),HL
0379  3E 00         LD A,0
037B  32 00 A0      LD (A000h),A
037E  21 08 A0      LD HL,A008h
0381  CB A6         RES 4,(HL)
0383  CD 2A 01      CALL S012A

L0386:   ; xref 0386 0455 0466 0477 0488 0499
0386  C3 86 03      JP L0386

L0389:   ; xref 036D
0389  31 FF A7      LD SP,A7FFh
038C  21 9C 00      LD HL,9Ch
038F  22 0B A0      LD (A00Bh),HL
0392  3E 00         LD A,0
0394  32 0D A0      LD (A00Dh),A
0397  21 08 A0      LD HL,A008h
039A  CB A6         RES 4,(HL)
039C  CD 2A 01      CALL S012A
039F  CD 8F 05      CALL S058F
03A2  11 10 04      LD DE,0410h
03A5  3E 20         LD A,20h
03A7  32 22 A0      LD (A022h),A
03AA  CD 0B 04      CALL S040B
03AD  ED 5B 23 A0   LD DE,(A023h)
03B1  21 76 F5      LD HL,F576h
03B4  CD 25 04      CALL S0425
03B7  11 00 20      LD DE,2000h
03BA  3E 40         LD A,40h
03BC  32 22 A0      LD (A022h),A
03BF  CD 0B 04      CALL S040B
03C2  ED 5B 23 A0   LD DE,(A023h)
03C6  21 63 B8      LD HL,B863h
03C9  CD 25 04      CALL S0425
03CC  11 00 40      LD DE,4000h
03CF  3E 60         LD A,60h
03D1  32 22 A0      LD (A022h),A
03D4  CD 0B 04      CALL S040B
03D7  ED 5B 23 A0   LD DE,(A023h)
03DB  21 ED AB      LD HL,ABEDh
03DE  CD 25 04      CALL S0425
03E1  11 00 60      LD DE,6000h
03E4  3E 80         LD A,L0080
03E6  32 22 A0      LD (A022h),A
03E9  CD 0B 04      CALL S040B
03EC  ED 5B 23 A0   LD DE,(A023h)
03F0  21 E4 B3      LD HL,B3E4h
03F3  CD 25 04      CALL S0425
03F6  11 00 80      LD DE,8000h
03F9  3E A0         LD A,A0h
03FB  32 22 A0      LD (A022h),A
03FE  CD 0B 04      CALL S040B
0401  ED 5B 23 A0   LD DE,(A023h)
0405  21 00 E0      LD HL,E000h
0408  C3 9C 04      JP L049C

S040B:   ; xref 03AA 03BF 03D4 03E9 03FE
040B  21 00 00      LD HL,0
040E  22 23 A0      LD (A023h),HL

L0411:   ; xref 0422
0411  06 00         LD B,0
0413  EB            EX DE,HL
0414  4E            LD C,(HL)
0415  EB            EX DE,HL
0416  2A 23 A0      LD HL,(A023h)
0419  09            ADD HL,BC
041A  22 23 A0      LD (A023h),HL
041D  13            INC DE
041E  3A 22 A0      LD A,(A022h)
0421  BA            CP D
0422  20 ED         JR nz,L0411
0424  C9            RET

S0425:   ; xref 03B4 03C9 03DE 03F3
0425  7A            LD A,D
0426  BC            CP H
0427  C2 30 04      JP nz,L0430
042A  7B            LD A,E
042B  BD            CP L
042C  C2 30 04      JP nz,L0430
042F  C9            RET

L0430:   ; xref 0427 042C
0430  3A 22 A0      LD A,(A022h)
0433  FE 40         CP 40h
0435  CA 58 04      JP z,L0458
0438  FE 60         CP 60h
043A  CA 69 04      JP z,L0469
043D  FE 80         CP L0080
043F  CA 7A 04      JP z,L047A
0442  FE A0         CP A0h
0444  CA 8B 04      JP z,L048B
0447  21 B0 00      LD HL,B0h
044A  22 0B A0      LD (A00Bh),HL
044D  3E 00         LD A,0
044F  32 0D A0      LD (A00Dh),A
0452  CD 2A 01      CALL S012A
0455  C3 86 03      JP L0386

L0458:   ; xref 0435
0458  21 B3 00      LD HL,B3h
045B  22 0B A0      LD (A00Bh),HL
045E  3E 00         LD A,0
0460  32 0D A0      LD (A00Dh),A
0463  CD 2A 01      CALL S012A
0466  C3 86 03      JP L0386

L0469:   ; xref 043A
0469  21 B6 00      LD HL,B6h
046C  22 0B A0      LD (A00Bh),HL
046F  3E 00         LD A,0
0471  32 0D A0      LD (A00Dh),A
0474  CD 2A 01      CALL S012A
0477  C3 86 03      JP L0386

L047A:   ; xref 043F
047A  21 B9 00      LD HL,B9h
047D  22 0B A0      LD (A00Bh),HL
0480  3E 00         LD A,0
0482  32 0D A0      LD (A00Dh),A
0485  CD 2A 01      CALL S012A
0488  C3 86 03      JP L0386

L048B:   ; xref 0444
048B  21 BC 00      LD HL,BCh
048E  22 0B A0      LD (A00Bh),HL
0491  3E 00         LD A,0
0493  32 0D A0      LD (A00Dh),A
0496  CD 2A 01      CALL S012A
0499  C3 86 03      JP L0386

L049C:   ; xref 0408
049C  21 A2 00      LD HL,A2h
049F  22 0B A0      LD (A00Bh),HL
04A2  3E 00         LD A,0
04A4  32 0D A0      LD (A00Dh),A
04A7  CD 2A 01      CALL S012A
04AA  C3 AD 04      JP L04AD

L04AD:   ; xref 04AA
04AD  CD 46 05      CALL S0546
04B0  3E 07         LD A,7
04B2  32 10 E0      LD (E010h),A
04B5  3E 3E         LD A,3Eh
04B7  32 00 E0      LD (E000h),A
04BA  3E 08         LD A,8
04BC  32 10 E0      LD (E010h),A
04BF  3E 0F         LD A,15
04C1  32 00 E0      LD (E000h),A
04C4  3E 00         LD A,0
04C6  32 10 E0      LD (E010h),A
04C9  CD 10 05      CALL S0510
04CC  CD 46 05      CALL S0546
04CF  3E 07         LD A,7
04D1  32 10 E0      LD (E010h),A
04D4  3E 3D         LD A,3Dh
04D6  32 00 E0      LD (E000h),A
04D9  3E 09         LD A,9
04DB  32 10 E0      LD (E010h),A
04DE  3E 0F         LD A,15
04E0  32 00 E0      LD (E000h),A
04E3  3E 02         LD A,2
04E5  32 10 E0      LD (E010h),A
04E8  CD 10 05      CALL S0510
04EB  CD 46 05      CALL S0546
04EE  3E 07         LD A,7
04F0  32 10 E0      LD (E010h),A
04F3  3E 3B         LD A,L003B
04F5  32 00 E0      LD (E000h),A
04F8  3E 0A         LD A,10
04FA  32 10 E0      LD (E010h),A
04FD  3E 0F         LD A,15
04FF  32 00 E0      LD (E000h),A
0502  3E 04         LD A,4
0504  32 10 E0      LD (E010h),A
0507  CD 10 05      CALL S0510
050A  CD 46 05      CALL S0546
050D  C3 58 05      JP L0558

S0510:   ; xref 04C9 04E8 0507
0510  3E FE         LD A,FEh
0512  32 00 E0      LD (E000h),A
0515  3E D6         LD A,D6h
0517  32 00 E0      LD (E000h),A
051A  CD 99 05      CALL S0599
051D  3E BE         LD A,BEh
051F  32 00 E0      LD (E000h),A
0522  CD 99 05      CALL S0599
0525  3E AA         LD A,AAh
0527  32 00 E0      LD (E000h),A
052A  CD 99 05      CALL S0599
052D  3E A0         LD A,A0h
052F  32 00 E0      LD (E000h),A
0532  CD 99 05      CALL S0599
0535  3E 8F         LD A,8Fh
0537  32 00 E0      LD (E000h),A
053A  CD 99 05      CALL S0599
053D  3E 7F         LD A,7Fh
053F  32 00 E0      LD (E000h),A
0542  CD 99 05      CALL S0599
0545  C9            RET

S0546:   ; xref 04AD 04CC 04EB 050A
0546  3E 00         LD A,0
0548  0E 00         LD C,0
054A  21 00 E0      LD HL,E000h

L054D:   ; xref 0555
054D  32 10 E0      LD (E010h),A
0550  3C            INC A
0551  FE 10         CP 10h
0553  C8            RET z
0554  71            LD (HL),C
0555  C3 4D 05      JP L054D

L0558:   ; xref 050D
0558  21 A4 00      LD HL,A4h
055B  22 0B A0      LD (A00Bh),HL
055E  3E 00         LD A,0
0560  32 0D A0      LD (A00Dh),A
0563  CD 2A 01      CALL S012A
0566  CD 8F 05      CALL S058F
0569  3E 00         LD A,0

L056B:   ; xref 058C
056B  32 27 A0      LD (A027h),A
056E  21 3A 11      LD HL,113Ah
0571  3A 27 A0      LD A,(A027h)
0574  85            ADD A,L
0575  6F            LD L,A
0576  7E            LD A,(HL)
0577  21 30 E0      LD HL,E030h
057A  06 10         LD B,10h

L057C:   ; xref 057E
057C  77            LD (HL),A
057D  23            INC HL
057E  10 FC         DJNZ L057C
0580  CD 8F 05      CALL S058F
0583  3A 27 A0      LD A,(A027h)
0586  3C            INC A
0587  FE 0A         CP 10
0589  CA A3 05      JP z,L05A3
058C  C3 6B 05      JP L056B

S058F:   ; xref 0324 039F 0566 0580 0682
058F  11 FF FF      LD DE,FFFFh
0592  21 FF FF      LD HL,FFFFh

L0595:   ; xref 0596
0595  19            ADD HL,DE
0596  38 FD         JR c,L0595
0598  C9            RET

S0599:   ; xref 051A 0522 052A 0532 053A 0542
0599  11 FF FF      LD DE,FFFFh
059C  21 00 60      LD HL,6000h

L059F:   ; xref 05A0
059F  19            ADD HL,DE
05A0  38 FD         JR c,L059F
05A2  C9            RET

L05A3:   ; xref 0589
05A3  21 A7 00      LD HL,A7h
05A6  22 0B A0      LD (A00Bh),HL
05A9  3E 00         LD A,0
05AB  32 0D A0      LD (A00Dh),A
05AE  CD 2A 01      CALL S012A
05B1  3E FF         LD A,FFh
05B3  21 30 E0      LD HL,E030h
05B6  06 10         LD B,10h

L05B8:   ; xref 05BA
05B8  77            LD (HL),A
05B9  23            INC HL
05BA  10 FC         DJNZ L05B8
05BC  21 FF FF      LD HL,FFFFh
05BF  22 25 A0      LD (A025h),HL

L05C2:   ; xref 0644
05C2  3A 08 C0      LD A,(C008h)
05C5  CB 47         BIT 0,A
05C7  21 3D E0      LD HL,E03Dh
05CA  CA 47 06      JP z,L0647
05CD  36 FF         LD (HL),FFh

L05CF:   ; xref 0649
05CF  3A 08 C0      LD A,(C008h)
05D2  CB 4F         BIT 1,A
05D4  21 3C E0      LD HL,E03Ch
05D7  CA 4C 06      JP z,L064C
05DA  36 FF         LD (HL),FFh

L05DC:   ; xref 064E
05DC  3A 08 C0      LD A,(C008h)
05DF  CB 57         BIT 2,A
05E1  21 3B E0      LD HL,E03Bh
05E4  CA 51 06      JP z,L0651
05E7  36 FF         LD (HL),FFh

L05E9:   ; xref 0653
05E9  3A 08 C0      LD A,(C008h)
05EC  CB 5F         BIT 3,A
05EE  21 3A E0      LD HL,E03Ah
05F1  CA 56 06      JP z,L0656
05F4  36 FF         LD (HL),FFh

L05F6:   ; xref 0658
05F6  3A 08 C0      LD A,(C008h)
05F9  CB 67         BIT 4,A
05FB  21 39 E0      LD HL,E039h
05FE  CA 5B 06      JP z,L065B
0601  36 FF         LD (HL),FFh

L0603:   ; xref 065D
0603  3A 10 C0      LD A,(C010h)
0606  CB 57         BIT 2,A
0608  21 32 E0      LD HL,E032h
060B  CA 60 06      JP z,L0660
060E  36 FF         LD (HL),FFh

L0610:   ; xref 0662
0610  3A 10 C0      LD A,(C010h)
0613  CB 47         BIT 0,A
0615  21 31 E0      LD HL,E031h
0618  CA 65 06      JP z,L0665
061B  36 FF         LD (HL),FFh

L061D:   ; xref 0667
061D  3A 10 C0      LD A,(C010h)
0620  CB 4F         BIT 1,A
0622  21 30 E0      LD HL,E030h
0625  CA 6A 06      JP z,L066A
0628  36 FF         LD (HL),FFh

L062A:   ; xref 0671
062A  3A 10 C0      LD A,(C010h)
062D  CB 5F         BIT 3,A
062F  21 33 E0      LD HL,E033h
0632  CA 6F 06      JP z,L066F
0635  36 FF         LD (HL),FFh

L0637:   ; xref 066C
0637  2A 25 A0      LD HL,(A025h)
063A  11 FF FF      LD DE,FFFFh
063D  19            ADD HL,DE
063E  D2 74 06      JP nc,L0674
0641  22 25 A0      LD (A025h),HL
0644  C3 C2 05      JP L05C2

L0647:   ; xref 05CA
0647  36 00         LD (HL),0
0649  C3 CF 05      JP L05CF

L064C:   ; xref 05D7
064C  36 00         LD (HL),0
064E  C3 DC 05      JP L05DC

L0651:   ; xref 05E4
0651  36 00         LD (HL),0
0653  C3 E9 05      JP L05E9

L0656:   ; xref 05F1
0656  36 00         LD (HL),0
0658  C3 F6 05      JP L05F6

L065B:   ; xref 05FE
065B  36 00         LD (HL),0
065D  C3 03 06      JP L0603

L0660:   ; xref 060B
0660  36 00         LD (HL),0
0662  C3 10 06      JP L0610

L0665:   ; xref 0618
0665  36 00         LD (HL),0
0667  C3 1D 06      JP L061D

L066A:   ; xref 0625
066A  36 00         LD (HL),0
066C  C3 37 06      JP L0637

L066F:   ; xref 0632
066F  36 00         LD (HL),0
0671  C3 2A 06      JP L062A

L0674:   ; xref 063E
0674  21 AA 00      LD HL,AAh
0677  22 0B A0      LD (A00Bh),HL
067A  3E 00         LD A,0
067C  32 0D A0      LD (A00Dh),A
067F  CD 2A 01      CALL S012A
0682  CD 8F 05      CALL S058F
0685  21 9A 18      LD HL,189Ah
0688  22 0B A0      LD (A00Bh),HL
068B  3E 00         LD A,0
068D  32 0D A0      LD (A00Dh),A
0690  CD 2A 01      CALL S012A

L0693:   ; xref 0698
0693  CD 9E 06      CALL S069E
0696  E6 80         AND L0080
0698  C2 93 06      JP nz,L0693
069B  C3 00 00      JP S0000

S069E:   ; xref 0361 0693 116B 1282
069E  3E 0E         LD A,14
06A0  32 10 E0      LD (E010h),A
06A3  3A 00 C0      LD A,(C000h)
06A6  C9            RET

S06A7:   ; xref 0367 1165 127C
06A7  3E 0F         LD A,15
06A9  32 10 E0      LD (E010h),A
06AC  3A 00 C0      LD A,(C000h)
06AF  C9            RET
06B0  db 3E 0F CD 04 02 CD 0F 02 C9                       ; >........

S06B9:   ; xref 1B5F
06B9  3E A3         LD A,A3h
06BB  32 21 A0      LD (A021h),A
06BE  CD 0F 02      CALL S020F
06C1  C9            RET

S06C2:   ; xref 1B7A
06C2  3E A0         LD A,A0h
06C4  32 21 A0      LD (A021h),A
06C7  CD 0F 02      CALL S020F
06CA  C9            RET
06CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
06DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
06EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
06FB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
070B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
071B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
072B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
073B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
074B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
075B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
076B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
077B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
078B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
079B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07AB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07BB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
07FB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
080B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
081B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
082B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
083B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
084B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
085B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
086B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
087B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
088B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
089B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08AB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08BB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
08FB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
090B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
091B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
092B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
093B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
094B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
095B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
096B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
097B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
098B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
099B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09AB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09BB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
09FB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0A9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0ABB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0ACB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0ADB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0AFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0B9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BBB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BCB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BDB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0BFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0C9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CBB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CCB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CDB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0CFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0D9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DBB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DCB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DDB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0DFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0E9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EBB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0ECB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EDB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0EFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F0B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F1B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F2B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F3B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F4B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F5B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F6B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F7B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F8B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0F9B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FAB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FBB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FCB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FDB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FEB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
0FFB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
100B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
101B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
102B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
103B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
104B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
105B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
106B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
107B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
108B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
109B  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10AB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10BB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10CB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10DB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10EB  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
10FB  db FF FF FF FF FF 3F 0F 8F 4F 2F AF 6F 1F 9F 5F F7  ; .....?..O/.o.._.
110B  db FD FB DF EF F1 F4 FC A3 A0 CD CE FA E1 E0 3E 0C  ; ..............>.
111B  db CD 04 02 CD 0F 02 3E 0D CD 04 02 CD 0F 02 3E 0E  ; ......>.......>.
112B  db CD 04 02 CD 0F 02 3E 0F CD 04 02 CD 0F 02 00 00  ; ......>.........
113B  db 11 22 33 44 55 66 77 88 99                       ; ."3DUfw..

L1144:   ; xref 0038
1144  C3 20 18      JP L1820

L1147:   ; xref 0000
1147  31 FF A3      LD SP,A3FFh
114A  21 00 A0      LD HL,A000h
114D  11 01 A0      LD DE,A001h
1150  01 FF 03      LD BC,03FFh
1153  36 00         LD (HL),0
1155  ED B0         LDIR
1157  CD 2D 1C      CALL S1C2D
115A  3A 20 A0      LD A,(A020h)
115D  CB E7         SET 4,A
115F  32 20 A0      LD (A020h),A
1162  32 08 E0      LD (E008h),A
1165  CD A7 06      CALL S06A7
1168  32 11 A0      LD (A011h),A
116B  CD 9E 06      CALL S069E
116E  32 10 A0      LD (A010h),A
1171  CB 5F         BIT 3,A
1173  28 17         JR z,L118C
1175  3A 11 A0      LD A,(A011h)
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
1188  F6 80         OR L0080
118A  18 03         JR L118F

L118C:   ; xref 1173
118C  3A FB 1F      LD A,(1FFBh)

L118F:   ; xref 118A
118F  32 18 A0      LD (A018h),A
1192  21 10 A0      LD HL,A010h
1195  CB 6E         BIT 5,(HL)
1197  20 07         JR nz,L11A0
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
1217  CD 9B 1A      CALL S1A9B
121A  3E F0         LD A,F0h
121C  CD C9 1B      CALL S1BC9
121F  21 30 E0      LD HL,E030h
1222  06 10         LD B,10h

L1224:   ; xref 1227
1224  36 0F         LD (HL),15
1226  23            INC HL
1227  10 FB         DJNZ L1224
1229  CD BD 02      CALL S02BD
122C  CD BD 02      CALL S02BD
122F  3E 01         LD A,1
1231  CD 9B 1A      CALL S1A9B
1234  3E F0         LD A,F0h
1236  CD C9 1B      CALL S1BC9
1239  CD E1 02      CALL S02E1
123C  CD 58 1B      CALL S1B58
123F  3E 00         LD A,0
1241  CD 9B 1A      CALL S1A9B

L1244:   ; xref 1580 1FE3
1244  21 0E A0      LD HL,A00Eh
1247  3A FA 1F      LD A,(1FFAh)
124A  77            LD (HL),A
124B  2E 0F         LD L,15
124D  36 00         LD (HL),0
124F  11 30 A0      LD DE,A030h

L1252:   ; xref 12C0 12C7 12CD
1252  3A 11 A0      LD A,(A011h)
1255  CB 4F         BIT 1,A
1257  20 17         JR nz,L1270
1259  3A 11 A0      LD A,(A011h)
125C  CB 47         BIT 0,A
125E  28 0B         JR z,L126B
1260  21 06 A0      LD HL,A006h
1263  34            INC (HL)
1264  7E            LD A,(HL)
1265  E6 07         AND 7
1267  FE 00         CP 0
1269  20 05         JR nz,L1270

L126B:   ; xref 125E
126B  CD 58 1B      CALL S1B58
126E  18 03         JR L1273

L1270:   ; xref 1257 1269
1270  CD 73 1B      CALL S1B73

L1273:   ; xref 126E
1273  CD B4 15      CALL S15B4
1276  CD BD 16      CALL S16BD
1279  CD E1 02      CALL S02E1
127C  CD A7 06      CALL S06A7
127F  32 11 A0      LD (A011h),A
1282  CD 9E 06      CALL S069E
1285  32 10 A0      LD (A010h),A
1288  21 09 A0      LD HL,A009h
128B  AF            XOR A
128C  BE            CP (HL)
128D  20 4F         JR nz,L12DE
128F  21 19 A0      LD HL,A019h
1292  BE            CP (HL)
1293  20 3A         JR nz,L12CF
1295  3A 10 A0      LD A,(A010h)
1298  CB 77         BIT 6,A
129A  20 0E         JR nz,L12AA
129C  CB 6F         BIT 5,A
129E  28 05         JR z,L12A5
12A0  21 FF 1F      LD HL,1FFFh
12A3  18 08         JR L12AD

L12A5:   ; xref 129E
12A5  21 FC 1F      LD HL,1FFCh
12A8  18 03         JR L12AD

L12AA:   ; xref 129A
12AA  21 02 20      LD HL,2002h

L12AD:   ; xref 12A3 12A8
12AD  E6 01         AND 1
12AF  FE 00         CP 0
12B1  28 0F         JR z,L12C2
12B3  23            INC HL
12B4  FE 01         CP 1
12B6  28 0A         JR z,L12C2
12B8  23            INC HL
12B9  FE 02         CP 2
12BB  28 05         JR z,L12C2
12BD  23            INC HL
12BE  FE 03         CP 3
12C0  20 90         JR nz,L1252

L12C2:   ; xref 12B1 12B6 12BB
12C2  3A 12 A0      LD A,(A012h)
12C5  FE 00         CP 0
12C7  20 89         JR nz,L1252
12C9  7E            LD A,(HL)
12CA  32 0F A0      LD (A00Fh),A
12CD  18 83         JR L1252

L12CF:   ; xref 1293
12CF  ED 4B E6 1F   LD BC,(1FE6h)
12D3  CD 92 1B      CALL S1B92

L12D6:   ; xref 12DC
12D6  21 09 A0      LD HL,A009h
12D9  3E 00         LD A,0
12DB  BE            CP (HL)
12DC  28 F8         JR z,L12D6

L12DE:   ; xref 128D 1589
12DE  ED 4B E6 1F   LD BC,(1FE6h)
12E2  CD 92 1B      CALL S1B92
12E5  21 08 A0      LD HL,A008h
12E8  CB AE         RES 5,(HL)
12EA  CD 58 1B      CALL S1B58

L12ED:   ; xref 13B6
12ED  21 09 A0      LD HL,A009h
12F0  3E 01         LD A,1
12F2  BE            CP (HL)
12F3  D2 8B 13      JP nc,L138B
12F6  21 10 C0      LD HL,C010h
12F9  CB 4E         BIT 1,(HL)
12FB  C2 8B 13      JP nz,L138B

L12FE:   ; xref 16EF
12FE  21 38 A0      LD HL,A038h
1301  3A 18 A0      LD A,(A018h)
1304  3C            INC A
1305  77            LD (HL),A
1306  2E 39         LD L,39h
1308  3A 15 A0      LD A,(A015h)
130B  77            LD (HL),A
130C  32 3F E0      LD (E03Fh),A
130F  2E 3A         LD L,3Ah
1311  36 00         LD (HL),0
1313  06 06         LD B,6

L1315:   ; xref 1318
1315  36 00         LD (HL),0
1317  23            INC HL
1318  10 FB         DJNZ L1315
131A  21 C8 A0      LD HL,A0C8h
131D  06 08         LD B,8

L131F:   ; xref 1322
131F  36 00         LD (HL),0
1321  23            INC HL
1322  10 FB         DJNZ L131F
1324  01 2F 00      LD BC,2Fh
1327  21 90 A0      LD HL,A090h
132A  11 91 A0      LD DE,A091h
132D  36 00         LD (HL),0
132F  ED B0         LDIR
1331  2E 10         LD L,10h
1333  CB 66         BIT 4,(HL)
1335  20 03         JR nz,L133A
1337  2E 09         LD L,9
1339  35            DEC (HL)

L133A:   ; xref 1335 1392 1703
133A  21 30 A0      LD HL,A030h
133D  3A 18 A0      LD A,(A018h)
1340  77            LD (HL),A
1341  2E 31         LD L,31h
1343  3A 15 A0      LD A,(A015h)
1346  77            LD (HL),A
1347  32 3E E0      LD (E03Eh),A
134A  2E 32         LD L,32h
134C  36 00         LD (HL),0
134E  06 06         LD B,6

L1350:   ; xref 1353
1350  36 00         LD (HL),0
1352  23            INC HL
1353  10 FB         DJNZ L1350
1355  21 C0 A0      LD HL,A0C0h
1358  06 08         LD B,8

L135A:   ; xref 135D
135A  36 00         LD (HL),0
135C  23            INC HL
135D  10 FB         DJNZ L135A
135F  01 2F 00      LD BC,2Fh
1362  21 60 A0      LD HL,A060h
1365  11 61 A0      LD DE,A061h
1368  36 00         LD (HL),0
136A  ED B0         LDIR
136C  2E 10         LD L,10h
136E  CB 66         BIT 4,(HL)
1370  20 03         JR nz,L1375
1372  2E 09         LD L,9
1374  35            DEC (HL)

L1375:   ; xref 1370
1375  2E 08         LD L,8
1377  3E 5F         LD A,5Fh
1379  A6            AND (HL)
137A  77            LD (HL),A
137B  21 30 E0      LD HL,E030h
137E  06 0E         LD B,14

L1380:   ; xref 1383
1380  36 0F         LD (HL),15
1382  23            INC HL
1383  10 FB         DJNZ L1380
1385  CD 58 1B      CALL S1B58
1388  C3 B9 13      JP L13B9

L138B:   ; xref 12F3 12FB
138B  21 10 C0      LD HL,C010h
138E  CB 46         BIT 0,(HL)
1390  20 02         JR nz,L1394
1392  18 A6         JR L133A

L1394:   ; xref 1390
1394  21 09 A0      LD HL,A009h
1397  3E 01         LD A,1
1399  BE            CP (HL)
139A  30 1A         JR nc,L13B6
139C  2E 08         LD L,8
139E  CB 6E         BIT 5,(HL)
13A0  C2 B6 13      JP nz,L13B6

L13A3:   ; xref 1586
13A3  ED 4B E8 1F   LD BC,(1FE8h)
13A7  ED 43 0B A0   LD (A00Bh),BC
13AB  AF            XOR A
13AC  32 0D A0      LD (A00Dh),A
13AF  2E 08         LD L,8
13B1  CB EE         SET 5,(HL)
13B3  CD 18 1C      CALL S1C18

L13B6:   ; xref 139A 13A0
13B6  C3 ED 12      JP L12ED

L13B9:   ; xref 1388 13D3 1577
13B9  21 08 A0      LD HL,A008h
13BC  CB 7E         BIT 7,(HL)
13BE  20 15         JR nz,L13D5

L13C0:   ; xref 13D9
13C0  2E 31         LD L,31h
13C2  CB 7E         BIT 7,(HL)
13C4  20 15         JR nz,L13DB
13C6  2E 39         LD L,39h
13C8  CB 7E         BIT 7,(HL)
13CA  CA 7A 15      JP z,L157A

L13CD:   ; xref 1521
13CD  2E 08         LD L,8
13CF  3E 80         LD A,L0080
13D1  AE            XOR (HL)
13D2  77            LD (HL),A
13D3  18 E4         JR L13B9

L13D5:   ; xref 13BE
13D5  2E 39         LD L,39h
13D7  CB 7E         BIT 7,(HL)
13D9  28 E5         JR z,L13C0

L13DB:   ; xref 13C4
13DB  2D            DEC L
13DC  EB            EX DE,HL
13DD  CD 34 1C      CALL S1C34
13E0  21 39 A0      LD HL,A039h
13E3  CB 7E         BIT 7,(HL)
13E5  28 36         JR z,L141D
13E7  21 31 A0      LD HL,A031h
13EA  CB 76         BIT 6,(HL)
13EC  20 2F         JR nz,L141D
13EE  CB 7E         BIT 7,(HL)
13F0  28 2B         JR z,L141D
13F2  ED 4B F2 1F   LD BC,(1FF2h)
13F6  CD 92 1B      CALL S1B92
13F9  06 08         LD B,8
13FB  CD 00 1B      CALL S1B00
13FE  3E 30         LD A,30h
1400  BD            CP L
1401  23            INC HL
1402  4E            LD C,(HL)
1403  20 05         JR nz,L140A
1405  21 3E E0      LD HL,E03Eh
1408  18 03         JR L140D

L140A:   ; xref 1403
140A  21 3F E0      LD HL,E03Fh

L140D:   ; xref 1408 141B
140D  3E 07         LD A,7
140F  CD D3 1B      CALL S1BD3
1412  CB 40         BIT 0,B
1414  20 04         JR nz,L141A
1416  36 FF         LD (HL),FFh
1418  18 01         JR L141B

L141A:   ; xref 1414
141A  71            LD (HL),C

L141B:   ; xref 1418
141B  10 F0         DJNZ L140D

L141D:   ; xref 13E5 13EC 13F0
141D  21 07 00      LD HL,7
1420  19            ADD HL,DE
1421  36 00         LD (HL),0
1423  CD 00 1B      CALL S1B00
1426  2C            INC L
1427  CB 76         BIT 6,(HL)
1429  CB B6         RES 6,(HL)
142B  20 19         JR nz,L1446
142D  21 05 00      LD HL,5
1430  19            ADD HL,DE
1431  CB 76         BIT 6,(HL)
1433  20 11         JR nz,L1446
1435  CD 00 1B      CALL S1B00
1438  7E            LD A,(HL)
1439  32 12 A0      LD (A012h),A
143C  CD E9 1B      CALL S1BE9
143F  3E 01         LD A,1
1441  32 0F A0      LD (A00Fh),A
1444  18 0A         JR L1450

L1446:   ; xref 142B 1433
1446  CD 00 1B      CALL S1B00
1449  7E            LD A,(HL)
144A  32 12 A0      LD (A012h),A
144D  CD E9 1B      CALL S1BE9

L1450:   ; xref 1444 149E 14AF
1450  CD C3 1C      CALL S1CC3

L1453:   ; xref 1475
1453  CD 14 1F      CALL S1F14
1456  CD B4 15      CALL S15B4
1459  CD BD 16      CALL S16BD
145C  3A 10 A0      LD A,(A010h)
145F  CB 5F         BIT 3,A
1461  28 14         JR z,L1477
1463  3A 10 C0      LD A,(C010h)
1466  CB 47         BIT 0,A
1468  20 0D         JR nz,L1477
146A  FD 7E 02      LD A,(IY+2)
146D  32 0E A0      LD (A00Eh),A
1470  3E 00         LD A,0
1472  32 0F A0      LD (A00Fh),A
1475  18 DC         JR L1453

L1477:   ; xref 1461 1468
1477  FD E5         PUSH IY
1479  E1            POP HL
147A  01 05 00      LD BC,5
147D  09            ADD HL,BC
147E  3A 11 A0      LD A,(A011h)
1481  CB 6F         BIT 5,A
1483  28 2D         JR z,L14B2

L1485:   ; xref 14C4
1485  CB 6E         BIT 5,(HL)
1487  C4 1E 1E      CALL nz,S1E1E
148A  21 01 00      LD HL,1
148D  19            ADD HL,DE
148E  AF            XOR A
148F  BE            CP (HL)
1490  CA 41 15      JP z,L1541

L1493:   ; xref 14B7 14BB
1493  FD CB 00 66   BIT 4,(IY)
1497  20 2D         JR nz,L14C6
1499  3A 12 A0      LD A,(A012h)
149C  CB 7F         BIT 7,A
149E  CA 50 14      JP z,L1450
14A1  21 05 00      LD HL,5
14A4  19            ADD HL,DE
14A5  CB 9E         RES 3,(HL)
14A7  CB 8E         RES 1,(HL)
14A9  CD D8 1E      CALL S1ED8
14AC  CD A7 1F      CALL S1FA7
14AF  C3 50 14      JP L1450

L14B2:   ; xref 1483
14B2  FD 7E 02      LD A,(IY+2)
14B5  FE 94         CP L0094
14B7  28 DA         JR z,L1493
14B9  FE BE         CP BEh
14BB  28 D6         JR z,L1493
14BD  FD CB 00 6E   BIT 5,(IY)
14C1  C2 8C 15      JP nz,L158C
14C4  18 BF         JR L1485

L14C6:   ; xref 1497
14C6  21 05 00      LD HL,5
14C9  19            ADD HL,DE
14CA  CB FE         SET 7,(HL)
14CC  3A 10 A0      LD A,(A010h)
14CF  CB 5F         BIT 3,A
14D1  20 22         JR nz,L14F5
14D3  21 05 00      LD HL,5
14D6  19            ADD HL,DE
14D7  FD CB 05 56   BIT 2,(IY+5)
14DB  20 18         JR nz,L14F5
14DD  CB F6         SET 6,(HL)
14DF  CD F2 1E      CALL S1EF2
14E2  21 05 00      LD HL,5
14E5  19            ADD HL,DE
14E6  CB 6E         BIT 5,(HL)
14E8  20 0B         JR nz,L14F5
14EA  21 06 00      LD HL,6
14ED  19            ADD HL,DE
14EE  7E            LD A,(HL)
14EF  3C            INC A
14F0  F6 80         OR L0080
14F2  FD 77 02      LD (IY+2),A

L14F5:   ; xref 14D1 14DB 14E8
14F5  21 05 00      LD HL,5
14F8  19            ADD HL,DE
14F9  CB 8E         RES 1,(HL)
14FB  CD 00 1B      CALL S1B00
14FE  FD 7E 02      LD A,(IY+2)
1501  77            LD (HL),A
1502  2C            INC L
1503  3A 0A A0      LD A,(A00Ah)
1506  CB 47         BIT 0,A
1508  20 0F         JR nz,L1519
150A  3A 11 A0      LD A,(A011h)
150D  CB 57         BIT 2,A
150F  20 08         JR nz,L1519
1511  3A 10 A0      LD A,(A010h)
1514  CB 5F         BIT 3,A
1516  20 01         JR nz,L1519
1518  35            DEC (HL)

L1519:   ; xref 1508 150F 1516
1519  E5            PUSH HL
151A  CD 34 1C      CALL S1C34
151D  E1            POP HL
151E  3E 3F         LD A,3Fh
1520  A6            AND (HL)
1521  C2 CD 13      JP nz,L13CD
1524  18 00         JR L1526

L1526:   ; xref 1524
1526  21 31 A0      LD HL,A031h
1529  3E 3F         LD A,3Fh
152B  A6            AND (HL)
152C  20 13         JR nz,L1541
152E  2E 39         LD L,39h
1530  3E 3F         LD A,3Fh
1532  A6            AND (HL)
1533  20 0C         JR nz,L1541

L1535:   ; xref 153F
1535  CD B4 15      CALL S15B4
1538  CD BD 16      CALL S16BD
153B  FD CB 00 6E   BIT 5,(IY)
153F  28 F4         JR z,L1535

L1541:   ; xref 1490 152C 1533 1F4B
1541  21 39 A0      LD HL,A039h
1544  CB 7E         BIT 7,(HL)
1546  28 1A         JR z,L1562
1548  CD 00 1B      CALL S1B00
154B  3E 30         LD A,30h
154D  BB            CP E
154E  20 06         JR nz,L1556
1550  ED 4B F4 1F   LD BC,(1FF4h)
1554  18 04         JR L155A

L1556:   ; xref 154E
1556  ED 4B F6 1F   LD BC,(1FF6h)

L155A:   ; xref 1554
155A  CD 92 1B      CALL S1B92
155D  3E 20         LD A,20h
155F  CD D3 1B      CALL S1BD3

L1562:   ; xref 1546
1562  CD 00 1B      CALL S1B00
1565  2C            INC L
1566  CB BE         RES 7,(HL)

L1568:   ; xref 15B2
1568  3E 30         LD A,30h
156A  BB            CP E
156B  3E 0F         LD A,15
156D  20 05         JR nz,L1574
156F  32 3E E0      LD (E03Eh),A
1572  18 03         JR L1577

L1574:   ; xref 156D
1574  32 3F E0      LD (E03Fh),A

L1577:   ; xref 1572
1577  C3 B9 13      JP L13B9

L157A:   ; xref 13CA
157A  21 09 A0      LD HL,A009h
157D  3E 00         LD A,0
157F  BE            CP (HL)
1580  CA 44 12      JP z,L1244
1583  3E 02         LD A,2
1585  BE            CP (HL)
1586  DA A3 13      JP c,L13A3
1589  C3 DE 12      JP L12DE

L158C:   ; xref 14C1
158C  CD 00 1B      CALL S1B00
158F  2C            INC L
1590  36 00         LD (HL),0
1592  21 0A A0      LD HL,A00Ah
1595  CB 86         RES 0,(HL)
1597  CD 34 1B      CALL S1B34
159A  ED 4B EE 1F   LD BC,(1FEEh)
159E  ED 43 0B A0   LD (A00Bh),BC
15A2  AF            XOR A
15A3  32 0D A0      LD (A00Dh),A
15A6  2E 08         LD L,8
15A8  CB EE         SET 5,(HL)
15AA  CD 18 1C      CALL S1C18
15AD  3E FF         LD A,FFh
15AF  CD D3 1B      CALL S1BD3
15B2  18 B4         JR L1568

S15B4:   ; xref 1273 1456 1535
15B4  D9            EXX
15B5  21 08 A0      LD HL,A008h
15B8  CB 96         RES 2,(HL)
15BA  2E 0A         LD L,10
15BC  CB FE         SET 7,(HL)
15BE  21 0E A0      LD HL,A00Eh
15C1  3E 7F         LD A,7Fh
15C3  A6            AND (HL)
15C4  47            LD B,A
15C5  2E 0F         LD L,15
15C7  3E 7F         LD A,7Fh
15C9  A6            AND (HL)
15CA  4F            LD C,A
15CB  78            LD A,B
15CC  CB 27         SLA A
15CE  5F            LD E,A
15CF  16 00         LD D,0
15D1  21 08 21      LD HL,2108h
15D4  19            ADD HL,DE
15D5  CD B6 1A      CALL S1AB6
15D8  79            LD A,C
15D9  CB 27         SLA A
15DB  5F            LD E,A
15DC  16 00         LD D,0
15DE  19            ADD HL,DE
15DF  CD B6 1A      CALL S1AB6
15E2  DD 21 D0 A0   LD IX,A0D0h

L15E6:   ; xref 162D
15E6  11 10 00      LD DE,10h
15E9  DD 19         ADD IX,DE
15EB  CB 7E         BIT 7,(HL)
15ED  28 40         JR z,L162F
15EF  0E 00         LD C,0
15F1  CD C7 1A      CALL S1AC7
15F4  23            INC HL
15F5  0C            INC C
15F6  CD C7 1A      CALL S1AC7
15F9  23            INC HL
15FA  0C            INC C
15FB  3E 60         LD A,60h
15FD  DD A6 00      AND (IX)

L1600:   ; xref 1607
1600  CD C7 1A      CALL S1AC7
1603  23            INC HL
1604  0C            INC C
1605  D6 20         SUB 20h
1607  30 F7         JR nc,L1600
1609  DD CB 00 66   BIT 4,(IX)
160D  28 06         JR z,L1615
160F  0E 07         LD C,7
1611  CD C7 1A      CALL S1AC7
1614  23            INC HL

L1615:   ; xref 160D
1615  3E 00         LD A,0
1617  DD 77 0E      LD (IX+14),A
161A  DD 77 0F      LD (IX+15),A
161D  3E 03         LD A,3
161F  DD A6 01      AND (IX+1)
1622  0E 0C         LD C,12

L1624:   ; xref 162B
1624  CD C7 1A      CALL S1AC7
1627  23            INC HL
1628  0C            INC C
1629  D6 01         SUB 1
162B  30 F7         JR nc,L1624
162D  18 B7         JR L15E6

L162F:   ; xref 15ED
162F  CD C2 1A      CALL S1AC2
1632  0E 00         LD C,0
1634  CD D8 1A      CALL S1AD8
1637  23            INC HL
1638  0C            INC C
1639  CD D8 1A      CALL S1AD8
163C  23            INC HL
163D  0E 0E         LD C,14
163F  CD D8 1A      CALL S1AD8
1642  23            INC HL
1643  0C            INC C
1644  CD D8 1A      CALL S1AD8
1647  23            INC HL
1648  0E 05         LD C,5
164A  CD D8 1A      CALL S1AD8
164D  23            INC HL
164E  0E 03         LD C,3
1650  CD D8 1A      CALL S1AD8
1653  23            INC HL
1654  0C            INC C
1655  CD D8 1A      CALL S1AD8
1658  3A 0E A0      LD A,(A00Eh)
165B  FD 77 02      LD (IY+2),A
165E  FD 7E 03      LD A,(IY+3)
1661  32 0B A0      LD (A00Bh),A
1664  FD 7E 04      LD A,(IY+4)
1667  32 0C A0      LD (A00Ch),A
166A  AF            XOR A
166B  32 0D A0      LD (A00Dh),A
166E  3E 0F         LD A,15
1670  FD A6 00      AND (IY)
1673  21 9A 20      LD HL,209Ah
1676  CB 27         SLA A
1678  5F            LD E,A
1679  16 00         LD D,0
167B  CB 12         RL D
167D  19            ADD HL,DE
167E  CD B6 1A      CALL S1AB6
1681  22 13 A0      LD (A013h),HL
1684  21 08 A0      LD HL,A008h
1687  CB 4E         BIT 1,(HL)
1689  CB 8E         RES 1,(HL)
168B  20 10         JR nz,L169D
168D  FD CB 05 66   BIT 4,(IY+5)
1691  28 07         JR z,L169A
1693  D9            EXX
1694  CD 18 1C      CALL S1C18
1697  D9            EXX
1698  18 03         JR L169D

L169A:   ; xref 1691
169A  CD 08 1C      CALL S1C08

L169D:   ; xref 168B 1698
169D  21 08 A0      LD HL,A008h
16A0  CB D6         SET 2,(HL)
16A2  D9            EXX
16A3  CD 34 1B      CALL S1B34
16A6  CD BE 1B      CALL S1BBE
16A9  CD 2D 1C      CALL S1C2D
16AC  C9            RET

L16AD:   ; xref 16C2
16AD  21 0A A0      LD HL,A00Ah
16B0  CB 86         RES 0,(HL)
16B2  3A 08 C0      LD A,(C008h)
16B5  FE EA         CP EAh
16B7  20 0B         JR nz,L16C4
16B9  CB C6         SET 0,(HL)
16BB  18 07         JR L16C4

S16BD:   ; xref 1276 1459 1538
16BD  D9            EXX

L16BE:   ; xref 1720 1726
16BE  FD CB 05 46   BIT 0,(IY+5)
16C2  20 E9         JR nz,L16AD

L16C4:   ; xref 16B7 16BB
16C4  C3 4C 17      JP L174C

L16C7:   ; xref 1772
16C7  FD CB 00 76   BIT 6,(IY)
16CB  20 39         JR nz,L1706
16CD  FD CB 05 76   BIT 6,(IY+5)
16D1  CA 18 17      JP z,L1718
16D4  21 10 A0      LD HL,A010h
16D7  CB 66         BIT 4,(HL)
16D9  20 0F         JR nz,L16EA
16DB  21 09 A0      LD HL,A009h
16DE  3E 00         LD A,0
16E0  BE            CP (HL)
16E1  28 35         JR z,L1718
16E3  2E 09         LD L,9
16E5  3E 01         LD A,1
16E7  BE            CP (HL)
16E8  28 08         JR z,L16F2

L16EA:   ; xref 16D9 1716
16EA  21 10 C0      LD HL,C010h
16ED  CB 4E         BIT 1,(HL)
16EF  CA FE 12      JP z,L12FE

L16F2:   ; xref 16E8
16F2  21 10 C0      LD HL,C010h
16F5  CB 46         BIT 0,(HL)
16F7  20 1F         JR nz,L1718
16F9  3E 00         LD A,0
16FB  32 39 A0      LD (A039h),A
16FE  3E 0F         LD A,15
1700  32 3F E0      LD (E03Fh),A
1703  C3 3A 13      JP L133A

L1706:   ; xref 16CB
1706  21 19 A0      LD HL,A019h
1709  3E 00         LD A,0
170B  BE            CP (HL)
170C  C0            RET nz
170D  21 09 A0      LD HL,A009h
1710  BE            CP (HL)
1711  C0            RET nz
1712  2E 10         LD L,10h
1714  CB 66         BIT 4,(HL)
1716  20 D2         JR nz,L16EA

L1718:   ; xref 16D1 16E1 16F7
1718  CD BE 1B      CALL S1BBE
171B  3E 00         LD A,0
171D  FD BE 0F      CP (IY+15)
1720  C2 BE 16      JP nz,L16BE
1723  FD BE 0E      CP (IY+14)
1726  C2 BE 16      JP nz,L16BE
1729  FD CB 05 7E   BIT 7,(IY+5)
172D  28 11         JR z,L1740
172F  21 08 A0      LD HL,A008h
1732  CB CE         SET 1,(HL)

L1734:   ; xref 1739 173E
1734  3E 00         LD A,0
1736  FD BE 0F      CP (IY+15)
1739  20 F9         JR nz,L1734
173B  FD BE 0E      CP (IY+14)
173E  20 F4         JR nz,L1734

L1740:   ; xref 172D
1740  FD 7E 01      LD A,(IY+1)

L1743:   ; xref 181D
1743  21 12 A0      LD HL,A012h
1746  77            LD (HL),A
1747  CD E9 1B      CALL S1BE9
174A  D9            EXX
174B  C9            RET

L174C:   ; xref 16C4
174C  FD CB 00 76   BIT 6,(IY)
1750  20 03         JR nz,L1755
1752  CD 7D 1C      CALL S1C7D

L1755:   ; xref 1750
1755  DD 21 E0 A0   LD IX,A0E0h

L1759:   ; xref 1794
1759  DD CB 00 7E   BIT 7,(IX)
175D  20 16         JR nz,L1775
175F  06 0B         LD B,11
1761  21 40 A0      LD HL,A040h

L1764:   ; xref 1769
1764  CB 7E         BIT 7,(HL)
1766  20 05         JR nz,L176D
1768  23            INC HL
1769  10 F9         DJNZ L1764
176B  18 05         JR L1772

L176D:   ; xref 1766
176D  3E 02         LD A,2
176F  CD 8E 1B      CALL S1B8E

L1772:   ; xref 176B
1772  C3 C7 16      JP L16C7

L1775:   ; xref 175D
1775  DD 7E 01      LD A,(IX+1)
1778  E6 03         AND 3
177A  47            LD B,A
177B  DD 7E 01      LD A,(IX+1)
177E  CB 3F         SRL A
1780  CB 3F         SRL A
1782  4F            LD C,A
1783  DD E5         PUSH IX
1785  E1            POP HL
1786  7D            LD A,L
1787  C6 0C         ADD A,12
1789  6F            LD L,A
178A  3E 00         LD A,0
178C  BE            CP (HL)
178D  28 07         JR z,L1796

L178F:   ; xref 17A1 17AF
178F  11 10 00      LD DE,10h
1792  DD 19         ADD IX,DE
1794  18 C3         JR L1759

L1796:   ; xref 178D 179F
1796  23            INC HL
1797  BE            CP (HL)
1798  20 09         JR nz,L17A3
179A  CB 39         SRL C
179C  CB 39         SRL C
179E  05            DEC B
179F  20 F5         JR nz,L1796

L17A1:   ; xref 17BE
17A1  18 EC         JR L178F

L17A3:   ; xref 1798
17A3  3E 0F         LD A,15
17A5  DD A6 00      AND (IX)
17A8  21 40 A0      LD HL,A040h
17AB  85            ADD A,L
17AC  6F            LD L,A
17AD  CB 7E         BIT 7,(HL)
17AF  28 DE         JR z,L178F
17B1  3E 03         LD A,3
17B3  A1            AND C
17B4  C6 02         ADD A,2
17B6  DD E5         PUSH IX
17B8  E1            POP HL
17B9  85            ADD A,L
17BA  6F            LD L,A
17BB  7E            LD A,(HL)
17BC  FE FF         CP FFh
17BE  28 E1         JR z,L17A1
17C0  22 5A A0      LD (A05Ah),HL
17C3  3E 01         LD A,1
17C5  CD 8E 1B      CALL S1B8E
17C8  CD BE 1B      CALL S1BBE
17CB  DD CB 00 66   BIT 4,(IX)
17CF  28 44         JR z,L1815
17D1  2A 5A A0      LD HL,(A05Ah)
17D4  EB            EX DE,HL
17D5  21 08 A0      LD HL,A008h
17D8  7B            LD A,E
17D9  E6 0F         AND 15
17DB  FE 02         CP 2
17DD  28 0E         JR z,L17ED
17DF  FE 03         CP 3
17E1  28 14         JR z,L17F7
17E3  DD CB 07 6E   BIT 5,(IX+7)
17E7  28 2C         JR z,L1815
17E9  CB CE         SET 1,(HL)
17EB  18 12         JR L17FF

L17ED:   ; xref 17DD
17ED  DD CB 07 7E   BIT 7,(IX+7)
17F1  28 22         JR z,L1815
17F3  CB CE         SET 1,(HL)
17F5  18 08         JR L17FF

L17F7:   ; xref 17E1
17F7  DD CB 07 76   BIT 6,(IX+7)
17FB  28 18         JR z,L1815
17FD  CB CE         SET 1,(HL)

L17FF:   ; xref 17EB 17F5 1804 1809 180E 1813
17FF  3E 00         LD A,0
1801  DD BE 0C      CP (IX+12)
1804  20 F9         JR nz,L17FF
1806  DD BE 0D      CP (IX+13)
1809  20 F4         JR nz,L17FF
180B  DD BE 0E      CP (IX+14)
180E  20 EF         JR nz,L17FF
1810  DD BE 0F      CP (IX+15)
1813  20 EA         JR nz,L17FF

L1815:   ; xref 17CF 17E7 17F1 17FB
1815  2A 5A A0      LD HL,(A05Ah)
1818  7E            LD A,(HL)
1819  FD CB 00 A6   RES 4,(IY)
181D  C3 43 17      JP L1743

L1820:   ; xref 1144
1820  F5            PUSH AF
1821  C5            PUSH BC
1822  D5            PUSH DE
1823  E5            PUSH HL
1824  08            EX AF,AF'
1825  F5            PUSH AF
1826  21 01 A0      LD HL,A001h
1829  CB 56         BIT 2,(HL)
182B  20 05         JR nz,L1832
182D  CB CE         SET 1,(HL)
182F  C3 EE 19      JP L19EE

L1832:   ; xref 182B
1832  21 0A A0      LD HL,A00Ah
1835  CB F6         SET 6,(HL)
1837  3A 0A A0      LD A,(A00Ah)
183A  CB 6F         BIT 5,A
183C  C2 EE 19      JP nz,L19EE
183F  21 1A A0      LD HL,A01Ah
1842  CB 7E         BIT 7,(HL)
1844  20 22         JR nz,L1868
1846  3A 10 C0      LD A,(C010h)
1849  CB 57         BIT 2,A
184B  20 14         JR nz,L1861
184D  3A 01 A0      LD A,(A001h)
1850  CB 5F         BIT 3,A
1852  28 0B         JR z,L185F
1854  3A 4C A0      LD A,(A04Ch)
1857  3C            INC A
1858  32 4C A0      LD (A04Ch),A
185B  FE 03         CP 3
185D  20 31         JR nz,L1890

L185F:   ; xref 1852
185F  CB FE         SET 7,(HL)

L1861:   ; xref 184B
1861  3E 00         LD A,0
1863  32 4C A0      LD (A04Ch),A
1866  18 28         JR L1890

L1868:   ; xref 1844
1868  3A 10 C0      LD A,(C010h)
186B  CB 57         BIT 2,A
186D  28 1C         JR z,L188B
186F  3A 01 A0      LD A,(A001h)
1872  CB 5F         BIT 3,A
1874  28 0B         JR z,L1881
1876  3A 4C A0      LD A,(A04Ch)
1879  3C            INC A
187A  32 4C A0      LD (A04Ch),A
187D  FE 03         CP 3
187F  20 0F         JR nz,L1890

L1881:   ; xref 1874
1881  CB BE         RES 7,(HL)
1883  21 19 A0      LD HL,A019h
1886  34            INC (HL)
1887  21 5D A0      LD HL,A05Dh
188A  34            INC (HL)

L188B:   ; xref 186D
188B  3E 00         LD A,0
188D  32 4C A0      LD (A04Ch),A

L1890:   ; xref 185D 1866 187F
1890  21 1A A0      LD HL,A01Ah
1893  CB 76         BIT 6,(HL)
1895  20 22         JR nz,L18B9
1897  3A 10 C0      LD A,(C010h)
189A  CB 5F         BIT 3,A
189C  20 14         JR nz,L18B2
189E  3A 01 A0      LD A,(A001h)
18A1  CB 5F         BIT 3,A
18A3  28 0B         JR z,L18B0
18A5  3A 4D A0      LD A,(A04Dh)
18A8  3C            INC A
18A9  32 4D A0      LD (A04Dh),A
18AC  FE 03         CP 3
18AE  20 31         JR nz,L18E1

L18B0:   ; xref 18A3
18B0  CB F6         SET 6,(HL)

L18B2:   ; xref 189C
18B2  3E 00         LD A,0
18B4  32 4D A0      LD (A04Dh),A
18B7  18 28         JR L18E1

L18B9:   ; xref 1895
18B9  3A 10 C0      LD A,(C010h)
18BC  CB 5F         BIT 3,A
18BE  28 1C         JR z,L18DC
18C0  3A 01 A0      LD A,(A001h)
18C3  CB 5F         BIT 3,A
18C5  28 0B         JR z,L18D2
18C7  3A 4D A0      LD A,(A04Dh)
18CA  3C            INC A
18CB  32 4D A0      LD (A04Dh),A
18CE  FE 03         CP 3
18D0  20 0F         JR nz,L18E1

L18D2:   ; xref 18C5
18D2  CB B6         RES 6,(HL)
18D4  21 19 A0      LD HL,A019h
18D7  34            INC (HL)
18D8  21 5D A0      LD HL,A05Dh
18DB  34            INC (HL)

L18DC:   ; xref 18BE
18DC  3E 00         LD A,0
18DE  32 4D A0      LD (A04Dh),A

L18E1:   ; xref 18AE 18B7 18D0
18E1  3A 01 A0      LD A,(A001h)
18E4  CB 5F         BIT 3,A
18E6  28 0C         JR z,L18F4
18E8  3A 5C A0      LD A,(A05Ch)
18EB  3C            INC A
18EC  32 5C A0      LD (A05Ch),A
18EF  E6 07         AND 7
18F1  C2 F1 19      JP nz,L19F1

L18F4:   ; xref 18E6
18F4  3A 5D A0      LD A,(A05Dh)
18F7  FE 00         CP 0
18F9  28 15         JR z,L1910
18FB  3A 20 A0      LD A,(A020h)
18FE  CB 67         BIT 4,A
1900  28 0E         JR z,L1910
1902  3A 5D A0      LD A,(A05Dh)
1905  3D            DEC A
1906  32 5D A0      LD (A05Dh),A
1909  3A 20 A0      LD A,(A020h)
190C  CB A7         RES 4,A
190E  18 05         JR L1915

L1910:   ; xref 18F9 1900
1910  3A 20 A0      LD A,(A020h)
1913  CB E7         SET 4,A

L1915:   ; xref 190E
1915  32 20 A0      LD (A020h),A
1918  32 08 E0      LD (E008h),A
191B  21 08 A0      LD HL,A008h
191E  CB 56         BIT 2,(HL)
1920  28 5E         JR z,L1980
1922  21 01 A0      LD HL,A001h
1925  CB 46         BIT 0,(HL)
1927  28 04         JR z,L192D
1929  06 1F         LD B,1Fh
192B  18 02         JR L192F

L192D:   ; xref 1927
192D  06 FF         LD B,FFh

L192F:   ; xref 192B
192F  21 00 A0      LD HL,A000h
1932  7E            LD A,(HL)
1933  3C            INC A
1934  77            LD (HL),A
1935  B8            CP B
1936  20 05         JR nz,L193D
1938  AF            XOR A
1939  77            LD (HL),A
193A  C3 80 19      JP L1980

L193D:   ; xref 1936
193D  01 E0 A0      LD BC,A0E0h
1940  CD 03 1B      CALL S1B03

L1943:   ; xref 195B 196D
1943  CB 7E         BIT 7,(HL)
1945  28 28         JR z,L196F
1947  3E 0C         LD A,12
1949  85            ADD A,L
194A  6F            LD L,A
194B  3E 00         LD A,0
194D  BE            CP (HL)
194E  28 0D         JR z,L195D

L1950:   ; xref 1966
1950  35            DEC (HL)
1951  CD 03 1B      CALL S1B03
1954  01 10 00      LD BC,10h
1957  09            ADD HL,BC
1958  CD 06 1B      CALL S1B06
195B  18 E6         JR L1943

L195D:   ; xref 194E 1968
195D  23            INC HL
195E  3E 0F         LD A,15
1960  A5            AND L
1961  28 07         JR z,L196A
1963  3E 00         LD A,0
1965  BE            CP (HL)
1966  20 E8         JR nz,L1950
1968  18 F3         JR L195D

L196A:   ; xref 1961
196A  CD 06 1B      CALL S1B06
196D  18 D4         JR L1943

L196F:   ; xref 1945
196F  FD E5         PUSH IY
1971  E1            POP HL
1972  3E 0E         LD A,14
1974  85            ADD A,L
1975  6F            LD L,A
1976  CD E7 1A      CALL S1AE7
1979  30 05         JR nc,L1980
197B  36 00         LD (HL),0
197D  23            INC HL
197E  36 00         LD (HL),0

L1980:   ; xref 1920 193A 1979
1980  21 1F A0      LD HL,A01Fh
1983  3E 00         LD A,0
1985  BE            CP (HL)
1986  28 01         JR z,L1989
1988  35            DEC (HL)

L1989:   ; xref 1986 19C2
1989  21 10 A0      LD HL,A010h
198C  CB 66         BIT 4,(HL)
198E  28 0C         JR z,L199C
1990  3E 00         LD A,0
1992  32 36 E0      LD (E036h),A
1995  3E 02         LD A,2
1997  32 37 E0      LD (E037h),A
199A  18 2B         JR L19C7

L199C:   ; xref 198E
199C  21 10 A0      LD HL,A010h
199F  3E 01         LD A,1
19A1  A6            AND (HL)
19A2  3C            INC A
19A3  2E 19         LD L,19h
19A5  BE            CP (HL)
19A6  30 1C         JR nc,L19C4
19A8  2E 09         LD L,9
19AA  34            INC (HL)
19AB  3C            INC A
19AC  47            LD B,A
19AD  2E 19         LD L,19h
19AF  7E            LD A,(HL)
19B0  90            SUB B
19B1  77            LD (HL),A
19B2  3A 20 A0      LD A,(A020h)
19B5  CB A7         RES 4,A
19B7  32 20 A0      LD (A020h),A
19BA  32 08 E0      LD (E008h),A
19BD  3E 00         LD A,0
19BF  CD 9B 1A      CALL S1A9B
19C2  18 C5         JR L1989

L19C4:   ; xref 19A6
19C4  CD 9E 1B      CALL S1B9E

L19C7:   ; xref 199A
19C7  3E 0E         LD A,14
19C9  32 10 E0      LD (E010h),A
19CC  3A 00 C0      LD A,(C000h)
19CF  CB 7F         BIT 7,A
19D1  28 03         JR z,L19D6
19D3  C3 0D 03      JP L030D

L19D6:   ; xref 19D1
19D6  21 5E A0      LD HL,A05Eh
19D9  CD E7 1A      CALL S1AE7
19DC  30 05         JR nc,L19E3
19DE  36 00         LD (HL),0
19E0  23            INC HL
19E1  36 00         LD (HL),0

L19E3:   ; xref 19DC
19E3  21 DE A0      LD HL,A0DEh
19E6  CD E7 1A      CALL S1AE7
19E9  30 03         JR nc,L19EE
19EB  C3 CF 1F      JP L1FCF

L19EE:   ; xref 182F 183C 19E9
19EE  CD FA 19      CALL S19FA

L19F1:   ; xref 18F1
19F1  F1            POP AF
19F2  08            EX AF,AF'
19F3  E1            POP HL
19F4  D1            POP DE
19F5  C1            POP BC
19F6  F1            POP AF
19F7  FB            EI
19F8  ED 4D         RETI

S19FA:   ; xref 19EE
19FA  21 1C A0      LD HL,A01Ch
19FD  CB 46         BIT 0,(HL)
19FF  C8            RET z
1A00  2E 1F         LD L,1Fh
1A02  3E 00         LD A,0
1A04  BE            CP (HL)
1A05  C0            RET nz
1A06  2E 1D         LD L,1Dh
1A08  CD B6 1A      CALL S1AB6
1A0B  11 1D A0      LD DE,A01Dh
1A0E  46            LD B,(HL)
1A0F  23            INC HL
1A10  3E 03         LD A,3
1A12  A0            AND B
1A13  4F            LD C,A
1A14  CB 21         SLA C
1A16  3E FF         LD A,FFh
1A18  CD 89 1A      CALL S1A89
1A1B  CB 68         BIT 5,B
1A1D  28 07         JR z,L1A26
1A1F  3E 05         LD A,5
1A21  0E 01         LD C,1
1A23  CD 89 1A      CALL S1A89

L1A26:   ; xref 1A1D
1A26  3E 0C         LD A,12
1A28  A0            AND B
1A29  4F            LD C,A
1A2A  CB 39         SRL C
1A2C  CB 39         SRL C
1A2E  3E 07         LD A,7
1A30  CD 89 1A      CALL S1A89
1A33  CB 60         BIT 4,B
1A35  28 0C         JR z,L1A43
1A37  7E            LD A,(HL)
1A38  23            INC HL
1A39  EB            EX DE,HL
1A3A  2E 1B         LD L,1Bh
1A3C  77            LD (HL),A
1A3D  2E 1F         LD L,1Fh
1A3F  77            LD (HL),A
1A40  EB            EX DE,HL
1A41  18 08         JR L1A4B

L1A43:   ; xref 1A35
1A43  EB            EX DE,HL
1A44  2E 1B         LD L,1Bh
1A46  7E            LD A,(HL)
1A47  2E 1F         LD L,1Fh
1A49  77            LD (HL),A
1A4A  EB            EX DE,HL

L1A4B:   ; xref 1A41
1A4B  CB 70         BIT 6,B
1A4D  28 07         JR z,L1A56
1A4F  3E 0A         LD A,10
1A51  0E 02         LD C,2
1A53  CD 89 1A      CALL S1A89

L1A56:   ; xref 1A4D
1A56  CB 7E         BIT 7,(HL)
1A58  28 0D         JR z,L1A67
1A5A  3E 07         LD A,7
1A5C  32 10 E0      LD (E010h),A
1A5F  7E            LD A,(HL)
1A60  2F            CPL
1A61  E6 3F         AND 3Fh
1A63  32 00 E0      LD (E000h),A
1A66  23            INC HL

L1A67:   ; xref 1A58
1A67  CB 78         BIT 7,B
1A69  28 09         JR z,L1A74
1A6B  3E 0D         LD A,13
1A6D  32 10 E0      LD (E010h),A
1A70  7E            LD A,(HL)
1A71  32 00 E0      LD (E000h),A

L1A74:   ; xref 1A69
1A74  CB 6E         BIT 5,(HL)
1A76  28 0B         JR z,L1A83
1A78  23            INC HL
1A79  CD 06 1B      CALL S1B06
1A7C  21 1D A0      LD HL,A01Dh
1A7F  71            LD (HL),C
1A80  23            INC HL
1A81  70            LD (HL),B
1A82  C9            RET

L1A83:   ; xref 1A76
1A83  21 1C A0      LD HL,A01Ch
1A86  CB 86         RES 0,(HL)
1A88  C9            RET

S1A89:   ; xref 1A18 1A23 1A30 1A53 1A98
1A89  0D            DEC C
1A8A  FA 9A 1A      JP m,L1A9A
1A8D  3C            INC A
1A8E  32 10 E0      LD (E010h),A
1A91  08            EX AF,AF'
1A92  7E            LD A,(HL)
1A93  23            INC HL
1A94  32 00 E0      LD (E000h),A
1A97  08            EX AF,AF'
1A98  18 EF         JR S1A89

L1A9A:   ; xref 1A8A
1A9A  C9            RET

S1A9B:   ; xref 1217 1231 1241 19BF 1B8E
1A9B  21 BA 20      LD HL,20BAh
1A9E  01 00 00      LD BC,0
1AA1  4F            LD C,A
1AA2  CB 21         SLA C
1AA4  CB 10         RL B
1AA6  09            ADD HL,BC
1AA7  7E            LD A,(HL)
1AA8  32 1D A0      LD (A01Dh),A
1AAB  23            INC HL
1AAC  7E            LD A,(HL)
1AAD  32 1E A0      LD (A01Eh),A
1AB0  21 1C A0      LD HL,A01Ch
1AB3  CB C6         SET 0,(HL)
1AB5  C9            RET

S1AB6:   ; xref 15D5 15DF 167E 1A08
1AB6  5E            LD E,(HL)
1AB7  23            INC HL
1AB8  56            LD D,(HL)
1AB9  CD 00 1B      CALL S1B00
1ABC  C9            RET
1ABD  db FD E5 DD E1 C9                                   ; .....

S1AC2:   ; xref 162F
1AC2  DD E5         PUSH IX
1AC4  FD E1         POP IY
1AC6  C9            RET

S1AC7:   ; xref 15F1 15F6 1600 1611 1624 1D04
1AC7  08            EX AF,AF'
1AC8  C5            PUSH BC
1AC9  06 00         LD B,0
1ACB  DD E5         PUSH IX
1ACD  DD 09         ADD IX,BC
1ACF  7E            LD A,(HL)
1AD0  DD 77 00      LD (IX),A
1AD3  DD E1         POP IX
1AD5  C1            POP BC
1AD6  08            EX AF,AF'
1AD7  C9            RET

S1AD8:   ; xref 1634 1639 163F 1644 164A 1650 1655
1AD8  08            EX AF,AF'
1AD9  06 00         LD B,0
1ADB  FD E5         PUSH IY
1ADD  FD 09         ADD IY,BC
1ADF  7E            LD A,(HL)
1AE0  FD 77 00      LD (IY),A
1AE3  FD E1         POP IY
1AE5  08            EX AF,AF'
1AE6  C9            RET

S1AE7:   ; xref 1976 19D9 19E6
1AE7  4E            LD C,(HL)
1AE8  23            INC HL
1AE9  46            LD B,(HL)
1AEA  CD 09 1B      CALL S1B09
1AED  CD 03 1B      CALL S1B03
1AF0  01 01 00      LD BC,1
1AF3  A7            AND A
1AF4  ED 42         SBC HL,BC
1AF6  CD 06 1B      CALL S1B06
1AF9  CD 00 1B      CALL S1B00
1AFC  70            LD (HL),B
1AFD  2B            DEC HL
1AFE  71            LD (HL),C
1AFF  C9            RET

S1B00:   ; xref 13FB 1423 1435 1446 14FB 1548 1562 158C
1B00  D5            PUSH DE
1B01  E1            POP HL
1B02  C9            RET

S1B03:   ; xref 1940 1951 1AED
1B03  C5            PUSH BC
1B04  E1            POP HL
1B05  C9            RET

S1B06:   ; xref 1958 196A 1A79 1AF6
1B06  E5            PUSH HL
1B07  C1            POP BC
1B08  C9            RET

S1B09:   ; xref 1AEA
1B09  E5            PUSH HL
1B0A  D1            POP DE
1B0B  C9            RET
1B0C  db D9 21 13 A0 D5 CD E7 1A D1 30 08 21 00 00 22 13  ; .!.......0.!..".
1B1C  db A0 18 13 CD 00 1B 2C 2C 34 20 06 2C 34 20 02 2C  ; ......,,4 .,4 .,
1B2C  db 34 CD 34 1C 3E 03 D9 C9                          ; 4.4.>...

S1B34:   ; xref 1597 16A3 1E52
1B34  3A 13 A0      LD A,(A013h)
1B37  FE 00         CP 0
1B39  C8            RET z
1B3A  CD 00 1B      CALL S1B00
1B3D  2C            INC L
1B3E  2C            INC L
1B3F  86            ADD A,(HL)
1B40  77            LD (HL),A
1B41  3A 14 A0      LD A,(A014h)
1B44  2C            INC L
1B45  8E            ADC A,(HL)
1B46  77            LD (HL),A
1B47  3E 00         LD A,0
1B49  2C            INC L
1B4A  8E            ADC A,(HL)
1B4B  77            LD (HL),A
1B4C  CD 34 1C      CALL S1C34
1B4F  21 00 00      LD HL,0
1B52  22 13 A0      LD (A013h),HL
1B55  3E 03         LD A,3
1B57  C9            RET

S1B58:   ; xref 123C 126B 12EA 1385
1B58  21 11 A0      LD HL,A011h
1B5B  CB 5E         BIT 3,(HL)
1B5D  20 04         JR nz,L1B63
1B5F  CD B9 06      CALL S06B9
1B62  C9            RET

L1B63:   ; xref 1B5D
1B63  21 07 A0      LD HL,A007h
1B66  7E            LD A,(HL)
1B67  FE 00         CP 0
1B69  C8            RET z
1B6A  36 00         LD (HL),0
1B6C  CD CF 02      CALL S02CF
1B6F  CD D8 02      CALL S02D8
1B72  C9            RET

S1B73:   ; xref 1270
1B73  21 11 A0      LD HL,A011h
1B76  CB 5E         BIT 3,(HL)
1B78  20 04         JR nz,L1B7E
1B7A  CD C2 06      CALL S06C2
1B7D  C9            RET

L1B7E:   ; xref 1B78
1B7E  21 07 A0      LD HL,A007h
1B81  7E            LD A,(HL)
1B82  FE 00         CP 0
1B84  C0            RET nz
1B85  36 FF         LD (HL),FFh
1B87  CD CF 02      CALL S02CF
1B8A  CD D8 02      CALL S02D8
1B8D  C9            RET

S1B8E:   ; xref 176F 17C5
1B8E  CD 9B 1A      CALL S1A9B
1B91  C9            RET

S1B92:   ; xref 12D3 12E2 13F6 155A 1E98 1ED4
1B92  ED 43 0B A0   LD (A00Bh),BC
1B96  AF            XOR A
1B97  32 0D A0      LD (A00Dh),A
1B9A  CD 18 1C      CALL S1C18
1B9D  C9            RET

S1B9E:   ; xref 19C4
1B9E  3A 09 A0      LD A,(A009h)
1BA1  4F            LD C,A
1BA2  AF            XOR A
1BA3  06 09         LD B,9

L1BA5:   ; xref 1BA9
1BA5  8F            ADC A,A
1BA6  27            DAA
1BA7  CB 21         SLA C
1BA9  10 FA         DJNZ L1BA5
1BAB  32 37 E0      LD (E037h),A
1BAE  CD B5 1B      CALL S1BB5
1BB1  32 36 E0      LD (E036h),A
1BB4  C9            RET

S1BB5:   ; xref 1BAE 1C6A
1BB5  CB 3F         SRL A
1BB7  CB 3F         SRL A
1BB9  CB 3F         SRL A
1BBB  CB 3F         SRL A
1BBD  C9            RET

S1BBE:   ; xref 16A6 1718 17C8
1BBE  06 0B         LD B,11
1BC0  21 40 A0      LD HL,A040h

L1BC3:   ; xref 1BC6
1BC3  CB BE         RES 7,(HL)
1BC5  23            INC HL
1BC6  10 FB         DJNZ L1BC3
1BC8  C9            RET

S1BC9:   ; xref 121C 1236
1BC9  21 00 00      LD HL,0
1BCC  6F            LD L,A
1BCD  29            ADD HL,HL
1BCE  22 5E A0      LD (A05Eh),HL
1BD1  18 07         JR L1BDA

S1BD3:   ; xref 140F 155F 15AF 1E6C
1BD3  32 5E A0      LD (A05Eh),A
1BD6  AF            XOR A
1BD7  32 5F A0      LD (A05Fh),A

L1BDA:   ; xref 1BD1 1BDF
1BDA  3A 5F A0      LD A,(A05Fh)
1BDD  FE 00         CP 0
1BDF  20 F9         JR nz,L1BDA

L1BE1:   ; xref 1BE6
1BE1  3A 5E A0      LD A,(A05Eh)
1BE4  FE 00         CP 0
1BE6  20 F9         JR nz,L1BE1
1BE8  C9            RET

S1BE9:   ; xref 143C 144D 1747 1D3D 1EEE 1F86
1BE9  21 12 A0      LD HL,A012h
1BEC  7E            LD A,(HL)
1BED  CB 7F         BIT 7,A
1BEF  28 0D         JR z,L1BFE
1BF1  2E 0E         LD L,14
1BF3  77            LD (HL),A
1BF4  2E 0F         LD L,15
1BF6  36 00         LD (HL),0
1BF8  21 08 A0      LD HL,A008h
1BFB  CB 86         RES 0,(HL)
1BFD  C9            RET

L1BFE:   ; xref 1BEF
1BFE  2E 0F         LD L,15
1C00  77            LD (HL),A
1C01  2E 0E         LD L,14
1C03  FD 7E 02      LD A,(IY+2)
1C06  77            LD (HL),A
1C07  C9            RET

S1C08:   ; xref 169A
1C08  21 08 A0      LD HL,A008h
1C0B  CB E6         SET 4,(HL)
1C0D  CB 96         RES 2,(HL)
1C0F  CD 2A 01      CALL S012A
1C12  21 08 A0      LD HL,A008h
1C15  CB A6         RES 4,(HL)
1C17  C9            RET

S1C18:   ; xref 13B3 15AA 1694 1B9A
1C18  D9            EXX
1C19  21 08 A0      LD HL,A008h
1C1C  CB DE         SET 3,(HL)
1C1E  CB 96         RES 2,(HL)
1C20  CD 2A 01      CALL S012A
1C23  21 08 A0      LD HL,A008h
1C26  CB 9E         RES 3,(HL)
1C28  CD 2D 1C      CALL S1C2D
1C2B  D9            EXX
1C2C  C9            RET

S1C2D:   ; xref 1157 16A9 1C28 1FDF
1C2D  21 AA 08      LD HL,08AAh
1C30  22 DE A0      LD (A0DEh),HL
1C33  C9            RET

S1C34:   ; xref 13DD 151A 1B4C
1C34  CD 00 1B      CALL S1B00
1C37  3E 30         LD A,30h
1C39  BD            CP L
1C3A  23            INC HL
1C3B  20 0A         JR nz,L1C47
1C3D  7E            LD A,(HL)
1C3E  32 3E E0      LD (E03Eh),A
1C41  01 3D E0      LD BC,E03Dh
1C44  C5            PUSH BC
1C45  18 08         JR L1C4F

L1C47:   ; xref 1C3B
1C47  7E            LD A,(HL)
1C48  32 3F E0      LD (E03Fh),A
1C4B  01 35 E0      LD BC,E035h
1C4E  C5            PUSH BC

L1C4F:   ; xref 1C45
1C4F  23            INC HL
1C50  7E            LD A,(HL)
1C51  32 0B A0      LD (A00Bh),A
1C54  23            INC HL
1C55  7E            LD A,(HL)
1C56  32 0C A0      LD (A00Ch),A
1C59  23            INC HL
1C5A  7E            LD A,(HL)
1C5B  32 0D A0      LD (A00Dh),A
1C5E  CD 00 01      CALL S0100
1C61  D9            EXX
1C62  06 03         LD B,3
1C64  D1            POP DE
1C65  21 2C A0      LD HL,A02Ch

L1C68:   ; xref 1C71
1C68  7E            LD A,(HL)
1C69  12            LD (DE),A
1C6A  CD B5 1B      CALL S1BB5
1C6D  1B            DEC DE
1C6E  12            LD (DE),A
1C6F  1B            DEC DE
1C70  23            INC HL
1C71  10 F5         DJNZ L1C68
1C73  D9            EXX
1C74  C9            RET
1C75  db 06 02 B0 32 38 E0 C9 00                          ; ...28...

S1C7D:   ; xref 1752
1C7D  21 40 A0      LD HL,A040h
1C80  3A 08 C0      LD A,(C008h)
1C83  EE FF         XOR FFh
1C85  CB 67         BIT 4,A
1C87  28 26         JR z,L1CAF
1C89  CB 6E         BIT 5,(HL)
1C8B  28 2E         JR z,L1CBB
1C8D  CB 76         BIT 6,(HL)
1C8F  20 04         JR nz,L1C95
1C91  CB F6         SET 6,(HL)
1C93  CB FE         SET 7,(HL)

L1C95:   ; xref 1C8F 1CB3 1CBD
1C95  E6 0F         AND 15
1C97  C6 40         ADD A,40h
1C99  23            INC HL
1C9A  06 0B         LD B,11

L1C9C:   ; xref 1CAC
1C9C  BD            CP L
1C9D  20 16         JR nz,L1CB5
1C9F  CB 6E         BIT 5,(HL)
1CA1  28 1C         JR z,L1CBF
1CA3  CB 76         BIT 6,(HL)
1CA5  20 04         JR nz,L1CAB
1CA7  CB F6         SET 6,(HL)
1CA9  CB FE         SET 7,(HL)

L1CAB:   ; xref 1CA5 1CB9 1CC1
1CAB  23            INC HL
1CAC  10 EE         DJNZ L1C9C
1CAE  C9            RET

L1CAF:   ; xref 1C87
1CAF  CB B6         RES 6,(HL)
1CB1  CB AE         RES 5,(HL)
1CB3  18 E0         JR L1C95

L1CB5:   ; xref 1C9D
1CB5  CB B6         RES 6,(HL)
1CB7  CB AE         RES 5,(HL)
1CB9  18 F0         JR L1CAB

L1CBB:   ; xref 1C8B
1CBB  CB EE         SET 5,(HL)
1CBD  18 D6         JR L1C95

L1CBF:   ; xref 1CA1
1CBF  CB EE         SET 5,(HL)
1CC1  18 E8         JR L1CAB

S1CC3:   ; xref 1450
1CC3  3A 10 A0      LD A,(A010h)
1CC6  CB 5F         BIT 3,A
1CC8  C0            RET nz
1CC9  3A 12 A0      LD A,(A012h)
1CCC  CB 7F         BIT 7,A
1CCE  C8            RET z
1CCF  21 05 00      LD HL,5
1CD2  19            ADD HL,DE
1CD3  CB 6E         BIT 5,(HL)
1CD5  C0            RET nz
1CD6  E6 7F         AND 7Fh
1CD8  32 54 A0      LD (A054h),A
1CDB  21 06 00      LD HL,6
1CDE  19            ADD HL,DE
1CDF  77            LD (HL),A
1CE0  2B            DEC HL
1CE1  CB 7E         BIT 7,(HL)
1CE3  28 05         JR z,L1CEA
1CE5  CB 76         BIT 6,(HL)
1CE7  20 01         JR nz,L1CEA
1CE9  C9            RET

L1CEA:   ; xref 1CE3 1CE7
1CEA  D9            EXX
1CEB  21 35 20      LD HL,2035h
1CEE  3A 54 A0      LD A,(A054h)
1CF1  CB 27         SLA A
1CF3  CB 27         SLA A
1CF5  85            ADD A,L
1CF6  6F            LD L,A
1CF7  3E 00         LD A,0
1CF9  8C            ADC A,H
1CFA  67            LD H,A
1CFB  DD E5         PUSH IX
1CFD  DD 21 50 A0   LD IX,A050h
1D01  01 00 04      LD BC,0400h

L1D04:   ; xref 1D09
1D04  CD C7 1A      CALL S1AC7
1D07  23            INC HL
1D08  0C            INC C
1D09  10 F9         DJNZ L1D04
1D0B  DD E1         POP IX
1D0D  3A 52 A0      LD A,(A052h)
1D10  E6 07         AND 7
1D12  FE 00         CP 0
1D14  20 3A         JR nz,L1D50
1D16  2A 50 A0      LD HL,(A050h)
1D19  7E            LD A,(HL)

L1D1A:   ; xref 1D8A 1DC0
1D1A  D9            EXX
1D1B  21 05 00      LD HL,5
1D1E  19            ADD HL,DE
1D1F  CB 4E         BIT 1,(HL)
1D21  D9            EXX
1D22  20 16         JR nz,L1D3A
1D24  21 11 A0      LD HL,A011h
1D27  CB 7E         BIT 7,(HL)
1D29  20 0F         JR nz,L1D3A
1D2B  21 10 A0      LD HL,A010h
1D2E  CB 56         BIT 2,(HL)
1D30  20 06         JR nz,L1D38
1D32  D9            EXX
1D33  CB 66         BIT 4,(HL)
1D35  D9            EXX
1D36  28 02         JR z,L1D3A

L1D38:   ; xref 1D30
1D38  C6 2A         ADD A,2Ah

L1D3A:   ; xref 1D22 1D29 1D36
1D3A  32 12 A0      LD (A012h),A
1D3D  CD E9 1B      CALL S1BE9
1D40  D9            EXX
1D41  21 05 00      LD HL,5
1D44  19            ADD HL,DE
1D45  CB 76         BIT 6,(HL)
1D47  CB B6         RES 6,(HL)
1D49  C8            RET z
1D4A  3E 01         LD A,1
1D4C  32 0F A0      LD (A00Fh),A
1D4F  C9            RET

L1D50:   ; xref 1D14
1D50  D9            EXX
1D51  3E 30         LD A,30h
1D53  BB            CP E
1D54  D9            EXX
1D55  20 05         JR nz,L1D5C
1D57  21 60 A0      LD HL,A060h
1D5A  18 03         JR L1D5F

L1D5C:   ; xref 1D55
1D5C  21 90 A0      LD HL,A090h

L1D5F:   ; xref 1D5A
1D5F  3A 54 A0      LD A,(A054h)
1D62  85            ADD A,L
1D63  6F            LD L,A
1D64  22 55 A0      LD (A055h),HL
1D67  3A 53 A0      LD A,(A053h)
1D6A  BE            CP (HL)
1D6B  20 02         JR nz,L1D6F
1D6D  36 00         LD (HL),0

L1D6F:   ; xref 1D6B
1D6F  3A 52 A0      LD A,(A052h)
1D72  E6 07         AND 7
1D74  47            LD B,A
1D75  32 57 A0      LD (A057h),A
1D78  3A 52 A0      LD A,(A052h)
1D7B  CB 5F         BIT 3,A
1D7D  20 0E         JR nz,L1D8D
1D7F  ED 4B 50 A0   LD BC,(A050h)
1D83  2A 55 A0      LD HL,(A055h)
1D86  CD C3 1D      CALL S1DC3
1D89  0A            LD A,(BC)
1D8A  C3 1A 1D      JP L1D1A

L1D8D:   ; xref 1D7D
1D8D  04            INC B
1D8E  3E 01         LD A,1

L1D90:   ; xref 1D95
1D90  05            DEC B
1D91  28 04         JR z,L1D97
1D93  CB 27         SLA A
1D95  18 F9         JR L1D90

L1D97:   ; xref 1D91 1DA9
1D97  2A 55 A0      LD HL,(A055h)
1D9A  32 58 A0      LD (A058h),A
1D9D  A6            AND (HL)
1D9E  28 0B         JR z,L1DAB
1DA0  21 57 A0      LD HL,A057h
1DA3  35            DEC (HL)
1DA4  3A 58 A0      LD A,(A058h)
1DA7  CB 3F         SRL A
1DA9  18 EC         JR L1D97

L1DAB:   ; xref 1D9E
1DAB  3A 58 A0      LD A,(A058h)
1DAE  2A 55 A0      LD HL,(A055h)
1DB1  B6            OR (HL)
1DB2  77            LD (HL),A
1DB3  2A 50 A0      LD HL,(A050h)
1DB6  3A 57 A0      LD A,(A057h)
1DB9  85            ADD A,L
1DBA  6F            LD L,A
1DBB  3E 00         LD A,0
1DBD  8C            ADC A,H
1DBE  67            LD H,A
1DBF  7E            LD A,(HL)
1DC0  C3 1A 1D      JP L1D1A

S1DC3:   ; xref 1D86
1DC3  7E            LD A,(HL)
1DC4  E6 07         AND 7
1DC6  FE 00         CP 0
1DC8  28 2A         JR z,L1DF4
1DCA  FE 01         CP 1
1DCC  28 34         JR z,L1E02
1DCE  FE 02         CP 2
1DD0  28 3A         JR z,L1E0C
1DD2  FE 04         CP 4
1DD4  28 40         JR z,L1E16
1DD6  FE 03         CP 3
1DD8  28 0B         JR z,L1DE5
1DDA  FE 05         CP 5
1DDC  28 03         JR z,L1DE1

L1DDE:   ; xref 1DFA 1E14 1E1A
1DDE  CB C6         SET 0,(HL)
1DE0  C9            RET

L1DE1:   ; xref 1DDC 1E00 1E0A 1E1C
1DE1  CB CE         SET 1,(HL)
1DE3  03            INC BC
1DE4  C9            RET

L1DE5:   ; xref 1DD8 1DFE 1E08 1E12
1DE5  3A 10 A0      LD A,(A010h)
1DE8  E6 02         AND 2
1DEA  20 03         JR nz,L1DEF
1DEC  C3 3B 00      JP L003B

L1DEF:   ; xref 0091 1DEA
1DEF  CB D6         SET 2,(HL)
1DF1  03            INC BC
1DF2  03            INC BC
1DF3  C9            RET

L1DF4:   ; xref 1DC8
1DF4  ED 5F         LD A,R
1DF6  E6 07         AND 7
1DF8  CB 47         BIT 0,A
1DFA  28 E2         JR z,L1DDE
1DFC  FE 07         CP 7
1DFE  28 E5         JR z,L1DE5
1E00  18 DF         JR L1DE1

L1E02:   ; xref 1DCC
1E02  ED 5F         LD A,R
1E04  E6 03         AND 3
1E06  FE 03         CP 3
1E08  28 DB         JR z,L1DE5
1E0A  18 D5         JR L1DE1

L1E0C:   ; xref 1DD0
1E0C  ED 5F         LD A,R
1E0E  E6 03         AND 3
1E10  FE 03         CP 3
1E12  28 D1         JR z,L1DE5
1E14  18 C8         JR L1DDE

L1E16:   ; xref 1DD4
1E16  ED 5F         LD A,R
1E18  CB 47         BIT 0,A
1E1A  28 C2         JR z,L1DDE
1E1C  18 C3         JR L1DE1

S1E1E:   ; xref 1487 1F3F
1E1E  3A 0A A0      LD A,(A00Ah)
1E21  CB 47         BIT 0,A
1E23  C0            RET nz
1E24  21 10 A0      LD HL,A010h
1E27  CB 76         BIT 6,(HL)
1E29  C8            RET z
1E2A  21 05 00      LD HL,5
1E2D  19            ADD HL,DE
1E2E  CB 56         BIT 2,(HL)
1E30  20 20         JR nz,L1E52
1E32  21 01 00      LD HL,1
1E35  19            ADD HL,DE
1E36  3A 10 A0      LD A,(A010h)
1E39  CB 6F         BIT 5,A
1E3B  20 15         JR nz,L1E52
1E3D  3A 11 A0      LD A,(A011h)
1E40  CB 6F         BIT 5,A
1E42  28 0C         JR z,L1E50
1E44  CB 77         BIT 6,A
1E46  20 0A         JR nz,L1E52
1E48  3E 83         LD A,83h
1E4A  BE            CP (HL)
1E4B  28 05         JR z,L1E52
1E4D  34            INC (HL)
1E4E  18 02         JR L1E52

L1E50:   ; xref 1E42
1E50  36 83         LD (HL),83h

L1E52:   ; xref 1E30 1E3B 1E46 1E4B 1E4E
1E52  CD 34 1B      CALL S1B34
1E55  3E FF         LD A,FFh
1E57  32 5E A0      LD (A05Eh),A
1E5A  3E 01         LD A,1
1E5C  32 5F A0      LD (A05Fh),A
1E5F  CD 9D 1E      CALL S1E9D
1E62  21 09 A0      LD HL,A009h
1E65  AF            XOR A
1E66  BE            CP (HL)
1E67  28 10         JR z,L1E79
1E69  35            DEC (HL)
1E6A  3E 5A         LD A,5Ah
1E6C  CD D3 1B      CALL S1BD3
1E6F  C9            RET

L1E70:   ; xref 1E92 1E9B
1E70  21 09 A0      LD HL,A009h
1E73  AF            XOR A
1E74  BE            CP (HL)
1E75  28 02         JR z,L1E79
1E77  35            DEC (HL)
1E78  C9            RET

L1E79:   ; xref 1E67 1E75
1E79  ED 4B 5E A0   LD BC,(A05Eh)
1E7D  21 00 00      LD HL,0
1E80  A7            AND A
1E81  ED 42         SBC HL,BC
1E83  20 07         JR nz,L1E8C
1E85  CD 00 1B      CALL S1B00
1E88  23            INC HL
1E89  36 00         LD (HL),0
1E8B  C9            RET

L1E8C:   ; xref 1E83
1E8C  21 40 00      LD HL,40h
1E8F  A7            AND A
1E90  ED 42         SBC HL,BC
1E92  38 DC         JR c,L1E70
1E94  ED 4B F8 1F   LD BC,(1FF8h)
1E98  CD 92 1B      CALL S1B92
1E9B  18 D3         JR L1E70

S1E9D:   ; xref 1E5F
1E9D  3E 00         LD A,0
1E9F  21 1D 20      LD HL,201Dh
1EA2  18 03         JR L1EA7
1EA4  db 21 05 20                                         ; !. 

L1EA7:   ; xref 1EA2
1EA7  85            ADD A,L
1EA8  6F            LD L,A
1EA9  3E 00         LD A,0
1EAB  8C            ADC A,H
1EAC  67            LD H,A
1EAD  FD 7E 02      LD A,(IY+2)
1EB0  FE 94         CP L0094
1EB2  28 1D         JR z,L1ED1
1EB4  FE BE         CP BEh
1EB6  28 19         JR z,L1ED1
1EB8  23            INC HL
1EB9  23            INC HL
1EBA  FE 9E         CP 9Eh
1EBC  28 13         JR z,L1ED1
1EBE  FE C8         CP C8h
1EC0  28 0F         JR z,L1ED1
1EC2  23            INC HL
1EC3  23            INC HL
1EC4  FE A4         CP A4h
1EC6  28 09         JR z,L1ED1
1EC8  FE CE         CP CEh
1ECA  28 05         JR z,L1ED1
1ECC  23            INC HL
1ECD  23            INC HL
1ECE  FE FF         CP FFh
1ED0  C0            RET nz

L1ED1:   ; xref 1EB2 1EB6 1EBC 1EC0 1EC6 1ECA
1ED1  4E            LD C,(HL)
1ED2  23            INC HL
1ED3  46            LD B,(HL)
1ED4  CD 92 1B      CALL S1B92
1ED7  C9            RET

S1ED8:   ; xref 14A9
1ED8  3A 12 A0      LD A,(A012h)
1EDB  CB 7F         BIT 7,A
1EDD  C8            RET z
1EDE  FD CB 05 4E   BIT 1,(IY+5)
1EE2  C0            RET nz
1EE3  21 06 00      LD HL,6
1EE6  19            ADD HL,DE
1EE7  7E            LD A,(HL)
1EE8  3C            INC A
1EE9  F6 80         OR L0080
1EEB  32 12 A0      LD (A012h),A
1EEE  CD E9 1B      CALL S1BE9
1EF1  C9            RET

S1EF2:   ; xref 14DF
1EF2  21 90 00      LD HL,90h
1EF5  19            ADD HL,DE
1EF6  06 08         LD B,8
1EF8  3E 00         LD A,0

L1EFA:   ; xref 1F11
1EFA  BE            CP (HL)
1EFB  20 13         JR nz,L1F10
1EFD  FD 7E 02      LD A,(IY+2)
1F00  E5            PUSH HL
1F01  21 05 00      LD HL,5
1F04  19            ADD HL,DE
1F05  CB 4E         BIT 1,(HL)
1F07  CB 8E         RES 1,(HL)
1F09  28 02         JR z,L1F0D
1F0B  C6 05         ADD A,5

L1F0D:   ; xref 1F09
1F0D  E1            POP HL
1F0E  77            LD (HL),A
1F0F  C9            RET

L1F10:   ; xref 1EFB
1F10  23            INC HL
1F11  10 E7         DJNZ L1EFA
1F13  C9            RET

S1F14:   ; xref 1453
1F14  3A 12 A0      LD A,(A012h)
1F17  CB 7F         BIT 7,A
1F19  C8            RET z
1F1A  21 05 00      LD HL,5
1F1D  19            ADD HL,DE
1F1E  CB 5E         BIT 3,(HL)
1F20  20 67         JR nz,L1F89
1F22  CB 6E         BIT 5,(HL)
1F24  20 38         JR nz,L1F5E
1F26  3A 12 A0      LD A,(A012h)
1F29  FE A4         CP A4h
1F2B  28 04         JR z,L1F31
1F2D  FE CE         CP CEh
1F2F  20 58         JR nz,L1F89

L1F31:   ; xref 1F2B
1F31  CB EE         SET 5,(HL)
1F33  3A 11 A0      LD A,(A011h)
1F36  CB 6F         BIT 5,A
1F38  28 14         JR z,L1F4E
1F3A  3E FF         LD A,FFh
1F3C  FD 77 02      LD (IY+2),A
1F3F  CD 1E 1E      CALL S1E1E
1F42  21 01 00      LD HL,1
1F45  19            ADD HL,DE
1F46  AF            XOR A
1F47  BE            CP (HL)
1F48  20 04         JR nz,L1F4E
1F4A  F1            POP AF
1F4B  C3 41 15      JP L1541

L1F4E:   ; xref 1F38 1F48
1F4E  3A 12 A0      LD A,(A012h)
1F51  47            LD B,A
1F52  21 06 00      LD HL,6
1F55  19            ADD HL,DE
1F56  4E            LD C,(HL)
1F57  21 A0 00      LD HL,A0h
1F5A  19            ADD HL,DE
1F5B  70            LD (HL),B
1F5C  23            INC HL
1F5D  71            LD (HL),C

L1F5E:   ; xref 1F24
1F5E  21 90 00      LD HL,90h
1F61  19            ADD HL,DE
1F62  06 08         LD B,8
1F64  AF            XOR A

L1F65:   ; xref 1F69
1F65  BE            CP (HL)
1F66  20 37         JR nz,L1F9F
1F68  23            INC HL
1F69  10 FA         DJNZ L1F65
1F6B  21 A0 00      LD HL,A0h
1F6E  19            ADD HL,DE
1F6F  7E            LD A,(HL)
1F70  32 12 A0      LD (A012h),A
1F73  23            INC HL
1F74  7E            LD A,(HL)
1F75  21 30 00      LD HL,30h
1F78  19            ADD HL,DE
1F79  77            LD (HL),A
1F7A  21 05 00      LD HL,5
1F7D  19            ADD HL,DE
1F7E  CB DE         SET 3,(HL)
1F80  CB D6         SET 2,(HL)
1F82  CB AE         RES 5,(HL)
1F84  CB B6         RES 6,(HL)

L1F86:   ; xref 1FA5
1F86  CD E9 1B      CALL S1BE9

L1F89:   ; xref 1F20 1F2F
1F89  21 05 00      LD HL,5
1F8C  19            ADD HL,DE
1F8D  CB 7E         BIT 7,(HL)
1F8F  CB BE         RES 7,(HL)
1F91  C8            RET z
1F92  3E 01         LD A,1
1F94  32 0F A0      LD (A00Fh),A
1F97  C9            RET
1F98  db CB 7E CB BE C0 18 BF                             ; .~.....

L1F9F:   ; xref 1F66
1F9F  7E            LD A,(HL)
1FA0  32 12 A0      LD (A012h),A
1FA3  36 00         LD (HL),0
1FA5  18 DF         JR L1F86

S1FA7:   ; xref 14AC
1FA7  3A 12 A0      LD A,(A012h)
1FAA  CB 7F         BIT 7,A
1FAC  C8            RET z
1FAD  21 05 00      LD HL,5
1FB0  19            ADD HL,DE
1FB1  CB 66         BIT 4,(HL)
1FB3  C0            RET nz
1FB4  21 07 00      LD HL,7
1FB7  19            ADD HL,DE
1FB8  34            INC (HL)
1FB9  3A 11 A0      LD A,(A011h)
1FBC  CB 67         BIT 4,A
1FBE  28 04         JR z,L1FC4
1FC0  3E 09         LD A,9
1FC2  18 02         JR L1FC6

L1FC4:   ; xref 1FBE
1FC4  3E 05         LD A,5

L1FC6:   ; xref 1FC2
1FC6  BE            CP (HL)
1FC7  C0            RET nz
1FC8  21 05 00      LD HL,5
1FCB  19            ADD HL,DE
1FCC  CB E6         SET 4,(HL)
1FCE  C9            RET

L1FCF:   ; xref 19EB
1FCF  31 FF A3      LD SP,A3FFh
1FD2  21 30 A0      LD HL,A030h
1FD5  11 31 A0      LD DE,A031h
1FD8  01 CF 03      LD BC,03CFh
1FDB  36 00         LD (HL),0
1FDD  ED B0         LDIR
1FDF  CD 2D 1C      CALL S1C2D
1FE2  FB            EI
1FE3  C3 44 12      JP L1244
1FE6  db 32 01 32 01 3B 01 1D 01 CA 79 E7 00 3C 01 20 01  ; 2.2.;....y..<. .
1FF6  db 23 01 38 01 A5 80 01 02 03 04 05 06 08 08 09 E6  ; #.8.............
2006  db 00 EF 00 EC 00 F5 00 E6 00 EF 00 F5 00 F5 00 E6  ; ................
2016  db 00 EF 00 FE 00 F5 00 02 01 0B 01 08 01 11 01 02  ; ................
2026  db 01 0B 01 11 01 11 01 02 01 0B 01 19 01 11 01 6D  ; ...............m
2036  db 20 08 01 6E 20 02 07 71 20 02 07 74 20 02 07 77  ;  ..n ..q ..t ..w
2046  db 20 02 07 7A 20 02 07 7D 20 02 07 80 20 02 07 83  ;  ..z ..} ... ...
2056  db 20 02 07 86 20 02 07 89 20 02 07 8C 20 02 07 8F  ;  ... ... ... ...
2066  db 20 02 07 92 20 0A 07 80 83 8B 91 8D 98 96 9F 8F  ;  ... ...........
2076  db 99 A6 A7 A6 A2 A3 A1 89 97 9A 88 8A 95 81 82 85  ; ................
2086  db 86 87 8C 84 90 92 8E 93 9D 9C A0 9B A4 9E 94 D4  ; ................
2096  db D5 D6 D7 D8 00 00 31 00 7C 00 FB 00 7B 01 EF 01  ; ......1.|...{...
20A6  db 93 03 2E 05 93 07 8F 08 73 0A B7 0C DF 0D BA 0F  ; ........s.......
20B6  db 8E 12 88 13 C2 20 D4 20 E6 20 F8 20 DF 66 01 0C  ; ..... . . . .f..
20C6  db 01 EF 00 10 10 10 06 00 0F 87 20 00 80 00 DF D5  ; .......... .....
20D6  db 00 D5 00 D5 00 10 10 10 06 00 03 87 20 00 80 00  ; ............ ...
20E6  db DF 99 05 99 05 99 05 0A 0A 0A 03 00 07 87 20 00  ; .............. .
20F6  db 80 00 1F 90 00 90 00 90 00 0A 0A 0A 01 87 20 00  ; .............. .
2106  db 80 00 C4 21 DC 21 F8 21 0C 22 24 22 4C 22 64 22  ; ...!.!.!."$"L"d"
2116  db 06 28 1E 28 3C 28 52 28 5E 28 6C 28 80 28 9A 28  ; .(.(<(R(^(l(.(.(
2126  db B6 28 D4 28 AE 2E C6 2E EE 2E 08 2F 1E 2F 3C 2F  ; .(.(......././</
2136  db 56 2F 7C 2F 8A 2F A8 2F BE 2F CA 38 E0 38 FC 38  ; V/|/./././.8.8.8
2146  db 10 39 42 39 66 39 7A 39 96 39 AA 39 7E 22 D2 2F  ; .9B9f9z9.9.9~"./
2156  db CC 21 58 69 8E 69 83 42 9B 42 B9 42 CD 42 E5 42  ; .!Xi.i.B.B.B.B.B
2166  db 0D 43 25 43 92 48 AA 48 C8 48 DE 48 EA 48 F8 48  ; .C%C.H.H.H.H.H.H
2176  db 0C 49 26 49 42 49 60 49 E1 4F F9 4F 21 50 3B 50  ; .I&IBI`I.O.O!P;P
2186  db 51 50 6F 50 89 50 AF 50 BD 50 DB 50 F1 50 E8 5A  ; QPoP.P.P.P.P.P.Z
2196  db FE 5A 1A 5B 2E 5B 60 5B 86 5B 9E 5B BA 5B CE 5B  ; .Z.[.[`[.[.[.[.[
21A6  db 00 00 05 51 8B 42 58 69 8E 69 EB 64 2B 65 45 65  ; ...Q.BXi.i.d+eEe
21B6  db 03 65 5B 65 E1 4F 6F 50 DB 50 F9 4F F1 50 E8 22  ; .e[e.OoP.P.O.P."
21C6  db E1 22 E8 22 EF 22 FD 22 F6 22 FD 22 20 23 37 23  ; ."."."."."." #7#
21D6  db 3E 23 45 23 4C 23 5A 23 53 23 5A 23 67 23 74 23  ; >#E#L#Z#S#Z#g#t#
21E6  db 90 23 B8 23 D6 23 FE 23 05 24 0C 24 13 24 1A 24  ; .#.#.#.#.$.$.$.$
21F6  db 21 24 2F 24 28 24 2F 24 41 24 53 24 65 24 6C 24  ; !$/$($/$A$S$e$l$
2206  db 73 24 7A 24 81 24 A1 24 9A 24 A1 24 D8 24 F6 24  ; s$z$.$.$.$.$.$.$
2216  db 14 25 32 25 39 25 40 25 47 25 BA 24 4E 25 5C 25  ; .%2%9%@%G%.$N%\%
2226  db 55 25 5C 25 78 25 8F 25 AB 25 C7 25 E8 25 04 26  ; U%\%x%.%.%.%.%.&
2236  db 1B 26 32 26 4E 26 55 26 5C 26 63 26 6A 26 71 26  ; .&2&N&U&\&c&j&q&
2246  db 78 26 7F 26 86 26 94 26 8D 26 94 26 B0 26 D6 26  ; x&.&.&.&.&.&.&.&
2256  db F8 26 14 27 2B 27 32 27 39 27 40 27 47 27 55 27  ; .&.'+'2'9'@'G'U'
2266  db 4E 27 55 27 71 27 93 27 B2 27 D5 27 DC 27 E3 27  ; N'U'q'.'.'.'.'.'
2276  db EA 27 F1 27 F8 27 FF 27 94 22 9B 22 A2 22 A9 22  ; .'.'.'.'."."."."
2286  db B0 22 B7 22 BE 22 C5 22 CC 22 D3 22 DA 22 40 00  ; ."."."."."."."@.
2296  db F5 04 03 43 01 40 0A B4 00 10 C2 00 40 0A B4 00  ; ...C.@......@...
22A6  db 10 C8 00 40 0A B4 00 10 CE 00 40 0A B4 00 10 C5  ; ...@......@.....
22B6  db 00 40 0A B4 00 10 CB 00 40 0A B4 00 10 D1 00 40  ; .@......@......@
22C6  db 0A B4 00 10 2C 01 40 0A B4 00 10 29 01 40 0A B4  ; ....,.@....).@..
22D6  db 00 10 29 01 40 A5 B4 00 10 32 01 00 02 3C 00 00  ; ..).@....2...<..
22E6  db 57 05 00 03 AB 00 00 90 05 00 81 46 00 00 1F 07  ; W..........F....
22F6  db 00 02 3B 00 00 F3 0F 92 01 03 80 3B 3C 98 01 03  ; ..;........;<...
2306  db 80 3B 3C 9A 01 03 80 3B 3C 81 01 05 3B 3C 84 01  ; .;<....;<...;<..
2316  db 05 4A 2C 01 05 77 00 00 5F 07 98 01 04 80 00 1D  ; .J,..w.._.......
2326  db 81 01 05 00 1D 84 01 05 00 1D 03 05 15 00 00 AC  ; ................
2336  db 07 03 85 2A 00 00 D8 07 10 07 31 00 00 25 08 10  ; ...*......1..%..
2346  db 07 3A 00 00 6C 08 20 00 5D 00 00 A5 08 00 02 3B  ; .:..l. .]......;
2356  db 00 00 F9 08 90 01 03 80 50 26 01 09 76 00 00 31  ; ........P&..v..1
2366  db 09 91 01 04 80 2A 1C 01 0A 46 00 00 99 09 98 01  ; .....*...F......
2376  db 05 80 23 17 82 01 0A 00 39 80 01 0A 00 39 84 01  ; ..#.....9....9..
2386  db 0A 23 17 04 0A 39 00 00 CD 09 92 01 06 80 0F 1C  ; .#...9..........
2396  db 98 01 06 80 0F 1C 9A 01 06 80 0F 1C 81 01 0C 0F  ; ................
23A6  db 1C 84 01 0A 00 2B 80 01 0A 00 2C 05 0C 2B 00 00  ; .....+....,..+..
23B6  db FD 09 B4 12 0A 07 40 00 3B 17 81 01 0B 00 51 82  ; ......@.;.....Q.
23C6  db 01 0A 00 51 80 01 0B 00 51 06 0B 51 00 00 1F 0A  ; ...Q....Q..Q....
23D6  db 91 11 08 80 0B 37 99 11 08 80 0B 37 98 11 08 80  ; .....7.....7....
23E6  db 0B 37 84 01 0A 00 42 80 01 0A 00 42 82 01 0A 00  ; .7....B....B....
23F6  db 42 07 0A 42 00 00 62 0A 08 89 0A 00 00 99 0A 10  ; B..B..b.........
2406  db 0D 4E 00 00 A9 0A 10 0D 31 00 00 F1 0A 10 0D 4E  ; .N......1......N
2416  db 00 00 21 0B 10 0D 13 00 00 75 0B 20 00 5F 00 00  ; ..!......u. ._..
2426  db 8C 0B 00 02 3A 00 00 E1 0B 90 01 03 80 3B 16 84  ; ....:........;..
2436  db 01 07 3B 16 01 07 51 00 00 19 0C 90 01 04 80 1C  ; ..;...Q.........
2446  db 16 88 01 07 1C 16 05 07 32 00 00 5C 0C 90 01 09  ; ........2..\....
2456  db 80 1F 19 84 01 07 1E 19 0A 09 37 00 80 86 0C 08  ; ..........7.....
2466  db 89 56 00 00 C8 0C 00 07 32 00 00 15 0D 10 08 14  ; .V......2.......
2476  db 00 00 45 0D 20 00 5E 00 00 5D 0D 91 01 05 80 00  ; ..E. .^..]......
2486  db 16 99 01 05 80 00 16 98 01 05 80 00 16 01 06 16  ; ................
2496  db 00 00 B4 0C 00 02 42 00 00 B1 0D A8 13 08 03 00  ; ......B.........
24A6  db 25 1B 3F 81 01 08 00 4A 82 01 08 00 4A 01 0A 42  ; %.?....J....J..B
24B6  db 00 80 E9 0D B8 12 08 03 40 00 37 1F 81 01 08 00  ; ........@.7.....
24C6  db 56 82 01 08 00 56 84 01 08 37 1F 00 08 4E 00 00  ; V....V...7...N..
24D6  db 26 0E B8 12 08 04 40 00 20 17 81 01 08 00 37 82  ; &.....@. .....7.
24E6  db 01 08 00 37 84 01 08 00 37 03 07 2F 00 00 6D 0E  ; ...7....7../..m.
24F6  db B8 12 08 05 40 00 20 17 81 01 08 00 37 82 01 08  ; ....@. .....7...
2506  db 00 37 84 01 08 00 37 04 07 2F 00 00 9B 0E B8 12  ; .7....7../......
2516  db 08 06 40 00 1A 1A 81 01 08 00 35 82 01 08 00 35  ; ..@.......5....5
2526  db 84 01 08 00 35 05 09 2D 00 00 C9 0E 06 82 1F 00  ; ....5..-........
2536  db 00 F4 0E 00 08 2C 00 80 55 0F 10 0B 23 00 00 7B  ; .....,..U...#..{
2546  db 0F 10 0B 2E 00 00 27 0F 20 00 5E 00 00 9F 0F 00  ; ......'. .^.....
2556  db 02 3B 00 00 F3 0F 94 01 03 80 00 37 81 01 0E 30  ; .;.........7...0
2566  db 0C 82 01 0E 30 0C 88 01 0E 30 0C 01 0E 38 00 00  ; ....0....0...8..
2576  db 2B 10 91 01 04 80 1B 22 88 01 0E 00 3D 84 01 0C  ; +......"....=...
2586  db 1B 22 07 0C 3D 00 00 5D 10 98 01 05 80 20 29 84  ; ."..=..]..... ).
2596  db 01 0E 2D 1C 81 01 0E 20 29 82 01 0E 28 21 08 0E  ; ..-.... )...(!..
25A6  db 49 00 00 8B 10 91 01 06 80 0F 26 82 01 0E 00 37  ; I.........&....7
25B6  db 88 01 0E 00 37 84 01 0E 00 37 09 0E 37 00 00 C7  ; ....7....7..7...
25C6  db 10 94 01 07 80 14 2B 88 01 0F 21 1E 80 01 0F 21  ; ......+...!....!
25D6  db 1E 81 01 0F 21 1E 82 01 0F 21 1E 0A 0F 3F 00 00  ; ....!....!...?..
25E6  db F3 10 91 01 08 80 25 15 88 01 0F 00 3A 84 01 10  ; ......%.....:...
25F6  db 25 15 82 01 0E 00 3A 0B 10 3A 00 00 27 11 90 01  ; %.....:..:..'...
2606  db 09 80 4A 16 82 01 0E 00 60 84 01 11 4A 16 0C 11  ; ..J.....`...J...
2616  db 60 00 00 57 11 98 01 0A 80 16 17 82 01 0E 00 2E  ; `..W............
2626  db 84 01 0E 1B 13 0D 0E 2E 00 00 A6 11 91 01 0B 80  ; ................
2636  db 17 27 88 01 0E 00 3E 84 01 0E 00 3E 82 01 0F 00  ; .'....>....>....
2646  db 3E 0F 12 3E 00 00 C7 11 0E 8B 22 00 00 FB 11 10  ; >..>......".....
2656  db 13 14 00 00 1F 12 10 13 30 00 00 37 12 10 13 31  ; ........0..7...1
2666  db 00 00 67 12 10 13 58 00 00 97 12 10 13 22 00 00  ; ..g...X......"..
2676  db E7 12 10 13 31 00 00 0B 13 10 13 41 00 00 3B 13  ; ....1......A..;.
2686  db 20 00 5E 00 00 77 13 00 02 3B 00 00 CB 13 91 01  ;  .^..w...;......
2696  db 03 80 3B 17 82 01 09 3B 17 88 01 09 3B 17 84 01  ; ..;....;....;...
26A6  db 09 3B 17 01 09 52 00 00 03 14 90 01 04 80 31 1A  ; .;...R........1.
26B6  db 81 01 08 31 1A 82 01 09 31 1A 88 01 09 37 1B 84  ; ...1....1....7..
26C6  db 01 08 31 1A 84 01 08 31 1A 09 08 4B 00 00 47 14  ; ..1....1...K..G.
26D6  db 92 01 05 80 11 19 9A 01 05 80 11 19 81 01 09 00  ; ................
26E6  db 2A 88 01 09 00 2A 84 01 09 00 2A 0B 09 2A 00 00  ; *....*....*..*..
26F6  db 85 14 90 01 06 80 14 20 81 01 0A 14 20 88 01 0A  ; ....... .... ...
2706  db 00 08 84 01 09 00 34 0B 0A 34 00 00 A7 14 98 01  ; ......4..4......
2716  db 07 80 36 21 81 01 09 00 58 84 01 09 00 58 09 09  ; ..6!....X....X..
2726  db 58 00 00 D2 14 07 89 11 00 00 1A 15 10 0B 22 00  ; X.............".
2736  db 00 2F 15 10 0B 22 00 00 53 15 10 0B 1B 00 00 89  ; ./..."..S.......
2746  db 15 20 00 5E 00 00 A7 15 00 02 3B 00 00 FB 15 90  ; . .^......;.....
2756  db 01 03 80 47 16 81 01 09 2D 30 88 01 07 47 16 84  ; ...G....-0...G..
2766  db 01 0C 47 16 01 07 5D 00 00 33 16 99 01 04 80 21  ; ..G...]..3.....!
2776  db 16 81 01 09 1B 1C 98 01 04 80 21 16 84 01 08 21  ; ..........!....!
2786  db 16 80 01 08 21 16 04 07 37 00 00 7E 16 90 01 05  ; ....!...7..~....
2796  db 80 2C 14 B1 12 05 0A 80 00 2C 14 82 01 0A 00 40  ; .,.......,.....@
27A6  db 84 01 09 00 40 07 0C 40 00 00 AB 16 95 01 06 80  ; ....@..@........
27B6  db 1A 15 91 01 06 80 1A 15 94 01 06 80 1A 15 82 01  ; ................
27C6  db 0A 00 30 80 01 0A 18 18 0B 06 30 00 80 E0 16 00  ; ..0.......0.....
27D6  db 8A 37 00 00 07 17 10 0B 37 00 00 97 17 00 09 51  ; .7......7......Q
27E6  db 00 80 CB 17 10 0B 23 00 00 13 18 10 0B 64 00 00  ; ......#......d..
27F6  db 3B 17 20 00 5E 00 00 37 18 10 0B 14 00 00 7F 17  ; ;. .^..7........
2806  db F1 28 EA 28 F1 28 FE 28 0B 29 28 29 44 29 4B 29  ; .(.(.(.(.)()D)K)
2816  db 52 29 59 29 60 29 67 29 75 29 6E 29 75 29 96 29  ; R)Y)`)g)u)n)u).)
2826  db B7 29 D0 29 DD 29 EF 29 F6 29 FD 29 04 2A 0B 2A  ; .).).).).).).*.*
2836  db 12 2A 19 2A 20 2A 2E 2A 27 2A 2E 2A 55 2A 71 2A  ; .*.* *.*'*.*U*q*
2846  db 8D 2A A9 2A B0 2A B7 2A BE 2A C5 2A D3 2A CC 2A  ; .*.*.*.*.*.*.*.*
2856  db D3 2A E5 2A EC 2A F3 2A 01 2B FA 2A 01 2B 0E 2B  ; .*.*.*.*.+.*.+.+
2866  db 15 2B 1C 2B 23 2B 31 2B 2A 2B 31 2B 43 2B 68 2B  ; .+.+#+1+*+1+C+h+
2876  db 8B 2B A7 2B AE 2B B5 2B BC 2B CA 2B C3 2B CA 2B  ; .+.+.+.+.+.+.+.+
2886  db E7 2B FE 2B 15 2C 2C 2C 43 2C 5A 2C 61 2C 68 2C  ; .+.+.,,,C,Z,a,h,
2896  db 6F 2C 76 2C 84 2C 7D 2C 84 2C 91 2C 9E 2C AB 2C  ; o,v,.,},.,.,.,.,
28A6  db B8 2C C5 2C D2 2C DF 2C F1 2C F8 2C FF 2C 06 2D  ; .,.,.,.,.,.,.,.-
28B6  db 14 2D 0D 2D 14 2D 35 2D 51 2D 6D 2D 89 2D A0 2D  ; .-.-.-5-Q-m-.-.-
28C6  db C1 2D C8 2D CF 2D D6 2D DD 2D E4 2D EB 2D F9 2D  ; .-.-.-.-.-.-.-.-
28D6  db F2 2D F9 2D 10 2E 33 2E 54 2E 76 2E 92 2E 99 2E  ; .-.-..3.T.v.....
28E6  db A0 2E A7 2E 00 02 3C 00 00 8B 18 94 01 03 80 3C  ; ......<........<
28F6  db 16 01 07 48 00 00 E7 18 90 01 04 80 2C 16 05 08  ; ...H........,...
2906  db 42 00 00 2A 19 94 01 05 80 17 16 95 01 05 80 17  ; B..*............
2916  db 16 82 01 08 00 2D 88 01 08 00 2D 08 05 2D 00 80  ; .....-....-..-..
2926  db 61 19 94 01 06 80 3B 24 88 01 09 3B 24 81 01 09  ; a.....;$...;$...
2936  db 3B 24 82 01 0B 00 26 06 07 5F 00 00 87 19 07 8A  ; ;$....&.._......
2946  db 21 00 00 D5 19 10 0A 32 00 00 F7 19 10 0A 23 00  ; !......2......#.
2956  db 00 27 1A 10 0A 6C 00 00 4B 1A 20 00 5E 00 00 AB  ; .'...l..K. .^...
2966  db 1A 10 0A 26 00 00 07 1A 00 02 3C 00 00 FF 1A 90  ; ...&......<.....
2976  db 01 03 80 42 1A 84 01 08 00 5C 88 01 08 00 5C 81  ; ...B.....\....\.
2986  db 01 08 2D 32 82 01 08 00 4F 01 09 5C 00 00 52 1B  ; ..-2....O..\..R.
2996  db 90 01 04 80 3A 10 81 01 08 22 26 82 01 08 00 22  ; ....:...."&...."
29A6  db 88 01 08 00 4A 84 01 08 00 4A 06 0A 4A 00 00 9F  ; ....J....J..J...
29B6  db 1B B4 12 08 05 40 00 1D 34 82 01 08 00 51 88 01  ; .....@..4....Q..
29C6  db 08 00 51 08 0B 51 00 00 DB 1B 90 01 06 80 1F 18  ; ..Q..Q..........
29D6  db 07 0C 37 00 00 1D 1C 90 01 07 80 9A 1F 88 01 0D  ; ..7.............
29E6  db 9A 1F 07 0D B9 00 00 4B 1C 06 88 6F 00 00 E1 1C  ; .......K...o....
29F6  db 10 0E 23 00 00 41 1D 10 0E 14 00 00 65 1D 10 0E  ; ..#..A......e...
2A06  db 31 00 00 7D 1D 10 0E 17 00 00 C7 1D 10 0E 14 00  ; 1..}............
2A16  db 00 E1 1D 10 0E 45 00 00 01 1E 20 00 5E 00 00 41  ; .....E.... .^..A
2A26  db 1E 00 02 3C 00 00 95 1E A1 12 07 03 00 2F 0B A1  ; ...<........./..
2A36  db 13 07 03 3A 21 0B 21 A1 12 03 07 87 0B 21 84 01  ; ...:!.!......!..
2A46  db 09 00 B4 88 01 09 00 B4 01 07 AC 00 00 44 1F 90  ; .............D..
2A56  db 01 04 80 59 12 88 01 09 00 6A 84 01 09 00 67 82  ; ...Y.....j....g.
2A66  db 01 09 60 0B 0D 08 6B 00 00 D7 1F 92 01 05 80 2F  ; ..`...k......../
2A76  db 28 81 01 09 00 57 88 01 09 00 57 84 01 09 43 14  ; (....W....W...C.
2A86  db 09 09 57 00 00 2E 20 91 01 06 80 2C 2D 82 01 09  ; ..W... ....,-...
2A96  db 32 27 88 01 09 00 59 84 01 09 00 59 07 09 59 00  ; 2'....Y....Y..Y.
2AA6  db 00 77 20 06 87 05 00 00 BF 20 10 0A 39 00 00 CB  ; .w ...... ..9...
2AB6  db 20 10 0A 3E 00 00 1B 21 10 0A 23 00 00 55 21 20  ;  ..>...!..#..U! 
2AC6  db 00 5D 00 00 7A 21 00 02 3C 00 00 CD 21 98 01 03  ; .]..z!..<...!...
2AD6  db 80 DB 16 81 01 04 B1 40 01 04 F1 00 00 05 22 04  ; .......@......".
2AE6  db 88 0E 00 00 CA 22 10 05 4E 00 00 EA 22 20 00 5E  ; ....."..N..." .^
2AF6  db 00 00 31 23 00 02 3C 00 00 85 23 91 11 03 80 00  ; ..1#..<...#.....
2B06  db 2A 01 04 22 00 00 DD 23 04 82 48 00 00 FF 23 10  ; *.."...#..H...#.
2B16  db 06 0F 00 00 55 24 10 06 41 00 00 AD 24 20 00 5E  ; ....U$..A...$ .^
2B26  db 00 00 AD 24 00 02 3C 00 00 01 25 98 01 03 80 56  ; ...$..<...%....V
2B36  db 13 84 01 08 56 12 01 08 69 00 00 39 25 D1 93 07  ; ....V...i..9%...
2B46  db FF 04 20 00 0A 19 1D D4 93 07 FF 04 20 00 0A 19  ; .. ......... ...
2B56  db 1D 82 01 08 22 1F 88 01 08 22 1F 06 08 40 00 00  ; ...."...."...@..
2B66  db 8F 25 94 01 05 80 14 27 81 01 07 14 27 92 01 05  ; .%.....'....'...
2B76  db 80 14 27 96 01 05 80 14 27 88 01 07 00 3B 07 08  ; ..'.....'....;..
2B86  db 3B 00 00 C3 25 94 01 06 80 06 2B 81 01 07 00 31  ; ;...%.....+....1
2B96  db 82 01 08 00 31 88 01 08 00 31 06 08 31 00 00 F4  ; ....1....1..1...
2BA6  db 25 07 8A 45 00 00 25 26 00 08 23 00 00 5D 26 10  ; %..E..%&..#..]&.
2BB6  db 09 14 00 00 81 26 20 00 5E 00 00 99 26 00 02 3C  ; .....& .^...&..<
2BC6  db 00 00 ED 26 99 01 03 80 71 16 98 01 03 80 71 16  ; ...&....q.....q.
2BD6  db 81 01 09 71 16 84 01 0B 71 16 01 09 87 00 00 25  ; ...q....q......%
2BE6  db 27 94 01 04 80 16 13 81 01 09 16 13 88 01 0B 16  ; '...............
2BF6  db 13 05 09 29 00 00 93 27 98 01 05 80 24 13 81 01  ; ...)...'....$...
2C06  db 09 1A 1D 84 01 0B 24 13 05 09 37 00 00 B4 27 94  ; ......$...7...'.
2C16  db 01 06 80 27 14 88 01 0B 27 14 81 01 09 1F 1C 05  ; ...'....'.......
2C26  db 09 3B 00 00 E1 27 94 01 07 80 27 11 81 01 0A 1D  ; .;...'....'.....
2C36  db 1B 88 01 0A 1D 1B 05 0A 38 00 00 11 28 94 01 08  ; ........8...(...
2C46  db 80 16 14 88 01 0B 16 14 81 01 09 0C 1E 07 09 2A  ; ...............*
2C56  db 00 00 3F 28 05 83 87 00 00 61 28 10 0C 31 00 00  ; ..?(.....a(..1..
2C66  db D5 28 10 0C 45 00 00 05 29 10 0C 23 00 00 45 29  ; .(..E...)..#..E)
2C76  db 20 00 5E 00 00 69 29 00 02 3C 00 00 BD 29 98 01  ;  .^..i)..<...)..
2C86  db 03 80 56 29 01 0B 7F 00 00 F5 29 94 01 04 80 0D  ; ..V)......).....
2C96  db 1A 08 0B 27 00 00 5E 2A 91 01 05 80 1D 11 08 0B  ; ...'..^*........
2CA6  db 2E 00 00 7E 2A 94 01 06 80 22 1E 09 0B 40 00 00  ; ...~*...."...@..
2CB6  db A5 2A 98 01 07 80 24 1B 08 0B 3F 00 00 D8 2A 94  ; .*....$...?...*.
2CC6  db 01 08 80 0C 13 08 0B 1F 00 00 0B 2B 98 01 09 80  ; ...........+....
2CD6  db 06 11 08 0B 17 00 00 25 2B 81 01 0C 30 20 90 01  ; .......%+...0 ..
2CE6  db 0A 80 30 20 0D 0C 50 00 00 39 2B 09 8C 66 00 00  ; ..0 ..P..9+..f..
2CF6  db 7B 2B 10 0D 32 00 00 05 2C 10 0D 1E 00 00 35 2C  ; {+..2...,.....5,
2D06  db 20 00 5E 00 00 55 2C 00 02 3C 00 00 A9 2C 91 01  ;  .^..U,..<...,..
2D16  db 03 80 42 1E 80 01 09 42 1D 82 01 0A 42 1D 88 01  ; ..B....B....B...
2D26  db 0A 42 1D 84 01 0A 42 1D 01 0A 60 00 00 E1 2C 90  ; .B....B...`...,.
2D36  db 01 04 80 15 12 81 01 0B 1C 0B 82 01 0A 00 27 84  ; ..............'.
2D46  db 01 0B 15 12 05 0B 27 00 00 30 2D 91 01 05 80 1F  ; ......'..0-.....
2D56  db 22 82 01 0A 1F 21 88 01 0C 1F 21 84 01 0C 1F 21  ; "....!....!....!
2D66  db 06 0C 41 00 00 51 2D 90 01 06 80 12 12 81 01 0B  ; ..A..Q-.........
2D76  db 12 11 82 01 0C 00 24 88 01 0B 12 11 05 0B 24 00  ; ......$.......$.
2D86  db 00 86 2D 94 01 07 80 0D 2A 82 01 0C 00 37 88 01  ; ..-.....*....7..
2D96  db 0C 0B 2C 06 0C 37 00 00 A4 2D 90 01 08 80 15 22  ; ..,..7...-....."
2DA6  db 81 01 0D 20 17 82 01 0D 15 22 88 01 0D 20 17 84  ; ... ....."... ..
2DB6  db 01 0D 20 17 05 0D 37 00 00 D1 2D 05 84 7D 00 00  ; .. ...7...-..}..
2DC6  db FD 2D 10 0A 23 00 00 69 2E 10 0E 07 00 00 80 2E  ; .-..#..i........
2DD6  db 10 0E 13 00 00 8D 2E 10 0E 24 00 00 A4 2E 10 0E  ; .........$......
2DE6  db 49 00 00 CF 2E 20 00 54 00 00 10 2F 00 02 3C 00  ; I.... .T.../..<.
2DF6  db 00 65 2F 91 01 03 80 00 50 82 01 09 3D 13 88 01  ; .e/.....P...=...
2E06  db 09 00 50 01 09 50 00 00 9E 2F 95 01 04 80 00 22  ; ..P..P.../....."
2E16  db 91 01 04 80 00 22 94 01 04 80 1D 22 82 01 09 00  ; ....."....."....
2E26  db 22 88 01 09 00 22 06 09 22 00 00 E0 2F 90 01 05  ; "...."..".../...
2E36  db 80 34 16 88 01 09 00 4A 81 01 08 34 16 82 01 09  ; .4.....J...4....
2E46  db 00 0B 84 01 09 0A 49 06 08 4A 00 00 FD 2F 98 01  ; ......I..J.../..
2E56  db 06 80 0B 20 81 01 09 00 1F 99 01 06 80 0B 1F 82  ; ... ............
2E66  db 01 09 00 2B 84 01 09 00 22 0A 09 2C 00 00 3A 30  ; ...+...."..,..:0
2E76  db 98 01 07 80 1B 11 81 01 09 00 2C 82 01 09 00 2C  ; ..........,....,
2E86  db 84 01 09 00 2C 06 09 24 00 00 5D 30 0C 8B 41 00  ; ....,..$..]0..A.
2E96  db 00 81 30 10 0A 31 00 00 F9 30 10 0A 41 00 00 BD  ; ..0..1...0..A...
2EA6  db 30 20 00 5E 00 00 29 31 EF 2F E8 2F EF 2F 21 30  ; 0 .^..)1./././!0
2EB6  db 3F 30 5D 30 7B 30 82 30 89 30 90 30 08 30 97 30  ; ?0]0{0.0.0.0.0.0
2EC6  db A5 30 9E 30 A5 30 BC 30 CE 30 EA 30 06 31 27 31  ; .0.0.0.0.0.0.1'1
2ED6  db 43 31 5A 31 71 31 8D 31 94 31 9B 31 A2 31 A9 31  ; C1Z1q1.1.1.1.1.1
2EE6  db B0 31 B7 31 BE 31 C5 31 D3 31 CC 31 D3 31 E5 31  ; .1.1.1.1.1.1.1.1
2EF6  db F7 31 1A 32 31 32 38 32 3F 32 46 32 4D 32 54 32  ; .1.21282?2F2M2T2
2F06  db 5B 32 69 32 62 32 69 32 8F 32 B6 32 E1 32 E8 32  ; [2i2b2i2.2.2.2.2
2F16  db EF 32 F6 32 FD 32 04 33 12 33 0B 33 12 33 35 33  ; .2.2.2.3.3.3.353
2F26  db 58 33 71 33 94 33 AB 33 B2 33 B9 33 C0 33 C7 33  ; X3q3.3.3.3.3.3.3
2F36  db CE 33 D5 33 DC 33 EA 33 E3 33 EA 33 0D 34 28 34  ; .3.3.3.3.3.3.4(4
2F46  db 43 34 5E 34 77 34 92 34 99 34 A0 34 A7 34 AE 34  ; C4^4w4.4.4.4.4.4
2F56  db BC 34 B5 34 BC 34 DF 34 F6 34 0D 35 24 35 3B 35  ; .4.4.4.4.4.5$5;5
2F66  db 52 35 65 35 77 35 8A 35 97 35 B3 35 C0 35 C7 35  ; R5e5w5.5.5.5.5.5
2F76  db CE 35 D5 35 DC 35 EA 35 E3 35 EA 35 06 36 0D 36  ; .5.5.5.5.5.5.6.6
2F86  db 14 36 1B 36 29 36 22 36 29 36 4A 36 66 36 82 36  ; .6.6)6"6)6J6f6.6
2F96  db 9E 36 B5 36 D1 36 D8 36 DF 36 E6 36 ED 36 F4 36  ; .6.6.6.6.6.6.6.6
2FA6  db FB 36 09 37 02 37 09 37 2F 37 50 37 6C 37 88 37  ; .6.7.7.7/7P7l7.7
2FB6  db 8F 37 96 37 9D 37 A4 37 B2 37 AB 37 B2 37 C9 37  ; .7.7.7.7.7.7.7.7
2FC6  db E2 37 FE 37 05 38 0C 38 13 38 1A 38 28 38 21 38  ; .7.7.8.8.8.8(8!8
2FD6  db 28 38 4E 38 75 38 A0 38 A7 38 AE 38 B5 38 BC 38  ; (8N8u8.8.8.8.8.8
2FE6  db C3 38 00 02 42 00 00 7D 31 A4 13 09 03 00 25 1B  ; .8..B..}1.....%.
2FF6  db 3F 81 01 09 00 4A 82 01 09 00 4A 01 0A 4B 00 80  ; ?....J....J..K..
3006  db B5 31 B4 12 09 03 40 00 37 1F 81 01 09 00 56 82  ; .1....@.7.....V.
3016  db 01 09 00 56 00 09 4E 00 00 F2 31 B4 12 09 04 40  ; ...V..N...1....@
3026  db 00 21 16 88 01 09 00 37 81 01 09 00 37 82 01 09  ; .!.....7....7...
3036  db 00 37 04 08 2F 00 00 39 32 B4 12 09 05 40 00 20  ; .7../..92....@. 
3046  db 17 88 01 09 00 37 81 01 09 00 37 82 01 09 00 37  ; .....7....7....7
3056  db 05 08 2F 00 00 67 32 B4 12 09 06 40 00 1A 1A 81  ; ../..g2....@....
3066  db 01 09 00 34 82 01 09 00 34 88 01 09 00 34 00 07  ; ...4....4....4..
3076  db 2C 00 00 95 32 00 82 1F 00 00 C1 32 10 0B 2C 00  ; ,...2......2..,.
3086  db 00 F1 32 10 0B 52 00 00 21 33 10 0B 1F 00 00 47  ; ..2..R..!3.....G
3096  db 33 20 00 5E 00 00 6B 33 00 02 3C 00 00 BF 33 98  ; 3 .^..k3..<...3.
30A6  db 01 03 80 00 38 81 01 0E 30 0C 84 01 0E 30 0C 01  ; ....8...0....0..
30B6  db 0E 38 00 00 F7 33 91 01 04 80 1B 22 84 01 0E 00  ; .8...3....."....
30C6  db 3D 08 0C 3D 00 00 2D 34 94 01 05 80 20 28 88 01  ; =..=..-4.... (..
30D6  db 0E 2D 1B 81 01 0E 20 28 82 01 0E 20 28 09 0E 40  ; .-.... (... (..@
30E6  db 00 00 57 34 91 01 06 80 0F 25 82 01 0E 00 34 88  ; ..W4.....%....4.
30F6  db 01 0E 00 34 84 01 0E 00 34 0A 0E 34 00 00 93 34  ; ...4....4..4...4
3106  db 98 01 07 80 14 2A 84 01 0F 21 1E 81 01 0F 20 1E  ; .....*...!.... .
3116  db 82 01 0F 20 1E 80 01 0F 20 1E 0B 0F 3E 00 00 BF  ; ... .... ...>...
3126  db 34 91 01 08 80 24 16 84 01 0F 00 3A 88 01 10 24  ; 4....$.....:...$
3136  db 15 82 01 0E 00 3A 0C 10 3A 00 00 F3 34 90 01 09  ; .....:..:...4...
3146  db 80 4A 16 82 01 0E 00 63 88 01 11 4A 19 0D 11 60  ; .J.....c...J...`
3156  db 00 00 23 35 94 01 0A 80 16 18 82 01 0E 00 27 88  ; ..#5..........'.
3166  db 01 0E 1B 13 0D 0E 2E 00 00 75 35 91 01 0B 80 17  ; .........u5.....
3176  db 27 88 01 0E 00 3E 84 01 0E 00 3E 82 01 0F 00 3E  ; '....>....>....>
3186  db 0F 12 3E 00 00 93 35 0E 8B 22 00 00 C7 35 10 13  ; ..>...5.."...5..
3196  db 14 00 00 EB 35 10 13 30 00 00 03 36 10 13 31 00  ; ....5..0...6..1.
31A6  db 00 33 36 10 13 57 00 00 63 36 10 13 23 00 00 B3  ; .36..W..c6..#...
31B6  db 36 10 13 32 00 00 D7 36 10 13 41 00 00 07 37 20  ; 6..2...6..A...7 
31C6  db 00 5E 00 00 43 37 00 02 3C 00 00 97 37 90 01 03  ; .^..C7..<...7...
31D6  db 80 00 1E 88 01 0A 00 1E 01 08 1E 00 00 F7 37 94  ; ..............7.
31E6  db 01 04 80 19 11 88 01 0A 00 2A 07 0A 2A 00 00 0F  ; .........*..*...
31F6  db 38 95 01 05 80 33 13 91 01 05 80 33 13 94 01 05  ; 8....3.....3....
3206  db 80 33 13 82 01 0A 00 46 88 01 08 00 46 09 09 46  ; .3.....F....F..F
3216  db 00 00 33 38 90 01 06 80 34 12 82 01 0A 12 11 84  ; ..38....4.......
3226  db 01 0B 34 12 07 0B 46 00 00 71 38 0C 07 2B 00 80  ; ..4...F..q8..+..
3236  db A7 38 01 8C 21 00 00 CC 38 10 0C 32 00 00 13 39  ; .8..!...8..2...9
3246  db 00 0A 17 00 80 43 39 10 0C 17 00 00 57 39 10 0C  ; .....C9.....W9..
3256  db 23 00 00 EF 38 20 00 5E 00 00 73 39 00 02 3C 00  ; #...8 .^..s9..<.
3266  db 00 C7 39 A4 13 09 07 54 41 0A 0A A4 13 07 08 A9  ; ..9....TA.......
3276  db 0A 0A 0A 88 01 09 54 75 81 01 09 54 75 82 01 09  ; ......Tu...Tu...
3286  db 54 75 01 03 CA 00 80 FF 39 C8 93 09 07 08 00 49  ; Tu......9......I
3296  db 0A 0A A8 13 07 08 5D 0A 0A 0A 84 01 09 00 7F 81  ; ......].........
32A6  db 01 09 00 7F 82 01 09 00 7F 01 04 7F 00 80 A3 3A  ; ...............:
32B6  db A4 13 08 07 00 49 0A 0A A4 13 07 08 5D 0A 0A 0A  ; .....I......]...
32C6  db 84 01 09 7B 2A 88 01 09 00 A5 81 01 09 00 A5 82  ; ...{*...........
32D6  db 01 09 00 A5 08 05 A5 00 80 0B 3B 10 0A 3C 00 04  ; ..........;..<..
32E6  db 92 3B 00 07 6D 00 02 05 3C 0B 81 8A 00 22 06 3C  ; .;..m...<....".<
32F6  db 10 0A 41 00 04 CA 3B 10 0A 19 00 04 EA 3B 20 00  ; ..A...;......; .
3306  db 5E 00 00 7E 3C 00 02 3C 00 00 D2 3C B0 12 09 03  ; ^..~<..<...<....
3316  db 40 2C 16 1C 84 01 08 00 5C 88 01 08 00 5C 81 01  ; @,......\....\..
3326  db 08 2D 32 82 01 08 00 4F 01 09 5E 00 00 25 3D B0  ; .-2....O..^..%=.
3336  db 12 0A 04 40 1A 20 10 81 01 08 22 26 82 01 08 00  ; ...@. ...."&....
3346  db 22 88 01 08 00 4A 84 01 08 00 4A 07 0A 4A 00 00  ; "....J....J..J..
3356  db 72 3D B8 12 08 05 40 00 1D 35 82 01 08 00 52 84  ; r=....@..5....R.
3366  db 01 08 00 52 09 0B 52 00 00 AE 3D B0 12 0C 06 40  ; ...R..R...=....@
3376  db 07 17 19 81 01 0C 1F 19 82 01 0C 1F 19 84 01 0C  ; ................
3386  db 1F 19 88 01 0C 1F 19 07 0C 36 00 00 F0 3D 90 01  ; .........6...=..
3396  db 07 80 99 1F 88 01 0D 9A 1F 84 01 0D 9A 1F 07 0D  ; ................
33A6  db B8 00 00 1E 3E 06 88 6F 00 00 B3 3E 10 0E 23 00  ; ....>..o...>..#.
33B6  db 00 14 3F 10 0E 14 00 00 38 3F 10 0E 31 00 00 50  ; ..?.....8?..1..P
33C6  db 3F 10 0E 17 00 00 9A 3F 10 0E 14 00 00 B4 3F 10  ; ?......?......?.
33D6  db 0E 45 00 00 D5 3F 20 00 5F 00 00 15 40 00 02 3C  ; .E...? ._...@..<
33E6  db 00 00 68 40 B5 12 09 03 40 66 0A 16 B4 12 09 03  ; ..h@....@f......
33F6  db 40 66 0A 16 81 01 09 71 15 A8 12 09 0B 66 0A 15  ; @f.....q.....f..
3406  db 01 09 86 00 00 A0 40 B8 12 09 04 40 00 16 10 81  ; ......@....@....
3416  db 01 09 16 11 A4 12 09 0B 00 16 11 06 09 26 00 00  ; .............&..
3426  db 0D 41 B4 12 09 05 40 00 27 14 A8 12 09 0B 00 27  ; .A....@.'......'
3436  db 14 81 01 09 1A 21 06 09 3B 00 00 2C 41 B8 12 09  ; .....!..;..,A...
3446  db 06 40 00 27 14 A4 12 09 0B 00 27 14 81 01 09 1F  ; .@.'......'.....
3456  db 1C 05 09 3B 00 00 5C 41 B8 12 09 07 40 00 25 11  ; ...;..\A....@.%.
3466  db 81 01 0A 1D 19 84 01 0A 1D 19 05 0A 36 00 00 8C  ; ............6...
3476  db 41 B8 12 09 08 40 00 18 14 A4 12 09 0B 00 18 14  ; A....@..........
3486  db 81 01 09 0C 20 08 09 2C 00 00 B8 41 05 83 87 00  ; .... ..,...A....
3496  db 00 DC 41 10 0C 30 00 00 50 42 10 0C 45 00 00 80  ; ..A..0..PB..E...
34A6  db 42 10 0C 23 00 00 C0 42 20 00 5E 00 00 E4 42 00  ; B..#...B .^...B.
34B6  db 02 3A 00 00 38 43 94 01 03 80 0E 32 91 01 03 80  ; .:..8C.....2....
34C6  db 0E 32 95 01 03 80 0E 32 82 01 11 0E 32 88 01 10  ; .2.....2....2...
34D6  db 00 40 01 0F 40 00 00 70 43 98 01 04 80 6A 1A 84  ; .@..@..pC....j..
34E6  db 01 10 6A 1A 82 01 0F 6A 1A 08 11 84 00 00 A4 43  ; ..j....j.......C
34F6  db 98 01 05 80 4F 19 84 01 10 4F 19 82 01 0F 4F 19  ; ....O....O....O.
3506  db 07 11 68 00 00 0F 44 98 01 06 80 24 1A 84 01 10  ; ..h...D....$....
3516  db 00 3E 82 01 0F 00 3E 07 11 3E 00 00 64 44 98 01  ; .>....>..>..dD..
3526  db 07 80 72 1D 84 01 10 72 1D 82 01 0F 00 8F 07 11  ; ..r....r........
3536  db 8F 00 00 96 44 98 01 08 80 2A 16 84 01 10 2A 16  ; ....D....*....*.
3546  db 82 01 0F 2A 16 07 11 40 00 00 0A 45 91 01 09 80  ; ...*...@...E....
3556  db 0E 34 90 01 09 80 0E 34 09 11 42 00 00 3E 45 90  ; .4.....4..B..>E.
3566  db 01 0A 80 19 16 82 01 0F 19 16 0B 0F 2F 00 00 74  ; ............/..t
3576  db 45 90 01 0B 80 0A 13 92 01 0B 80 0A 13 00 0B 1D  ; E...............
3586  db 00 80 9A 45 90 01 0C 80 05 19 00 0C 1E 00 80 B2  ; ...E............
3596  db 45 90 01 0D 80 0F 0D 88 01 11 00 1C 82 01 0D 0F  ; E...............
35A6  db 0D 84 01 0F 0F 0D 00 0D 1C 00 80 CA 45 90 01 0E  ; ............E...
35B6  db 80 11 10 00 0E 21 00 80 E1 45 00 87 8C 00 00 FC  ; .....!...E......
35C6  db 45 10 12 14 00 00 74 46 10 12 59 00 00 8C 46 10  ; E.....tF..Y...F.
35D6  db 12 3F 00 00 A2 46 20 00 5E 00 00 DE 46 00 02 3C  ; .?...F .^...F..<
35E6  db 00 00 32 47 98 01 03 80 00 3D 81 01 04 00 3D 82  ; ..2G.....=....=.
35F6  db 01 05 27 16 84 01 05 27 16 01 05 3D 00 00 6A 47  ; ..'....'...=..jG
3606  db 04 83 2B 00 00 9E 47 10 06 7C 00 00 CA 47 10 06  ; ..+...G..|...G..
3616  db 23 00 00 36 48 20 00 5E 00 00 5A 48 00 02 3C 00  ; #..6H .^..ZH..<.
3626  db 00 AE 48 91 01 03 80 49 1E 80 01 09 49 1D 82 01  ; ..H....I....I...
3636  db 0A 49 1D 88 01 0A 49 1D 84 01 0A 49 1D 01 0A 67  ; .I....I....I...g
3646  db 00 00 E6 48 90 01 04 80 0F 0D 81 01 0B 11 0B 82  ; ...H............
3656  db 01 0A 00 26 88 01 0B 0F 0D 05 0B 1C 00 00 3A 49  ; ...&..........:I
3666  db 91 01 05 80 22 20 82 01 0A 22 21 88 01 0C 22 20  ; ...." ..."!..." 
3676  db 84 01 0C 22 20 09 0C 42 00 00 52 49 90 01 06 80  ; ..." ..B..RI....
3686  db 15 0D 81 01 0B 15 0D 82 01 0C 00 23 84 01 0B 15  ; ...........#....
3696  db 0D 05 0B 22 00 00 89 49 98 01 07 80 0F 28 82 01  ; ..."...I.....(..
36A6  db 0C 00 37 84 01 0C 0F 37 09 0C 37 00 00 A6 49 90  ; ..7....7..7...I.
36B6  db 01 08 80 17 20 88 01 0D 17 20 84 01 0D 17 20 82  ; .... .... .... .
36C6  db 01 0D 17 20 05 0D 37 00 00 D4 49 05 84 7B 00 00  ; ... ..7...I..{..
36D6  db 02 4A 10 0E 23 00 00 6E 4A 10 0E 07 00 00 85 4A  ; .J..#..nJ......J
36E6  db 10 0E 12 00 00 92 4A 10 0E 23 00 00 AA 4A 10 0E  ; ......J..#...J..
36F6  db 49 00 00 CE 4A 20 00 54 00 00 16 4B 00 02 3B 00  ; I...J .T...K..;.
3706  db 00 6A 4B A1 13 07 03 00 16 09 23 A1 13 03 07 42  ; .jK.......#....B
3716  db 09 23 09 81 01 07 77 0C 84 01 09 00 85 88 01 09  ; .#....w.........
3726  db 00 85 01 07 7D 00 00 40 4C 90 01 04 80 5A 11 82  ; ....}..@L....Z..
3736  db 01 09 5A 12 88 01 09 00 51 84 01 09 00 51 81 01  ; ..Z.....Q....Q..
3746  db 08 00 6B 0E 08 6B 00 00 AC 4C 92 01 05 80 40 19  ; ..k..k...L....@.
3756  db 81 01 09 00 59 88 01 09 40 19 84 01 09 00 59 09  ; ....Y...@.....Y.
3766  db 09 59 00 00 02 4D 91 01 06 80 30 1D 82 01 09 30  ; .Y...M....0....0
3776  db 2A 88 01 09 00 5A 84 01 09 30 2A 07 09 4D 00 00  ; *....Z...0*..M..
3786  db 4A 4D 06 87 0F 00 00 8A 4D 10 0A 39 00 00 A0 4D  ; JM......M..9...M
3796  db 10 0A 41 00 00 EE 4D 10 0A 22 00 00 2A 4E 20 00  ; ..A...M.."..*N .
37A6  db 5E 00 00 4E 4E 00 02 3C 00 00 A2 4E 92 01 03 80  ; ^..NN..<...N....
37B6  db 70 16 84 01 06 53 33 88 01 07 70 16 01 06 84 00  ; p....S3...p.....
37C6  db 00 DB 4E B1 12 06 04 40 0A 11 14 84 01 06 0A 25  ; ..N....@.......%
37D6  db 82 01 07 0A 25 08 07 2F 00 00 48 4F 94 01 05 80  ; ....%../..HO....
37E6  db 0F 11 81 01 08 0F 11 82 01 07 0A 16 88 01 07 0A  ; ................
37F6  db 16 0A 07 18 00 00 6F 4F 08 8D 14 00 00 88 4F 10  ; ......oO......O.
3806  db 09 23 00 00 E2 4F 10 09 31 00 00 06 50 10 09 48  ; .#...O..1...P..H
3816  db 00 00 A0 4F 20 00 5E 00 00 36 50 00 02 3C 00 00  ; ...O .^..6P..<..
3826  db C7 39 A4 13 09 07 54 41 0A 0A A4 13 07 08 A9 0A  ; .9....TA........
3836  db 0A 0A 88 01 09 54 82 81 01 09 54 82 82 01 09 54  ; .....T....T....T
3846  db 82 01 05 CC 00 00 FF 39 C8 93 09 07 08 00 49 0A  ; .......9......I.
3856  db 0A A8 13 07 08 5D 0A 0A 0A 84 01 09 00 7F 81 01  ; .....]..........
3866  db 09 00 7F 82 01 09 00 7F 01 04 7F 00 80 A3 3A A4  ; ..............:.
3876  db 13 08 07 00 1E 0A 0A A4 13 07 08 32 0A 0A 0A 84  ; ...........2....
3886  db 01 09 50 2A 88 01 09 00 A5 81 01 09 00 A5 82 01  ; ..P*............
3896  db 09 00 A5 08 05 7B 00 80 2E 3B 10 0A 5A 00 00 7A  ; .....{...;..Z..z
38A6  db 3B 00 07 6D 00 00 05 3C 0B 85 8A 00 00 06 3C 10  ; ;..m...<......<.
38B6  db 0A 41 00 00 CA 3B 10 0A 19 00 00 EA 3B 20 00 5E  ; .A...;......; .^
38C6  db 00 00 7E 3C DB 39 D4 39 DB 39 F7 39 1A 3A 36 3A  ; ..~<.9.9.9.9.:6:
38D6  db 59 3A 60 3A 67 3A 6E 3A 75 3A 83 3A 7C 3A 83 3A  ; Y:`:g:n:u:.:|:.:
38E6  db 9F 3A BB 3A D7 3A F3 3A 0F 3B 2B 3B 47 3B 59 3B  ; .:.:.:.:.;+;G;Y;
38F6  db 60 3B 67 3B 6E 3B 7C 3B 75 3B 7C 3B C5 3B EA 3B  ; `;g;n;|;u;|;.;.;
3906  db 21 3C 28 3C 2F 3C 36 3C 3D 3C 4B 3C 44 3C 4B 3C  ; !<(</<6<=<K<D<K<
3916  db 69 3C 80 3C 97 3C AE 3C CC 3C EA 3C 08 3D 26 3D  ; i<.<.<.<.<.<.=&=
3926  db 43 3D 60 3D 7D 3D 9A 3D BD 3D C4 3D CB 3D D2 3D  ; C=`=}=.=.=.=.=.=
3936  db D9 3D E0 3D E7 3D EE 3D F5 3D 52 3C 03 3E FC 3D  ; .=.=.=.=.=R<.>.=
3946  db 03 3E 26 3E 49 3E 70 3E 98 3E B9 3E DA 3E 00 3F  ; .>&>I>p>.>.>.>.?
3956  db 21 3F 45 3F 4C 3F 53 3F 5A 3F 61 3F 68 3F 6F 3F  ; !?E?L?S?Z?a?h?o?
3966  db 7D 3F 76 3F 7D 3F 94 3F AB 3F C7 3F CE 3F D5 3F  ; }?v?}?.?.?.?.?.?
3976  db DC 3F E3 3F F1 3F EA 3F F1 3F 05 40 19 40 2D 40  ; .?.?.?.?.?.@.@-@
3986  db 41 40 55 40 69 40 70 40 77 40 7E 40 85 40 94 40  ; A@U@i@p@w@~@.@.@
3996  db A2 40 9B 40 A2 40 BE 40 E4 40 01 41 08 41 0F 41  ; .@.@.@.@.@.A.A.A
39A6  db 16 41 1D 41 2B 41 24 41 2B 41 38 41 5C 41 69 41  ; .A.A+A$A+A8A\AiA
39B6  db 93 41 BB 41 D3 41 EC 41 FF 41 20 42 3E 42 4B 42  ; .A.A.A.A.A B>BKB
39C6  db 52 42 59 42 60 42 67 42 6E 42 75 42 7C 42 00 02  ; RBYB`BgBnBuB|B..
39D6  db 3C 00 00 8A 50 98 01 03 80 3B 17 81 01 08 30 42  ; <...P....;....0B
39E6  db 82 01 08 30 42 84 01 08 30 42 01 08 52 00 00 C2  ; ...0B...0B..R...
39F6  db 50 91 01 04 80 00 15 99 01 04 80 00 15 98 01 04  ; P...............
3A06  db 80 00 15 84 01 08 00 15 82 01 08 00 15 07 08 15  ; ................
3A16  db 00 00 06 51 98 01 05 80 04 17 84 01 07 00 1B 81  ; ...Q............
3A26  db 01 08 00 1B 82 01 08 00 1B 0B 08 1B 00 00 17 51  ; ...............Q
3A36  db D8 93 FF FF 06 20 00 24 41 1D C4 93 FF FF 08 00  ; ..... .$A.......
3A46  db 24 41 1D C2 93 FF FF 08 00 24 41 15 0A 09 7F 00  ; $A.......$A.....
3A56  db 00 2E 51 08 8D 28 00 00 98 51 10 0A 4F 00 00 C0  ; ..Q..(...Q..O...
3A66  db 51 10 0A 1C 00 00 08 52 10 0A 29 00 00 26 52 20  ; Q......R..)..&R 
3A76  db 00 4A 00 00 50 52 00 02 3C 00 00 A4 52 94 01 03  ; .J..PR..<...R...
3A86  db 80 67 1B 81 01 0B 67 7F 82 01 0B 67 1B 88 01 0B  ; .g....g....g....
3A96  db 67 1B 01 0B 82 00 00 DC 52 98 01 04 80 11 16 81  ; g.......R.......
3AA6  db 01 0B 11 16 82 01 0B 11 16 84 01 0B 11 16 09 0B  ; ................
3AB6  db 27 00 00 46 53 91 01 05 80 1D 13 82 01 0B 1D 13  ; '..FS...........
3AC6  db 88 01 0B 1D 13 84 01 0B 1D 13 09 0B 30 00 00 65  ; ............0..e
3AD6  db 53 98 01 06 80 25 1B 81 01 0B 25 1B 82 01 0B 25  ; S....%....%....%
3AE6  db 1B 84 01 0B 25 1B 0A 0B 40 00 00 8A 53 94 01 07  ; ....%...@...S...
3AF6  db 80 24 1B 81 01 0B 24 1B 82 01 0B 24 1B 88 01 0B  ; .$....$....$....
3B06  db 24 1B 09 0B 3F 00 00 BF 53 98 01 08 80 0C 13 81  ; $...?...S.......
3B16  db 01 0B 0C 13 82 01 0B 0C 13 84 01 0B 0C 13 09 0B  ; ................
3B26  db 1F 00 00 F3 53 94 01 09 80 06 11 81 01 0B 06 11  ; ....S...........
3B36  db 88 01 0B 06 11 82 01 0B 06 11 09 0B 17 00 00 0C  ; ................
3B46  db 54 81 01 0C 37 1A 90 01 0A 80 37 1A 0E 0C 51 00  ; T...7.....7...Q.
3B56  db 00 1F 54 0A 8C 66 00 00 62 54 10 0D 32 00 00 EC  ; ..T..f..bT..2...
3B66  db 54 10 0D 1E 00 00 1C 55 20 00 5E 00 00 3C 55 00  ; T......U .^..<U.
3B76  db 02 44 00 00 90 55 C8 93 FF 06 07 00 53 42 0A A8  ; .D...U......SB..
3B86  db 13 08 07 9F 0A 0A 0A A8 12 07 06 BD 0A 4A C4 93  ; .............J..
3B96  db FF 06 08 00 53 3F 37 84 01 06 C9 48 C1 93 FF 06  ; ....S?7....H....
3BA6  db 08 00 53 3F 37 81 01 06 C9 48 C2 93 FF 06 08 00  ; ..S?7....H......
3BB6  db 53 3F 37 82 01 06 C9 48 01 03 11 01 80 C7 55 A4  ; S?7....H......U.
3BC6  db 13 07 08 00 0B 0A 0A A4 12 08 07 1F 0A 0A 88 01  ; ................
3BD6  db 08 00 36 81 01 08 00 36 82 01 08 00 36 02 04 36  ; ..6....6....6..6
3BE6  db 00 80 A5 56 C8 93 06 07 08 00 4B 0A 0A A8 13 07  ; ...V......K.....
3BF6  db 08 5F 0A 0A 0A A8 12 08 06 7D 0F 1D A4 13 06 08  ; ._.......}......
3C06  db 00 58 35 1C A1 13 06 08 00 58 35 1C A2 13 06 08  ; .X5......X5.....
3C16  db 00 58 35 1C 09 05 A9 00 80 D1 56 10 09 32 00 04  ; .X5.......V..2..
3C26  db 5A 57 10 09 19 00 04 B2 57 0B 81 8A 00 22 CE 57  ; ZW......W....".W
3C36  db 00 06 17 00 80 92 57 20 00 5E 00 00 99 58 00 02  ; ......W .^...X..
3C46  db 3C 00 00 9A 58 00 18 4F 00 00 D2 58 94 01 03 80  ; <...X..O...X....
3C56  db 00 1E 81 01 10 00 1E 88 01 10 00 1E 01 10 1E 00  ; ................
3C66  db 00 98 59 98 01 04 80 1D 1D 81 01 11 1D 1D 84 01  ; ..Y.............
3C76  db 11 1D 1D 04 11 3A 00 00 B0 59 94 01 05 80 1F 1D  ; .....:...Y......
3C86  db 81 01 12 1F 1D 88 01 12 1F 1D 04 12 3C 00 00 DF  ; ............<...
3C96  db 59 98 01 06 80 1D 1E 81 01 13 1D 1E 84 01 13 1D  ; Y...............
3CA6  db 1E 04 13 3B 00 00 10 5A D1 93 FF 14 07 20 00 75  ; ...;...Z..... .u
3CB6  db 12 13 B8 12 07 14 80 6F 19 12 84 01 14 82 18 04  ; .......o........
3CC6  db 14 9A 00 00 40 5A D1 93 FF 14 08 20 00 24 13 14  ; ....@Z..... .$..
3CD6  db 88 01 14 24 1D B4 12 08 14 80 20 19 12 05 14 4B  ; ...$...... ....K
3CE6  db 00 00 BD 5A D1 93 FF 14 09 20 00 27 0F 14 B8 12  ; ...Z..... .'....
3CF6  db 09 14 80 1E 1A 12 84 01 14 22 28 05 14 4A 00 00  ; ........."(..J..
3D06  db FA 5A D1 93 FF 14 0A 20 00 28 19 13 88 01 14 30  ; .Z..... .(.....0
3D16  db 24 B4 12 0A 14 80 28 19 13 05 14 54 00 00 36 5B  ; $.....(....T..6[
3D26  db 98 01 0B 80 72 31 99 01 0B 80 72 31 81 01 15 72  ; ....r1....r1...r
3D36  db 31 84 01 15 72 31 05 15 A3 00 00 7A 5B 94 01 0C  ; 1...r1.....z[...
3D46  db 80 2A 27 95 01 0C 80 2A 27 81 01 15 2A 27 88 01  ; .*'....*'...*'..
3D56  db 15 2A 27 03 15 51 00 00 FE 5B 98 01 0D 80 28 22  ; .*'..Q...[....("
3D66  db 99 01 0D 80 28 22 81 01 15 28 22 84 01 15 28 22  ; ....("...("...("
3D76  db 03 15 4A 00 00 40 5C 94 01 0E 80 2B 26 95 01 0E  ; ..J..@\....+&...
3D86  db 80 2B 26 81 01 15 2B 26 88 01 15 2B 26 03 15 51  ; .+&...+&...+&..Q
3D96  db 00 00 7C 5C 99 01 0F 80 73 26 91 01 0F 80 73 26  ; ..|\....s&....s&
3DA6  db 82 01 16 73 26 98 01 0F 80 73 26 84 01 16 73 26  ; ...s&....s&...s&
3DB6  db 03 16 99 00 00 BE 5C 05 84 4E 00 00 3A 5D 10 17  ; ......\..N..:]..
3DC6  db 15 00 00 82 5D 10 17 15 00 00 9A 5D 10 17 15 00  ; ....]......]....
3DD6  db 00 B2 5D 10 17 15 00 00 CA 5D 10 17 41 00 00 E2  ; ..]......]..A...
3DE6  db 5D 10 17 44 00 00 1E 5E 10 17 34 00 00 7B 5E 20  ; ]..D...^..4..{^ 
3DF6  db 00 5D 00 00 AE 5E 00 02 3C 00 00 02 5F 90 01 03  ; .]...^..<..._...
3E06  db 80 76 3B 81 01 0D 7E 32 A2 12 0E 0F 69 44 03 88  ; .v;...~2....iD..
3E16  db 01 0F 76 3B 84 01 0F 76 3B 01 0F B1 00 00 3A 5F  ; ..v;...v;.....:_
3E26  db 88 01 0F 51 1D 82 01 0F 51 1D B1 12 0F 04 40 00  ; ...Q....Q.....@.
3E36  db 51 1D 84 01 0F 00 6E 80 01 0F 00 6E 07 04 6E 00  ; Q.....n....n..n.
3E46  db 80 CA 5F 91 11 05 80 09 27 95 11 05 80 09 27 80  ; .._.....'.....'.
3E56  db 01 0F 09 26 84 01 0C 09 26 88 01 0E 09 26 82 01  ; ...&....&....&..
3E66  db 0F 09 26 07 0F 30 00 00 24 60 91 01 06 80 1E 10  ; ..&..0..$`......
3E76  db 98 01 06 80 1E 10 99 01 06 80 1E 10 82 01 0F 1E  ; ................
3E86  db 10 84 01 0E 1E 10 80 01 0F 1E 10 09 0F 2E 00 00  ; ................
3E96  db 4A 60 91 01 07 80 1A 20 84 01 0C 1A 20 82 01 0D  ; J`..... .... ...
3EA6  db 1A 20 88 01 0F 26 14 80 01 0F 26 14 0A 0F 3A 00  ; . ...&....&...:.
3EB6  db 00 6F 60 91 01 08 80 14 1D 84 01 0C 14 1C 88 01  ; .o`.............
3EC6  db 0E 14 1C 82 01 0F 14 1C 80 01 0F 14 1C 07 0F 31  ; ...............1
3ED6  db 00 00 9E 60 B5 12 10 09 40 2C 0E 15 B1 12 10 09  ; ...`....@,......
3EE6  db 40 2C 0E 15 84 01 10 2C 22 88 01 10 2C 22 82 01  ; @,.....,"...,"..
3EF6  db 0F 2C 22 07 10 4F 00 00 C6 60 91 01 0A 80 21 30  ; .,"..O...`....!0
3F06  db 88 01 10 21 31 84 01 10 21 31 82 01 0F 21 31 80  ; ...!1...!1...!1.
3F16  db 01 0F 21 31 07 0F 51 00 00 07 61 91 01 0B 80 54  ; ..!1..Q...a....T
3F26  db 38 98 01 0B 80 54 38 A2 12 0F 0E 54 23 74 84 01  ; 8....T8....T#t..
3F36  db 0F 77 74 80 01 0F 62 74 07 0F 82 00 00 4A 61 07  ; .wt...bt.....Ja.
3F46  db 8D 51 00 00 C1 61 10 11 79 00 00 6A 62 10 11 14  ; .Q...a..y..jb...
3F56  db 00 00 0A 62 10 11 23 00 00 10 63 10 11 41 00 00  ; ...b..#...c..A..
3F66  db D4 62 10 11 32 00 00 3A 62 20 00 5E 00 00 34 63  ; .b..2..:b .^..4c
3F76  db 00 02 3C 00 00 88 63 94 01 03 80 50 19 88 01 06  ; ..<...c....P....
3F86  db 5D 0C 81 01 07 50 1B 01 07 69 00 00 C0 63 94 01  ; ]....P...i...c..
3F96  db 04 80 5C 17 81 01 09 5C 15 88 01 06 67 64 08 09  ; ..\....\....gd..
3FA6  db 73 00 00 18 64 98 01 05 80 49 17 84 01 06 49 16  ; s...d....I....I.
3FB6  db 81 01 09 49 16 82 01 06 3B 16 08 09 60 00 00 76  ; ...I....;...`..v
3FC6  db 64 0A 86 38 00 00 C5 64 10 08 23 00 00 FA 64 10  ; d..8...d..#...d.
3FD6  db 08 40 00 00 2A 65 20 00 5E 00 00 65 65 10 08 28  ; .@..*e .^..ee..(
3FE6  db 00 00 3E 65 00 02 3C 00 00 BA 65 B2 12 09 03 40  ; ..>e..<...e....@
3FF6  db 91 08 18 81 01 0A 99 18 01 0A B1 00 00 F2 65 B2  ; ..............e.
4006  db 12 09 04 40 1A 07 17 81 01 0A 00 38 03 0A 38 00  ; ...@.......8..8.
4016  db 00 83 66 B2 12 09 05 40 1B 0A 16 81 01 0A 00 3B  ; ..f....@.......;
4026  db 04 0A 3B 00 00 B1 66 B2 12 09 06 40 1B 08 18 81  ; ..;...f....@....
4036  db 01 0A 00 3B 04 0A 3B 00 00 E1 66 B2 12 09 07 40  ; ...;..;...f....@
4046  db 1B 08 18 81 01 0A 00 3B 04 0A 3B 00 00 11 67 B2  ; .......;..;...g.
4056  db 12 09 0C 40 1B 07 17 81 01 0A 00 39 04 0A 39 00  ; ...@.......9..9.
4066  db 00 41 67 04 86 35 00 00 9F 67 10 0B 14 00 00 F5  ; .Ag..5...g......
4076  db 67 10 0B 0C 00 00 E4 67 20 00 5F 00 00 0D 68 B1  ; g......g ._...h.
4086  db 12 0A 08 40 00 18 18 04 0D 30 00 00 71 67 10 0B  ; ...@.....0..qg..
4096  db 19 00 00 B2 57 00 02 3C 00 00 63 68 91 01 03 80  ; ....W..<..ch....
40A6  db 11 46 82 01 07 4A 0D 88 01 07 45 12 84 01 07 45  ; .F...J....E....E
40B6  db 12 01 07 57 00 00 9A 68 A1 13 04 06 00 0C 07 0D  ; ...W...h........
40C6  db B1 12 06 04 40 20 07 0E 82 01 07 00 35 88 01 07  ; ....@ ......5...
40D6  db 00 35 84 01 07 00 35 06 07 2D 00 00 E2 68 C4 93  ; .5....5..-...h..
40E6  db 05 08 05 5C 0C 0F 0C B4 12 08 05 40 83 0F 0D 88  ; ...\.......@....
40F6  db 01 07 3A 65 07 08 9F 00 00 0D 69 09 86 15 00 00  ; ..:e......i.....
4106  db 91 69 10 09 23 00 00 AA 69 10 09 23 00 00 CD 69  ; .i..#...i..#...i
4116  db 10 09 23 00 00 F2 69 20 00 5D 00 00 16 6A 00 02  ; ..#...i .]...j..
4126  db 3C 00 00 D2 70 94 01 03 80 75 1C 01 13 91 00 00  ; <...p....u......
4136  db 0A 71 B4 12 FF 04 40 FF 3B 11 A1 12 FF 13 FF 3B  ; .q....@.;......;
4146  db 11 A8 12 FF 13 FF 3B 11 A0 12 FF 13 FF 3B 11 07  ; ......;......;..
4156  db 13 4B 01 00 81 71 94 01 05 80 CF 30 08 13 FF 00  ; .K...q.....0....
4166  db 00 92 72 B6 43 FF 06 40 FF FF 8E 18 B4 43 FF 06  ; ..r.C..@.....C..
4176  db 40 FF FF 8E 18 B2 43 FF 06 40 FF FF 8E 18 A0 43  ; @.....C..@.....C
4186  db FF 0E FF FF 8E 18 07 0E A4 02 00 62 73 81 01 10  ; ...........bs...
4196  db C2 19 92 01 07 80 C2 19 88 01 11 C2 19 94 01 07  ; ................
41A6  db 80 C2 19 96 01 07 80 C2 19 80 01 11 C2 19 09 11  ; ................
41B6  db DB 00 00 85 75 92 01 13 80 8A 14 98 01 08 80 8A  ; ....u...........
41C6  db 14 84 01 13 8A 14 09 13 9E 00 00 36 76 98 01 09  ; ...........6v...
41D6  db 80 4F 1E 91 01 09 80 4F 1E 99 01 09 80 4F 1E 0B  ; .O.....O.....O..
41E6  db 13 6D 00 00 B5 76 90 01 0A 80 0C 20 98 01 0A 80  ; .m...v..... ....
41F6  db 0C 20 09 0F 2C 00 00 0C 77 90 01 0B 80 50 20 81  ; . ..,...w....P .
4206  db 01 10 50 20 82 01 10 50 20 88 01 10 50 20 84 01  ; ..P ...P ...P ..
4216  db 10 50 20 0C 10 70 00 00 30 77 94 01 0C 80 48 2C  ; .P ..p..0w....H,
4226  db 91 01 0C 80 48 2C 95 01 0C 80 48 2C 88 01 12 48  ; ....H,....H,...H
4236  db 2C 0D 12 74 00 00 8A 77 90 01 0D 80 21 21 0E 10  ; ,..t...w....!!..
4246  db 42 00 00 E6 77 2F 81 17 02 22 1C 78 10 10 41 00  ; B...w/...".x..A.
4256  db 04 06 7A 10 14 32 00 04 42 7A 10 14 29 00 04 7A  ; ..z..2..Bz..)..z
4266  db 7A 10 14 41 00 04 A2 7A 10 14 31 00 04 DE 7A 10  ; z..A...z..1...z.
4276  db 14 31 00 04 D6 79 20 00 5E 00 00 0E 7B 46 43 3F  ; .1...y .^...{FC?
4286  db 43 46 43 4D 43 5B 43 54 43 5B 43 7E 43 95 43 9C  ; CFCMC[CTC[C~C.C.
4296  db 43 A3 43 AA 43 B8 43 B1 43 B8 43 CA 43 E1 43 FD  ; C.C.C.C.C.C.C.C.
42A6  db 43 27 44 49 44 84 44 8B 44 92 44 99 44 A0 44 A7  ; C'DID.D.D.D.D.D.
42B6  db 44 AE 44 BC 44 B5 44 BC 44 CE 44 E0 44 F2 44 F9  ; D.D.D.D.D.D.D.D.
42C6  db 44 00 45 07 45 0E 45 2E 45 27 45 2E 45 65 45 83  ; D.E.E.E.E'E.EeE.
42D6  db 45 A1 45 BF 45 C6 45 CD 45 D4 45 47 45 DB 45 E9  ; E.E.E.E.E.EGE.E.
42E6  db 45 E2 45 E9 45 05 46 1C 46 38 46 54 46 75 46 91  ; E.E.E.F.F8FTFuF.
42F6  db 46 A8 46 BF 46 DB 46 E2 46 E9 46 F0 46 F7 46 FE  ; F.F.F.F.F.F.F.F.
4306  db 46 05 47 0C 47 13 47 21 47 1A 47 21 47 3D 47 63  ; F.G.G.G!G.G!G=Gc
4316  db 47 85 47 A1 47 B8 47 BF 47 C6 47 CD 47 D4 47 E2  ; G.G.G.G.G.G.G.G.
4326  db 47 DB 47 E2 47 FE 47 20 48 3E 48 61 48 68 48 6F  ; G.G.G.G H>HaHhHo
4336  db 48 76 48 7D 48 84 48 8B 48 00 02 3C 00 00 57 05  ; HvH}H.H.H..<..W.
4346  db 00 03 AB 00 00 90 05 00 81 46 00 00 1F 07 00 02  ; .........F......
4356  db 3B 00 00 F3 0F 92 01 03 80 3B 3C 98 01 03 80 3B  ; ;........;<....;
4366  db 3C 9A 01 03 80 3B 3C 81 01 05 3B 3C 84 01 05 4A  ; <....;<...;<...J
4376  db 2C 01 05 77 00 00 5F 07 98 01 04 80 00 1D 81 01  ; ,..w.._.........
4386  db 05 00 1D 84 01 05 00 1D 03 05 15 00 00 AC 07 03  ; ................
4396  db 85 2A 00 00 D8 07 10 07 31 00 00 25 08 10 07 3A  ; .*......1..%...:
43A6  db 00 00 6C 08 20 00 5D 00 00 A5 08 00 02 3B 00 00  ; ..l. .]......;..
43B6  db F9 08 90 01 03 80 1C 19 81 01 09 1C 19 01 09 29  ; ...............)
43C6  db 00 00 66 09 91 01 04 80 30 0F 82 01 0A 30 0F 80  ; ..f.....0....0..
43D6  db 01 0A 30 0F 01 0A 3F 00 00 91 09 98 01 05 80 2C  ; ..0...?........,
43E6  db 1B 82 01 0A 31 16 80 01 0A 31 16 84 01 0A 31 16  ; ....1....1....1.
43F6  db 04 0A 47 00 00 C5 09 B2 12 0A 06 40 00 16 0F 98  ; ..G........@....
4406  db 01 06 80 16 0F 9A 01 06 80 16 0F 81 01 0C 16 0F  ; ................
4416  db 84 01 0A 00 26 80 01 0A 00 26 05 0C 26 00 00 FF  ; ....&....&..&...
4426  db 09 B4 12 0A 07 40 00 44 14 A1 12 0A 0B 00 3B 1C  ; .....@.D......;.
4436  db A0 12 0A 0B 00 3B 1C 82 01 0B 3B 1C 06 0B 57 00  ; .....;....;...W.
4446  db 00 1E 0A A1 13 0E 08 00 07 0F 07 B1 12 08 0E 80  ; ................
4456  db 1D 0F 0A A9 13 0E 08 00 07 0F 07 B9 12 08 0E 80  ; ................
4466  db 1D 0F 0A 88 01 0A 00 37 84 01 0A 00 36 80 01 0A  ; .......7....6...
4476  db 00 36 82 01 0A 00 36 07 0A 42 00 00 65 0A 08 86  ; .6....6..B..e...
4486  db 15 00 00 91 0A 10 0D 4E 00 00 A9 0A 10 0D 31 00  ; .......N......1.
4496  db 00 F1 0A 10 0D 4E 00 00 21 0B 10 0D 13 00 00 75  ; .....N..!......u
44A6  db 0B 20 00 5F 00 00 8C 0B 10 0D 24 00 00 69 0B 00  ; . ._......$..i..
44B6  db 02 3A 00 00 E1 0B 90 01 03 80 03 16 84 01 07 03  ; .:..............
44C6  db 16 01 07 19 00 00 48 0C 90 01 04 80 1C 16 88 01  ; ......H.........
44D6  db 07 1C 16 05 07 32 00 00 5C 0C 90 01 09 80 20 0C  ; .....2..\..... .
44E6  db 84 01 07 1E 0C 0A 06 2C 00 00 86 0C 08 86 56 00  ; .......,......V.
44F6  db 00 C8 0C 00 07 32 00 00 15 0D 10 08 14 00 00 45  ; .....2.........E
4506  db 0D 20 00 5E 00 00 5D 0D 91 01 05 80 0C 16 99 01  ; . .^..].........
4516  db 05 80 0C 16 98 01 05 80 0C 16 01 06 22 00 00 AA  ; ............"...
4526  db 0C 00 02 42 00 00 B1 0D A8 13 08 03 00 25 1B 3F  ; ...B.........%.?
4536  db 81 01 08 00 4A 82 01 08 00 4A 01 0A 42 00 80 E9  ; ....J....J..B...
4546  db 0D B8 12 08 03 40 00 37 1F 81 01 08 00 56 82 01  ; .....@.7.....V..
4556  db 08 00 56 84 01 08 37 1F 00 08 4E 00 00 26 0E B8  ; ..V...7...N..&..
4566  db 12 08 04 40 00 27 10 81 01 08 00 37 82 01 08 00  ; ...@.'.....7....
4576  db 37 84 01 08 00 37 03 07 2F 00 00 6D 0E B8 12 08  ; 7....7../..m....
4586  db 05 40 00 27 10 81 01 08 00 37 82 01 08 00 37 84  ; .@.'.....7....7.
4596  db 01 08 00 37 04 07 2F 00 00 9B 0E B8 12 08 06 40  ; ...7../........@
45A6  db 00 1A 1A 81 01 08 00 35 82 01 08 00 35 84 01 08  ; .......5....5...
45B6  db 00 35 05 09 2D 00 00 C9 0E 06 82 1F 00 00 F4 0E  ; .5..-...........
45C6  db 00 08 2C 00 80 55 0F 10 0B 23 00 00 7B 0F 10 0B  ; ..,..U...#..{...
45D6  db 2E 00 00 27 0F 20 00 5E 00 00 9F 0F 00 02 3B 00  ; ...'. .^......;.
45E6  db 00 F3 0F 94 01 03 80 00 12 81 01 0E 05 0D 82 01  ; ................
45F6  db 0E 05 0D 88 01 0E 05 0D 01 0E 12 00 00 4E 10 91  ; .............N..
4606  db 01 04 80 29 14 88 01 0E 00 3D 84 01 0C 29 14 07  ; ...).....=...)..
4616  db 0C 31 00 00 5D 10 98 01 05 80 20 29 84 01 0E 2D  ; .1..]..... )...-
4626  db 1C 81 01 0E 20 29 82 01 0E 28 21 08 0E 39 00 00  ; .... )...(!..9..
4636  db 8B 10 91 01 06 80 0F 26 82 01 0E 00 37 88 01 0E  ; .......&....7...
4646  db 00 37 84 01 0E 00 37 09 0E 37 00 00 C7 10 94 01  ; .7....7..7......
4656  db 07 80 27 18 88 01 0F 21 1E 80 01 0F 21 1E 81 01  ; ..'....!....!...
4666  db 0F 21 1E 82 01 0F 21 1E 0A 0F 38 00 00 F3 10 91  ; .!....!...8.....
4676  db 01 08 80 25 15 88 01 0F 00 3A 84 01 10 25 15 82  ; ...%.....:...%..
4686  db 01 0E 00 3A 0B 10 32 00 00 27 11 90 01 09 80 4A  ; ...:..2..'.....J
4696  db 16 82 01 0E 00 60 84 01 11 4A 16 0C 11 58 00 00  ; .....`...J...X..
46A6  db 57 11 98 01 0A 80 16 11 82 01 0E 00 2E 84 01 0E  ; W...............
46B6  db 1B 0D 0D 0E 28 00 00 A6 11 91 01 0B 80 30 14 88  ; ....(........0..
46C6  db 01 0E 00 44 84 01 0E 00 44 82 01 0F 00 44 0F 12  ; ...D....D....D..
46D6  db 44 00 00 C2 11 0E 8C 22 00 00 FB 11 10 13 14 00  ; D......"........
46E6  db 00 1F 12 10 13 30 00 00 37 12 10 13 31 00 00 67  ; .....0..7...1..g
46F6  db 12 10 13 58 00 00 97 12 10 13 22 00 00 E7 12 10  ; ...X......".....
4706  db 13 31 00 00 0B 13 10 13 41 00 00 3B 13 20 00 5E  ; .1......A..;. .^
4716  db 00 00 77 13 00 02 3B 00 00 CB 13 91 01 03 80 14  ; ..w...;.........
4726  db 17 82 01 09 14 17 88 01 09 14 17 84 01 09 14 17  ; ................
4736  db 01 09 22 00 00 23 14 90 01 04 80 31 1A 81 01 08  ; .."..#.....1....
4746  db 31 1A 82 01 09 31 1A 88 01 09 37 1B 84 01 08 31  ; 1....1....7....1
4756  db 1A 84 01 08 31 1A 09 08 3F 00 00 47 14 92 01 05  ; ....1...?..G....
4766  db 80 11 19 9A 01 05 80 11 19 81 01 09 00 2A 88 01  ; .............*..
4776  db 09 00 2A 84 01 09 00 2A 0B 09 2A 00 00 85 14 90  ; ..*....*..*.....
4786  db 01 06 80 14 20 81 01 0A 14 20 88 01 0A 00 08 84  ; .... .... ......
4796  db 01 09 00 34 0B 0A 34 00 00 A7 14 98 01 07 80 36  ; ...4..4........6
47A6  db 21 81 01 09 00 58 84 01 09 00 58 09 09 58 00 00  ; !....X....X..X..
47B6  db D2 14 07 89 11 00 00 1A 15 10 0B 22 00 00 2F 15  ; ..........."../.
47C6  db 10 0B 22 00 00 53 15 10 0B 1B 00 00 89 15 20 00  ; .."..S........ .
47D6  db 5E 00 00 A7 15 00 02 3B 00 00 FB 15 90 01 03 80  ; ^......;........
47E6  db 47 16 81 01 09 2D 30 88 01 07 47 16 84 01 0C 47  ; G....-0...G....G
47F6  db 16 01 07 5D 00 00 33 16 99 01 04 80 21 16 81 01  ; ...]..3.....!...
4806  db 09 1B 1C 98 01 04 80 21 16 84 01 08 21 16 80 01  ; .......!....!...
4816  db 08 21 16 04 07 37 00 00 7E 16 B0 12 0A 05 40 00  ; .!...7..~.....@.
4826  db 2C 14 81 01 0C 2C 14 82 01 0A 00 40 84 01 09 00  ; ,....,.....@....
4836  db 40 07 0C 40 00 00 AB 16 95 01 06 80 1A 15 91 01  ; @..@............
4846  db 06 80 1A 15 94 01 06 80 1A 15 82 01 0A 00 30 80  ; ..............0.
4856  db 01 0A 18 18 0B 0C 30 00 00 E0 16 00 87 37 00 00  ; ......0......7..
4866  db 07 17 10 0B 37 00 00 97 17 00 09 51 00 80 CB 17  ; ....7......Q....
4876  db 10 0B 23 00 00 13 18 10 0B 64 00 00 3B 17 20 00  ; ..#......d..;. .
4886  db 5E 00 00 37 18 10 0B 14 00 00 7F 17 7D 49 76 49  ; ^..7........}IvI
4896  db 7D 49 8F 49 9C 49 BA 49 E0 49 E7 49 EE 49 F5 49  ; }I.I.I.I.I.I.I.I
48A6  db FC 49 03 4A 11 4A 0A 4A 11 4A 34 4A 57 4A 70 4A  ; .I.J.J.J.J4JWJpJ
48B6  db 7F 4A 91 4A 98 4A 9F 4A A6 4A AD 4A B4 4A BB 4A  ; .J.J.J.J.J.J.J.J
48C6  db C2 4A D0 4A C9 4A D0 4A F7 4A 13 4B 2F 4B 4B 4B  ; .J.J.J.J.J.K/KKK
48D6  db 52 4B 59 4B 60 4B 67 4B 75 4B 6E 4B 75 4B 89 4B  ; RKYK`KgKuKnKuK.K
48E6  db 90 4B 97 4B A5 4B 9E 4B A5 4B BC 4B C3 4B CA 4B  ; .K.K.K.K.K.K.K.K
48F6  db D1 4B DF 4B D8 4B DF 4B FB 4B 20 4C 43 4C 5F 4C  ; .K.K.K.K.K LCL_L
4906  db 66 4C 6D 4C 74 4C 82 4C 7B 4C 82 4C A3 4C BC 4C  ; fLmLtL.L{L.L.L.L
4916  db D5 4C EE 4C 07 4D 20 4D 27 4D 2E 4D 35 4D 3C 4D  ; .L.L.M M'M.M5M<M
4926  db 4A 4D 43 4D 4A 4D 66 4D 82 4D 9E 4D BA 4D D6 4D  ; JMCMJMfM.M.M.M.M
4936  db F2 4D 0E 4E 20 4E 27 4E 2E 4E 35 4E 43 4E 3C 4E  ; .M.N N'N.N5NCN<N
4946  db 43 4E 64 4E 82 4E 9E 4E BC 4E D3 4E F4 4E FB 4E  ; CNdN.N.N.N.N.N.N
4956  db 02 4F 09 4F 10 4F 17 4F 1E 4F 2C 4F 25 4F 2C 4F  ; .O.O.O.O.O,O%O,O
4966  db 43 4F 66 4F 87 4F A9 4F C5 4F CC 4F D3 4F DA 4F  ; COfO.O.O.O.O.O.O
4976  db 00 02 3C 00 00 8B 18 94 01 03 80 05 14 82 01 07  ; ..<.............
4986  db 05 14 01 07 11 00 00 11 19 90 01 04 80 34 11 05  ; .............4..
4996  db 08 45 00 00 27 19 94 01 05 80 1B 11 A2 12 0B 08  ; .E..'...........
49A6  db 00 1B 11 88 01 08 1B 11 80 01 08 1B 11 08 08 2C  ; ...............,
49B6  db 00 00 5F 19 94 01 06 80 3B 0F 95 01 06 80 3B 0F  ; .._.....;.....;.
49C6  db 88 01 09 3B 0F 81 01 09 3B 0F C2 93 08 0B 07 00  ; ...;....;.......
49D6  db 2B 17 11 06 07 4F 00 00 87 19 07 88 34 00 00 C7  ; +....O......4...
49E6  db 19 10 0A 32 00 00 F7 19 10 0A 23 00 00 27 1A 10  ; ...2......#..'..
49F6  db 0A 6C 00 00 4B 1A 20 00 5E 00 00 AB 1A 10 0A 26  ; .l..K. .^......&
4A06  db 00 00 07 1A 00 02 3C 00 00 FF 1A B0 12 09 03 40  ; ......<........@
4A16  db 2C 23 0D 84 01 08 00 5C 88 01 08 00 5C 81 01 08  ; ,#.....\....\...
4A26  db 2D 32 82 01 08 00 22 01 09 5C 00 00 52 1B B0 12  ; -2...."..\..R...
4A36  db 0A 04 40 1A 23 0D 81 01 08 22 26 82 01 08 00 22  ; ..@.#...."&...."
4A46  db 88 01 08 00 4A 84 01 08 00 4A 06 0A 4A 00 00 9F  ; ....J....J..J...
4A56  db 1B B4 12 08 05 40 00 1D 34 82 01 0B 1E 33 88 01  ; .....@..4....3..
4A66  db 08 00 51 08 0B 51 00 00 DB 1B B0 12 0C 06 40 06  ; ..Q..Q........@.
4A76  db 24 0D 07 0C 37 00 00 1D 1C 90 01 07 80 9A 1F 88  ; $...7...........
4A86  db 01 0D 9A 1F 07 0D B9 00 00 4B 1C 06 85 6F 00 00  ; .........K...o..
4A96  db E1 1C 10 0E 23 00 00 41 1D 10 0E 14 00 00 65 1D  ; ....#..A......e.
4AA6  db 10 0E 31 00 00 7D 1D 10 0E 17 00 00 C7 1D 10 0E  ; ..1..}..........
4AB6  db 14 00 00 E1 1D 10 0E 45 00 00 01 1E 20 00 5E 00  ; .......E.... .^.
4AC6  db 00 41 1E 00 02 3C 00 00 95 1E A1 12 07 03 00 30  ; .A...<.........0
4AD6  db 0A A1 13 07 03 3A 22 0A 22 A1 12 03 07 88 0A 21  ; .....:"."......!
4AE6  db 84 01 09 00 B4 88 01 09 00 B4 01 07 AC 00 00 44  ; ...............D
4AF6  db 1F 90 01 04 80 59 0D 88 01 09 00 66 84 01 09 00  ; .....Y.....f....
4B06  db 66 82 01 09 60 06 0D 08 66 00 00 D7 1F 92 01 05  ; f...`...f.......
4B16  db 80 34 28 81 01 09 00 5C 88 01 09 00 5C 84 01 09  ; .4(....\....\...
4B26  db 48 14 09 09 5C 00 00 2A 20 91 01 06 80 2C 2D 82  ; H...\..* ....,-.
4B36  db 01 09 32 27 88 01 09 00 59 84 01 09 00 59 07 09  ; ..2'....Y....Y..
4B46  db 59 00 00 77 20 06 88 05 00 00 BF 20 10 0A 39 00  ; Y..w ...... ..9.
4B56  db 00 CB 20 10 0A 3E 00 00 1B 21 10 0A 23 00 00 55  ; .. ..>...!..#..U
4B66  db 21 20 00 5D 00 00 7A 21 00 02 3C 00 00 CD 21 B8  ; ! .]..z!..<...!.
4B76  db 12 04 03 40 68 19 16 81 01 04 58 40 01 04 98 00  ; ...@h.....X@....
4B86  db 00 4D 22 04 86 0E 00 00 CA 22 10 05 4F 00 00 E9  ; .M"......"..O...
4B96  db 22 20 00 5E 00 00 31 23 00 02 3C 00 00 85 23 91  ; " .^..1#..<...#.
4BA6  db 11 03 80 00 1F 88 01 05 00 1F 84 01 05 00 1F 01  ; ................
4BB6  db 04 12 00 00 E6 23 04 83 48 00 00 FF 23 10 06 0F  ; .....#..H...#...
4BC6  db 00 00 55 24 10 06 40 00 00 71 24 20 00 5E 00 00  ; ..U$..@..q$ .^..
4BD6  db AD 24 00 02 3C 00 00 01 25 98 01 03 80 3A 13 81  ; .$..<...%....:..
4BE6  db 01 08 3A 12 84 01 08 3A 12 82 01 08 3A 12 01 08  ; ..:....:....:...
4BF6  db 4D 00 00 50 25 D1 93 07 FF 04 20 00 0A 19 1D D4  ; M..P%..... .....
4C06  db 93 07 FF 04 20 00 0A 19 1D 82 01 08 22 1F 88 01  ; .... ......."...
4C16  db 08 22 1F 06 08 40 00 00 8F 25 94 01 05 80 14 27  ; ."...@...%.....'
4C26  db 81 01 07 14 27 92 01 05 80 14 27 96 01 05 80 14  ; ....'.....'.....
4C36  db 27 88 01 07 00 3B 07 08 3B 00 00 C3 25 94 01 06  ; '....;..;...%...
4C46  db 80 06 2B 81 01 07 00 31 82 01 08 00 31 88 01 08  ; ..+....1....1...
4C56  db 00 31 06 08 31 00 00 F4 25 07 8A 45 00 00 25 26  ; .1..1...%..E..%&
4C66  db 00 08 23 00 00 5D 26 10 09 14 00 00 81 26 20 00  ; ..#..]&......& .
4C76  db 5E 00 00 99 26 00 02 3C 00 00 ED 26 B9 12 09 03  ; ^...&..<...&....
4C86  db 40 67 09 17 B8 12 09 03 40 67 0A 16 81 01 09 71  ; @g......@g.....q
4C96  db 16 84 01 0B 71 16 01 09 7D 00 00 25 27 B4 12 09  ; ....q...}..%'...
4CA6  db 04 40 0C 09 14 81 01 09 16 13 88 01 0B 16 13 05  ; .@..............
4CB6  db 09 22 00 00 93 27 B8 12 09 05 40 1A 09 14 81 01  ; ."...'....@.....
4CC6  db 09 1A 1D 84 01 0B 24 13 05 09 30 00 00 B4 27 B4  ; ......$...0...'.
4CD6  db 12 09 06 40 1D 09 15 88 01 0B 27 14 81 01 09 1F  ; ...@......'.....
4CE6  db 1C 05 09 34 00 00 E1 27 B4 12 09 07 40 1D 09 12  ; ...4...'....@...
4CF6  db 81 01 0A 1D 1B 88 01 0A 1D 1B 05 0A 32 00 00 11  ; ............2...
4D06  db 28 B4 12 09 08 40 0C 09 15 88 01 0B 16 14 81 01  ; (....@..........
4D16  db 09 0C 1E 07 09 23 00 00 3F 28 05 83 87 00 00 61  ; .....#..?(.....a
4D26  db 28 10 0C 31 00 00 D5 28 10 0C 45 00 00 05 29 10  ; (..1...(..E...).
4D36  db 0C 23 00 00 45 29 20 00 5E 00 00 69 29 00 02 3C  ; .#..E) .^..i)..<
4D46  db 00 00 BD 29 98 01 03 80 56 29 81 01 0B 67 18 82  ; ...)....V)...g..
4D56  db 01 0B 67 18 84 01 0B 67 18 01 0B 7F 00 00 F5 29  ; ..g....g.......)
4D66  db 94 01 04 80 0D 1A 81 01 0B 00 27 82 01 0B 00 27  ; ..........'....'
4D76  db 88 01 0B 00 27 08 0B 27 00 00 5E 2A 91 01 05 80  ; ....'..'..^*....
4D86  db 1D 11 82 01 0B 00 2E 88 01 0B 00 2E 84 01 0B 00  ; ................
4D96  db 2E 08 0B 2E 00 00 7E 2A 94 01 06 80 22 1E 81 01  ; ......~*...."...
4DA6  db 0B 00 40 82 01 0B 00 40 88 01 0B 00 40 09 0B 40  ; ..@....@....@..@
4DB6  db 00 00 A5 2A 98 01 07 80 24 1B 81 01 0B 00 3F 82  ; ...*....$.....?.
4DC6  db 01 0B 00 3F 84 01 0B 00 3F 08 0B 3F 00 00 D8 2A  ; ...?....?..?...*
4DD6  db 94 01 08 80 0C 13 81 01 0B 00 1F 82 01 0B 00 1F  ; ................
4DE6  db 88 01 0B 00 1F 08 0B 1F 00 00 0B 2B 98 01 09 80  ; ...........+....
4DF6  db 06 11 81 01 0B 00 17 88 01 0B 00 17 84 01 0B 00  ; ................
4E06  db 17 08 0B 17 00 00 25 2B 81 01 0C 30 20 90 01 0A  ; ......%+...0 ...
4E16  db 80 30 20 0D 0C 50 00 00 39 2B 09 8B 66 00 00 7B  ; .0 ..P..9+..f..{
4E26  db 2B 10 0D 32 00 00 05 2C 10 0D 1E 00 00 35 2C 20  ; +..2...,.....5, 
4E36  db 00 5E 00 00 55 2C 00 02 3C 00 00 A9 2C 91 01 03  ; .^..U,..<...,...
4E46  db 80 45 1B 80 01 09 42 1D 82 01 0A 42 1D 88 01 0A  ; .E....B....B....
4E56  db 42 1D 84 01 0A 42 1D 01 0A 60 00 00 E1 2C B0 12  ; B....B...`...,..
4E66  db 0A 04 40 00 15 12 81 01 0B 1C 0B 82 01 0A 00 27  ; ..@............'
4E76  db 84 01 0B 15 12 05 0B 27 00 00 30 2D 91 01 05 80  ; .......'..0-....
4E86  db 23 1E 82 01 0A 1F 21 88 01 0C 1F 21 84 01 0C 1F  ; #.....!....!....
4E96  db 21 06 0C 41 00 00 51 2D B0 12 0A 06 40 00 12 12  ; !..A..Q-....@...
4EA6  db 81 01 0B 12 11 82 01 0C 00 24 88 01 0B 12 11 05  ; .........$......
4EB6  db 0B 24 00 00 86 2D 94 01 07 80 17 20 82 01 0C 00  ; .$...-..... ....
4EC6  db 37 88 01 0C 0B 2C 06 0C 37 00 00 A4 2D 90 01 08  ; 7....,..7...-...
4ED6  db 80 18 1F 81 01 0D 20 17 82 01 0D 15 22 88 01 0D  ; ...... ....."...
4EE6  db 20 17 84 01 0D 20 17 05 0D 37 00 00 D1 2D 05 84  ;  .... ...7...-..
4EF6  db 7D 00 00 FD 2D 10 0A 23 00 00 69 2E 10 0E 07 00  ; }...-..#..i.....
4F06  db 00 80 2E 10 0E 13 00 00 8D 2E 10 0E 24 00 00 A4  ; ............$...
4F16  db 2E 10 0E 49 00 00 CF 2E 20 00 54 00 00 10 2F 00  ; ...I.... .T.../.
4F26  db 02 3C 00 00 65 2F 91 01 03 80 00 15 82 01 09 02  ; .<..e/..........
4F36  db 13 88 01 09 00 1F 01 09 15 00 00 CE 2F 95 01 04  ; ............/...
4F46  db 80 00 22 91 01 04 80 00 22 94 01 04 80 1D 22 82  ; ..".....".....".
4F56  db 01 09 00 22 88 01 09 00 22 06 09 22 00 00 E0 2F  ; ..."...."..".../
4F66  db 90 01 05 80 34 16 88 01 09 00 4A 81 01 08 34 16  ; ....4.....J...4.
4F76  db 82 01 09 00 0B 84 01 09 0A 49 06 08 4A 00 00 FD  ; .........I..J...
4F86  db 2F 98 01 06 80 0B 20 81 01 09 00 1F 99 01 06 80  ; /..... .........
4F96  db 0B 1F 82 01 09 00 2B 84 01 09 00 22 0A 09 2C 00  ; ......+...."..,.
4FA6  db 00 3A 30 98 01 07 80 1B 11 81 01 09 00 2C 82 01  ; .:0..........,..
4FB6  db 09 00 2C 84 01 09 00 2C 06 09 24 00 00 5D 30 0C  ; ..,....,..$..]0.
4FC6  db 89 41 00 00 81 30 10 0A 31 00 00 F9 30 10 0A 41  ; .A...0..1...0..A
4FD6  db 00 00 BD 30 20 00 5E 00 00 29 31 22 51 1B 51 22  ; ...0 .^..)1"Q.Q"
4FE6  db 51 54 51 72 51 90 51 AE 51 B5 51 BC 51 C3 51 3B  ; QTQrQ.Q.Q.Q.Q.Q;
4FF6  db 51 CA 51 D8 51 D1 51 D8 51 EF 51 01 52 1D 52 39  ; Q.Q.Q.Q.Q.Q.R.R9
5006  db 52 5A 52 76 52 8D 52 A4 52 C0 52 C7 52 CE 52 D5  ; RZRvR.R.R.R.R.R.
5016  db 52 DC 52 E3 52 EA 52 F1 52 F8 52 06 53 FF 52 06  ; R.R.R.R.R.R.S.R.
5026  db 53 13 53 25 53 48 53 64 53 76 53 7D 53 84 53 8B  ; S.S%SHSdSvS}S.S.
5036  db 53 92 53 99 53 A7 53 A0 53 A7 53 CD 53 F4 53 1F  ; S.S.S.S.S.S.S.S.
5046  db 54 26 54 2D 54 34 54 3B 54 42 54 50 54 49 54 50  ; T&T-T4T;TBTPTITP
5056  db 54 73 54 96 54 AF 54 D2 54 E9 54 F0 54 F7 54 FE  ; TsT.T.T.T.T.T.T.
5066  db 54 05 55 0C 55 13 55 1A 55 28 55 21 55 28 55 4B  ; T.U.U.U.U(U!U(UK
5076  db 55 66 55 81 55 9C 55 B5 55 D0 55 D7 55 DE 55 E5  ; UfU.U.U.U.U.U.U.
5086  db 55 EC 55 FA 55 F3 55 FA 55 1E 56 3F 56 60 56 81  ; U.U.U.U.U.V?V`V.
5096  db 56 A2 56 C3 56 E5 56 F7 56 09 57 1B 57 34 57 46  ; V.V.V.V.V.W.W4WF
50A6  db 57 4D 57 54 57 5B 57 62 57 70 57 69 57 70 57 8C  ; WMWTW[WbWpWiWpW.
50B6  db 57 93 57 9A 57 A1 57 AF 57 A8 57 AF 57 D0 57 EE  ; W.W.W.W.W.W.W.W.
50C6  db 57 0A 58 28 58 3F 58 5B 58 62 58 69 58 70 58 77  ; W.X(X?X[XbXiXpXw
50D6  db 58 7E 58 85 58 93 58 8C 58 93 58 B9 58 DA 58 F6  ; X~X.X.X.X.X.X.X.
50E6  db 58 12 59 19 59 20 59 27 59 2E 59 3C 59 35 59 3C  ; X.Y.Y Y'Y.Y<Y5Y<
50F6  db 59 53 59 6C 59 88 59 8F 59 96 59 9D 59 A4 59 46  ; YSYlY.Y.Y.Y.Y.YF
5106  db 5A 3F 5A 46 5A 6C 5A 93 5A BE 5A C5 5A CC 5A D3  ; Z?ZFZlZ.Z.Z.Z.Z.
5116  db 5A DA 5A E1 5A 00 02 42 00 00 7D 31 A4 13 09 03  ; Z.Z.Z..B..}1....
5126  db 00 25 1B 3F 81 01 09 00 4A 82 01 09 00 4A 01 0A  ; .%.?....J....J..
5136  db 4B 00 80 B5 31 B4 12 09 03 40 00 37 1F 81 01 09  ; K...1....@.7....
5146  db 00 56 82 01 09 00 56 00 09 4E 00 00 F2 31 B4 12  ; .V....V..N...1..
5156  db 09 04 40 00 28 0F 88 01 09 00 37 81 01 09 00 37  ; ..@.(.....7....7
5166  db 82 01 09 00 37 04 08 2F 00 00 39 32 B4 12 09 05  ; ....7../..92....
5176  db 40 00 28 0F 88 01 09 00 37 81 01 09 00 37 82 01  ; @.(.....7....7..
5186  db 09 00 37 05 08 2F 00 00 67 32 B4 12 09 06 40 00  ; ..7../..g2....@.
5196  db 1A 1A 81 01 09 00 34 82 01 09 00 34 88 01 09 00  ; ......4....4....
51A6  db 34 00 07 2C 00 00 95 32 00 82 1F 00 00 C1 32 10  ; 4..,...2......2.
51B6  db 0B 2C 00 00 F1 32 10 0B 52 00 00 21 33 10 0B 1F  ; .,...2..R..!3...
51C6  db 00 00 47 33 20 00 5E 00 00 6B 33 00 02 3C 00 00  ; ..G3 .^..k3..<..
51D6  db BF 33 98 01 03 80 00 1A 81 01 0E 0E 0C 84 01 0E  ; .3..............
51E6  db 0E 0C 01 0E 1A 00 00 18 34 91 01 04 80 1B 22 84  ; ........4.....".
51F6  db 01 0E 00 3D 08 0C 3D 00 00 2D 34 94 01 05 80 20  ; ...=..=..-4.... 
5206  db 28 88 01 0E 2D 1B 81 01 0E 20 28 82 01 0E 20 28  ; (...-.... (... (
5216  db 09 0E 40 00 00 57 34 91 01 06 80 0F 25 82 01 0E  ; ..@..W4.....%...
5226  db 00 34 88 01 0E 00 34 84 01 0E 00 34 0A 0E 34 00  ; .4....4....4..4.
5236  db 00 93 34 98 01 07 80 14 2A 84 01 0F 21 1E 81 01  ; ..4.....*...!...
5246  db 0F 20 1E 82 01 0F 20 1E 80 01 0F 20 1E 0B 0F 3E  ; . .... .... ...>
5256  db 00 00 BF 34 91 01 08 80 24 16 84 01 0F 00 3A 88  ; ...4....$.....:.
5266  db 01 10 24 15 82 01 0E 00 3A 0C 10 3A 00 00 F3 34  ; ..$.....:..:...4
5276  db 90 01 09 80 4A 16 82 01 0E 00 63 88 01 11 4A 19  ; ....J.....c...J.
5286  db 0D 11 60 00 00 23 35 94 01 0A 80 16 18 82 01 0E  ; ..`..#5.........
5296  db 00 27 88 01 0E 1B 13 0D 0E 2E 00 00 75 35 91 01  ; .'..........u5..
52A6  db 0B 80 17 27 88 01 0E 00 3E 84 01 0E 00 3E 82 01  ; ...'....>....>..
52B6  db 0F 00 3E 0F 12 3E 00 00 93 35 0E 8C 22 00 00 C7  ; ..>..>...5.."...
52C6  db 35 10 13 14 00 00 EB 35 10 13 30 00 00 03 36 10  ; 5......5..0...6.
52D6  db 13 31 00 00 33 36 10 13 57 00 00 63 36 10 13 23  ; .1..36..W..c6..#
52E6  db 00 00 B3 36 10 13 32 00 00 D7 36 10 13 41 00 00  ; ...6..2...6..A..
52F6  db 07 37 20 00 5E 00 00 43 37 00 02 3C 00 00 97 37  ; .7 .^..C7..<...7
5306  db 90 01 03 80 00 1E 01 08 14 00 00 F7 37 94 01 04  ; ............7...
5316  db 80 19 16 88 01 0A 00 2F 07 0A 2F 00 00 0F 38 95  ; ......./../...8.
5326  db 01 05 80 32 1A 91 01 05 80 32 1A 94 01 05 80 32  ; ...2.....2.....2
5336  db 1A 82 01 0A 0C 40 88 01 08 00 0C 09 09 3A 00 00  ; .....@.......:..
5346  db 35 38 90 01 06 80 2F 12 82 01 0A 00 24 88 01 0A  ; 58..../.....$...
5356  db 2E 12 84 01 0B 2E 12 07 0B 3B 00 00 73 38 94 01  ; .........;..s8..
5366  db 07 80 00 30 88 01 0A 00 30 0C 0A 28 00 00 A7 38  ; ...0....0..(...8
5376  db 01 8C 1E 00 00 CE 38 10 0C 32 00 00 13 39 00 0A  ; ......8..2...9..
5386  db 17 00 80 43 39 10 0C 17 00 00 57 39 10 0C 23 00  ; ...C9.....W9..#.
5396  db 00 EF 38 20 00 5E 00 00 73 39 00 02 3C 00 00 C7  ; ..8 .^..s9..<...
53A6  db 39 A4 13 09 07 54 42 09 0B A4 13 07 08 AA 09 0B  ; 9....TB.........
53B6  db 09 88 01 09 54 75 81 01 09 54 75 82 01 09 54 75  ; ....Tu...Tu...Tu
53C6  db 01 03 CA 00 80 FF 39 C8 93 09 07 08 00 4A 09 0B  ; ......9......J..
53D6  db A8 13 07 08 5E 09 0B 09 84 01 09 00 7F 81 01 09  ; ....^...........
53E6  db 00 7F 82 01 09 00 7F 01 04 7F 00 80 A3 3A A4 13  ; .............:..
53F6  db 08 07 00 4A 09 0B A4 13 07 08 5E 09 0B 09 84 01  ; ...J......^.....
5406  db 09 7B 2A 88 01 09 00 A5 81 01 09 00 A5 82 01 09  ; .{*.............
5416  db 00 A5 08 05 A5 00 80 0B 3B 10 0A 3C 00 04 92 3B  ; ........;..<...;
5426  db 00 07 6D 00 02 05 3C 0B 81 8A 00 22 06 3C 10 0A  ; ..m...<....".<..
5436  db 41 00 04 CA 3B 10 0A 19 00 04 EA 3B 20 00 5E 00  ; A...;......; .^.
5446  db 00 7E 3C 00 02 3C 00 00 D2 3C B0 12 09 03 40 2C  ; .~<..<...<....@,
5456  db 23 0F 84 01 08 00 5C 88 01 08 00 5C 81 01 08 2D  ; #.....\....\...-
5466  db 32 82 01 08 00 4F 01 09 5E 00 00 25 3D B0 12 0A  ; 2....O..^..%=...
5476  db 04 40 1A 21 0F 81 01 08 22 26 82 01 08 00 22 88  ; .@.!...."&....".
5486  db 01 08 00 4A 84 01 08 00 4A 07 0A 4A 00 00 72 3D  ; ...J....J..J..r=
5496  db B8 12 08 05 40 00 1D 35 82 01 08 00 52 84 01 08  ; ....@..5....R...
54A6  db 00 52 09 0B 52 00 00 AE 3D B0 12 0C 06 40 07 21  ; .R..R...=....@.!
54B6  db 0F 81 01 0C 1F 19 82 01 0C 1F 19 84 01 0C 1F 19  ; ................
54C6  db 88 01 0C 1F 19 07 0C 36 00 00 F0 3D 90 01 07 80  ; .......6...=....
54D6  db 99 1F 88 01 0D 9A 1F 84 01 0D 9A 1F 07 0D B8 00  ; ................
54E6  db 00 1E 3E 06 85 6F 00 00 B3 3E 10 0E 23 00 00 14  ; ..>..o...>..#...
54F6  db 3F 10 0E 14 00 00 38 3F 10 0E 31 00 00 50 3F 10  ; ?.....8?..1..P?.
5506  db 0E 17 00 00 9A 3F 10 0E 14 00 00 B4 3F 10 0E 45  ; .....?......?..E
5516  db 00 00 D5 3F 20 00 5F 00 00 15 40 00 02 3C 00 00  ; ...? ._...@..<..
5526  db 68 40 B5 12 09 03 40 66 0A 16 B4 12 09 03 40 66  ; h@....@f......@f
5536  db 0A 16 81 01 09 71 15 A8 12 09 0B 66 0A 15 01 09  ; .....q.....f....
5546  db 7E 00 00 A0 40 B8 12 09 04 40 00 16 10 81 01 09  ; ~...@....@......
5556  db 16 11 A4 12 09 0B 00 16 11 06 09 22 00 00 0D 41  ; ..........."...A
5566  db B4 12 09 05 40 00 27 14 A8 12 09 0B 00 27 14 81  ; ....@.'......'..
5576  db 01 09 1A 21 06 09 33 00 00 2C 41 B8 12 09 06 40  ; ...!..3..,A....@
5586  db 00 27 14 A4 12 09 0B 00 27 14 81 01 09 1F 1C 05  ; .'......'.......
5596  db 09 34 00 00 5C 41 B8 12 09 07 40 00 25 11 81 01  ; .4..\A....@.%...
55A6  db 0A 1D 19 84 01 0A 1D 19 05 0A 31 00 00 8C 41 B8  ; ..........1...A.
55B6  db 12 09 08 40 00 18 14 A4 12 09 0B 00 18 14 81 01  ; ...@............
55C6  db 09 0C 20 08 09 28 00 00 B8 41 05 83 87 00 00 DC  ; .. ..(...A......
55D6  db 41 10 0C 30 00 00 50 42 10 0C 45 00 00 80 42 10  ; A..0..PB..E...B.
55E6  db 0C 23 00 00 C0 42 20 00 5E 00 00 E4 42 00 02 3A  ; .#...B .^...B..:
55F6  db 00 00 38 43 B4 12 10 03 40 00 2F 0E 81 01 10 23  ; ..8C....@./....#
5606  db 1D 95 01 03 80 2F 0E 82 01 11 0E 32 88 01 10 00  ; ...../.....2....
5616  db 40 01 0F 40 00 00 70 43 98 01 04 80 6A 1A 88 01  ; @..@..pC....j...
5626  db 10 1F 46 84 01 10 1E 64 81 01 10 6A 1A 82 01 0F  ; ..F....d...j....
5636  db 1E 64 08 11 82 00 00 A4 43 98 01 05 80 50 17 88  ; .d......C....P..
5646  db 01 10 14 3B 84 01 10 14 53 82 01 0F 14 53 81 01  ; ...;....S....S..
5656  db 10 50 17 07 11 67 00 00 0E 44 98 01 06 80 2F 14  ; .P...g...D..../.
5666  db 88 01 10 0F 1F 84 01 10 0F 34 81 01 10 2F 14 82  ; .........4.../..
5676  db 01 0F 0F 34 07 11 43 00 00 62 44 98 01 07 80 76  ; ...4..C..bD....v
5686  db 14 88 01 10 36 3F 84 01 10 36 54 81 01 10 76 14  ; ....6?...6T...v.
5696  db 82 01 0F 36 54 07 11 8A 00 00 98 44 98 01 08 80  ; ...6T......D....
56A6  db 2F 14 88 01 10 0F 20 84 01 10 0F 34 81 01 10 2F  ; /..... ....4.../
56B6  db 14 82 01 0F 0F 34 07 11 43 00 00 08 45 91 01 09  ; .....4..C...E...
56C6  db 80 0C 36 90 01 09 80 0C 36 88 01 10 0C 36 84 01  ; ..6.....6....6..
56D6  db 10 0C 36 82 01 0F 0C 36 09 11 42 00 00 3E 45 90  ; ..6....6..B..>E.
56E6  db 01 0A 80 19 16 82 01 0F 19 16 0B 0F 2F 00 00 74  ; ............/..t
56F6  db 45 90 01 0B 80 06 1A 84 01 0F 06 1A 00 0F 20 00  ; E............. .
5706  db 00 9A 45 90 01 0C 80 00 11 88 01 0F 00 11 00 0F  ; ..E.............
5716  db 1E 00 00 B4 45 90 01 0D 80 00 26 92 01 0D 80 00  ; ....E.....&.....
5726  db 26 96 01 0D 80 00 26 00 0F 26 00 00 C2 45 90 01  ; &.....&..&...E..
5736  db 0E 80 00 1F 88 01 0F 00 1F 00 0F 1F 00 00 E1 45  ; ...............E
5746  db 00 87 8B 00 00 FA 45 10 12 14 00 00 74 46 10 12  ; ......E.....tF..
5756  db 59 00 00 8C 46 10 12 3F 00 00 A2 46 20 00 5E 00  ; Y...F..?...F .^.
5766  db 00 DE 46 00 02 3C 00 00 32 47 98 01 03 80 00 3D  ; ..F..<..2G.....=
5776  db 81 01 04 00 3D 82 01 05 27 16 84 01 05 27 16 01  ; ....=...'....'..
5786  db 05 3D 00 00 6A 47 04 82 2B 00 00 9E 47 10 06 7C  ; .=..jG..+...G..|
5796  db 00 00 CA 47 10 06 23 00 00 36 48 20 00 5E 00 00  ; ...G..#..6H .^..
57A6  db 5A 48 00 02 3C 00 00 AE 48 91 01 03 80 49 1E 80  ; ZH..<...H....I..
57B6  db 01 09 49 1D 82 01 0A 49 1D 88 01 0A 49 1D 84 01  ; ..I....I....I...
57C6  db 0A 49 1D 01 0A 67 00 00 E6 48 B0 12 0A 04 40 00  ; .I...g...H....@.
57D6  db 0F 0D 81 01 0B 11 0B 82 01 0A 00 26 88 01 0B 0F  ; ...........&....
57E6  db 0D 05 0B 1C 00 00 3A 49 91 01 05 80 22 20 82 01  ; ......:I...." ..
57F6  db 0A 22 21 88 01 0C 22 20 84 01 0C 22 20 09 0C 42  ; ."!..." ..." ..B
5806  db 00 00 52 49 B0 12 0A 06 40 00 15 0D 81 01 0B 15  ; ..RI....@.......
5816  db 0D 82 01 0C 00 23 84 01 0B 15 0D 05 0B 22 00 00  ; .....#......."..
5826  db 89 49 98 01 07 80 0F 28 82 01 0C 00 37 84 01 0C  ; .I.....(....7...
5836  db 0F 37 09 0C 37 00 00 A6 49 90 01 08 80 17 20 88  ; .7..7...I..... .
5846  db 01 0D 17 20 84 01 0D 17 20 82 01 0D 17 20 05 0D  ; ... .... .... ..
5856  db 37 00 00 D4 49 05 84 7B 00 00 02 4A 10 0E 23 00  ; 7...I..{...J..#.
5866  db 00 6E 4A 10 0E 07 00 00 85 4A 10 0E 12 00 00 92  ; .nJ......J......
5876  db 4A 10 0E 23 00 00 AA 4A 10 0E 49 00 00 CE 4A 20  ; J..#...J..I...J 
5886  db 00 54 00 00 16 4B 00 02 3B 00 00 6A 4B A1 13 07  ; .T...K..;..jK...
5896  db 03 00 16 09 23 A1 13 03 07 42 09 23 09 81 01 07  ; ....#....B.#....
58A6  db 77 0C 84 01 09 00 85 88 01 09 00 85 01 07 7D 00  ; w.............}.
58B6  db 00 40 4C 90 01 04 80 5A 0F 82 01 09 5A 10 88 01  ; .@L....Z....Z...
58C6  db 09 00 51 84 01 09 00 51 81 01 08 00 69 0E 08 69  ; ..Q....Q....i..i
58D6  db 00 00 AC 4C 92 01 05 80 42 19 81 01 09 00 5B 88  ; ...L....B.....[.
58E6  db 01 09 42 19 84 01 09 00 5B 09 09 5B 00 00 00 4D  ; ..B.....[..[...M
58F6  db 91 01 06 80 30 1D 82 01 09 30 2A 88 01 09 00 5A  ; ....0....0*....Z
5906  db 84 01 09 30 2A 07 09 4D 00 00 4A 4D 06 88 0F 00  ; ...0*..M..JM....
5916  db 00 8A 4D 10 0A 39 00 00 A0 4D 10 0A 41 00 00 EE  ; ..M..9...M..A...
5926  db 4D 10 0A 22 00 00 2A 4E 20 00 5E 00 00 4E 4E 00  ; M.."..*N .^..NN.
5936  db 02 3C 00 00 A2 4E 92 01 03 80 70 16 84 01 06 53  ; .<...N....p....S
5946  db 33 88 01 07 70 16 01 06 84 00 00 DB 4E B1 12 06  ; 3...p.......N...
5956  db 04 40 0A 11 14 84 01 06 0A 25 82 01 07 0A 25 08  ; .@.......%....%.
5966  db 07 2F 00 00 48 4F 94 01 05 80 0F 11 81 01 08 0F  ; ./..HO..........
5976  db 11 82 01 07 0A 16 88 01 07 0A 16 0A 07 18 00 00  ; ................
5986  db 6F 4F 08 8D 14 00 00 88 4F 10 09 23 00 00 E2 4F  ; oO......O..#...O
5996  db 10 09 31 00 00 06 50 10 09 48 00 00 A0 4F 20 00  ; ..1...P..H...O .
59A6  db 5E 00 00 36 50 00 02 3C 00 00 A2 4E 92 01 03 80  ; ^..6P..<...N....
59B6  db 6E 19 84 01 06 3B 4C 81 01 06 6E 19 88 01 07 6E  ; n....;L...n....n
59C6  db 19 01 06 87 00 00 DB 4E 98 01 04 80 14 10 94 01  ; .......N........
59D6  db 04 80 14 10 82 01 07 07 1D B1 12 06 04 40 00 19  ; .............@..
59E6  db 0B 0B 07 24 00 00 48 4F 91 01 0A 80 00 0C 82 01  ; ...$..HO........
59F6  db 07 00 0C 0D 07 0C 00 00 65 4F 00 89 14 00 00 88  ; ........eO......
5A06  db 4F 10 09 23 00 00 E2 4F 10 09 31 00 00 06 50 10  ; O..#...O..1...P.
5A16  db 09 48 00 00 A0 4F 20 00 5E 00 00 36 50 94 01 05  ; .H...O .^..6P...
5A26  db 80 0E 11 88 01 07 00 1F 82 01 07 00 1F 81 01 08  ; ................
5A36  db 0D 11 09 07 1F 00 00 6F 4F 00 02 3C 00 00 C7 39  ; .......oO..<...9
5A46  db A4 13 09 07 54 41 0A 0A A4 13 07 08 A9 0A 0A 0A  ; ....TA..........
5A56  db 88 01 09 54 82 81 01 09 54 82 82 01 09 54 82 01  ; ...T....T....T..
5A66  db 05 CC 00 00 FF 39 C8 93 09 07 08 00 49 0A 0A A8  ; .....9......I...
5A76  db 13 07 08 5D 0A 0A 0A 84 01 09 00 7F 81 01 09 00  ; ...]............
5A86  db 7F 82 01 09 00 7F 01 04 7F 00 80 A3 3A A4 13 08  ; ............:...
5A96  db 07 00 1E 0A 0A A4 13 07 08 32 0A 0A 0A 84 01 09  ; .........2......
5AA6  db 50 2A 88 01 09 00 A5 81 01 09 00 A5 82 01 09 00  ; P*..............
5AB6  db A5 08 05 7B 00 80 2E 3B 10 0A 5A 00 00 7A 3B 00  ; ...{...;..Z..z;.
5AC6  db 07 6D 00 00 05 3C 0B 85 8A 00 00 06 3C 10 0A 41  ; .m...<......<..A
5AD6  db 00 00 CA 3B 10 0A 19 00 00 EA 3B 20 00 5E 00 00  ; ...;......; .^..
5AE6  db 7E 3C 05 5C FE 5B 05 5C 23 5C 45 5C 66 5C 89 5C  ; ~<.\.[.\#\E\f\.\
5AF6  db 90 5C 97 5C 9E 5C A5 5C B3 5C AC 5C B3 5C CF 5C  ; .\.\.\.\.\.\.\.\
5B06  db EB 5C 07 5D 23 5D 3F 5D 5B 5D 77 5D 89 5D 90 5D  ; .\.]#]?][]w].].]
5B16  db 97 5D 9E 5D AC 5D A5 5D AC 5D F5 5D 1A 5E 51 5E  ; .].].].].].].^Q^
5B26  db 58 5E 5F 5E 66 5E 6D 5E 7B 5E 74 5E 7B 5E 99 5E  ; X^_^f^m^{^t^{^.^
5B36  db B0 5E C7 5E DE 5E FC 5E 1A 5F 38 5F 56 5F 5D 5F  ; .^.^.^.^._8_V_]_
5B46  db 7A 5F 97 5F B4 5F D7 5F DE 5F E5 5F EC 5F F3 5F  ; z_._._._._._._._
5B56  db FA 5F 01 60 08 60 0F 60 82 5E 1D 60 16 60 1D 60  ; ._.`.`.`.^.`.`.`
5B66  db 40 60 63 60 8A 60 B2 60 D3 60 F4 60 1A 61 3B 61  ; @`c`.`.`.`.`.a;a
5B76  db 5F 61 66 61 6D 61 74 61 7B 61 82 61 89 61 90 61  ; _afamata{a.a.a.a
5B86  db A4 61 9D 61 A4 61 CE 61 E5 61 01 62 08 62 0F 62  ; .a.a.a.a.a.b.b.b
5B96  db 16 62 1D 62 B7 61 24 62 32 62 2B 62 32 62 46 62  ; .b.b.a$b2b+b2bFb
5BA6  db 5A 62 6E 62 82 62 96 62 AA 62 B1 62 B8 62 BF 62  ; Zbnb.b.b.b.b.b.b
5BB6  db C6 62 D5 62 E3 62 DC 62 E3 62 FF 62 25 63 42 63  ; .b.b.b.b.b.b%cBc
5BC6  db 49 63 50 63 57 63 5E 63 6C 63 65 63 6C 63 79 63  ; IcPcWc^clceclcyc
5BD6  db 9D 63 AA 63 D4 63 FC 63 14 64 2D 64 40 64 61 64  ; .c.c.c.c.d-d@dad
5BE6  db 7F 64 8C 64 93 64 9A 64 A1 64 A8 64 AF 64 B6 64  ; .d.d.d.d.d.d.d.d
5BF6  db BD 64 C4 64 D1 64 DE 64 00 02 3C 00 00 8A 50 B8  ; .d.d.d.d..<...P.
5C06  db 12 07 03 40 00 3B 17 81 01 08 30 42 82 01 08 30  ; ...@.;....0B...0
5C16  db 42 84 01 08 30 42 01 08 52 00 00 C2 50 91 01 04  ; B...0B..R...P...
5C26  db 80 0A 0B 99 01 04 80 0A 0B 88 01 08 0A 0B 84 01  ; ................
5C36  db 08 0A 0B 82 01 08 00 15 07 08 15 00 00 06 51 98  ; ..............Q.
5C46  db 01 05 80 05 16 84 01 07 05 16 80 01 07 05 16 81  ; ................
5C56  db 01 08 05 16 82 01 08 05 16 0B 08 1B 00 00 17 51  ; ...............Q
5C66  db D8 93 FF FF 06 20 00 24 41 1D C4 93 FF FF 08 00  ; ..... .$A.......
5C76  db 24 41 1D C2 93 FF FF 08 00 24 41 15 0A 09 77 00  ; $A.......$A...w.
5C86  db 00 2E 51 08 8B 28 00 00 98 51 10 0A 4F 00 00 C0  ; ..Q..(...Q..O...
5C96  db 51 10 0A 1C 00 00 08 52 10 0A 29 00 00 26 52 20  ; Q......R..)..&R 
5CA6  db 00 4A 00 00 50 52 00 02 3C 00 00 A4 52 94 01 03  ; .J..PR..<...R...
5CB6  db 80 67 1B 81 01 0B 67 7F 82 01 0B 67 1B 88 01 0B  ; .g....g....g....
5CC6  db 67 1B 01 0B 82 00 00 DC 52 98 01 04 80 11 16 81  ; g.......R.......
5CD6  db 01 0B 11 16 82 01 0B 11 16 84 01 0B 11 16 09 0B  ; ................
5CE6  db 27 00 00 46 53 91 01 05 80 1D 13 82 01 0B 1D 13  ; '..FS...........
5CF6  db 88 01 0B 1D 13 84 01 0B 1D 13 09 0B 30 00 00 65  ; ............0..e
5D06  db 53 98 01 06 80 25 1B 81 01 0B 25 1B 82 01 0B 25  ; S....%....%....%
5D16  db 1B 84 01 0B 25 1B 0A 0B 40 00 00 8A 53 94 01 07  ; ....%...@...S...
5D26  db 80 24 1B 81 01 0B 24 1B 82 01 0B 24 1B 88 01 0B  ; .$....$....$....
5D36  db 24 1B 09 0B 3F 00 00 BF 53 98 01 08 80 0C 13 81  ; $...?...S.......
5D46  db 01 0B 0C 13 82 01 0B 0C 13 84 01 0B 0C 13 09 0B  ; ................
5D56  db 1F 00 00 F3 53 94 01 09 80 08 0F 81 01 0B 06 11  ; ....S...........
5D66  db 88 01 0B 06 11 82 01 0B 06 11 09 0B 17 00 00 0C  ; ................
5D76  db 54 81 01 0C 37 1A 90 01 0A 80 37 1A 0E 0C 51 00  ; T...7.....7...Q.
5D86  db 00 1F 54 0A 8B 66 00 00 62 54 10 0D 32 00 00 EC  ; ..T..f..bT..2...
5D96  db 54 10 0D 1E 00 00 1C 55 20 00 5E 00 00 3C 55 00  ; T......U .^..<U.
5DA6  db 02 44 00 00 90 55 C8 93 FF 06 07 00 53 43 09 A8  ; .D...U......SC..
5DB6  db 13 08 07 9F 0B 09 0B A8 12 07 06 BE 09 4A C4 93  ; .............J..
5DC6  db FF 06 08 00 53 3F 37 84 01 06 C9 48 C1 93 FF 06  ; ....S?7....H....
5DD6  db 08 00 53 3F 37 81 01 06 C9 48 C2 93 FF 06 08 00  ; ..S?7....H......
5DE6  db 53 3F 37 82 01 06 C9 48 01 03 11 01 80 C7 55 A4  ; S?7....H......U.
5DF6  db 13 07 08 02 09 0B 09 A4 12 08 07 20 09 0A 88 01  ; ........... ....
5E06  db 08 00 36 81 01 08 00 36 82 01 08 00 36 02 04 36  ; ..6....6....6..6
5E16  db 00 80 A5 56 C8 93 06 07 08 00 4C 09 0B A8 13 07  ; ...V......L.....
5E26  db 08 60 09 0B 09 A8 12 08 06 7D 0F 1D A4 13 06 08  ; .`.......}......
5E36  db 00 58 35 1C A1 13 06 08 00 58 35 1C A2 13 06 08  ; .X5......X5.....
5E46  db 00 58 35 1C 09 05 A9 00 80 D1 56 10 09 32 00 04  ; .X5.......V..2..
5E56  db 5A 57 10 09 19 00 04 B2 57 0B 81 8A 00 22 CE 57  ; ZW......W....".W
5E66  db 00 06 17 00 80 92 57 20 00 5E 00 00 99 58 00 02  ; ......W .^...X..
5E76  db 3C 00 00 9A 58 00 18 4F 00 00 D2 58 94 01 03 80  ; <...X..O...X....
5E86  db 00 1E 81 01 10 00 1E 88 01 10 00 1E 01 10 1E 00  ; ................
5E96  db 00 98 59 98 01 04 80 1D 1D 81 01 11 1D 1D 84 01  ; ..Y.............
5EA6  db 11 1D 1D 04 11 3A 00 00 B0 59 94 01 05 80 1F 1D  ; .....:...Y......
5EB6  db 81 01 12 1F 1D 88 01 12 1F 1D 04 12 3C 00 00 DF  ; ............<...
5EC6  db 59 98 01 06 80 1D 1E 81 01 13 1D 1E 84 01 13 1D  ; Y...............
5ED6  db 1E 04 13 3B 00 00 10 5A D1 93 FF 14 07 20 00 75  ; ...;...Z..... .u
5EE6  db 12 13 B8 12 07 14 80 6F 19 12 84 01 14 82 18 04  ; .......o........
5EF6  db 14 9A 00 00 40 5A D1 93 FF 14 08 20 00 24 13 14  ; ....@Z..... .$..
5F06  db 88 01 14 24 1D B4 12 08 14 80 20 19 12 05 14 4B  ; ...$...... ....K
5F16  db 00 00 BD 5A D1 93 FF 14 09 20 00 27 0F 14 B8 12  ; ...Z..... .'....
5F26  db 09 14 80 1E 1A 12 84 01 14 22 28 05 14 4A 00 00  ; ........."(..J..
5F36  db FA 5A D1 93 FF 14 0A 20 00 28 19 13 88 01 14 30  ; .Z..... .(.....0
5F46  db 24 B4 12 0A 14 80 28 19 13 05 14 54 00 00 36 5B  ; $.....(....T..6[
5F56  db 02 0B 67 00 00 7A 5B 94 01 0C 80 00 12 95 01 0C  ; ..g..z[.........
5F66  db 80 00 12 81 01 15 00 12 88 01 15 00 12 03 15 12  ; ................
5F76  db 00 00 31 5C 98 01 0D 80 36 14 99 01 0D 80 36 14  ; ..1\....6.....6.
5F86  db 81 01 15 28 22 84 01 15 28 22 03 15 4A 00 00 40  ; ...("...("..J..@
5F96  db 5C 94 01 0E 80 3D 14 95 01 0E 80 3D 14 81 01 15  ; \....=.....=....
5FA6  db 2B 26 88 01 15 2B 26 03 15 51 00 00 7C 5C 99 01  ; +&...+&..Q..|\..
5FB6  db 0F 80 73 26 91 01 0F 80 73 26 82 01 16 73 26 98  ; ..s&....s&...s&.
5FC6  db 01 0F 80 73 26 84 01 16 73 26 03 16 99 00 00 BE  ; ...s&...s&......
5FD6  db 5C 05 85 4E 00 00 3A 5D 10 17 15 00 00 82 5D 10  ; \..N..:]......].
5FE6  db 17 15 00 00 9A 5D 10 17 15 00 00 B2 5D 10 17 15  ; .....]......]...
5FF6  db 00 00 CA 5D 10 17 41 00 00 E2 5D 10 17 44 00 00  ; ...]..A...]..D..
6006  db 1E 5E 10 17 34 00 00 7B 5E 20 00 5D 00 00 AE 5E  ; .^..4..{^ .]...^
6016  db 00 02 3C 00 00 02 5F 90 01 03 80 76 3B 81 01 0D  ; ..<..._....v;...
6026  db 7E 32 A2 12 0E 0F 69 44 03 88 01 0F 76 3B 84 01  ; ~2....iD....v;..
6036  db 0F 76 3B 01 0F B1 00 00 3A 5F 88 01 0F 51 1D 82  ; .v;.....:_...Q..
6046  db 01 0F 51 1D B1 12 0F 04 40 00 51 1D 84 01 0F 00  ; ..Q.....@.Q.....
6056  db 6E 80 01 0F 28 46 07 04 6E 00 80 CA 5F 91 11 05  ; n...(F..n..._...
6066  db 80 09 27 95 11 05 80 09 27 80 01 0F 09 26 84 01  ; ..'.....'....&..
6076  db 0C 09 26 88 01 0E 09 26 82 01 0F 09 26 07 0F 30  ; ..&....&....&..0
6086  db 00 00 24 60 91 01 06 80 1E 10 98 01 06 80 1E 10  ; ..$`............
6096  db 99 01 06 80 1E 10 82 01 0F 1E 10 84 01 0E 1E 10  ; ................
60A6  db 80 01 0F 1E 10 09 0F 2E 00 00 4A 60 91 01 07 80  ; ..........J`....
60B6  db 1A 20 84 01 0C 1A 20 82 01 0D 1A 20 88 01 0F 26  ; . .... .... ...&
60C6  db 14 80 01 0F 26 14 0A 0F 3A 00 00 6F 60 91 01 08  ; ....&...:..o`...
60D6  db 80 14 1D 84 01 0C 14 1C 88 01 0E 14 1C 82 01 0F  ; ................
60E6  db 14 1C 80 01 0F 14 1C 07 0F 31 00 00 9E 60 B5 12  ; .........1...`..
60F6  db 10 09 40 2C 0E 15 B1 12 10 09 40 2C 0E 15 84 01  ; ..@,......@,....
6106  db 10 2C 22 88 01 10 2C 22 82 01 0F 2C 22 07 10 4F  ; .,"...,"...,"..O
6116  db 00 00 C6 60 91 01 0A 80 21 30 88 01 10 21 31 84  ; ...`....!0...!1.
6126  db 01 10 21 31 82 01 0F 21 31 80 01 0F 21 31 07 0F  ; ..!1...!1...!1..
6136  db 51 00 00 07 61 91 01 12 80 54 38 98 01 0B 80 54  ; Q...a....T8....T
6146  db 38 A2 12 0F 0E 54 23 74 84 01 0F 77 74 80 01 0F  ; 8....T#t...wt...
6156  db 62 74 07 0F 82 00 00 4A 61 07 8A 3E 00 00 D0 61  ; bt.....Ja..>...a
6166  db 10 11 79 00 00 6A 62 10 11 14 00 00 0A 62 10 11  ; ..y..jb......b..
6176  db 23 00 00 10 63 10 11 41 00 00 D4 62 10 11 32 00  ; #...c..A...b..2.
6186  db 00 3A 62 20 00 5E 00 00 34 63 91 01 0B 80 00 13  ; .:b .^..4c......
6196  db 05 10 13 00 00 C1 61 00 02 3C 00 00 88 63 98 01  ; ......a..<...c..
61A6  db 0A 80 00 19 91 01 0A 80 00 19 01 0B 11 00 00 C0  ; ................
61B6  db 63 94 01 03 80 35 19 88 01 06 42 0C 81 01 07 35  ; c....5....B....5
61C6  db 1B 04 07 4E 00 00 D6 63 94 01 04 80 5C 17 81 01  ; ...N...c....\...
61D6  db 09 5C 15 88 01 06 67 64 08 09 73 00 00 18 64 98  ; .\....gd..s...d.
61E6  db 01 05 80 49 17 84 01 06 49 16 81 01 09 49 16 82  ; ...I....I....I..
61F6  db 01 06 3B 16 08 09 60 00 00 76 64 0A 8A 38 00 00  ; ..;...`..vd..8..
6206  db C5 64 10 08 23 00 00 FA 64 10 08 40 00 00 2A 65  ; .d..#...d..@..*e
6216  db 20 00 5E 00 00 65 65 10 08 28 00 00 3E 65 10 08  ;  .^..ee..(..>e..
6226  db 19 00 00 D4 69 00 02 3C 00 00 BA 65 B2 12 09 03  ; ....i..<...e....
6236  db 40 91 08 18 81 01 0A 99 18 01 0A A9 00 00 F2 65  ; @..............e
6246  db B2 12 09 04 40 1A 07 17 81 01 0A 00 38 03 0A 32  ; ....@.......8..2
6256  db 00 00 83 66 B2 12 09 05 40 1B 0A 16 81 01 0A 00  ; ...f....@.......
6266  db 3B 04 0A 32 00 00 B1 66 B2 12 09 06 40 1B 08 18  ; ;..2...f....@...
6276  db 81 01 0A 00 3B 04 0A 34 00 00 E1 66 B2 12 09 07  ; ....;..4...f....
6286  db 40 1B 08 18 81 01 0A 00 3B 04 0A 34 00 00 11 67  ; @.......;..4...g
6296  db B2 12 09 0C 40 1B 09 15 81 01 0A 00 39 04 0A 34  ; ....@.......9..4
62A6  db 00 00 41 67 04 84 44 00 00 94 67 10 0B 14 00 00  ; ..Ag..D...g.....
62B6  db F5 67 10 0B 0C 00 00 E4 67 20 00 5F 00 00 0D 68  ; .g......g ._...h
62C6  db B1 12 0A 08 40 00 1A 11 04 0D 2B 00 00 71 67 10  ; ....@.....+..qg.
62D6  db 0B 19 00 00 B2 57 00 02 3C 00 00 63 68 91 01 03  ; .....W..<..ch...
62E6  db 80 00 19 82 01 07 0C 0D 88 01 07 07 12 84 01 07  ; ................
62F6  db 07 12 01 07 19 00 00 CE 68 A1 13 04 06 00 0C 07  ; ........h.......
6306  db 0D B1 12 06 04 40 20 07 0E 82 01 07 00 35 88 01  ; .....@ ......5..
6316  db 07 00 35 84 01 07 00 35 06 06 2D 00 00 E2 68 C4  ; ..5....5..-...h.
6326  db 93 05 08 05 5C 0C 0F 0C B4 12 08 05 40 83 0F 0D  ; ....\.......@...
6336  db 88 01 07 3A 65 07 08 9F 00 00 0D 69 09 87 15 00  ; ...:e......i....
6346  db 00 91 69 10 09 23 00 00 AA 69 10 09 23 00 00 CD  ; ..i..#...i..#...
6356  db 69 10 09 23 00 00 F2 69 20 00 5D 00 00 16 6A 00  ; i..#...i .]...j.
6366  db 02 3C 00 00 D2 70 94 01 03 80 75 1C 01 13 91 00  ; .<...p....u.....
6376  db 00 0A 71 B4 12 FF 04 40 FF 3B 11 A1 12 FF 13 FF  ; ..q....@.;......
6386  db 3B 11 A8 12 FF 13 FF 3B 11 A0 12 FF 13 FF 3B 11  ; ;......;......;.
6396  db 07 13 48 01 00 81 71 94 01 05 80 CF 30 08 13 FF  ; ..H...q.....0...
63A6  db 00 00 92 72 B6 43 FF 15 40 FF FF 8E 18 B4 43 FF  ; ...r.C..@.....C.
63B6  db 15 40 FF FF 8E 18 B2 43 FF 15 40 FF FF 8E 18 A0  ; .@.....C..@.....
63C6  db 43 FF 0E FF FF 8E 18 07 0E A4 02 00 62 73 81 01  ; C...........bs..
63D6  db 10 4B 19 92 01 16 80 4B 19 88 01 11 4B 19 94 01  ; .K.....K....K...
63E6  db 16 80 4B 19 96 01 16 80 4B 19 80 01 11 4B 19 09  ; ..K.....K....K..
63F6  db 11 61 00 00 E6 75 92 01 13 80 00 13 98 01 08 80  ; .a...u..........
6406  db 00 13 84 01 13 00 13 09 13 13 00 00 A6 76 98 01  ; .............v..
6416  db 09 80 4F 1E 91 01 09 80 4F 1E 99 01 09 80 4F 1E  ; ..O.....O.....O.
6426  db 0B 13 6D 00 00 B5 76 90 01 0A 80 0C 20 98 01 0A  ; ..m...v..... ...
6436  db 80 0C 20 09 0F 2C 00 00 0C 77 90 01 0B 80 50 20  ; .. ..,...w....P 
6446  db 81 01 10 50 20 82 01 10 50 20 88 01 10 50 20 84  ; ...P ...P ...P .
6456  db 01 10 50 20 0C 10 70 00 00 30 77 94 01 17 80 48  ; ..P ..p..0w....H
6466  db 29 91 01 17 80 48 29 95 01 17 80 48 29 88 01 12  ; )....H)....H)...
6476  db 48 29 0D 12 74 00 00 8A 77 90 01 0D 80 00 25 0E  ; H)..t...w.....%.
6486  db 10 14 00 00 00 78 2F 81 10 02 22 18 78 10 10 41  ; .....x/...".x..A
6496  db 00 04 06 7A 10 14 32 00 04 42 7A 10 14 29 00 04  ; ...z..2..Bz..)..
64A6  db 7A 7A 10 14 41 00 04 A2 7A 10 14 31 00 04 DE 7A  ; zz..A...z..1...z
64B6  db 10 14 31 00 04 D6 79 20 00 5E 00 00 0E 7B 91 01  ; ..1...y .^...{..
64C6  db 06 80 61 14 07 13 6E 00 00 85 75 91 01 07 80 6C  ; ..a...n...u....l
64D6  db 1E 08 13 80 00 00 36 76 90 01 0C 80 0F 19 09 10  ; ......6v........
64E6  db 16 00 00 E6 77 76 65 6F 65 76 65 A8 65 C6 65 E4  ; ....wveoeve.e.e.
64F6  db 65 02 66 09 66 10 66 17 66 8F 65 1E 66 2C 66 25  ; e.f.f.f.f.e.f,f%
6506  db 66 2C 66 43 66 57 66 73 66 8F 66 B0 66 CE 66 E9  ; f,fCfWfsf.f.f.f.
6516  db 66 00 67 20 67 27 67 2E 67 35 67 3C 67 43 67 4A  ; f.g g'g.g5g<gCgJ
6526  db 67 51 67 58 67 66 67 5F 67 66 67 89 67 A4 67 BF  ; gQgXgfg_gfg.g.g.
6536  db 67 DA 67 F3 67 0E 68 15 68 1C 68 23 68 2A 68 38  ; g.g.g.h.h.h#h*h8
6546  db 68 31 68 38 68 5E 68 81 68 9D 68 BB 68 C2 68 C9  ; h1h8h^h.h.h.h.h.
6556  db 68 D0 68 D7 68 E5 68 DE 68 E5 68 FE 68 17 69 35  ; h.h.h.h.h.h.h.i5
6566  db 69 3C 69 43 69 4A 69 51 69 00 02 42 00 00 7D 31  ; i<iCiJiQi..B..}1
6576  db A4 13 09 03 00 33 07 0C 81 01 09 00 4A 82 01 09  ; .....3......J...
6586  db 00 4A 01 0A 4B 00 80 B5 31 B4 12 09 03 40 00 46  ; .J..K...1....@.F
6596  db 0E 81 01 09 00 56 82 01 09 00 56 00 09 4E 00 00  ; .....V....V..N..
65A6  db F2 31 B4 12 09 04 40 00 29 0C 88 01 09 00 37 81  ; .1....@.).....7.
65B6  db 01 09 00 37 82 01 09 00 37 04 08 2F 00 00 39 32  ; ...7....7../..92
65C6  db B4 12 09 05 40 00 2C 0B 88 01 09 00 37 81 01 09  ; ....@.,.....7...
65D6  db 00 37 82 01 09 00 37 05 08 2F 00 00 67 32 B4 12  ; .7....7../..g2..
65E6  db 09 06 40 00 24 0F 81 01 09 00 34 82 01 09 00 34  ; ..@.$.....4....4
65F6  db 88 01 09 00 34 00 07 2C 00 00 95 32 00 82 1F 00  ; ....4..,...2....
6606  db 00 C1 32 10 0B 2C 00 00 F1 32 10 0B 52 00 00 21  ; ..2..,...2..R..!
6616  db 33 10 0B 1F 00 00 47 33 20 00 5E 00 00 6B 33 00  ; 3.....G3 .^..k3.
6626  db 02 3C 00 00 BF 33 98 01 03 80 00 1A 81 01 0E 0E  ; .<...3..........
6636  db 0C 84 01 0E 0E 0C 01 0E 11 00 00 18 34 B1 12 0C  ; ............4...
6646  db 04 40 00 31 0C 84 01 0E 00 3D 08 0C 3D 00 00 2D  ; .@.1.....=..=..-
6656  db 34 94 01 05 80 20 28 88 01 0E 2D 1B 81 01 0E 20  ; 4.... (...-.... 
6666  db 28 82 01 0E 20 28 09 0E 2B 00 00 57 34 91 01 06  ; (... (..+..W4...
6676  db 80 24 0E 82 01 0E 00 34 88 01 0E 00 34 84 01 0E  ; .$.....4....4...
6686  db 00 34 0A 0E 32 00 00 93 34 98 01 07 80 14 2A 84  ; .4..2...4.....*.
6696  db 01 0F 21 1E 81 01 0F 20 1E 82 01 0F 20 1E 80 01  ; ..!.... .... ...
66A6  db 0F 20 1E 0B 0F 1F 00 00 BF 34 B1 12 0E 08 40 00  ; . .......4....@.
66B6  db 24 16 84 01 0F 00 3A 88 01 10 24 15 82 01 0E 00  ; $.....:...$.....
66C6  db 3A 0C 10 2F 00 00 F3 34 D0 93 0E 0E 09 20 00 1B  ; :../...4..... ..
66D6  db 34 13 82 01 0E 00 63 88 01 11 4A 19 0D 11 60 00  ; 4.....c...J...`.
66E6  db 00 23 35 94 01 0A 80 16 18 82 01 0E 00 27 88 01  ; .#5..........'..
66F6  db 0E 1B 13 0D 0E 21 00 00 75 35 D1 93 FF 12 0B 20  ; .....!..u5..... 
6706  db 00 0B 1E 14 88 01 0E 00 3E 84 01 0E 00 3E 82 01  ; ........>....>..
6716  db 0F 00 3E 0F 12 3E 00 00 93 35 0E 8C 22 00 00 C7  ; ..>..>...5.."...
6726  db 35 10 13 14 00 00 EB 35 10 13 30 00 00 03 36 10  ; 5......5..0...6.
6736  db 13 31 00 00 33 36 10 13 57 00 00 63 36 10 13 23  ; .1..36..W..c6..#
6746  db 00 00 B3 36 10 13 32 00 00 D7 36 10 13 41 00 00  ; ...6..2...6..A..
6756  db 07 37 20 00 5E 00 00 43 37 00 02 3C 00 00 68 40  ; .7 .^..C7..<..h@
6766  db B5 12 09 03 40 66 08 18 B4 12 09 03 40 66 08 18  ; ....@f......@f..
6776  db 81 01 09 71 15 A8 12 09 0B 66 0A 15 01 09 72 00  ; ...q.....f....r.
6786  db 00 A0 40 B8 12 09 04 40 00 18 0E 81 01 09 16 11  ; ..@....@........
6796  db A4 12 09 0B 00 16 11 06 09 1C 00 00 0D 41 B4 12  ; .............A..
67A6  db 09 05 40 00 29 0F A8 12 09 0B 00 27 14 81 01 09  ; ..@.)......'....
67B6  db 1A 21 06 09 2F 00 00 2C 41 B8 12 09 06 40 00 28  ; .!../..,A....@.(
67C6  db 11 A4 12 09 0B 00 27 14 81 01 09 1F 1C 05 09 2E  ; ......'.........
67D6  db 00 00 5C 41 B8 12 09 07 40 00 23 11 81 01 0A 1D  ; ..\A....@.#.....
67E6  db 19 84 01 0A 1D 19 05 0A 2C 00 00 8C 41 B8 12 09  ; ........,...A...
67F6  db 08 40 00 1B 0F A4 12 09 0B 00 18 14 81 01 09 0C  ; .@..............
6806  db 20 08 09 23 00 00 B8 41 05 83 87 00 00 DC 41 10  ;  ..#...A......A.
6816  db 0C 30 00 00 50 42 10 0C 45 00 00 80 42 10 0C 23  ; .0..PB..E...B..#
6826  db 00 00 C0 42 20 00 5E 00 00 E4 42 00 02 3B 00 00  ; ...B .^...B..;..
6836  db 6A 4B A1 13 07 03 00 16 08 23 A1 13 03 07 42 07  ; jK.......#....B.
6846  db 22 08 81 01 07 78 0B 84 01 09 00 85 88 01 09 00  ; "....x..........
6856  db 85 01 07 7D 00 00 40 4C B0 12 09 04 40 31 28 0F  ; ...}..@L....@1(.
6866  db 82 01 09 5A 10 88 01 09 00 51 84 01 09 00 51 81  ; ...Z.....Q....Q.
6876  db 01 08 00 69 0E 08 62 00 00 AC 4C 92 01 05 80 42  ; ...i..b...L....B
6886  db 19 81 01 09 00 5B 88 01 09 42 19 84 01 09 00 5B  ; .....[...B.....[
6896  db 09 09 48 00 00 00 4D B1 12 09 06 40 13 1D 1D 82  ; ..H...M....@....
68A6  db 01 09 30 2A 88 01 09 00 5A 84 01 09 30 2A 07 09  ; ..0*....Z...0*..
68B6  db 36 00 00 4A 4D 06 88 0F 00 00 8A 4D 10 0A 39 00  ; 6..JM......M..9.
68C6  db 00 A0 4D 10 0A 41 00 00 EE 4D 10 0A 22 00 00 2A  ; ..M..A...M.."..*
68D6  db 4E 20 00 5E 00 00 4E 4E 00 02 3C 00 00 A2 4E B2  ; N .^..NN..<...N.
68E6  db 12 07 03 40 00 7D 08 84 01 06 53 33 88 01 07 70  ; ...@.}....S3...p
68F6  db 16 01 06 84 00 00 DB 4E B1 12 06 04 40 10 1B 08  ; .......N....@...
6906  db 84 01 06 0A 25 82 01 07 0A 25 08 07 2E 00 00 48  ; ....%....%.....H
6916  db 4F B4 12 07 05 40 00 0E 0D 81 01 08 0F 11 82 01  ; O....@..........
6926  db 07 0A 16 88 01 07 0A 16 0A 07 1B 00 00 6F 4F 08  ; .............oO.
6936  db 8D 14 00 00 88 4F 10 09 23 00 00 E2 4F 10 09 31  ; .....O..#...O..1
6946  db 00 00 06 50 10 09 48 00 00 A0 4F 20 00 5E 00 00  ; ...P..H...O .^..
6956  db 36 50 CB 69 C4 69 CB 69 DA 69 FE 69 0B 6A 36 6A  ; 6P.i.i.i.i.i.j6j
6966  db 5C 6A 76 6A 95 6A A8 6A CB 6A EB 6A F8 6A FF 6A  ; \jvj.j.j.j.j.j.j
6976  db 06 6B 0D 6B 14 6B 1B 6B 22 6B 29 6B 30 6B 3D 6B  ; .k.k.k.k"k)k0k=k
6986  db 4A 6B 57 6B 5E 6B 12 6A 6C 6B 65 6B 6C 6B 7B 6B  ; JkWk^k.jlkeklk{k
6996  db 9F 6B AE 6B D9 6B FF 6B 19 6C 38 6C 4B 6C 6E 6C  ; .k.k.k.k.l8lKlnl
69A6  db 8E 6C 9B 6C A2 6C A9 6C B0 6C B7 6C BE 6C C5 6C  ; .l.l.l.l.l.l.l.l
69B6  db CC 6C D3 6C E0 6C ED 6C FA 6C 01 6D B5 6B 00 02  ; .l.l.l.l.l.m.k..
69C6  db 3C 00 00 D2 70 B4 12 13 03 40 00 75 1C 01 13 91  ; <...p....@.u....
69D6  db 00 00 0A 71 B4 12 FF 04 40 FF 3B 11 A1 12 FF 13  ; ...q....@.;.....
69E6  db FF 3B 11 A8 12 FF 13 FF 3B 11 A0 12 FF 13 FF 3B  ; .;......;......;
69F6  db 11 07 13 48 01 00 81 71 94 01 05 80 CF 30 08 13  ; ...H...q.....0..
6A06  db FF 00 00 92 72 00 1A 41 02 80 62 73 B6 12 13 15  ; ....r..A..bs....
6A16  db 40 00 4A 18 B4 12 13 15 40 00 4A 18 B2 12 13 15  ; @.J.....@.J.....
6A26  db 40 00 4A 18 80 01 0E 4A 18 07 0E 63 00 00 36 75  ; @.J....J...c..6u
6A36  db B2 12 13 16 40 2E 1C 19 B4 12 13 16 40 2E 1C 19  ; ....@.......@...
6A46  db 81 01 10 4B 19 88 01 11 4B 19 80 01 11 4B 19 09  ; ...K....K....K..
6A56  db 11 61 00 00 E6 75 92 01 13 80 00 13 B8 12 18 08  ; .a...u..........
6A66  db 40 00 04 0F 84 01 13 00 13 09 13 13 00 00 A6 76  ; @..............v
6A76  db B9 12 18 09 40 31 1D 1E B8 12 18 09 40 31 1D 1E  ; ....@1......@1..
6A86  db B1 12 18 09 40 31 1D 1E 0B 13 6D 00 00 B5 76 90  ; ....@1....m...v.
6A96  db 01 0A 80 0C 20 98 01 0A 80 0C 20 09 0F 2C 00 00  ; .... ..... ..,..
6AA6  db 0C 77 B0 12 10 0B 40 3B 15 20 81 01 10 50 20 82  ; .w....@;. ...P .
6AB6  db 01 10 50 20 88 01 10 50 20 84 01 10 50 20 0C 10  ; ..P ...P ...P ..
6AC6  db 70 00 00 30 77 B4 12 19 17 40 3E 09 29 91 01 17  ; p..0w....@>.)...
6AD6  db 80 48 29 95 01 17 80 48 29 88 01 12 48 29 0D 12  ; .H)....H)...H)..
6AE6  db 74 00 00 8A 77 90 01 0D 80 00 25 0E 10 14 00 00  ; t...w.....%.....
6AF6  db 00 78 0F 81 10 02 22 18 78 10 10 41 00 04 06 7A  ; .x....".x..A...z
6B06  db 10 14 32 00 04 42 7A 10 14 29 00 04 7A 7A 10 14  ; ..2..Bz..)..zz..
6B16  db 41 00 04 A2 7A 10 14 31 00 04 DE 7A 10 14 31 00  ; A...z..1...z..1.
6B26  db 04 D6 79 20 00 5E 00 00 0E 7B 91 01 06 80 61 14  ; ..y .^...{....a.
6B36  db 07 13 6E 00 00 85 75 91 01 07 80 6C 1E 08 13 80  ; ..n...u....l....
6B46  db 00 00 36 76 90 01 0C 80 0F 19 09 10 16 00 00 E6  ; ..6v............
6B56  db 77 10 14 13 00 04 F6 7A 10 14 31 00 04 E4 7A 00  ; w......z..1...z.
6B66  db 02 3C 00 00 D2 70 B4 12 13 03 40 00 7F 12 01 13  ; .<...p....@.....
6B76  db 91 00 00 0A 71 B4 12 FF 04 40 FF 3B 11 A1 12 FF  ; ....q....@.;....
6B86  db 13 FF 3B 11 A8 12 FF 13 FF 3B 11 A0 12 FF 13 FF  ; ..;......;......
6B96  db 3B 11 07 13 48 01 00 81 71 B4 12 13 05 40 C7 21  ; ;...H...q....@.!
6BA6  db 17 08 13 FF 00 00 92 72 00 1A 41 02 80 62 73 B6  ; .......r..A..bs.
6BB6  db 12 13 15 40 00 4A 18 B4 12 13 15 40 00 4A 18 B2  ; ...@.J.....@.J..
6BC6  db 12 13 15 40 00 4A 18 80 01 0E 4A 18 07 0E 57 00  ; ...@.J....J...W.
6BD6  db 00 36 75 B2 12 13 16 40 2D 28 0C B4 12 13 16 40  ; .6u....@-(.....@
6BE6  db 2D 28 0C 81 01 10 4B 19 88 01 11 4B 19 80 01 11  ; -(....K....K....
6BF6  db 4B 19 09 11 61 00 00 E6 75 92 01 13 80 00 13 B8  ; K...a...u.......
6C06  db 12 18 08 40 00 04 0F 84 01 13 00 13 09 13 13 00  ; ...@............
6C16  db 00 A6 76 B9 12 18 09 40 31 1D 1E B8 12 18 09 40  ; ..v....@1......@
6C26  db 31 1D 1E B1 12 18 09 40 31 1D 1E 0B 13 6D 00 00  ; 1......@1....m..
6C36  db B5 76 90 01 0A 80 0C 20 98 01 0A 80 0C 20 09 0F  ; .v..... ..... ..
6C46  db 2C 00 00 0C 77 B0 12 10 0B 40 3B 26 0E 81 01 10  ; ,...w....@;&....
6C56  db 50 20 82 01 10 50 20 88 01 10 50 20 84 01 10 50  ; P ...P ...P ...P
6C66  db 20 0C 10 70 00 00 30 77 B4 12 19 17 40 40 24 0E  ;  ..p..0w....@@$.
6C76  db 91 01 17 80 48 29 95 01 17 80 48 29 88 01 12 48  ; ....H)....H)...H
6C86  db 29 0D 12 74 00 00 8A 77 90 01 0D 80 00 25 0E 10  ; )..t...w.....%..
6C96  db 14 00 00 00 78 2F 81 10 02 22 18 78 10 10 41 00  ; ....x/...".x..A.
6CA6  db 04 06 7A 10 14 32 00 04 42 7A 10 14 29 00 04 7A  ; ..z..2..Bz..)..z
6CB6  db 7A 10 14 41 00 04 A2 7A 10 14 31 00 04 DE 7A 10  ; z..A...z..1...z.
6CC6  db 14 31 00 04 D6 79 20 00 5E 00 00 0E 7B 91 01 06  ; .1...y .^...{...
6CD6  db 80 68 0D 07 13 6E 00 00 85 75 91 01 07 80 6C 1E  ; .h...n...u....l.
6CE6  db 08 13 80 00 00 36 76 90 01 0C 80 0F 19 09 10 16  ; .....6v.........
6CF6  db 00 00 E6 77 10 14 13 00 04 F6 7A 10 14 31 00 04  ; ...w......z..1..
6D06  db E4 7A FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; .z..............
6D16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6D96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6DF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6E96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6EA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6EB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6EC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6ED6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6EE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6EF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6F96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
6FF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7006  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7016  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7026  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7036  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7046  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7056  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7066  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7076  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7086  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7096  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
70F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7106  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7116  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7126  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7136  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7146  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7156  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7166  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7176  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7186  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7196  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
71F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7206  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7216  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7226  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7236  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7246  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7256  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7266  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7276  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7286  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7296  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
72F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7306  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7316  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7326  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7336  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7346  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7356  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7366  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7376  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7386  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7396  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
73F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7406  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7416  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7426  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7436  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7446  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7456  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7466  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7476  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7486  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7496  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
74F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7506  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7516  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7526  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7536  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7546  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7556  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7566  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7576  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7586  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7596  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
75F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7606  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7616  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7626  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7636  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7646  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7656  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7666  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7676  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7686  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7696  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
76F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7706  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7716  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7726  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7736  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7746  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7756  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7766  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7776  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7786  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7796  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
77F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7806  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7816  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7826  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7836  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7846  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7856  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7866  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7876  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7886  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7896  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
78F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7906  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7916  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7926  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7936  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7946  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7956  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7966  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7976  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7986  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7996  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79A6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79B6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79C6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79D6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79E6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
79F6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7A96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7AF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7B96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7BF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7C96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7CF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7D96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7DF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7E96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7EA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7EB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7EC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7ED6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7EE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7EF6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F06  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F16  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F26  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F36  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F46  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F56  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F66  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F76  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F86  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7F96  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FA6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FB6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FC6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FD6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FE6  db FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF  ; ................
7FF6  db FF FF FF FF FF FF FF FF FF FF                    ; ..........
