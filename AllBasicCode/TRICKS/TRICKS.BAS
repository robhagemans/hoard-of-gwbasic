1000 DEFINT C-L:DEFSTR M-Z:DEFDBL A
1010 '
1020 'search for BYTE, largest within a string
1030 '  call:  X= any string
1040 '  exit:  C= asc(largest byte), E= 1st position
1050 '  temp:  I= Incr
1060 C=0
1070 FOR I=1 TO LEN(X)
1080  E=ASC(MID$(X,I)):C=E*ABS(E=>C)+C*ABS(C>E):NEXT
1090 E=INSTR(X,CHR$(C))
1100 '
1110 'search for BYTE, smallest within a string
1120 '  call:  X= any string
1130 '  exit:  C= asc(smallest byte), E= 1st position
1140 '  temp:  I= Incr
1150 C=-255*(LEN(X)>0)
1160 FOR I=1 TO LEN(X)
1170  E=ASC(MID$(X,I)):C=E*ABS(E<C)+C*ABS(C<=E):NEXT
1180 E=INSTR(X,CHR$(C))
1190 '
1200 'search for ELEMENT in an array (binary search)
1210 '  call:  F= find, A(n)= array, sorted, ascending
1220 '         H= highest element, L= lowest element
1230 '  exit:  I= position, E= 0 if F is not found
1240 '  temp:  H= High, L= Low, I= Incr, E= Exit
1250 '  note:  for descending order switch less/greater signs
1260 I=H\2:H=H+1:L=L-1
1270 FOR E=0 TO 1
1280  IF F<A(I) THEN H=I:I=I-(H-L)\2
1290  IF F>A(I) THEN L=I:I=I+(H-L)\2
1300 E=ABS(F=A(I) OR I=H OR I=L):NEXT:E=(F=A(I))
1310 '
1320 'search for SUBSTRING (longest repeated, in a string)
1330 '  call:  X= any string, len>2
1340 '  exit:  F= From (1st one), L=Len, as in mid$(X,F,L)
1350 '  temp:  I= Instr
1360 '  note:  includes overlaps ("aaaaa" is F= 1, L= 4)
1370 I=LEN(X):L=SGN(I):F=1
1380 WHILE I
1390  I=INSTR(F+1,X,MID$(X,F,L+1)):L=L+SGN(I)
1400  IF I=0 THEN I=INSTR(F+L,X,MID$(X,F+1,L)):IF I THEN F=I
1410  IF I=0 THEN I=INSTR(F+L,X,MID$(X,F,L)):IF I THEN F=I
1420 WEND:F=INSTR(X,MID$(X,F,L))
1430 '
1440 'reverse sequence of BYTES in a string
1450 '  call:  X= any string
1460 '  exit:  X= byte sequence reversed
1470 '  temp:  I= Incr, C= Chr
1480 FOR I=1 TO LEN(X)\2:C=ASC(MID$(X,LEN(X)-I+1))
1490  MID$(X,LEN(X)-I+1)=MID$(X,I,1):MID$(X,I)=CHR$(C)
1500 NEXT
1510 '
1520 'reverse sequence of ELEMENTS in an array
1530 '  call:  T(n)= array, F= 1st position, E= last position
1540 '  exit:  T(n)= element sequence reversed
1550 '  temp:  I= Incr
1560 FOR I=F TO E/2
1570  SWAP T(I),T(E-I)
1580 NEXT
1590 '
1600 'shuffle significant ELEMENTS to top of an array
1610 '  call:  T(n)= array, F= 1st position, L= last position
1620 '  exit:  T(n)= nulls shifted to "bottom" of table
1630 '  temp:  E= Exit, I= Incr
1640 '  note:  for numeric array change LEN to SGN
1650 FOR E=F TO L
1660  IF LEN(T(E))=0 THEN I=E ELSE I=L+1
1670  FOR I=L TO I STEP-1
1680   IF LEN(T(I)) THEN SWAP T(E),T(I)
1690  NEXT
1700 NEXT
1710 '
1720 'sort BYTES of a string, ascending
1730 '  call:  X= any string
1740 '  exit:  X= bytes sorted left-to-right
1750 '  temp:  E= Exit, I= Incr, J= Juggle, L= len(X)
1760 L=LEN(X)
1770 FOR E=L>0 TO 0
1780  FOR I=1 TO L-1:J=MID$(X,I,1)>MID$(X,I+1,1)
1790   IF J THEN MID$(X,I)=MID$(X,I+1,1)+MID$(X,I,1):L=I
1800  NEXT
1810  E=L<I AND L>0
1820 NEXT
1830 '
1840 'sort BYTES of a string, descending
1850 '  call:  X= any string
1860 '  exit:  X= bytes sorted right-to-left
1870 '  temp:  E= Exit, I= Incr, J= Juggle, L= len(X)
1880 L=LEN(X)
1890 FOR E=L>0 TO 0
1900  FOR I=1 TO L-1:J=MID$(X,I+1,1)>MID$(X,I,1)
1910   IF J THEN MID$(X,I)=MID$(X,I+1,1)+MID$(X,I,1):L=I
1920  NEXT
1930  E=L<I AND L>0
1940 NEXT
1950 '
1960 'sort ELEMENTS of an array, ascending (bubble-sort)
1970 '  call:  A(n)= array, F= 1st position, L= last position
1980 '  exit:  A(n)= sorted, ascending, positions F thru L
1990 '  temp:  E= Exit, I= Incr
2000 FOR E=-1 TO 0
2010  FOR I=F TO L-1
2020   IF A(I)>A(I+1) THEN SWAP A(I),A(I+1):L=I
2030  NEXT
2040  E=L<I
2050 NEXT
2060 '
2070 'sort ELEMENTS of an array, ascending (shell-sort)
2080 '  call:  A(n)= array, F= 1st position, L= last position
2090 '  exit:  A(n)= sorted, ascending, positions F thru L
2100 '  temp:  E= Exit, H= Half, I= Incr, J= Juggle
2110 H=(L-F)/2
2120 WHILE H
2130  FOR I=F TO H+F:E=1
2140   WHILE E:E=0
2150    FOR J=I TO L-H STEP H
2160     IF A(J)>A(J+H) THEN SWAP A(J),A(J+H):E=1
2170    NEXT
2180   WEND
2190  NEXT:H=H\2
2200 WEND
2210 '
2220 'sort ELEMENTS of an array, descending (bubble-sort)
2230 '  call:  A(n)= array, F= 1st position L= last position
2240 '  exit:  A(n)= sorted, descending, positions F thru L
2250 '  temp:  E= Exit, I= Incr
2260 FOR E=-1 TO 0
2270  FOR I=F TO L-1
2280   IF A(I+1)>A(I) THEN SWAP A(I),A(I+1):L=I
2290  NEXT
2300  E=L<I
2310 NEXT
2320 '
2330 'sort ELEMENTS of an array, descending (shell-sort)
2340 '  call:  A(n)= array, F= 1st position, L= last position
2350 '  exit:  A(n)= sorted, descending, positions F thru L
2360 '  temp:  E= Exit, H= Half, I= Incr, J= Juggle
2370 H=(L-F)/2
2380 WHILE H
2390  FOR I=F TO H+F:E=1
2400   WHILE E:E=0
2410    FOR J=I TO L-H STEP H
2420     IF A(J+H)>A(J) THEN SWAP A(J),A(J+H):E=1
2430    NEXT
2440   WEND
2450  NEXT:H=H\2
2460 WEND
2470 '
2480 'find MEAN average, sorted array
2490 '  call:  A(n)= table of numbers (anytype)
2500 '         F= 1st element, L= Last element; max= 32767
2510 '  exit:  A= A(F) + A(L) divided by 2
2520 A=(A(F)+A(L))/2            'answer
2530 '
2540 'find MEAN average, unsorted array
2550 '  call:  A(n)= table of numbers (anytype)
2560 '         F= 1st element, L= Last element
2570 '  exit:  A= A(lowval) + A(hival) divided by 2
2580 '  temp:  I= Incr, J= lowval ptr, K= hival ptr
2590 J=L                        'swag lowval ptr
2600 K=L                        'swag hival ptr
2610  FOR I=F TO L
2620   IF A(I)<A(J) THEN J=I    'new lowval ptr
2630   IF A(I)>A(K) THEN K=I    'new hival ptr
2640  NEXT
2650 A=(A(K)+A(J))/2            'answer
2660 '
2670 'find MEDIAN average, sorted array
2680 '  call:  A(n)= table of numbers (anytype)
2690 '         F= 1st element, L= Last element
2700 '  exit:  A= median of A(first) and A(last)
2710 '  temp:  I= mid ptr-1 of A(n) if L-F is odd
2720 '         J= mid ptr+1 of A(n) if L-F is odd
2730 I=(L-F)\2+F                'mid ptr rounded up
2740 J=(L-F+1)\2+F              'mid ptr rounded down
2750 A=(A(I)+A(J))/2            'answer
2760 '
2770 'find MODE (norm), unsorted array
2780 '  call:  T(n)= table (anytype)
2790 '         F= 1st element, L= Last element
2800 '  exit:  G= Got ptr of most-of in T(n)
2810 '            latter-one of dupes
2820 '  temp:  I= Incr, H= Had ptr
2830 '         K= had cnt, J= found cnt, E= exit
2840 FOR J=L TO F STEP-1        'redef L
2850  FOR I=F TO L              'init Found
2860   IF T(I)=T(J) AND I<>J THEN G=I:I=L:L=J:J=0
2870  NEXT
2880 NEXT                       'J starts as -1
2890 FOR E=L TO F STEP-1
2900  K=0                       'reset had cnt
2910  FOR I=F TO L              'sample loop
2920   IF T(I)<>T(G) THEN IF K=0 THEN H=I:K=-1
2930   IF T(I)=T(H) AND K<0 THEN K=K-1
2940   IF J>K THEN I=L:G=H:J=K  'Got replaces Had
2950  NEXT
2960  IF ABS(J)>E THEN E=0      'early finish
2970 NEXT
2980 '
2990 'find SIMPLE average, unsorted array
3000 '  call:  A(n)= table of numbers (anytype)
3010 '         F= 1st element, L= Last element
3020 '  exit:  A= sum of A(all) divided by L
3030 '  temp:  I= Incr
3040 A=A(F)                     'first
3050  FOR I=F+1 TO L:A=A+A(I):NEXT
3060 A=A/L                      'answer
3070 '
3080 'bit EXPRESSION examples
3090 '  call:  E= integer (using low-order byte)
3100 '  mask:  |128|64|32|16|8|4|2|1|
3110 '  bit #  |  7| 6| 5| 4|3|2|1|0|
3120 E=E-32*(E>64 AND E<91)  'force lower case
3130 E=E+32*(E>96 AND E<123) 'force upper case
3140 E=E+32*(E>96 AND E<123)-32*(E>64 AND E<91) 'flip case
3150 E=E AND 32639           'force 7-bit off
3160 '
3170 'bit RESET (make binary 0)
3180 E=E OR E XOR 8     'set #3 OFF
3190 E=E OR E XOR 68    'set OFF bits #6 and #2 (68= 64+4)
3200 'bit REVERSAL (toggle ON/OFF state)
3210 E=E XOR 32         '#5 REVERSED
3220 E=E XOR 21         '#4, #2, & #0 REVERSED (21= 16+4+1)
3230 'bit SET (make binary 1)
3240 E=E OR 16          'set ON #4
3250 E=E OR 48          'set ON #5 and #4 (48= 32+16)
3260 'bit SHIFT (all bits, 1 position in unison)
3270 E=E/2              'RIGHT (#0 lost, #7 is 0)
3280 E=E*2 AND 255      'LEFT (#7 lost, #0 is 0)
3290 'bit TEST (sample for binary 0 or 1)
3300 IF E AND 8 THEN    'true for #3 ON
3310 IF E AND 4=0 THEN  'true for #2 OFF
3320 IF E AND 33 THEN   'true for #5 & #0 ON (33= 32+1)
3330 ' 
3340 'get GREATER of 2 numbers
3350 '  call:  I= any number, J= any number
3360 '  exit:  E= greater of I,J  (I and J unchanged)
3370 '  note:  logic equals:  IF I>J THEN E=I ELSE E=J
3380 E=I*ABS(I=>J)+J*ABS(J>I)
3390 '
3400 'get GREATER of 2 strings
3410 '  call:  X= any string, R= any string
3420 '  exit:  S= the greater of X,R  (X and R unchanged)
3430 '  note:  logic equals:  IF X>R THEN S=X ELSE S=R
3440 S=LEFT$(X,LEN(X)*-(X=>R))+LEFT$(R,LEN(R)*-(R>X))
3450 '
3460 'get SMALLER of 2 numbers
3470 '  call:  I= any number, J= any number
3480 '  exit:  E= smaller of I,J  (I and J unchanged)
3490 '  note:  logic equals:  IF I<J THEN E=I ELSE E=J
3500 E=I*ABS(I<J)+J*ABS(J<=I)
3510 '
3520 'get SMALLER of 2 strings
3530 '  call:  X= any string, R= any string
3540 '  exit:  S= the smaller of X,R  (X and R unchanged)
3550 '  note:  logic equals:  IF X<R THEN S=X ELSE S=R
3560 S=LEFT$(X,LEN(X)*-(X<R))+LEFT$(R,LEN(R)*-(R<=X))
3570 '
3580 'display BYTES in numeric variables
3590 '  call:  A= any value, DEFtype A as needed
3600 '  temp:  I= Incr, B= var adrs, G= var type
3610 '         C= byte, F= Factor bits
3620 G=ASC(VARPTR$(A))-1:B=VARPTR(A)    'var type & adrs
3630 FOR I=0 TO G:C=PEEK(B+I)           'chr loop
3640  IF C<31 THEN PRINT "."; ELSE PRINT CHR$(C);
3650 PRINT SPC(8);:NEXT:PRINT
3660 FOR I=0 TO G:C=PEEK(B+I)           'hex loop
3670  PRINT STRING$(-1*(C<16),48);HEX$(C);SPC(7);
3680 NEXT:PRINT
3690 FOR I=0 TO G:C=PEEK(B+I)           'octal loop
3700  PRINT STRING$(-1*(C<64),48);STRING$(-1*(C<8),48);
3710  PRINT OCT$(C);SPC(6);
3720 NEXT:PRINT
3730 FOR I=0 TO G:C=PEEK(B+I):F=128     'bits loop
3740  WHILE F:PRINT CHR$(48+SGN(C AND F));
3750  F=F\2:WEND:PRINT " ";
3760 NEXT:PRINT
3770 '
3780 'convert BCD (Binary Coded Decimal) to DECIMAL
3790 '  call:  X= bytes in range 00H-99H
3800 '  exit:  S= ASCII digits 0-9
3810 '  temp:  I= Incr
3820 S=""
3830 FOR I=1 TO LEN(X)
3840  S=S+HEX$(ASC(MID$(X,I)))
3850 NEXT
3860 '
3870 'convert BINARY to DECIMAL
3880 '  call:  X= ASCII zeros and ones
3890 '  exit:  A= positive whole number
3900 '  temp:  I= Incr, B= factor position
3910 A=0:B=1
3920 FOR I=LEN(X) TO 1 STEP-1
3930  A=A+(ASC(MID$(X,I)) MOD 2)*B:B=B*2
3940 NEXT
3950 '
3960 'convert BINARY to HEXADECIMAL
3970 '  call:  X= ASCII zeros and ones
3980 '  exit:  S= ASCII, 0-F, X= length adj MOD 4
3990 '  temp:  I= Incr, J= hex digit
4000 X=STRING$((4-LEN(X) MOD 4)*-(LEN(X) MOD 4>0),48)+X:S=""
4010 FOR I=1 TO LEN(X) STEP 4
4020  J=VAL(MID$(X,I,1))*8+VAL(MID$(X,I+1,1))*4
4030  J=J+VAL(MID$(X,I+2,1))*2+VAL(MID$(X,I+3,1))
4040  S=S+MID$("0123456789ABCDEF",J+1,1)
4050 NEXT
4060 '
4070 'convert BINARY to OCTAL
4080 '  call:  X= ASCII zeros and ones
4090 '  exit:  S= ASCII 0-7, X= length adj MOD 3
4100 '  temp:  I= Incr, J= octal digit
4110 X=STRING$((3-LEN(X) MOD 3)*-(LEN(X) MOD 3>0),48)+X:S=""
4120 FOR I=1 TO LEN(X) STEP 3
4130  J=VAL(MID$(X,I,1))*4+VAL(MID$(X,I+1,1))*2
4140  J=J+VAL(MID$(X,I+2,1)):S=S+CHR$(48+J)
4150 NEXT
4160 '
4170 'convert DECIMAL to BCD (Binary Coded Decimal)
4180 '  call:  X= ASCII digits 0-9
4190 '  exit:  S= bytes, range 00H-99H, X= length adj MOD 2
4200 '  temp:  I= Incr
4210 X=STRING$(LEN(X) MOD 2,48)+X:S=""
4220 FOR I=1 TO LEN(X) STEP 2
4230  S=S+CHR$((ASC(MID$(X,I))-48)*16+ASC(MID$(X,I+1))-48)
4240 NEXT
4250 '
4260 'convert DECIMAL to BINARY
4270 '  call:  A= positive whole number
4280 '  exit:  S= ASCII zeros and ones, A= 1
4290 '  temp:  I= Incr, AQ= quotient
4300 S="":A=A+1
4310 FOR I=A>1 TO 0:AQ=INT(A/2)
4320  S=CHR$(48-(A=AQ*2))+S:A=A-AQ:I=A>1
4330 NEXT
4340 '
4350 'convert DECIMAL to HEXADECIMAL
4360 '  call:  A= positive whole number
4370 '  exit:  S= ASCII, 0-F, A= 0
4380 '  temp:  I= Incr, J= hex digit
4390 I=0:WHILE A=>16^I:I=I+1:WEND:S=""
4400 FOR I=I-1 TO 0 STEP-1:J=INT(A/(16^I))
4410  S=S+MID$("0123456789ABCDEF",J+1,1):A=INT(A-(J*16^I))
4420 NEXT
4430 '
4440 'convert DECIMAL to OCTAL
4450 '  call:  A= positive whole number
4460 '  exit:  S= ASCII, 0-7, A= 0
4470 '  temp:  I= Incr, J= octal digit
4480 I=0:WHILE A=>8^I:I=I+1:WEND:S=""
4490 FOR I=I-1 TO 0 STEP-1:J=INT(A/8^I)
4500  S=S+CHR$(48+J):A=INT(A-(J*8^I))
4510 NEXT
4520 '
4530 'convert HEXADECIMAL to BINARY
4540 '  call:  X= ASCII 0-F
4550 '  exit:  S= ASCII zeros and ones
4560 '  temp:  I= Incr, Q= translate string
4570 Q="0000000100100011010001010110011110001001101010111100110111101111"
4580 S=""
4590 FOR I=1 TO LEN(X)
4600 S=S+MID$(Q,(INSTR("123456789ABCDEF",MID$(X,I,1))*4)+1,4)
4610 NEXT
4620 '
4630 'convert HEXADECIMAL to DECIMAL
4640 '  call:  X= ASCII 0-F
4650 '  exit:  A= positive whole number
4660 '  temp:  I= Incr
4670 A=0
4680 FOR I=LEN(X) TO 1 STEP-1
4690  A=INT(A)+INSTR("123456789ABCDEF",MID$(X,I,1))
4700 A=A*16^(LEN(X)-I):NEXT
4710 '
4720 'convert HEXADECIMAL to OCTAL
4730 '  call:  X= ASCII 0-F
4740 '  exit:  S= ASCII 0-7
4750 '  temp:  I= Incr, J= hex digit, A= decimal
4760 S="":A=0
4770 FOR I=LEN(X) TO 1 STEP-1
4780  A=INT(A)+INSTR("123456789ABCDEF",MID$(X,I,1))
4790 A=A*16^(LEN(X)-I):NEXT:I=0:WHILE A=>8^I:I=I+1:WEND
4800 FOR I=I-1 TO 0 STEP-1:J=INT(A/8^I)
4810  S=S+CHR$(48+J):A=INT(A-(J*8^I))
4820 NEXT
4830 '
4840 'convert OCTAL to BINARY
4850 '  call:  X= ASCII 0-7
4860 '  exit:  S= ASCII zeros and ones
4870 '  temp:  I= Incr, Q= translate string
4880 Q="000001010011100101110111":S=""
4890 FOR I=1 TO LEN(X)
4900  S=S+MID$(Q,(INSTR("1234567",MID$(X,I,1))*3)+1,3)
4910 NEXT
4920 '
4930 'convert OCTAL to DECIMAL
4940 '  call:  X= ASCII 0-7
4950 '  exit:  A= positive whole number
4960 '  temp:  I= Incr
4970 A=0
4980 FOR I=LEN(X) TO 1 STEP-1
4990  A=INT(A)+INSTR("1234567",MID$(X,I,1))*8^(LEN(X)-I)
5000 NEXT
5010 '
5020 'convert OCTAL to HEXADECIMAL
5030 '  call:  X= ASCII 0-7
5040 '  exit:  S= ASCII 0-F
5050 '  temp:  I= Incr, J= octal digit, Q= translate string
5060 Q="000001010011100101110111":S=""
5070 FOR I=1 TO LEN(X)
5080  S=S+MID$(Q,(INSTR("1234567",MID$(X,I,1))*3)+1,3)
5090 NEXT
5100 Q=STRING$((4-LEN(S) MOD 4)*-(LEN(S) MOD 4>0),48)+S:S=""
5110 FOR I=1 TO LEN(Q) STEP 4
5120  J=VAL(MID$(Q,I,1))*8+VAL(MID$(Q,I+1,1))*4
5130  J=J+VAL(MID$(Q,I+2,1))*2+VAL(MID$(Q,I+3,1))
5140  S=S+MID$("0123456789ABCDEF",J+1,1)
5150 NEXT
5160 '
5170 'generate BCC (Block Check Code) 1-byte hash
5180 '  call:  X= string less than 255 bytes
5190 '  exit:  X= X+CHR$(bcc), as often used in RS232
5200 '  temp:  I= Incr, K= bcc hash
5210 X=LEFT$(X,254)+CHR$(0):K=0                 'len(X)<255
5220 FOR I=1 TO LEN(X)-1 STEP 2
5230  K=K XOR CVI(MID$(X,I))                    'pairs
5240 NEXT
5250 K=PEEK(VARPTR(K)) XOR PEEK(VARPTR(K)+1)    'fold over
5260 MID$(X,LEN(X))=CHR$(ABS(K))                'insert BCC
5270 '
5280 'generate COKE codes (consonants only keys)
5290 '  call:  X= the "name", upper case ASCII, len<255
5300 '  exit:  S= any 1st ltr + consonants, no doubles
5310 '  temp:  I= Incr, C= ptr
5320 S=X+" ":IF MID$(S,2,1)=LEFT$(S,1) THEN MID$(S,2)="."
5330 FOR I=2 TO LEN(S)-1
5340  C=INSTR("BCDFGHJKLMNPQRSTVWXYZ",MID$(S,I,1))
5350  IF C=0 THEN MID$(S,I)="."
5360  IF MID$(S,I,1)=MID$(S,I+1,1) THEN MID$(S,I)="."
5370 NEXT:C=INSTR(S,".")
5380 WHILE C:MID$(S,C)=MID$(S,C+1):C=INSTR(S,"."):WEND
5390 S=LEFT$(S,INSTR(S," "))
5400 '
5410 'generate SOUNDEX code (phonetic search key)
5420 '  call:  X= the "name" in upper case ASCII
5430 '  exit:  S= 1st letter of name + 3 ASCII digits
5440 '  temp:  I= Incr, J= scan, C= ptr
5450 S="0000":MID$(S,1,1)=X:C=2
5460 FOR I=2 TO LEN(X)
5470  J=INSTR("RMNLDTCGJKQSXZBFPV",MID$(X,I,1))          'key
5480  IF J THEN MID$(S,C,1)=MID$("655433222222221111",J) 'sub
5490  IF J THEN C=C+1:IF C>4 THEN I=255
5500 NEXT
5510 '
5520 'determine CURRENCY denominations (US)
5530 '  call:  A= positive dollars amount
5540 '         S= string, len>9
5550 '  exit:  monitor output, S= string amount
5560 '  temp:  I= Incr, K= cnt
5570 PRINT USING "#######.##";A;:PRINT STRING$(10,29);:K=1
5580 FOR I=POS(0) TO POS(0)+9
5590  MID$(S,K)=CHR$(SCREEN(CSRLIN,I)):K=K+1:NEXT:PRINT
5600 K=VAL(LEFT$(S,4))
5610  IF K THEN PRINT K;"thousands";MKI$(-(K=1)*8221)
5620 K=VAL(MID$(S,5,1))
5630  IF K THEN PRINT K;"hundreds";MKI$(-(K=1)*8221)
5640 K=VAL(MID$(S,6,2))
5650  IF K>49 THEN K=K-50:PRINT " 1 fifty"
5660  IF K>39 THEN K=K-40:PRINT " 2 twenties"
5670  IF K>19 THEN K=K-20:PRINT " 1 twenty"
5680  IF K>9  THEN K=K-10:PRINT " 1 ten"
5690  IF K>4  THEN K=K -5:PRINT " 1 five"
5700  IF K THEN PRINT K;"ones";MKI$(-(K=1)*8221)
5710 K=VAL(RIGHT$(S,2))
5720  IF K>74 THEN K=K-75:PRINT " 3 quarters"
5730  IF K>49 THEN K=K-50:PRINT " 2 quarters"
5740  IF K>24 THEN K=K-25:PRINT " 1 quarter"
5750  IF K>19 THEN K=K-20:PRINT " 2 dimes"
5760  IF K>9  THEN K=K-10:PRINT " 1 dime"
5770  IF K>4  THEN K=K -5:PRINT " 1 nickle"
5780  IF K THEN PRINT K;"pennys";MKI$(-(K=1)*8221)
5790 '
5800 'mask-off high order BIT (#7) in character strings
5810 '  call:  Q= any string
5820 '  exit:  Q= with all bytes < chr$(128)
5830 '  temp:  I= Incr
5840 FOR I=1 TO LEN(Q):C=ASC(MID$(Q,I))
5850  MID$(Q,I)=CHR$(C AND 32639)
5860 NEXT
5870 '
5880 'shift LOWER case ASCII letters to UPPER case
5890 '  call:  Q= any string
5900 '  exit:  Q= with no lower case
5910 '  temp:  I= Incr, C= chr val
5920 FOR I=1 TO LEN(Q):C=ASC(MID$(Q,I))
5930  MID$(Q,I)=CHR$(C-32*(C>64 AND C<91))
5940 NEXT
5950 '
5960 'shift UPPER case ASCII letters to LOWER case
5970 '  call:  Q= any string
5980 '  exit:  Q= with no upper case
5990 '  temp:  I= Incr
6000 FOR I=1 TO LEN(Q):C=ASC(MID$(Q,I))
6010  MID$(Q,I)=CHR$(C+32*(C>96 AND C<123))
6020 NEXT
6030 '
6040 'switch UPPER and LOWER case ASCII letters
6050 '  call:  Q= any string
6060 '  exit:  Q= with all upper/lower cases reversed
6070 '  temp:  I= Incr
6080 FOR I=1 TO LEN(Q):C=ASC(MID$(Q,I))
6090  MID$(Q,I)=CHR$(C+32*(C>96 AND C<123)-32*(C>64 AND C<91))
6100 NEXT
6110 '
6120 'tokenize repeated CHARACTERS in ASCII strings
6130 '  call:  X= string, S= pack-character (often " ")
6140 '  exit:  X= repeats tokenized CHR$(127+ # of S)
6150 '            tokens follow S-characters
6160 '  temp:  I= Incr, J= cnt, E= exit
6170 E=LEN(X)
6180 E=E+(E-128)*(E>128)        'max 128 or len(X)
6190 FOR I=E TO 3 STEP-1        'trips at least
6200  J=INSTR(X,STRING$(I,S))   'repititions of S
6210   IF J THEN X=LEFT$(X,J)+CHR$(127+I)+MID$(X,J+I)
6220  I=I-(J>0)                 'same sequence again?
6230   IF INSTR(X,STRING$(3,S))=0 THEN I=3
6240 NEXT
6250 '
6260 'token-expand repeated CHARACTERS in ASCII strings
6270 '  call:  X= string, bytes > CHR$(128) are tokens
6280 '  exit:  X= token-byte-1 repeated, token-128 times
6290 '  temp:  I= Incr, E= expander
6300 FOR I=LEN(X) TO 2 STEP-1   'scan right-to-left
6310  E=ASC(MID$(X,I))          'token test
6320  IF E>128 THEN X=LEFT$(X,I-1)+STRING$(E-128,MID$(X,I-1))+MID$(X,I+1)
6330 NEXT
6340 '      
6350 'translate BYTES of strings using find/swap strings
6360 '  call:  X= any string
6370 '         Q= find-in-this string
6380 '         S= swap-with-in string
6390 '  exit:  E= len(X) or, 0 if len(S)<>len(Q)
6400 '         X= translated if E, else unchanged
6410 '  temp:  I= Incr, C= ptr
6420 E=LEN(X)*-(LEN(Q)=LEN(S))
6430 FOR I=1 TO E:C=INSTR(Q,MID$(X,I,1))
6440  IF C THEN MID$(X,I)=MID$(S,C,1)
6450 NEXT
6460 '
6470 'translate ORDINAL number to CARDINAL string
6480 '  call:  Q= translate string, len=>213
6490 '         X= mask string, len=>9
6500 '         P= parse string, len=>11
6510 '         A= input number <= 99,999,999.99
6520 '  temp:  I= Incr, L= cnt, C= cnt, K= cents
6530 '  exit:  printed, I= L= C= junk, A=unchanged
6540 '  note:  output is akin to "check amounts"
6550 LSET Q="1one2two3three4four5five6six7seven8eight"
6560  MID$(Q,41)="9nine:ten;eleven<twelve=thirteen"
6570  MID$(Q,73)=">fourteen?fifteen@sixteenAseventeen"
6580  MID$(Q,108)="BeighteenCnineteenDtwentyEthirty"
6590  MID$(Q,140)="FfortyGfiftyHsixtyIseventyJeighty"
6600  MID$(Q,173)="KninetyLhundredMthousandNmillionO"
6610 L=CSRLIN:C=POS(0):PRINT USING "########.##";A;:LSET X=""
6620 FOR I=1 TO 11:MID$(X,I)=CHR$(SCREEN(L,C)):C=C+1:NEXT
6630 PRINT:K=VAL(RIGHT$(X,2)):LSET P=LEFT$(X,8)
6640  WHILE ASC(P)=32:LSET P=MID$(P,2):WEND:J=77
6650 FOR I=INSTR(P," ")-3 TO 2 STEP-3
6660  MID$(P,I+1)=MID$(P,I):MID$(P,I)=CHR$(J):J=J+1
6670 NEXT
6680 FOR I=INSTR(P," ")-2 TO 2 STEP-4:C=VAL(MID$(P,I-1,1))
6690  IF C THEN MID$(P,I+1)=MID$(P,I):MID$(P,I)="L"
6700 NEXT:C=1
6710 L=INSTR(P,"N000M"):IF L THEN MID$(P,L+1)=MID$(P,L+5,80)
6720 FOR I=1 TO INSTR(P," ")-1:L=ASC(MID$(P,I))
6730  J=VAL(MID$(P,I,2)):IF J>9 AND J<20 THEN L=J+48:I=I+1
6740  IF J>19 THEN L=J\10+66:IF J MOD 10 THEN J=-1 ELSE I=I+1
6750  E=INSTR(Q,CHR$(L))
6760  IF E THEN LSET X=MID$(Q,E+1,INSTR(E,Q,CHR$(L+1))-E-1)
6770  IF C THEN MID$(X,1)=CHR$(ASC(MID$(X,1))-32)
6780  IF E THEN PRINT LEFT$(X,INSTR(X," ")-1);
6790  C=VAL(MID$(P,I+1,1))*(L>66 AND L<76)
6800  IF C THEN PRINT "-"; ELSE IF L-48 THEN PRINT " ";
6810 C=0:NEXT:IF INT(A)=0 THEN PRINT "Zero ";
6820 PRINT "Dollar";STRING$(ABS(INT(A)<>1),115);
6830 PRINT " and";K;"Cent";STRING$(ABS(K<>1),115)
6840 '
6850 'calendar MONTH display, years 1901-2000
6860 '  call:  T= string len=>182, Y= string len=>100
6870 '         I= year (1901-2000), J= month (1-12)
6880 '  temp:  T= months, Y= years, E= exit, I= days
6890 '         K= 1st day, L= line, C= col, H= hold, J= flag
6900     LSET Y ="CDEMABCKFGAIDEFNBCDL" '1901-20
6910 MID$(Y,21) ="GABJEFGHCDEMABCKFGAI" '1921-40
6920 MID$(Y,41) ="DEFNLCDLGABJEFGHCDEM" '1941-60
6930 MID$(Y,61) ="ABCKFGAIDEFNBCDLGABJ" '1961-80
6940 MID$(Y,81) ="EFGHCDEMABCKFGAIDEFN" '1981-00
6950     LSET T ="A144725736146B255136147257"
6960 MID$(T,27) ="C366247251361D477351362472"
6970 MID$(T,53) ="E511462473513F622573514624"
6980 MID$(T,79) ="G733614625735H145136147257"
6990 MID$(T,105)="I256247251361J367351362472"
7000 MID$(T,131)="K471462473513L512573514624"
7010 MID$(T,157)="M623614625735N734725736146"
7020 K=VAL(MID$(T,INSTR(T,MID$(Y,I-1900,1))+J,1))
7030 E=ASC(MID$("303232332323",J))-(I MOD 4=0 AND J=2)-20
7040 PRINT " Su Mo Tu We Th Fr Sa":H=1:I=1
7050 FOR L=1 TO 6:FOR C=1 TO 7:J=(H<K OR I>E)
7060  IF J THEN PRINT "   "; ELSE PRINT USING "###";I;
7070 I=I-(J=0):H=H+1:NEXT:PRINT:NEXT
7080 '
7090 'compute DAY of WEEK for years 1901-2000
7100 '  call:  X= string, Julian date as yyddd, len=>5
7110 '         Q= string, len=>101
7120 '  exit:  B= cvs(3-letter-day-name-space)
7130 '         E= 0 if X is not logical
7140 '  temp:  Q= translate string (day years begin on)
7150 '         I= year, J= day pointer
7160 LSET Q="5612346712456723457123567134":MID$(Q,29)=Q
7170 MID$(Q,4)=LEFT$(Q,101):MID$(Q,1)="734"       'years=Jan 1
7180 I=ABS(VAL(LEFT$(X,2))):E=VAL(MID$(Q,I+1,1))  'year starts
7190 J=((VAL(MID$(X,3,3))+E-1) MOD 7+1)*4         'day pointer
7200 B=CVS(MID$("   Sat Sun Mon Tue Wed Thu Fri ",J))
7210 E=(VAL(MID$(X,3,3))<=365-(I MOD 4=0))        'logic check
7220 IF E THEN PRINT MKS$(B)                      'display
7230 '
7240 'convert DATE, Gregorian to Julian
7250 '  call:  X= string, mm/dd/yy (assumed valid)
7260 '  exit:  B= single precision whole number, yyddd
7270 '  temp:  I= Incr
7280 B=VAL(MID$(X,4,2))                       'date
7290 FOR I=VAL(LEFT$(X,2))-1 TO 1 STEP-1
7300  B=B+ASC(MID$("CACBCBCCBCBC",I))-36
7310 NEXT                                     'per month
7320 B=B+((B>59)*SGN(VAL(RIGHT$(X,2)) MOD 4)) 'leap year
7330 B=B+VAL(RIGHT$(X,2))*1000                'append year
7340 '
7350 'convert DATE, Julian to Gregorian
7360 '  call:  B= whole number, yyddd (assumed valid)
7370 '         S= string, len=8
7380 '  exit:  S= mm/dd/yy, B= junk
7390 '  temp:  I= month, J= days
7400 RSET S=STR$(INT(B/1000)+100)             'get year
7410 B=B-INT(B/1000)*1000                     'get days
7420 FOR I=1 TO 12
7430  J=ASC(MID$("C@CBCBCCBCBC",I))-36
7440  J=J-(I=2 AND VAL(S) MOD 4=0)            'leap year
7450  IF B<=J THEN MID$(S,3)=STR$(I+100):I=12
7460 B=B-J:NEXT                               'per month
7470 MID$(S,1)=STR$(B+J+100)                  'format
7480 MID$(S,1)=MID$(S,5,2):MID$(S,4)=MID$(S,3,2)
7490 MID$(S,3)="/":MID$(S,6)="/"
7500 '
7510 'convert TIME, 12-hour (AM/PM) to 24-hour
7520 '  call:  X= hhmmssAM or PM, len=>7
7530 '            assumed valid ("M" not used)
7540 '         R= string, len=>8
7550 '  exit:  R= hh:mm:ss
7560 '  temp:  I= hour, E= noon/midnight
7570 I=VAL(LEFT$(X,2))-12*(LEFT$(X,2)<="12")    'nighttime
7580 E=12*(INSTR(X,"P")=0)                      'morning
7590 E=E+12*(I=24)-12*(LEFT$(X,7)="120000A")
7600 LSET R=STR$(I+E+100):LSET R=MID$(R,3)      'format
7610 MID$(R,4)=MID$(X,3):MID$(R,7)=MID$(X,5)
7620 MID$(R,3)=":":MID$(R,6)=":"
7630 '
7640 'convert TIME, 24-hour to 12-hour (AM/PM)
7650 '  call:  X= hh:mm:ss, len=>8, assumed valid
7660 '         R= string, len=>7
7670 '  exit:  R= hhmmssdM (d= "A" or "P")
7680 '            "M" included if R is long enough
7690 '  temp:  I= hour, E= 1 or 2 (AM/PM)
7700 I=12*(X>"12:59:59")-12*(VAL(X)=0)+VAL(X)   'adj hour
7710 E=2+(LEFT$(X,8)<"12:00:00" OR VAL(X)=24)   'set AM/PM
7720 LSET R=STR$(I+100):LSET R=MID$(R,3)        'format
7730 MID$(R,3)=MID$(X,4,2):MID$(R,5)=MID$(X,7)
7740 MID$(R,7)=MID$(" AMPM",E*2)
7750 '
7760 'elapsed DAYS, Julian dates, 1900-1999
7770 '  call:  X= fromdate, yyddd, len=>5 (assumed valid)
7780 '         R= thrudate, yyddd, len=>5 (assumed valid)
7790 '  exit:  B= days elapsed
7800 '         E= 0 if from/thru reversed
7810 '  temp:  I= Incr, J= fromyear, K= thruyear
7820 J=VAL(LEFT$(X,2)):K=VAL(LEFT$(R,2))    'from:thru
7830 B=0                                    'clear
7840 FOR I=J TO K-1
7850  B=B+365-(I MOD 4=0)
7860 NEXT                                   'per year
7870 B=B+VAL(MID$(R,3,3))-VAL(MID$(X,3,3))  'subtract
7880 E=(B=>0)*(LEFT$(R,5)>LEFT$(X,5))       'logical?
7890 '
7900 'elapsed TIME, 12-hour, hhmmssA or hhmmssP
7910 '  call:  S= start time (assumed valid), len=>7
7920 '         X= end time (assumed valid), len=>7
7930 '         R= string, len=>6
7940 '  exit:  R= elapsed time (hhmmss)
7950 '  temp:  I= hours, J= minutes, K= seconds, E= flag
7960 K=VAL(MID$(X,5,2))-VAL(MID$(S,5,2))        'seconds
7970 J=VAL(MID$(X,3,2))-VAL(MID$(S,3,2))+(K<0)  'minutes
7980 I=VAL(LEFT$(X,2))-VAL(LEFT$(S,2))+(J<0)    'hours
7990 E=(RIGHT$(S,1)<>RIGHT$(X,1))               'AM/PM flag
8000 K=K-60*(K<0):J=J-60*(J<0)                  'adjust
8010 I=I-12*(I<0)-12*(I<0 AND E=0)-12*(I=>0 AND E<0)
8020 LSET R=STR$(I+100):I=CVI(MID$(R,3))        'format
8030 LSET R=STR$(J+100):J=CVI(MID$(R,3))
8040 RSET R=STR$(K+100):MID$(R,3)=MKI$(J):MID$(R,1)=MKI$(I)
8050 '
8060 'elapsed TIME, 24-hour, hh:mm:ss
8070 '  call:  S= start time (assumed valid), len=>8
8080 '         X= end time (assumed valid), len=>8
8090 '         R= string, len=>8
8100 '  exit:  R= elapsed time (hh:mm:ss)
8110 '  temp:  I= hours, J= minutes, K= seconds
8120 K=VAL(MID$(X,7))-VAL(MID$(S,7))            'seconds
8130 J=VAL(MID$(X,4))-VAL(MID$(S,4))+(K<0)      'minutes
8140 I=VAL(X)-VAL(S)+(J<0)                      'hours
8150 K=K-60*(K<0):J=J-60*(J<0):I=I-24*(I<0)     'adjust
8160 LSET R=STR$(I+100):I=CVI(MID$(R,3))        'format
8170 LSET R=STR$(J+100):J=CVI(MID$(R,3))
8180 RSET R=STR$(K+100):MID$(R,4)=MKI$(J):MID$(R,1)=MKI$(I)
8190 MID$(R,3)=":":MID$(R,6)=":"
8200 '
8210 'fielded DATE, Julian, 2-bytes, encode/decode
8220 '  call:  B= yyddd (assumed valid)
8230 '         R= 2-byte string (typically fielded)
8240 '  exit:  B= decoded R, R= encoded B
8250 '  temp:  C= year, D= days
8260 C=B/1000:D=B-C*1000                   'encode
8270  IF D>255 THEN C=C+128:D=D-128
8280   LSET R=CHR$(C):MID$(R,2)=CHR$(D)
8290 '
8300 C=ASC(R):D=ASC(MID$(R,2))             'decode
8310  IF C>127 THEN C=C-128:D=D+128
8320   B=C*1000+D
8330 '
8340 'reformat DATE, ddmmmyy as mm/dd/yy
8350 '  call:  X= ddmmmyy (assumed valid), len=>7
8360 '         R= string, len=>8
8370 '  exit:  R= mm/dd/yy
8380 '  temp:  J= month number
8390 J=INSTR(" ANEBARPRAYUNULUGEPCTOVEC",MID$(X,4,2))\2
8400 LSET R=STR$(J+100):LSET R=MID$(R,3)
8410 MID$(R,4)=MID$(X,1):MID$(R,7)=MID$(X,6)
8420 MID$(R,3)="/":MID$(R,6)="/"
8430 '
8440 'reformat DATE, mm/dd/yy as ddmmmyy
8450 '  call:  X= mm/dd/yy (assumed valid), len=>8
8460 '         R= string, len=>7
8470 '  exit:  R= ddmmmyy
8480 '  temp:  none
8490 LSET R=MID$(X,4,2):MID$(R,6)=MID$(X,7,2)
8500 MID$(R,3)=MID$("JFMAMJJASOND",VAL(X),1)
8510 MID$(R,4)=MID$("AEAPAUUUECOE",VAL(X),1)
8520 MID$(R,5)=MID$("NBRRYNLGPTVC",VAL(X),1)
8530 '
8540 'reformat DATE, mm/dd/yy as month day, year
8550 '  call:  X= mm/dd/yy (assumed valid), len=>8
8560 '         R= string, len=>19
8570 '  exit:  R= month-name daySS, year
8580 '         (SS= st,nd,rd or th)
8590 '  temp:  I= Instr, J= month
8600 J=VAL(X):I=(J MOD 3+1)*9-8
8610             LSET R=MID$("March    January  February",I,9)
8620 IF J>3 THEN LSET R=MID$("June     April    May",I,9)
8630 IF J>6 THEN LSET R=MID$("SeptemberJuly     August",I,9)
8640 IF J>9 THEN LSET R=MID$("December October  November",I,9)
8650 I=INSTR(R," "):MID$(R,I)=STR$(VAL(MID$(X,4)))
8660        I=INSTR("   1  21 31 2  22 3  23",MID$(R,I,3))+1
8670 MID$(R,INSTR(R,"  "))=MID$("th,st,st,st,nd,nd,rd,rd,",I,3)
8680 MID$(R,INSTR(R,",")+1)=STR$(1900+VAL(MID$(X,7)))
8690 '
8700 'validate DATE, Gregorian
8710 '  call:  X= mm/dd/yy, len=>8
8720 '  exit:  E= 0 if X is invalid
8730 '  temp:  none
8740 E=32-VAL(MID$(" 141212112121",VAL(LEFT$(X,2))+1,1))
8750 E=E-(E=28 AND (VAL(MID$(X,7,2)) MOD 4=0))
8760 E=E*VAL(MID$(X,4,2))*(VAL(MID$(X,4,2))<=E)
8770 E=E*SGN(VAL(X))*(VAL(LEFT$(X,2))<13)
8780 E=E*(MID$(X,3,1)=MID$(X,6,1))*(MID$(X,3,1)="/")
8790 E=E*SGN(INSTR("01",MID$(X,1,1)))*(LEN(X)>7)
8800 E=E*SGN(INSTR("012",MID$(X,2,1)))
8810 E=E*SGN(INSTR("0123",MID$(X,4,1)))
8820 E=E*SGN(INSTR("0123456789",MID$(X,5,1)))
8830 E=E*SGN(INSTR("0123456789",MID$(X,7,1)))
8840 E=E*SGN(INSTR("0123456789",MID$(X,8,1)))
8850 '
8860 'validate DATE, Julian
8870 '  call:  X= yyddd, len=>5
8880 '  exit:  E= 0 if X is invalid
8890 '  temp:  none
8900 E=(VAL(LEFT$(X,2)) MOD 4=0)
8910 E=VAL(MID$(X,3,3))*(VAL(MID$(X,3,3))<=365-E)
8920 E=E*SGN(INSTR("0123456789",MID$(X,1,1)))
8930 E=E*SGN(INSTR("0123456789",MID$(X,2,1)))
8940 E=E*SGN(INSTR("0123",MID$(X,3,1)))*(LEN(X)>4)
8950 E=E*SGN(INSTR("0123456789",MID$(X,4,1)))
8960 E=E*SGN(INSTR("0123456789",MID$(X,5,1)))
8970 '
8980 'validate TIME, 12-hour, hhmmssA or hhmmssP
8990 '  call:  X= hhmmssyb, len=>7
9000 '         (y is A or P, b is blank, null, or M)
9010 '  exit:  E= 0 if X is invalid
9020 '  temp:  none
9030 E=(LEN(X)=7 OR INSTR("M ",MID$(X,8,1))<>0)
9040 E=E*(VAL(LEFT$(X,2))<13)*SGN(VAL(LEFT$(X,2)))
9050 E=E*INSTR("01",MID$(X,1,1))*INSTR("AP",MID$(X,7,1))
9060 E=E*INSTR("0123456789",MID$(X,2,1))
9070 E=E*INSTR("012345",MID$(X,3,1))
9080 E=E*INSTR("0123456789",MID$(X,4,1))
9090 E=E*INSTR("012345",MID$(X,5,1))
9100 E=E*INSTR("0123456789",MID$(X,6,1))
9110 '
9120 'validate TIME, 24-hour, hh:mm:ss
9130 '  call:  X= hh:mm:ss, len=>8
9140 '  exit:  E= 0 if X is invalid
9150 '  temp:  none
9160 E=(LEFT$(X,2)<>"24" OR LEFT$(X,8)="24:00:00")
9170 E=E*(VAL(LEFT$(X,2))<25)*INSTR("012",MID$(X,1,1))
9180 E=E*SGN(INSTR("0123456789",MID$(X,2,1)))
9190 E=E*INSTR("012345",MID$(X,4,1))
9200 E=E*SGN(INSTR("0123456789",MID$(X,5,1)))
9210 E=E*INSTR("012345",MID$(X,7,1))
9220 E=E*INSTR("0123456789",MID$(X,8,1))
9230 E=E*(MID$(X,3,1)=MID$(X,6,1))*(MID$(X,3,1)=":")
9240 E=E*(LEFT$(X,8)<>"00:00:00")
9250 '
9260 'edit DOLLARS, floating-$, $ZZZ,ZZZ,ZZD.DD-
9270 '  call:  A= whole number, S= string, len=>16
9280 '  exit:  S= edited string, right justified
9290 '  temp:  I= Instr, L= len(S)
9300 LSET S=STR$(INT(A)/100):MID$(S,1)="-"
9310 I=INSTR(S,"  "):L=LEN(S)
9320  IF INSTR(S,".")=0 THEN MID$(S,I)=".00":I=I+3
9330  IF LEFT$(S,2)="-." THEN MID$(S,2)=LEFT$(S,L)
9340  IF LEFT$(S,2)="--" THEN MID$(S,1)="-0":I=I+1
9350 RSET S=LEFT$(S,I):MID$(S,L)=CHR$(32-13*SGN(A<0))
9360  I=L+7*(VAL(LEFT$(S,L-7))<0)
9370  IF I<L THEN MID$(S,1)=MID$(S,2,I):MID$(S,I)=","
9380  I=L+11*(VAL(LEFT$(S,L-11))<0)
9390  IF I<L THEN MID$(S,1)=MID$(S,2,I):MID$(S,I)=","
9400  MID$(S,INSTR(S,"-"))="$"
9410 '
9420 'reverse NAMES, Doe, John J. Jr. as John J. Doe, Jr.
9430 '  call:  X= last, first middle rank
9440 '         S= string, len=>len(X)
9450 '  exit:  S= first middle last, rank
9460 '  temp:  I= ptr, J= ptr
9470 LSET S=X
9480 FOR I=1 TO LEN(S):J=ASC(MID$(S,I))
9490  MID$(S,I)=CHR$(J-32*(J>64 AND J<91)):NEXT
9500   J=INSTR(S," iv")+INSTR(S," ii")
9510   J=J+INSTR(S," jr")+INSTR(S," sr")
9520   J=J*SGN(INSTR(". ",MID$(S,J+3,1)) OR J+3=LEN(S))
9530   I=INSTR(S," iii")
9540   I=I*SGN(INSTR(". ",MID$(S,I+4,1)) OR I+4=LEN(S))
9550   J=I*ABS(I=>J)+J*ABS(J>I):I=J:IF J=0 THEN J=LEN(S)+1
9560  WHILE I AND I<LEN(S):MID$(S,I)=" ":I=I+1:WEND
9570  I=INSTR(S,","):LSET S=MID$(S,I+2)
9580  MID$(S,INSTR(S,"    ")+1)=LEFT$(X,I-SGN(I)+1)
9590 I=LEN(S):J=I*ABS(I<J)+J*ABS(J<=I):MID$(S,J)=MID$(X,J)
9600 '
9610 'reverse NAMES, John J. Doe, Jr. as Doe, John J. Jr.
9620 '  call:  X= first middle last, rank
9630 '         S= string, len=>len(X)
9640 '  exit:  S= last, first middle rank
9650 '  temp:  I= ptr, J= ptr
9660 LSET S=X:I=INSTR(S,","):IF I=0 THEN I=LEN(S)
9670 FOR I=LEN(S) TO I STEP-1:MID$(S,I)=" ":NEXT
9680 I=LEN(S):WHILE I>1 AND MID$(S,I,1)=" ":I=I-1:WEND
9690      J=I:WHILE J>1 AND MID$(S,J,1)>" ":J=J-1:WEND
9700      J=J-(MID$(S,J,1)=" ")
9710 LSET S=MID$(S,J):I=INSTR(S,"  "):MID$(S,I)=","
9720 MID$(S,I+2)=LEFT$(X,J-1):I=INSTR(X,", ")
9730 IF I THEN MID$(S,INSTR(S,"  "))=MID$(X,I+1)
9740  WHILE MID$(S,14,1)=" ":MID$(S,2)=LEFT$(S,13):WEND
9750 MID$(S,2)=MID$(S,5,3):MID$(S,7)=MID$(S,8,3)
9760 MID$(S,5)=")":MID$(S,1)="(":MID$(S,10)="-":I=INSTR(S," ")
9770  WHILE I*(I<15):MID$(S,I)="0":I=INSTR(S," "):WEND
9780 MID$(S,6)=" "
9790 '
9800 'edit PHONE number as 999-999-9999
9810 '  call:  A= 10-digit whole number, S= string len=>12
9820 '  exit:  S= zzz-zzz-zzzz, left justified, zero filled
9830 '  temp:  I= inspect for spaces
9840 LSET S=STR$(A)
9850  WHILE MID$(S,12,1)=" ":MID$(S,2)=LEFT$(S,11):WEND
9860 MID$(S,1)=MID$(S,3,3):MID$(S,5)=MID$(S,6,3)
9870 MID$(S,4)="-":MID$(S,8)="-":I=INSTR(S," ")
9880  WHILE I*(I<13):MID$(S,I)="0":I=INSTR(S," "):WEND
9890 '
9900 'edit SOCIAL SECURITY number as 999-99-9999
9910 '  call:  A= 9-digit whole number, S= string len=>11
9920 '  exit:  S= zzz-zz-zzzz, left justified, zero filled
9930 '  temp:  I= inspect for spaces
9940 LSET S=STR$(A)
9950  WHILE MID$(S,11,1)=" ":MID$(S,2)=LEFT$(S,11):WEND
9960 MID$(S,1)=MID$(S,3,3):MID$(S,5)=MID$(S,6,2)
9970 MID$(S,4)="-":MID$(S,7)="-":I=INSTR(S," ")
9980  WHILE I*(I<12):MID$(S,I)="0":I=INSTR(S," "):WEND
9990 '
