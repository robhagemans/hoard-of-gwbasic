' SCRLEN.MOO -- demonstration of inline ASM

' Displays information on the current screen mode.


'       3CEh index  6  (r/W): Graphics: Miscellaneous Register
'         bit 0  Indicates Graphics Mode if set, Alphanumeric mode else.
'             1  Enables Odd/Even mode if set.
'           2-3  Memory Mapping:
'                  0: use A000h-BFFFh
'                  1: use A000h-AFFFh   EGA/VGA Graphics modes
'                  2: use B000h-B7FFh   Monochrome modes
'                  3: use B800h-BFFFh   CGA modes

@                mov  dx,3ceh
@                mov  al,6
@                out  dx,al
@                inc  dl
@                in   al,dx
@                shr  al,1
@                shr  al,1
@                and  al,03h
@                mov  bl,al
@                xor  bh,bh
@                add  bx,bx
@                mov  ax,word ptr cs:[seglist+bx]    ; get value from table
@                mov  word ptr ds:[screenseg%],ax    ; store value to
@                                                    ; screenseg%

print "Screen segment is : 0" + hex16(screenseg%) + "h"
rows% = mget(84h, 40h)
rows% = rows% and 0ffh + 1    ' Rows
mode% = mget(49h, 40h)
mode% = mode% and 0ffh        ' Current screen mode
print "\nScreen mode is    : " + mode%
print "\nScreen length is  : " + rows%
end

@seglist         dw 0a000h,0a000h,0b000h,0b800h
' Screen segment data
