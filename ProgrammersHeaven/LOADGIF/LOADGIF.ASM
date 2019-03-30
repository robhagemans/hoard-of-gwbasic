;LOADGIF.ASM v1.0 - Optimized GIF Loader for EGA and VGA Video Modes
;By Rich Geldreich, Jr.
;Last Modified August 20, 1993
;Assembled with TASM v2.0

IDEAL
MODEL SMALL

;-------------------------------------------------------------------------------
MACRO           PushaMacro
                Push    ax
                Push    bx
                Push    cx
                Push    dx
                Push    si
                Push    di
                Push    bp
ENDM            PushaMacro
;-------------------------------------------------------------------------------
MACRO           PopaMacro
                Pop     bp
                Pop     di
                Pop     si
                Pop     dx
                Pop     cx
                Pop     bx
                Pop     ax
ENDM            PopaMacro
;-------------------------------------------------------------------------------
;This equate specifies the size the disk I/O buffer.
;Make sure it's at least 1024 or so bytes long.
DiskIOSize      = 8192
;-------------------------------------------------------------------------------
RP              = 0
;-------------------------------------------------------------------------------
;I/O Control.
BufferOffset    = RP
RP = RP + 2
BufferLeft      = RP
RP = RP + 2
BufferHandle    = RP
RP = RP + 2
EOFFlag         = RP
RP = RP + 2
;-------------------------------------------------------------------------------
;GIF Decoding & Image Size.
TotalX          = RP
RP = RP + 2
TotalY          = RP
RP = RP + 2
NumColors       = RP
RP = RP + 2
XStart          = RP
RP = RP + 2
YStart          = RP
RP = RP + 2
XLength         = RP
RP = RP + 2
YLength         = RP
RP = RP + 2
XEnd            = RP
RP = RP + 2
YEnd            = RP
RP = RP + 2
X               = RP
RP = RP + 2
Y               = RP
RP = RP + 2
;-------------------------------------------------------------------------------
;View window & Upper left hand corner of GIF image.
XOrg            = RP
RP = RP + 2
YOrg            = RP
RP = RP + 2
X0              = RP
RP = RP + 2
Y0              = RP
RP = RP + 2
X1              = RP
RP = RP + 2
Y1              = RP
RP = RP + 2
;-------------------------------------------------------------------------------
;Hardware parameters.
VidColors       = RP
RP = RP + 2
Handler         = RP
RP = RP + 2
ScrOffset       = RP
RP = RP + 2
ScrWidth        = RP
RP = RP + 2
ScrX            = RP
RP = RP + 2
ScrY            = RP
RP = RP + 2
PixsLeft        = RP
RP = RP + 2
AdapterType     = RP
RP = RP + 2
PalIgnore       = RP
RP = RP + 2
;-------------------------------------------------------------------------------
;LZW Decompression.
PassNumber      = RP
RP = RP + 2
PassStep        = RP
RP = RP + 2
Background      = RP
RP = RP + 2
NoPalette       = RP
RP = RP + 2
Interlaced      = RP
RP = RP + 2
FirstCode       = RP
RP = RP + 2
StartCode       = RP
RP = RP + 2
StartMaxCode    = RP
RP = RP + 2
NextCode        = RP
RP = RP + 2
LastCode        = RP
RP = RP + 2
LastPixel       = RP
RP = RP + 2
StartCodeMask   = RP
RP = RP + 2
StartCodeSize   = RP
RP = RP + 2
;-------------------------------------------------------------------------------
;Scanline buffer. A maximum of 1536 pixels per scanline should be enough.
LineBuffer      = RP
RP = RP + 1536
;-------------------------------------------------------------------------------
;LZW string tables. The Suffix table MUST come directly before Prefix in memory!
Suffix          = RP
RP = RP + 4096*2
Prefix          = RP
RP = RP + 4096*2
PStack          = RP
RP = RP + 4096+128
;-------------------------------------------------------------------------------
;GIF's palette.
Palette         = RP
RP = RP + 768
;-------------------------------------------------------------------------------
;Disk I/O buffer.
RP = RP + 16
DiskBuffer      = RP
RP = RP + DiskIOSize
;-------------------------------------------------------------------------------
;For 16 color pixel plotting.
Plane0          = RP
RP = RP + 80
Plane1          = RP
RP = RP + 80
Plane2          = RP
RP = RP + 80
Plane3          = RP
RP = RP + 80
;-------------------------------------------------------------------------------
;The value of RP here determines how much memory the function requires.
;-------------------------------------------------------------------------------
SEGMENT         GIFCODE PARA PUBLIC 'CODE'
;-------------------------------------------------------------------------------
ASSUME          DS:@DATA, ES:@DATA, CS:GIFCODE, SS:@DATA
;-------------------------------------------------------------------------------
;In ERROR.ASM
EXTRN           ErrorCode:WORD
EXTRN           Hook24:NEAR, Unhook24:NEAR, CheckError:NEAR
;-------------------------------------------------------------------------------
PUBLIC          LoadGIF
PROC            LoadGIF

;Stack organization.
MemPointer      EQU     [ss:bp+42]
FileSeg         EQU     [ss:bp+40]
FileOfs         EQU     [ss:bp+38]

PScrType        EQU     [ss:bp+36]
PScrOffset      EQU     [ss:bp+34]
PScrWidth       EQU     [ss:bp+32]
PXRes           EQU     [ss:bp+30]
PYRes           EQU     [ss:bp+28]

PX0             EQU     [ss:bp+26]
PY0             EQU     [ss:bp+24]
PX1             EQU     [ss:bp+22]
PY1             EQU     [ss:bp+20]
PXOrg           EQU     [ss:bp+18]
PYOrg           EQU     [ss:bp+16]

PAdapterType    EQU     [ss:bp+14]
PPalIgnore      EQU     [ss:bp+12]

PPalSeg         EQU     [ss:bp+10]
PPalOfs         EQU     [ss:bp+08]
PPalColors      EQU     [ss:bp+06]

Parameters      = 19

                Cld
                Push    bp
                Mov     bp, sp
                Push    ds es si di

                Call    Hook24          ;Install critical error handler.

                Mov     ax, MemPointer
                Mov     ds, ax
                Mov     es, ax

                Call    Init            ;Fetch passed parameters.
                Jc      @@OpenError

                Call    CheckOpts       ;Check passed window coordinates.
                Jc      @@NothingToDo

                Call    IOOpen          ;Open GIF file.
                Jc      @@OpenError

                Call    IOReadInit      ;Initialize disk I/O buffer.
                Jc      @@Error

                Call    GetGIFHeader    ;Fetch GIF sig, tables, etc.
                Jc      @@Error

                Call    SetPalette      ;Set GIF's palette.

                Call    DecodeGIF       ;Decompress GIF.
                Jc      @@Error

                Xor     ax, ax          ;No error.

@@Exit0:        Push    ax
                Call    IOClose         ;Close input file.
                Pop     ax

@@Exit1:        Call    Unhook24        ;Uninstall critical error handler.
                Cld
                Pop     di si es ds bp
                Retf    Parameters*2

@@Error:        Mov     ax, -1
                Jmp     @@Exit0
@@OpenError:    Mov     ax, -1
                Jmp     @@Exit1
@@NothingToDo:  Xor     ax, ax
                Jmp     @@Exit1
ENDP            LoadGIF
;-------------------------------------------------------------------------------
PROC            Init
;---------------
;Clear work space.
                Xor     ax, ax

                Mov     di, offset BufferOffset
                Mov     cx, RP                  ;Clear memory block.

                Shr     cx, 1
                Rep     Stosw
                Rcl     cx, 1
                Rep     Stosb
;---------------
;Fetch & check passed parameters from stack.
                Mov     ax, PScrType
                Cmp     ax, 2
                Ja      @@Error1

                Mov     bx, offset WPIX1        ;assume mode 13
                Mov     cx, 256

                And     ax, ax
                Jnz     @@10

                Mov     bx, offset WPIX0        ;16 color modes
                Mov     cx, 16
@@10:
                Cmp     al, 2
                Jne     @@20
                Mov     bx, offset WPIX2        ;mode-x
@@20:
                Mov     [ds:Handler], bx
                Mov     [ds:VidColors], cx

                Mov     ax, PScrOffset
                Mov     [ds:ScrOffset], ax

                Mov     ax, PScrWidth
                Mov     [ds:ScrWidth], ax

                Mov     ax, PXRes
                Mov     [ds:ScrX], ax

                Mov     ax, PYRes
                Mov     [ds:ScrY], ax

                Mov     ax, PAdapterType
                Cmp     ax, 1
                Ja      @@Error2

                And     ax, ax
                Jnz     @@VGAPal
                Cmp     [word ds:VidColors], 16
                Ja      @@Error2

@@VGAPal:       Mov     [byte ds:AdapterType], al

                Mov     al, PPalIgnore
                Mov     [byte ds:PalIgnore], al

                Clc
                Ret

@@Error1:       Mov     [cs:ErrorCode], -6      ;Bad Screen type.
                Stc
                Ret
@@Error2:       Mov     [cs:ErrorCode], -7      ;Bad adapter type.
                Stc
                Ret
ENDP            Init
;-------------------------------------------------------------------------------
;Clip view window to screen boundry.
PROC            CheckOpts
                Mov     ax, PXOrg
                Mov     [ds:XOrg], ax
                Mov     ax, PYOrg
                Mov     [ds:YOrg], ax

                Mov     ax, PX0
                Mov     bx, PY0
                Mov     cx, PX1
                Mov     dx, PY1

                Cmp     ax, cx
                Jle     @@XOk
                Xchg    ax, cx
@@XOk:
                Cmp     bx, dx
                Jle     @@YOk
                Xchg    bx, dx
@@YOk:
                And     cx, cx
                Jl      @@ByeBye
                Cmp     ax, [ds:ScrX]
                Jg      @@ByeBye

                And     dx, dx
                Jl      @@ByeBye
                Cmp     bx, [ds:ScrY]
                Jg      @@ByeBye

                And     ax, ax
                Jnl     @@XOk1
                Xor     ax, ax
@@XOk1:
                And     bx, bx
                Jnl     @@YOk1
                Xor     bx, bx
@@YOk1:
                Cmp     cx, [ds:ScrX]
                Jng     @@XOk2
                Mov     cx, [ds:ScrX]
@@XOk2:
                Cmp     dx, [ds:ScrY]
                Jng     @@YOk2
                Mov     dx, [ds:ScrY]
@@YOk2:
                Mov     [ds:X0], ax
                Mov     [ds:Y0], bx
                Mov     [ds:X1], cx
                Mov     [ds:Y1], dx

                Clc
                Ret

@@ByeBye:       Stc                             ;Exit if GIF invisible.
                Ret
ENDP            CheckOpts
;-------------------------------------------------------------------------------
;Refresh disk input buffer.
PROC            IOReadInit
                PushaMacro
                Mov     cx, DiskIOSize
                Mov     ah, 03Fh
                Mov     bx, [ds:BufferHandle]
                Mov     dx, offset DiskBuffer
                Mov     [ds:BufferOffset], dx
                Int     021h
                Mov     [ds:BufferLeft], ax
                Call    CheckError
                Pushf
                Mov     [byte ds:EOFFlag], 0
                And     ax, ax
                Jnz     @@Exit
                Mov     [byte ds:EOFFlag], -1
@@Exit:         Popf
                PopaMacro
                Mov     si, offset DiskBuffer
                Ret
ENDP            IOReadInit
;-------------------------------------------------------------------------------
;Open input file.
PROC            IOOpen
                Push    ds
                Mov     ds, FileSeg
                Mov     dx, FileOfs
                Mov     ax, 03D00h
                Int     021h
                Pop     ds
                Mov     [ds:BufferHandle], ax
                Call    CheckError
                Ret
ENDP            IOOpen
;-------------------------------------------------------------------------------
;Close input file.
PROC            IOClose
                Mov     ax, 03E00h
                Mov     bx, [ds:BufferHandle]
                Int     021h
                Call    CheckError
                Ret
ENDP            IOClose
;-------------------------------------------------------------------------------
;Read one byte from input file(not used in main LZW decode loop).
ALIGN 4
PROC            IOReadByte
                Xchg    si, [ds:BufferOffset]
                Xor     ax, ax
                Lodsb
                Xchg    [ds:BufferOffset], si

                Dec     [word ds:BufferLeft]
                Jz      @@Refresh
                Ret
@@Refresh:      Push    si
                Call    IOReadInit
                Pop     si
                Ret
ENDP            IOReadByte
;-------------------------------------------------------------------------------
;Read one word from input file.
PROC            IOReadWord
                Push    bx
                Call    IOReadByte
                Push    ax
                Call    IOReadByte
                Pop     bx
                Mov     ah, al
                Mov     al, bl
                Pop     bx
                Ret
ENDP            IOReadWord
;-------------------------------------------------------------------------------
;Fetch GIF sig, header, and find first image.
PROC            GetGIFHeader
                Call    CheckGIFHeader
                Jc      @@Exit

                Call    GetScreenDescriptor
                Jc      @@Exit

                Call    GetImageDescriptor

@@Exit:         Ret
ENDP            GetGIFHeader
;-------------------------------------------------------------------------------
;Check for the string "GIF" at the beginning of the file. The version number,
;usually "87a" or "89a", is ignored.
PROC            CheckGIFHeader
                Call    IOReadWord
                Cmp     ax, 'G'+'I'*256
                Jne     @@BadHeader

                Call    IOReadByte
                Cmp     al, 'F'
                Jne     @@BadHeader

                Call    IOReadWord      ;skip GIF version #
                Call    IOReadByte

                Clc
                Ret

@@BadHeader:    Mov     [word cs:ErrorCode], -3
                Stc
                Ret
ENDP            CheckGIFHeader
;-------------------------------------------------------------------------------
;Fetch screen descriptor. Exits if GIF image has too many colors for
;the given video mode.
PROC            GetScreenDescriptor
                Call    IOReadWord
                Mov     [ds:TotalX], ax
                Call    IOReadWord
                Mov     [ds:TotalY], ax

                Call    IOReadByte
                Mov     cl, al
                And     al, 128
                Jnz     @@Palette
                Mov     [byte ds:NoPalette], -1
@@Palette:      And     cl, 7
                Inc     cl
                Mov     ax, 1
                Shl     ax, cl
                Mov     [ds:NumColors], ax

                Cmp     ax, [ds:VidColors]
                Ja      @@BadDescriptor

                Mov     bx, PPalColors ;store # colors
                Cmp     [byte ds:NoPalette], -1
                Jne     @@05
                Neg     ax
@@05:           Mov     [ss:bx], ax

                Call    IOReadByte
                Mov     [byte ds:Background], al

                Call    IOReadByte

                Cmp     [byte ds:NoPalette], -1
                Je      @@NoPalette

                Mov     cx, [ds:NumColors]
                Mov     di, offset Palette
@@10:           REPT    3                       ;Fetch palette
                Call    IOReadByte
                Stosb
                ENDM
                Loop    @@10

                Cmp     PPalSeg, cx
                Je      @@NoPalette

                Push    es
                Les     di, PPalOfs
                Mov     si, offset Palette
                Mov     cx, [ds:NumColors]
                Mov     ax, cx
                Shl     cx, 1
                Add     cx, ax
                Rep     Movsb
                Pop     es

@@NoPalette:    Clc
                Ret

@@BadDescriptor:
                Mov     [word cs:ErrorCode], -4
                Stc
                Ret
ENDP            GetScreenDescriptor
;-------------------------------------------------------------------------------
;Find first image. Ignores all GIF extensions.
PROC            GetImageDescriptor

@@05:           Call    IOReadByte
                Cmp     al, 44
                Je      @@Found

                Cmp     al, 33
                Jne     @@BadImageDescriptor
                Call    IOReadByte

@@10:           Call    IOReadByte
                Mov     cx, ax
                Jcxz    @@05
@@20:           Call    IOReadByte
                Loop    @@20
                Jmp     @@10
@@Found:
                Call    IOReadWord
                Add     ax, offset LineBuffer
                Mov     [ds:XStart], ax
                Call    IOReadWord
                Mov     [ds:YStart], ax

                Call    IOReadWord
                Mov     [ds:XLength], ax
                Add     ax, [ds:XStart]
                Cmp     ax, 1536+offset LineBuffer ;If GIF is larger than 1536
                Ja      @@BadImageDescriptor       ;pixels per scanline then
                Mov     [ds:XEnd], ax              ;exit.

                Call    IOReadWord
                Mov     [ds:YLength], ax
                Add     ax, [ds:YStart]
                Mov     [ds:YEnd], ax

                Call    IOReadByte
                Test    al, 128
                Jnz     @@BadImageDescriptor

                Test    al, 64
                Jz      @@NotInterlaced
                Mov     [byte ds:Interlaced], -1   ;Initialize vars needed
                Mov     [byte ds:PassNumber], 0    ;for interlaced GIF's.
                Mov     [byte ds:PassStep], 8
@@NotInterlaced:
                Clc
                Ret
@@BadImageDescriptor:
                Mov     [word cs:ErrorCode], -5
                Stc
                Ret
ENDP            GetImageDescriptor
;-------------------------------------------------------------------------------
PROC            DecodeGIF
                Call    InitDecode              ;Setup SM code.
                Call    Decode                  ;Decompress LZW data stream.
                Ret
ENDP            DecodeGIF
;-------------------------------------------------------------------------------
PROC            Decode
                ;Read # bytes left in this block.
                Call    IOReadByte
                Mov     bp, ax                  ;BP always holds bytes left in
                Mov     si, [ds:BufferOffset]   ;current block.
                Mov     [byte ds:si-1], 0
                Jmp     @@MainLoop
;-------------------------------------------------------------------------------
@@ClearCode:    Je      @@Done
                Mov     ax, [ds:FirstCode]      ;Clear code received, reset
                Mov     [ds:NextCode], ax       ;tables.
                Mov     ax, [ds:StartCodeSize]
                Mov     [byte cs:CodeSizeA], al
                Mov     ax, [ds:StartMaxCode]
                Mov     [word cs:MaxCode], ax
                Mov     ax, [ds:StartCodeMask]
                Mov     [word cs:CodeMaskA1], ax
                Mov     [word cs:CodeMaskA2], ax

                Call    GetCode1                ;Get next code as a special
                Mov     [ds:LastCode], dx       ;case.
                Shr     dx, 1
                Mov     [ds:LastPixel], dx

                Mov     di, [ds:X]
                Xchg    ax, dx
                Stosb
                Cmp     di, [ds:XEnd]
                Jne     @@NoFlush

                Call    FlushLine
                Jnc     @@NoFlush
@@Done:         Clc
                Ret
@@NoFlush:      Mov     [ds:X], di
                Jmp     short @@MainLoop
;-------------------------------------------------------------------------------
@@CodeError:    Mov     [word cs:ErrorCode], -2         ;Bad LZW code received,
                Stc                                     ;exit.
                Ret

@@Check:        Ja      @@CodeError
                Mov     di, offset PStack+4095
                Std
                Mov     al, [byte ds:LastPixel]
                Stosb
                Mov     si, [ds:LastCode]
                Jmp     @@CheckBack
;--------------- Standard LZW decoding algorithm
ALIGN 4
@@MainLoop:     Call    GetCode1                        ;Fetch LZW code.
                Mov     si, dx

                Cmp     dx, [ds:NextCode]               ;Not in table?
                Jae     @@Check

ClearCode       =       $+2
                Sub     dx, 09999h                      ;Clear code or EOF code?
                Cmp     dx, 02h
                Jbe     @@ClearCode
;---------------
                Mov     di, offset PStack+4095
                Std

FirstCde        =       $+2
@@CheckBack:    Cmp     si, 09999h
                Jb      @@Char

                Add     si, offset Suffix
                Mov     bx, 8192+1
CompareCode     =       $+1
                Mov     dx, 09999h

@@PushLoop:     REPT 14
                Movsb                                   ;Decode string
                Mov     si, [ds:si+bx]
                Cmp     si, dx
                Jnae    @@PLDone
                ENDM
                Movsb
                Mov     si, [ds:si+bx]
                Cmp     si, dx
                Jae     @@PushLoop
ALIGN 4
@@PLDone:       Sub     si, offset Suffix
;---------------
@@Char:         Mov     ax, si
                Shr     ax, 1
                Mov     [ds:LastPixel], ax
                Stosb
                Cld

                Mov     bx, offset PStack+4095
                Sub     bx, di
                Mov     si, di
                Inc     si
                Mov     di, [ds:X]

@@SlowCopy:     Mov     cx, [ds:XEnd]
                Sub     cx, di
                Cmp     cx, bx
                Jbe     @@Ok
                Mov     cx, bx
@@Ok:
                Sub     bx, cx
                Rep     Movsb

                Cmp     di, [ds:XEnd]
                Je      @@GoNextLine

@@GotNextLine:  And     bx, bx
                Jnz     @@SlowCopy

                Mov     [ds:X], di

                ;Update dictionary
                Mov     ax, [ds:LastPixel]
                Mov     bx, [ds:NextCode]
                Cmp     bx, 4096*2                      ;Dictionary filled?
                Jae     @@GoRound
                Mov     si, [ds:LastCode]
                Add     si, offset Suffix
                Mov     [ds:bx+offset Prefix], si
                Mov     [ds:bx+offset Suffix], ax
                Inc     bx
                Inc     bx
MaxCode         =       $+2
                Cmp     bx, 09999h
                Je      @@IncCode
@@Inced:        Mov     [ds:NextCode], bx

@@GoRound:
Code            =       $+4
                Mov     [word ds:LastCode], 09999h
                Jmp     @@MainLoop
;-------------------------------------------------------------------------------
@@GoNextLine:   Call    FlushLine
                Jnc     @@GotNextLine
                Clc
                Ret
;-------------------------------------------------------------------------------
;Increment LZW code size.
@@IncCode:      Cmp     [byte cs:CodeSizeA], 12
                Jae     @@Inced
                Inc     [byte cs:CodeSizeA]
                Shl     [word cs:MaxCode], 1
                Shl     [word cs:CodeMaskA1],1
                Inc     [word cs:CodeMaskA1]
                Shl     [word cs:CodeMaskA2],1
                Inc     [word cs:CodeMaskA2]
                Jmp     @@Inced
;-------------------------------------------------------------------------------
ENDP            Decode
;-------------------------------------------------------------------------------
PROC            FlushLine
                Cld
                Push    es
                PushaMacro

                Call    WPIX

                Mov     ax, [ds:Y]

                Cmp     [byte ds:Interlaced], 0
                Jne     @@Interlaced

                Inc     ax
                Mov     bx, ax
                Add     bx, [ds:YOrg]
                Cmp     bx, [ds:Y1]
                Jg      @@Done

                Clc
@@Return:       Mov     [ds:Y], ax
                PopaMacro
                Pop     es
                Mov     di, [ds:XStart]
                Ret

@@Done:         Stc
                Jmp     @@Return
;---------------
@@Interlaced:   Add     ax, [ds:PassStep]
                Cmp     ax, [ds:YEnd]
                Jnge    @@N

                Inc     [word ds:PassNumber]
                Mov     bl, [byte ds:PassNumber]
                Cmp     bl, 1
                Jne     @@10
                Mov     ax, 4
                Mov     [byte ds:PassStep], 8
                Jmp     @@N
@@10:           Cmp     bl, 2
                Jne     @@20
                Mov     ax, 2
                Mov     [byte ds:PassStep], 4
                Jmp     @@N
@@20:           Cmp     bl, 3
                Jne     @@N
                Mov     ax, 1
                Mov     [byte ds:PassStep], 2

@@N:            Clc
                Jmp     @@Return
ENDP            FlushLine
;-------------------------------------------------------------------------------
PROC            SetPalette
                Cmp     [byte ds:PalIgnore], 0 ;Ignore palette flag.
                Jne     @@Exit
                Cmp     [byte ds:NoPalette], 0 ;No palette in GIF?
                Jne     @@Exit

                Mov     cx, [ds:NumColors]
                Mov     si, offset Palette
                Xor     bx, bx

                Cmp     [byte ds:AdapterType], 1        ;VGA palette?
                Je      @@VGAPalette

;---------------
@@EGAPalette:   Xor     bh, bh                          ;Make EGA palette.
                Lodsb
                Test    al, 128
                Jz      @@10
                Or      bh, 4
@@10:           Test    al, 64
                Jz      @@20
                Or      bh, 32
@@20:           Lodsb
                Test    al, 128
                Jz      @@30
                Or      bh, 2
@@30:           Test    al, 64
                Jz      @@40
                Or      bh, 16
@@40:           Lodsb
                Test    al, 128
                Jz      @@50
                Or      bh, 1
@@50:           Test    al, 64
                Jz      @@60
                Or      bh, 8
@@60:           Mov     ax, 01000h
                Int     010h
                Inc     bx
                Loop    @@EGAPalette
@@Exit:         Ret
;---------------
@@VGAPalette:   Mov     dx, si

                Push    cx
                Mov     ax, cx
                Shl     cx, 1
                Add     cx, ax
                Mov     di, si
@@70:           Lodsb
                Shr     al, 1
                Shr     al, 1
                Stosb
                Loop    @@70
                Pop     cx

                Mov     ax, 01012h
                Int     010h
                Ret
ENDP            SetPalette
;-------------------------------------------------------------------------------
;This subroutine clips each line to the view window's edges and then
;calls lower level functions to plot the pixels onto the screen.
ALIGN 4
Skip:           Ret
ALIGN 4
PROC            WPIX

                Mov     ax, [ds:Y]
                Add     ax, [ds:YOrg]
                Cmp     ax, [ds:Y0]
                Jl      Skip
                Cmp     ax, [ds:Y1]
                Jg      Skip

                Mov     di, [ds:XStart]
                Mov     dx, [ds:XEnd]

                Mov     si, di
                Sub     di, offset LineBuffer
                Sub     dx, offset LineBuffer+1
                Add     di, [ds:XOrg]
                Add     dx, [ds:XOrg]

;di = physical image start X
;dx = physical image end X

                Mov     bp, [ds:X0]
                Mov     bx, [ds:X1]

                Cmp     di, bx  ;IF startx>x1 THEN exit
                Jg      Skip
                Cmp     dx, bp
                Jl      Skip    ;IF endx<x0 THEN exit

                Cmp     di, bp
                Jge     @@NoClipLowX
                Sub     di, bp
                Sub     si, di
                Mov     di, bp
@@NoClipLowX:
                Cmp     dx, bx
                Jle     @@NoClipHighX
                Mov     dx, bx
@@NoClipHighX:

                Mov     cx, dx
                Sub     cx, di
                Inc     cx

                Jmp     [word ds:Handler]

ENDP            WPIX
;-------------------------------------------------------------------------------
;Fast pixel plotter for 16 color modes. (Boy do I hate this thing!)
MACRO           SepPlanes
                Lodsb
                Shr     al, 1
                Rcl     bl, 1
                Shr     al, 1
                Rcl     bh, 1
                Shr     al, 1
                Rcl     dl, 1
                Shr     al, 1
                Rcl     dh, 1
ENDM

MACRO           SepPlanes2
                Lodsw
                Shr     al, 1
                Rcl     bl, 1
                Shr     al, 1
                Rcl     bh, 1
                Shr     al, 1
                Rcl     cl, 1
                Shr     al, 1
                Rcl     ch, 1

                Shr     ah, 1
                Rcl     bl, 1
                Shr     ah, 1
                Rcl     bh, 1
                Shr     ah, 1
                Rcl     cl, 1
                Shr     ah, 1
                Rcl     ch, 1
ENDM

PROC            WPIX0
                Mov     bp, cx

                Push    es 0A000h
                Pop     es

                Mul     [word ds:ScrWidth]
                Add     ax, [ds:ScrOffset]

                Xchg    ax, di
                Mov     cx, ax
                Shr     ax, 1
                Shr     ax, 1
                Shr     ax, 1
                Add     di, ax

                Mov     [ds:PixsLeft], bp

                Mov     dx, 03C4h
                Mov     al, 2
                Out     dx, al

                Mov     dl, 0CEh
                Mov     al, 8
                Out     dx, al
;-------------------------------------------------------------------------------
                And     cx, 7
                Jz      @@ByteAligned

                Neg     cx
                Add     cx, 8

                Xor     bx, bx
                Mov     dx, bx
                Mov     ah, 0ffh
ALIGN 4
@@EG1:          SepPlanes
                Shl     ah, 1
                Dec     bp
                Loopnz  @@EG1
                Shl     bx, cl
                Shl     dx, cl
                Rol     ah, cl
                Mov     [ds:PixsLeft], bp

                Mov     bp, dx
                Mov     dx, 03CFh
                Mov     al, ah
                Not     al
                Out     dx, al
                Mov     dl, 0C5h
                Mov     al, [es:di]

                Mov     al, 1
                Out     dx, al
                Mov     [es:di], bl
                Shl     al, 1
                Out     dx, al
                Mov     [es:di], bh
                Shl     al, 1
                Out     dx, al
                Mov     bx, bp
                Mov     [es:di], bl
                Shl     al, 1
                Out     dx, al
                Mov     [es:di], bh

                Mov     dl, 0CFh
                Mov     al, 0FFh
                Out     dx, al

                Inc     di
;-------------------------------------------------------------------------------
ALIGN 4
@@ByteAligned:  Mov     bp, [ds:PixsLeft]
                Shr     bp, 1
                Shr     bp, 1
                Shr     bp, 1
                And     bp, bp
                Jnz     @@DoRuns
                Jmp     @@NoRuns
ALIGN 4
@@DoRuns:       Push    di
                Mov     di, offset Plane0
                Mov     ax, ds
                Mov     es, ax

                Shr     bp, 1
                Jnc     @@EG2
                Inc     bp
                Jmp     @@Middle
ALIGN 4
@@EG2:
REPT    4
                SepPlanes2
ENDM
                Mov     [ds:di+80*1], bh
                Mov     [ds:di+80*2], cl
                Mov     [ds:di+80*3], ch
                Mov     al, bl
                Stosb
@@Middle:
REPT    4
                SepPlanes2
ENDM
                Mov     [ds:di+80*1], bh
                Mov     [ds:di+80*2], cl
                Mov     [ds:di+80*3], ch
                Mov     al, bl
                Stosb

                Dec     bp
                Jz      @@AllDone
                Jmp     @@EG2
ALIGN 4
@@AllDone:      Mov     cx, di
                Pop     di

                Mov     ax, 0A000h
                Mov     es, ax

                Push    si
                Mov     si, offset Plane0
                Sub     cx, si
                Mov     dx, 03C5h
                Mov     al, 1
                Mov     bp, 4

@@10:           Out     dx, al
                Push    si di cx
                Shr     cx, 1
                Rep     Movsw
                Rcl     cx, 1
                Rep     Movsb
                Pop     cx di si
                Shl     al, 1
                Add     si, 80
                Dec     bp
                Jnz     @@10
                Add     di, cx
                Pop     si
;-------------------------------------------------------------------------------
@@NoRuns:       Mov     cx, [ds:PixsLeft]
                And     cx, 7
                Jz      @@Exit
                Mov     bp, 03C5h

                Xor     bx, bx
                Mov     dx, bx

                Mov     ah, 0FFh
                Shl     ah, cl

                Push    cx
ALIGN 4
@@EG3:          SepPlanes
                Loop    @@EG3
                Pop     cx

                Neg     cl
                Add     cl, 8
                Shl     bx, cl
                Shl     dx, cl
                Rol     ah, cl

                Xchg    bp, dx
                Mov     dl, 0CFh
                Mov     al, ah
                Not     al
                Out     dx, al
                Mov     dl, 0C5h
                Mov     al, [es:di]

                Mov     al, 1
                Out     dx, al
                Mov     [es:di], bl
                Shl     al, 1
                Out     dx, al
                Mov     [es:di], bh
                Shl     al, 1
                Out     dx, al
                Mov     bx, bp
                Mov     [es:di], bl
                Shl     al, 1
                Out     dx, al
                Mov     [es:di], bh

                Mov     dl, 0CFh
                Mov     al, 0FFh
                Out     dx, al

@@Exit:         Mov     dx, 03C5h
                Mov     al, 0Fh
                Out     dx, al

                Pop     es
                Ret

ENDP            WPIX0
;-------------------------------------------------------------------------------
;Pixel plotter for screen 13.
PROC            WPIX1
                Push    es

                Mov     dx, 0A000h
                Mov     es, dx

                Mul     [word ds:ScrWidth]
                Add     ax, [ds:ScrOffset]
                Add     di, ax

                Shr     cx, 1
                Rep     Movsw
                Rcl     cx, 1
                Rep     Movsb

                Pop     es
                Ret
ENDP            WPIX1
;-------------------------------------------------------------------------------
;Pixel plotter for MODEX.
PROC            WPIX2
                Push    es
                Mov     dx, 0A000h
                Mov     es, dx

                Push    cx
                Mul     [word ds:ScrWidth]
                Add     ax, [ds:ScrOffset]

                Mov     cx, di
                Shr     di, 1
                Shr     di, 1
                Add     di, ax

                Mov     dx, 03C4h
                Mov     al, 2
                Out     dx, al
                Dec     ax
                And     cl, 3
                Shl     al, cl

                Pop     cx
                Mov     bp, 4

@@10:           Mov     dx, 03C5h
                Out     dx, al

                Push    si di cx

                Add     cx, 3
                Shr     cx, 1
                Shr     cx, 1

                Mov     dx, cx
                Shr     cx, 1
                Shr     cx, 1
                Shr     cx, 1
                Inc     cx

                And     dx, 7
                Mov     bx, dx
                Shl     dx, 1
                Add     dx, bx
                Neg     dx
                Add     dx, offset @@20
                Mov     bx, 3
                Jmp     dx

ALIGN 4
@@30:           REPT    8
                Movsb
                Add     si, bx
                ENDM
@@20:           Loop    @@30
@@40:           Pop     cx di si
                Inc     si

                Shl     al, 1
                Cmp     al, 16
                Je      @@Sp1

                Dec     bp
                Loopnz  @@10

                Pop     es
                Ret

@@Sp1:          Inc     di
                Mov     al, 1
                Dec     bp
                Loopnz  @@10
                Pop     es
                Ret

ENDP            WPIX2
;-------------------------------------------------------------------------------
ALIGN 4
PROC            GetCode1
BitsInA         = $+1
CodeSizeA       = $+2
                Mov     cx, 09999h
                Mov     si, [ds:BufferOffset]
                Xor     dx, dx
                Mov     dl, [ds:si-1]

                Shl     dx, cl
                Mov     dl, dh
                Xor     dh, dh

                Cmp     ch, cl
                Jna     @@NoMore

@@10:           Lodsb
                Dec     bp
                Jz      @@FillBlock
@@30:           Xor     ah, ah
                Shl     ax, cl
                Or      dx, ax
                Add     cl, 8
                Cmp     ch, cl
                Ja      @@NeedMore
                Mov     [ds:BufferOffset], si

@@NoMore:       Sub     cl, ch
                Mov     [byte cs:BitsInA], cl
CodeMaskA1      =       $+2
                And     dx, 09999h
                Shl     dx, 1
                Mov     [word cs:Code], dx
                Ret
;-------------------------------------------------------------------------------
ALIGN 4
@@NeedMore:     Lodsb
                Dec     bp
                Jz      @@FillBlock1
@@70:           Xor     ah, ah
                Shl     ax, cl
                Or      dx, ax
                Add     cl, 8

                Mov     [ds:BufferOffset], si

                Sub     cl, ch
                Mov     [byte cs:BitsInA], cl
CodeMaskA2      =       $+2
                And     dx, 09999h
                Shl     dx, 1
                Mov     [word cs:Code], dx
                Ret
;-------------------------------------------------------------------------------
ALIGN 4
@@FillBlock1:   Xchg    ax, bp
                Xor     ax, ax
                Lodsb
                Xchg    ax, bp
                Mov     [byte ds:si-1], al
                Cmp     si, offset DiskBuffer+(DiskIOSize-768)
                Jnae    @@70
                Call    IOReadFill
                Mov     [byte ds:si-1], al
                Jmp     @@70
;-------------------------------------------------------------------------------
ALIGN 4
@@FillBlock:    Xchg    ax, bp
                Xor     ax, ax
                Lodsb
                Xchg    ax, bp
                Mov     [byte ds:si-1], al
@@Check:        Cmp     si, offset DiskBuffer+(DiskIOSize-768)
                Jnae    @@30
                Call    IOReadFill
                Mov     [byte ds:si-1], al
                Jmp     @@30
;-------------------------------------------------------------------------------
ENDP            GetCode1
;-------------------------------------------------------------------------------
PROC            IOReadFill
                PushaMacro

                Mov     cx, offset DiskBuffer+DiskIOSize
                Sub     cx, si
                Mov     di, offset DiskBuffer
                Mov     [ds:BufferOffset], di

                Push    cx
                Jcxz    @@NoCopy
                Test    si, 1
                Jz      @@Skip
                Movsb
                Dec     cx
@@Skip:         Shr     cx, 1
                Rep     Movsw
                Rcl     cx, 1
                Rep     Movsb
@@NoCopy:       Pop     ax
                Mov     dx, di

                Mov     cx, DiskIOSize
                Sub     cx, ax

                Mov     [ds:BufferLeft], ax

                Mov     ah, 03Fh
                Mov     bx, [ds:BufferHandle]
                Int     021h
                Call    CheckError

                Add     [ds:BufferLeft], ax
                Mov     [byte ds:EOFFlag], 0
                Cmp     [word ds:BufferLeft], 0
                Jnz     @@Exit
                Mov     [byte ds:EOFFlag], -1
@@Exit:
                PopaMacro
                Cmp     [byte ds:EOFFlag], 0
                Jne     @@GoStopDecode
                Cmp     [word cs:ErrorCode], 0
                Jne     @@GoStopDecode
                Mov     si, [ds:BufferOffset]
                Ret
;-------------------------------------------------------------------------------
@@GoStopDecode: Pop     ax
                Pop     ax
                Cmp     [byte ds:EOFFlag], 0
                Je      @@NOEOFInStream
                Mov     [word cs:ErrorCode], -1
@@NOEOFInStream:
                Stc
                Ret
ENDP            IOReadFill
;-------------------------------------------------------------------------------
PROC            InitDecode

                ;Fetch LZW starting code size.
                Call    IOReadByte
                Mov     cl, al
                Inc     cl
                Mov     [byte ds:StartCodeSize], cl
                Mov     [byte cs:CodeSizeA], cl

                Mov     bx, 1
                Shl     bx, cl

                Mov     ax, bx
                Dec     ax
                Mov     [ds:StartCodeMask], ax
                Mov     [word cs:CodeMaskA1], ax
                Mov     [word cs:CodeMaskA2], ax
                Inc     ax
                Shl     ax, 1
                Mov     [ds:StartMaxCode], ax
                Mov     [word cs:MaxCode], ax

                Mov     [word cs:ClearCode], bx
                Add     bx, 4
                Mov     [ds:FirstCode], bx
                Mov     [word cs:FirstCde], bx
                Mov     [ds:NextCode], bx
                Add     bx, offset Suffix
                Mov     [word cs:CompareCode], bx

                Xor     ax, ax
                Mov     [byte cs:BitsInA], al

                Mov     ax, [ds:YStart]
                Mov     [ds:Y], ax

                Mov     ax, [ds:XStart]
                Mov     [ds:X], ax

                Clc
                Ret
ENDP            InitDecode
;-------------------------------------------------------------------------------
;Returns the number of 16 byte pages required by the LoadGIF function.
PUBLIC          LoadGIFMem
PROC            LoadGIFMem
P               =       0
                Mov     ax, ((RP+15)/16)+1 ;round up
                Retf    P*2
ENDP            LoadGIFMem
;-------------------------------------------------------------------------------
ENDS            GIFCODE
;-------------------------------------------------------------------------------
END

