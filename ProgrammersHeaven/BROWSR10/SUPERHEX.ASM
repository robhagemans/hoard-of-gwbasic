; =========== SuperHEX 1.1 ===============
; by Victor Yiu, July 1993
;
; Ultra-fast ASCII to HEX conversion...
; designed for calling up from a file
; or memory viewer to display hex/ascii
; codes like Norton's DiskEdit, or PCTool's
; View... except much faster!
;
; This code is released into public domain.
; =========================================

CODE SEGMENT PARA PUBLIC 'CODE'
    PUBLIC SuperHex, MemCopy, Scroll
    ASSUME CS:code, DS:nothing, ES:nothing, SS:nothing

CharsPerLine    = 80        ; set-up hard coded constant
FilterReplaceChar   EQU '.' ; replace bad chars. with what?

SuperHex PROC FAR
    PUSH BP             ; set up stack frame
    MOV BP, SP
    PUSH DS             ; save registers
    PUSH SI
    PUSH DI
; ===========================================================================
;VidSeg, Row, OffsetHex, OffsetASCii, Seg:Off memory (16 byte)
; BP+20  BP+18  BP+16       BP+14            BP+10 [DWORD]

; BG Color    Filter
;   BP+8       BP+6
; ===========================================================================

    LES AX, SS:[BP+18]  ; VidSeg --> ES
    DEC AX              ; Row --> AX  (adjust to 0-24 range)
    JZ NoMul            ; if 0, don't multiply to save time
    MOV BL, CharsPerLine; get # chars per line
    MUL BL              ; multiply
NoMul:
    SHL AX, 1           ; *2, since disp. memory alternates ASCii/color
    MOV DX, AX          ; save into DX

    LDS SI, SS:[BP+10]  ; get source memory into DS:SI
    PUSH SI             ; save it for later

; ====== Setup to write the 16 bytes of ASCii first
    MOV AH, SS:[BP+8]   ; get attribute into AH
    MOV DI, DX          ; move start of row offset into DI
    MOV BX, SS:[BP+14]  ; get offset of ASCii
    DEC BX
    SHL BX, 1           ; *2 because of vid. mem.
    ADD DI, BX          ; compute final offset
    CMP WORD PTR [BP+6], 0       ; filter on?
    JNE FilterOn

REPT 16                ; repeat 16 times
    LODSB               ; get byte
    STOSW               ; store byte + attribute
ENDM
    JMP SHORT Continue
EVEN
FilterOn:
    MOV CX, 16
    MOV BX, '~ '        ; preload constants
EVEN
FilterTop:
    LODSB
    CMP AL, BL          ; below 32?
    JL NoShow
    CMP AL, BH          ; more than 127
    JG NoShow
    STOSW
    LOOP FilterTop
    JMP SHORT Continue
EVEN
NoShow:
    MOV AL,FilterReplaceChar
    STOSW
    LOOP FilterTop

; ======= Set up for HEX conversion to screen
Continue:
    MOV BX, SS:[BP+16]  ; get offset of HEX
    DEC BX
    SHL BX, 1           ; *2 for vid. mem
    ADD DX, BX          ; add to original row offset
    MOV DI, DX          ; put it into the index register
    POP SI              ; get previous SI
    MOV CX, 16          ; do sixteen characters

    MOV BL, AH          ; attribute into BL
    MOV DX, (256*9) + ('A'-'9'-1) 
    MOV BP, '00'        ; preload stuff to make it scream

; BP = '00'
; BL = attribute
; BH = -- reserved for temporary digit
; DL = 'A'-'9'-1
; DH = 9
EVEN
LoopTop:
    MOV BH, 16          ; load divisor
    LODSB               ; get character
    MOV AH, 0           ; clear AH
    DIV BH              ; to get tens in AL, ones in AH.
    CMP AL, DH          ; > '9'?
    JLE NextDigit       ; no -- don't fix
EVEN
    ADD AL, DL          ; fix it
NextDigit:
    CMP AH, DH          ; > '9'?
    JLE WriteOut        ; no -- don't fix
    ADD AH, DL          ; fix it
WriteOut:
    ADD AX, BP          ; add '00' to digits to make them ASCii
    MOV BH, AH          ; save ones digit for next character
    MOV AH, BL          ; get attribute
    STOSW               ; write digit
    MOV AL, BH          ; get next
    STOSW               ; write
    MOV AL, ' '         ; write space
    STOSW
    CMP CX, 9           ; between the 8th and 9th HEX digits
    JE AddSpace
    LOOP LoopTop
    JMP SHORT OttaHere
EVEN
AddSpace: STOSW
    LOOP LoopTop

OttaHere:
    POP DI              ; restore registers
    POP SI
    POP DS
    POP BP
    RET 16              ; shave off 16 bytes of passed in parameters
SuperHex ENDP

MemCopy PROC FAR
    PUSH BP
    MOV BP, SP          ; set up stack frame
    PUSH DS
    PUSH SI
    PUSH DI

    CLD
    MOV CX, [BP+6]      ; # to copy in CX
    LES DI, [BP+8]      ; get dest.
    LDS SI, [BP+12]     ; get source

    SHR CX, 1           ; odd byte
    JNC CopyStart
    MOVSB
CopyStart: REP MOVSW    ; do copy

    POP DI
    POP SI
    POP DS
    POP BP
    RET 10
MemCopy ENDP

Scroll PROC FAR
    PUSH BP
    MOV BP, SP      ; set up stack frame

; BP+8 = MoveUp?   BP+6 = attribute

    MOV BH, [BP+6]  ; load up attribute
    MOV AX, 0601h   ; 1 line
    CMP BYTE PTR [BP+8], 0    ; zero?
    JE Down        ; yes; go up
    INC AH          ; go down (AX=0701)
Down:
    MOV CX, 0202h   ; (3,3) top left
    MOV DX, 0164Ch  ; (23,77) bottom right
    INT 010h        ; call vid. interrupt
    POP BP
    RET 4
Scroll ENDP
    CODE ENDS
END
