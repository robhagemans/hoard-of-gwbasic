;   +----------------------------------------------------------------------+
;   |                                                                      |
;   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
;   |                                                                      |
;   |            See BASUPD.DOC for info on distribution policy            |
;   |                                                                      |
;   +----------------------------------------------------------------------+



public  CHDRIVE



.model medium
.CODE



CHDRIVE       proc           far       ; change default drive
              mov            bx,sp          ;
              mov            bx,4[bx]       ; drive letter
              mov            cx,[bx]        ;
              mov            bx,2[bx]       ;
              mov            dl,[bx]        ;
              jcxz           Done           ;   exit if null drive string
              and            dl,1Fh         ; convert drive letter to number
              dec            dx             ;
              mov            ah,0Eh         ;
              int            21h            ; set default drive
Done:         ret            2              ;
CHDRIVE       endp                     ; change default drive




              end
