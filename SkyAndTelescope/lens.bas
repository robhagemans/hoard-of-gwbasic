10 REM  APLANATIC DOUBLET DESIGN
12 REM
14 INPUT "FRONT INDEXES";A,B,C
16 INPUT "REAR INDEXES ";D,E,F
18 INPUT "FOCAL LENGTH ";FL
20 PRINT
22 G=B/(B-1): H=E/(E-1)
24 I=(B-1)/(C-A): J=(E-1)/(F-D)
26 K=I^2: L=I^3: M=J^2: N=J^3
28 O=(3-2/G)*I: P=(3-2/H)*J
30 Q=(3*G-1)*K
32 R=(8-4/H)*I*J-(3*H-1)*M
34 S=(G^2)*L-(5-2/H)*K*J
36 T=(4*H-1)*I*M-(H^2)*N
38 U=(2-1/G)*I: V=(2-1/H)*J
40 W=G*K-(3-1/H)*I*J+H*M
42 X=(U^2)*P-(V^2)*O
44 Y=2*U*W*P-(V^2)*Q+U*V*R
46 Z=(W^2)*P-(V^2)*(S+T)+V*W*R
48 A1=(Y-SQR(Y^2-4*X*Z))/(2*X)
50 A2=(U*A1)/V-W/V
52 R1=((I-J)/A1)*FL
54 R2=((I-J)/(A1-(I*(G-1))))*FL
56 R3=((I-J)/A2)*FL
58 R4=((I-J)/(A2+(J*(H-1))))*FL
60 PRINT "R1 = ";R1
62 PRINT "R2 = ";R2
64 PRINT "R3 = ";R3
66 PRINT "R4 = ";R4
68 END
70 REM  ------------------------
80 REM  APPEARED IN ASTRONOMICAL
90 REM  COMPUTING, SKY & TELE-
92 REM  SCOPE, NOVEMBER, 1984
94 REM  ------------------------
