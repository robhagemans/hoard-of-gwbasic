'MAKESIGN.BAS By Rich Geldreich
'This is the routine that made the pc-speaker translation table.
'It writes an assembly file called sign2.asm, which is already
'included in tweakr.asm.
DEFINT A-Z
DIM X(255)
X1 = 0: Y = 65
FOR A! = 0 TO 360 STEP 360 / 64
    Number = 1 + INT(COS(A! / 57.29577951#) * 3.34 + 3.34)
    FOR B = 1 TO Number
        X(X1) = Y: X1 = X1 + 1
    NEXT
    Y = Y - 1
NEXT
X(255) = X(254)
OPEN "sign2.asm" FOR OUTPUT AS #1
A$ = "db "
FOR A = 128 TO 255
    A$ = A$ + MID$(STR$(X(A)), 2) + ","
    IF LEN(A$) > 70 THEN
        PRINT #1, LEFT$(A$, LEN(A$) - 1)
        A$ = "db "
    END IF
NEXT
FOR A = 0 TO 127
    A$ = A$ + MID$(STR$(X(A)), 2) + ","
    IF LEN(A$) > 70 THEN
        PRINT #1, LEFT$(A$, LEN(A$) - 1)
        A$ = "db "
    END IF
NEXT
PRINT #1, LEFT$(A$, LEN(A$) - 1)
CLOSE

