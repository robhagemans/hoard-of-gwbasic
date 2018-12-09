10050 NVAR = 1 : NP = 3
11000 '********************************************************************
11010 '* SUBROUTINE GAUSSIAN                                              *
11020 '*                                                                  *
11030 '* Fills the array fcalc(nobs) with values along a gaussian         *
11040 '* of the form:                                                     *
11050 '*                                                                  *
11060 '* gauss(pos) = H * exp[-1 * (pos - P)^2 / w^2]                     *
11070 '*                                                                  *
11080 '* where H, W, and P are parameters to be fit.                      *
11090 '* Assignments:  H = p(1)  W = p(2)  P = p(3)  pos = vobs(i,1)      *
11100 '********************************************************************
11110 LOCATE 1,1:  'PUT SPURIOUS UNDERFLOW MESSAGES IN INNOCENT LOCATION
11120 FOR I = 1 TO NOBS
11130    FCALC(I)  =  P(1) * EXP( -1 * ( (VOBS(I,1) - P(3))^2 / P(2)^2 ) )
11140    NEXT I
11150 RETURN
 FOR I = 1 TO NOBS
11130    FCALC(I)  =  P(1) * EXP( -1 * ( (VOBS(I,1) -