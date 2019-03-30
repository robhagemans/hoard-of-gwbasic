IDEAL
MODEL SMALL
;-------------------------------------------------------------------------------
SEGMENT         GIFCODE PARA PUBLIC 'CODE'
;-------------------------------------------------------------------------------
ASSUME          DS:@DATA, ES:@DATA, CS:GIFCODE, SS:@DATA
;-------------------------------------------------------------------------------
EVEN
Old24_Offset    dw      0
Old24_Segment   dw      0
CritErrCode     dw      0
PUBLIC          ErrorCode
ErrorCode       dw      0
;-------------------------------------------------------------------------------
EVEN
PROC            SetIntVector ;al has int vector cx:dx has new vector
                Push    ds bx
                Xor     bx, bx
                Mov     ds, bx
                Mov     bl, al
                Shl     bx, 1
                Shl     bx, 1
                Mov     [ds:bx], dx
                Mov     [ds:bx+2], cx
                Pop     bx ds
                Ret
ENDP            SetIntVector
;-------------------------------------------------------------------------------
EVEN
PROC            GetIntVector   ;al has int vector cx:dx has vector
                Push    ds bx
                Xor     bx, bx
                Mov     ds, bx
                Mov     bl, al
                Shl     bx, 1
                Shl     bx, 1
                Mov     dx, [ds:bx]
                Mov     cx, [ds:bx+2]
                Pop     bx ds
                Ret
ENDP            GetIntVector
;-------------------------------------------------------------------------------
EVEN
PUBLIC          Hook24
PROC            Hook24
                Push    ax bx cx dx
                Mov     al, 024h
                Call    GetIntVector
                Mov     [cs:Old24_Offset], dx
                Mov     [cs:Old24_Segment], cx
                Mov     al, 024h
                Mov     dx, offset NewInt24
                Mov     cx, cs
                Call    SetIntVector
                Mov     [cs:CritErrCode], 0
                Mov     [cs:ErrorCode], 0
                Pop     dx cx bx ax
                Ret
ENDP            Hook24
;-------------------------------------------------------------------------------
;Uninstalls my critical error handler.
EVEN
PUBLIC          UnHook24
PROC            UnHook24
                Push    ax bx cx dx
                Mov     dx, [cs:Old24_Offset]
                Mov     cx, [cs:Old24_Segment]
                Mov     al, 024h
                Call    SetIntVector
                Pop     dx cx bx ax
                Ret
ENDP            UnHook24
;-------------------------------------------------------------------------------
EVEN
PROC            NewInt24
                Mov     ax, di          ;put error code in ax
                Xor     ah, ah
                Mov     [cs:CritErrCode], ax ;store it for later
                Mov     al, 3           ;tell DOS to ignore the error
                Iret                    ;return to caller
ENDP            NewInt24
;-------------------------------------------------------------------------------
;This sub is called after each disk access to check for errors(either
;critical or non-critical). If a non-critical error is detected, then DOS's
;extended error function is also called to determine which type of error
;occured.
EVEN
PUBLIC          CheckError
PROC            CheckError
                Pushf                           ;preseve de flags
                Cmp     [cs:CritErrCode], 0     ;critical error?
                Jnz     @@CriticalError
                Popf                            ;get the flags back
                Jc      @@NormalError           ;normal error?
                Ret
;handles normal error
@@NormalError:  Push    ax bx cx dx bp si di ds es  ;preserve the registers
                Mov     ah, 059h                ;get extended error info.
                Xor     bx, bx
                Int     021h
                Pop     es ds di si bp dx cx bx
                Add     ax, 100                 ;add 100 to it to descriminate
@@ErrorExit:    Mov     [cs:ErrorCode], ax      ;between critical errors
                Pop     ax
                Stc
                Ret
;handles critical errors
@@CriticalError:
                Popf
                Push    ax
                Xor     ax, ax                  ;zero out critical error and
                Xchg    ax, [cs:CritErrCode]    ;get it at the same time
                Jmp     @@ErrorExit             ;put it in ErrorCode and exit
ENDP            CheckError
;-------------------------------------------------------------------------------
EVEN
PUBLIC          ErrorReport
PROC            ErrorReport
                Mov     ax, [cs:ErrorCode]
                Retf    0
ENDP            ErrorReport
;-------------------------------------------------------------------------------
ENDS            GIFCODE
;-------------------------------------------------------------------------------
END

