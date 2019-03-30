DEFINT A-Z

SUB QSort (WorkSpc%(), SglArry$(), DblArry$(), NoFlds%, NoItems%, KeyFld%) STATIC
'dim WorkSpc%(50)
'SglArry$ is a single-dimension array to be sorted
'DblArry$ is a two-dimension array to be sorted
'NoFlds% is the size of the 2nd element of DblArry$ (eg, if (x,5) then = 5)
'NoItems% is array size
'KeyFld% is the 2nd element of DblArry$ on which to sort
'   eg, if DblArry$ is (500,3) pass 1/2/3 for field on which to sort 500 recs

NEXTV = 3: WorkSpc%(1) = 1: WorkSpc%(2) = NoItems%

STARTSORT:

IF NEXTV = 1 THEN GOTO ENDSORT ELSE THIS = WorkSpc%(NEXTV - 2)
V9 = WorkSpc%(NEXTV - 2) + 1: J9 = WorkSpc%(NEXTV - 1)
IF V9 > J9 THEN NEXTV = NEXTV - 2: GOTO STARTSORT

SORTPOINT1:

IF NoFlds% = 1 THEN
     IF SglArry$(V9) > SglArry$(THIS) THEN GOTO SORTPOINT2
ELSEIF NoFlds% > 1 THEN
     IF DblArry$(V9, KeyFld%) > DblArry$(THIS, KeyFld%) THEN GOTO SORTPOINT2
END IF

V9 = V9 + 1: IF V9 > J9 THEN GOTO SORTPOINT4 ELSE GOTO SORTPOINT1

SORTPOINT2:

IF NoFlds% = 1 THEN
     IF SglArry$(J9) < SglArry$(THIS) THEN GOTO SORTPOINT3
ELSEIF NoFlds% > 1 THEN
     IF DblArry$(J9, KeyFld%) < DblArry$(THIS, KeyFld%) THEN GOTO SORTPOINT3
END IF

J9 = J9 - 1: IF V9 > J9 THEN GOTO SORTPOINT4 ELSE GOTO SORTPOINT2

SORTPOINT3:

IF NoFlds% = 1 THEN
     SWAP SglArry$(V9), SglArry$(J9)
ELSEIF NoFlds% > 1 THEN
     FOR SWAPCOUNT = 1 TO NoFlds%
       SWAP DblArry$(V9, SWAPCOUNT), DblArry$(J9, SWAPCOUNT)
     NEXT SWAPCOUNT
END IF

V9 = V9 + 1: J9 = J9 - 1: IF V9 > J9 THEN GOTO SORTPOINT4 ELSE GOTO SORTPOINT1

SORTPOINT4:

IF J9 < WorkSpc%(NEXTV - 2) THEN J9 = WorkSpc%(NEXTV - 2)
IF V9 > WorkSpc%(NEXTV - 1) THEN V9 = WorkSpc%(NEXTV - 1)
SWAP V9, J9
IF NoFlds% = 1 THEN
     SWAP SglArry$(THIS), SglArry$(V9)
ELSEIF NoFlds% > 1 THEN
     FOR SWAPCOUNT = 1 TO NoFlds%
       SWAP DblArry$(THIS, SWAPCOUNT), DblArry$(V9, SWAPCOUNT)
     NEXT SWAPCOUNT
END IF

K9 = WorkSpc%(NEXTV - 2)
L9 = WorkSpc%(NEXTV - 1)
NEXTV = NEXTV - 2

IF V9 - K9 <= 0 THEN IF L9 - J9 <= 0 THEN GOTO STARTSORT ELSE WorkSpc%(NEXTV) = J9: WorkSpc%(NEXTV + 1) = L9: NEXTV = NEXTV + 2: GOTO STARTSORT

IF L9 - J9 <= 0 THEN WorkSpc%(NEXTV) = K9: WorkSpc%(NEXTV + 1) = V9 - 1: NEXTV = NEXTV + 2: GOTO STARTSORT

IF V9 - K9 > L9 - J9 + 1 THEN WorkSpc%(NEXTV) = K9: WorkSpc%(NEXTV + 1) = V9 - 1: WorkSpc%(NEXTV + 2) = J9: WorkSpc%(NEXTV + 3) = L9: NEXTV = NEXTV + 4: GOTO STARTSORT

WorkSpc%(NEXTV) = J9
WorkSpc%(NEXTV + 1) = L9
WorkSpc%(NEXTV + 2) = K9
WorkSpc%(NEXTV + 3) = V9 - 1
NEXTV = NEXTV + 4
GOTO STARTSORT

ENDSORT:

END SUB

