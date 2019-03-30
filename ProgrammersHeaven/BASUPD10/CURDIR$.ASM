comment #

   +----------------------------------------------------------------------+
   |                                                                      |
   |        PBClone  Copyright (c) 1990-1992  Thomas G. Hanlin III        |
   |                                                                      |
   |                        assembled with MASM 6.0                       |
   |                                                                      |
   |           COMMERCIAL PRODUCT: NOT FOR PUBLIC DISTRIBUTION            |
   |                                                                      |
   +----------------------------------------------------------------------+

#

public  CURDIR



.model medium



.DATA



String    db "x:\"                ; result string (Drive:\PathFromRoot)
          db 64 dup(?)

StrHead   dw ?                    ; length of result string
          dw offset DGROUP:String ; pointer to result string



.CODE



CURDIR        proc           far       ; get current subdir on a given drive
              push           bp             ;
              mov            bp,sp          ;
              push           si             ;
              push           di             ;
                                            ;
              push           ds             ;
              pop            es             ;
              xor            dx,dx          ;
              mov            bx,6[bp]       ; drive letter
              mov            cx,[bx]        ;
              mov            bx,2[bx]       ;
              mov            al,[bx]        ;
              or             cx,cx          ; was there really a drive letter?
              jnz            GetSubDir      ;   yep, rock 'n' roll
                                            ;
              mov            ah,19h         ; get default drive
              int            21h            ;
              add            al,"A"         ; convert to letter
                                            ;
GetSubDir:    mov            String,al      ; set drive letter into result
              mov            dl,al          ;
              and            dl,1Fh         ;
              lea            si,DGROUP:String+3
              mov            di,si          ;
              mov            ah,47h         ; get current directory
              int            21h            ;
              jc             Error          ;
              mov            cx,64          ; max subdir length
              mov            al,ch          ;
              repnz          scasb          ; scan up to 64b until NUL
              mov            ax,66          ;
              sub            ax,cx          ;
                                            ;
Done:         mov            StrHead,ax     ; set length of subdir string
                                            ;
              lea            ax,DGROUP:StrHead
              pop            di             ;
              pop            si             ;
              pop            bp             ;
              ret            2              ;
                                            ;
Error:        xor            ax,ax          ; set subdir length to null
              jmp            Done           ;
CURDIR        endp                     ; get current subdir on a given drive



              end
