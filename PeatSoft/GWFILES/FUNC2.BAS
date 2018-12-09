11000 '********************************************************************
11010 '* SUBROUTINE LORENTZIAN                                            *
11020 '*                                                                  *
11030 '* Fills the array fcalc(nobs) with values along a lorentzian of    *
11040 '* the form:                                                        *
11050 '*                                                                  *
11060 '* lor(pos) = H / [(1/W)^2 * (pos - P)^2 + 1]                       *
11070 '*                                                                  *
11080 '* where H, W, and P are parameters to be fit.                      *
11090 '* Assignments: H = p(1)  W = p(2) P = p(3)    pos = vobs(i,1)      *
11100 '********************************************************************
11110 '
11130 WSQ2 = 1# / (P(2) * P(2))
11160 FOR I = 1 TO NOBS
11170    FCALC(I) =  P(1) / (WSQ2 * (VOBS(I,1) - P(3))^2 + 1#)
11230    NEXT I
11240 RETURN
P(2))
11160 F