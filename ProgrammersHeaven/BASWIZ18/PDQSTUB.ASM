comment #

   +----------------------------------------------------------------------+
   |                                                                      |
   |        BASWIZ  Copyright (c) 1990-1992  Thomas G. Hanlin III         |
   |                                                                      |
   |                      The BASIC Wizard's Library                      |
   |                                                                      |
   |                        assembled with MASM 6.0                       |
   |                                                                      |
   +----------------------------------------------------------------------+

#

public  B$SETM



BW_MEM        segment word public 'CODE'
              assume cs:BW_MEM



B$SETM        proc           far       ; stub for SETMEM function for P.D.Q.
              ret
B$SETM        endp                     ; stub for SETMEM function for P.D.Q.



BW_MEM        ends



              end
