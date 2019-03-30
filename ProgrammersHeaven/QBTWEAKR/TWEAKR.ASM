;   QBTWEAKR.ASM By Rich Geldreich 1992
;   For QuickBASIC 4.5 or PDS 7.1
;
;   Plays  simple,   8-bit digitized sounds over the PC-Speaker.   No
;   bells.   No whistles.   Have  fun.    This  code  is in the public
;   domain.  It's yours now!  All I ask is that you give credit where
;   credit is due.   Assembled with TASM v2.00 - should also assemble
;   with  MASM 4.00 too(that's all I had to test it out with, sorry)...
;
;   Notes: My play interrupt does not call the original interrupt 08h
;   routine every 18.206 times a second,  therefore,  the BIOS  clock
;   will  stop  dead while you're playing sounds.   It doesn't matter
;   what you set the main interrupt rate to; samples will always play
;   at the same  frequency.    The  main  difference  is quality;  an
;   interrupt  rate  of  18,000hz  sounds  much,   much  better  than
;   10,000hz,  of course.   Many functions could  be  added  to  this
;   program,  such as volume,  echo,  2 or more channels,  etc.   The
;   program  as-is  only  plays signed samples,  if you play a sample
;   which seems  distorted,   try  unsigning  it(or reassembling this
;   program, see the interrupt procedure).   That's all for now.   If
;   you find any bugs,  tell me about them and I'll do my best to fix
;   'em.
;
;   I've also included the small QB program that made the  pc-speaker
;   translation  table.    (This  program  can be easily modified for
;   other devices,  such as an 8-bit  DAC on a printer port,  or even
;   the Adlib.)
;
;Functions provided:
;
;TweakOn freq%
; Captures  interrupt  08h,   the  18.206hz  timer  click  interrupt.
; Reprograms the 8253 timer chip  to  whatever  frequency  passed  by
; freq%  (in  hertz).    You'll  should hear a little click from your
; speaker when you call  this  function.    (Valid range for freq% is
; 1-40000.)
;
;TweakOff
;
; Frees interrupt 08h,  and reprograms the timer back to what it used
; to be.   You must do this before your program ends!  (Actually, you
; don't because QB and PDS restore the vector to interrupt 08h.  It's
; best to be safe, though. You should always call this function before
; you start editing your program in the environment, just in case...)
;
;PlaySound Offset%, Segment%, Length%, Frequency%
; Plays a sample  at  a  "virtual"  frequency  over  the  pc-speaker.
; Offset%,   Segment%,  & Length% specify the location of a sample in
; memory.   Frequency%  specifies  the  frequency(in  hertz) that the
; sample will be played at.   (Note:  if you  set  interrupt  08h  to
; 10,000hz,   and  you play a sample at 20,000hz,  exactly 1/2 of the
; samples will be skipped,  so it will sound like 20khz.   All of the
; frequencies above the interrupt  rate  will  be adjusted similar to
; this...)
;
; TweakStatus () Function
;  Returns -1 if sample is playing. Returns 0 if a sample is not.
;
; Stuff you can't do while using this driver:
;  
;  I've tested this program in the environment,  and it seems to work
;  fine,  although I still don't recommend that you let the interrupt
;  go while editing your program!!    For instance,  if you edit your
;  program and make it smaller,  while my interrupt is going,  QB may
;  try to move memory around and my  play  interrupt  may  crash  and
;  burn.    One  thing  though:   QB and PDS disable interrupts while
;  you're in the editor.  This causes distortion in the sound because
;  my interrupt doesn't get all of  the time it deserves.   You can't
;  use the SOUND, PLAY, or SLEEP commands, because they use interrupt
;  08h for timing.   You can't SHELL to  dos,   because  QB  restores
;  interrupt 08h before going under.   In other words:  Don't use any
;  commands that leach off interrupt 08h!  I don't recommend that you
;  access any mass-storage devices  while  playing samples, doing  so 
;  may cause distortion.
;
; All of these routines were derived from my QB .MOD player,  which I
; will (hopefully) be releasing soon.
; 
; (Another last minute  note: Be  carefull using this  program in the 
; environment,  if you  press  ctrl+break and  the interrupt is still 
; going,  go to the immediate window and type "TweakOff".  Also  note  
; that the interrupt routine can still be going even though  it isn't
; producing any sound! Use caution!)
;
; And finally, here's what I need:  
;  If anybody has got an  assembly  routine that emulates QB's "PLAY"
;  command,  please let me know if you're willing to share it.    I'm
;  making  an ANSI emulator in assembly,  and it would be great if it
;  supported ANSI music.   I'd make it myself,  but I just don't have
;  the time these days...  Thanks!
  

public TweakOn, TweakOff, PlaySound, TweakStatus

cseg segment para public 'CODE'
        assume cs:cseg, es:nothing, ds:nothing

;Notice this is the first byte of the driver. When you press SHIFT+F5 to
;to run in the environment, I believe QB copies the original .QLB file
;overtop of the old one(or something similar to that). If this does actually
;happen, and my play interrupt is in progress, all hell could break loose.
;Putting this flag first should protect against that (?)...
EndFlag         db 0
even
;Enables the driver.
TweakOn proc far
        Push    bp
        Mov     bp, sp
        Push    ds
        Push    si                      ; si & di probably don't need to be
        Push    di                      ; preserved for QB, but what the hell!

        Mov     ax, cs
        Mov     ds, ax

        Mov     ax, 3508h               ; Get interrupt 08h vector in es:bx
        Int     021h

        Mov     dx, offset NewInterrupt

        Cmp     bx, dx                  ; Has it already been changed?
        Jne     NotInstalled            ; Nope
        Mov     ax, cs                  ; Check the segment
        Mov     cx, es
        Cmp     ax, cx                  ; Compare the segments
        Je      ExitTweakOn             ; If same then exit
        Even
NotInstalled:
        Mov     cx, [ss:bp+06]          ; Get interrupt rate
        Cmp     cx, 40000               ; < 1 or > 40000 ?
        Ja      ExitTweakOn
        And     cx, cx
        Jz      ExitTweakOn

        Mov     [ds:EndFlag], 0         ; Make sure interrupt doesn't play
        Mov     [ds:IFreq], cx          ; Save interrupt frequency for later
        Mov     [ds:OldOfs], bx         ; Save original interrupt 08h vector
        Mov     [ds:OldSeg], es

        cli                             ; Disable interrupts

        Mov     ax, 02508h              ; Change interrupt 08h vector to my
        Int     021h                    ; routine

        Mov     al, 00110110b           ; Reprogram the 8253 timer chip
        Out     043h, al

        ;Masm 4.00 didn't like this:
        ;Mov     dx, 1193180 shr 16      
        ;Mov     ax, 1193180 and 0FFFFh  

        Mov     dx, 012h                 ; Find the correct delay value:
        Mov     ax, 034DCh               ; Delay = 1193180/Frequency
        Div     cx

        Out     040h, al                ; Send it
        Mov     al, ah
        Out     040h, al

        In      al, 061h                ; Turn on PC-Speaker
        Or      al, 3
        Out     061h, al
        Mov     al, 128+32+16           ; Reprogram high & low bytes to 0
        Out     043h, al
        Xor     al, al
        Out     042h, al
        Out     042h, al
        Mov     al, 128+16              ; Tell 8253 we only want to change the
        Out     043h,al                 ; low byte for now on

        sti                             ; Let it lose!

ExitTweakOn:
        Pop     di                      ; Pop regs and exit to QB
        Pop     si
        Pop     ds
        Pop     bp

        ret     2
TweakOn endp
; This is the PC-Speaker translation table. A simple XLAT statement
; will translate an 8-bit signed sample into the correct delay value
; for the 8253 timer. (See MAKESIGN.BAS to see how this table was made.)
TweakTable:
db 32,31,30,29,28,27,26,25,24,24,23,23,22,22,21,21,21,20,20,20,19,19,19
db 18,18,18,18,17,17,17,17,16,16,16,16,15,15,15,15,14,14,14,14,14,13,13
db 13,13,13,12,12,12,12,12,11,11,11,11,11,11,10,10,10,10,10,10,9,9,9,9
db 9,9,8,8,8,8,8,8,7,7,7,7,7,7,7,6,6,6,6,6,6,6,5,5,5,5,5,5,5,4,4,4,4,4
db 4,4,3,3,3,3,3,3,3,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,65,65,65,65,65,65,65
db 64,64,64,64,64,64,64,63,63,63,63,63,63,63,62,62,62,62,62,62,62,61,61
db 61,61,61,61,61,60,60,60,60,60,60,60,59,59,59,59,59,59,59,58,58,58,58
db 58,58,57,57,57,57,57,57,56,56,56,56,56,56,55,55,55,55,55,55,54,54,54
db 54,54,53,53,53,53,53,52,52,52,52,52,51,51,51,51,50,50,50,50,49,49,49
db 49,48,48,48,48,47,47,47,46,46,46,45,45,45,44,44,43,43,42,42,41,40,39
db 38,37,36,35,34,33
Even

IFreq           dw 65535                ; Original interrupt rate
OldOfs          dw 0                    ; Old interrupt vector
OldSeg          dw 0

SampleOffset    dw 0                    ; Current offset
SampleSegment   dw 0                    ; Current segment
SampleEnd       dw 0                    ; End of sample
StepRate        dw 0                    ; Step rate of sample, actually Step/256
OffsetRemainder db 0                    ; Current offset remainder

Even
NewInterrupt proc far
        Push    ax                      ; Save ax
        Cmp     [cs:endflag], 0ffh      ; Any samples to play?
        Je      SamplesLeft             ; Yup.
        Mov     al, 020h                ; Send End of Interrupt command
        Out     020h, al
        Pop     ax                      ; Restore ax
        Iret                            ; Return to original program
        Even
SamplesLeft:                            ; Samples are left
        Push    ds                      ; Preserve what we use
        Push    es
        Push    si
        Push    bx

        Mov     ax, cs                              ; Set ds to cs
        Mov     ds, ax
        Les     si, dword ptr [ds:SampleOffset]     ; Get current offset:segment
        Mov     bx, offset TweakTable               ; Prepare to translate
        Mov     al, [es:si]                         ; Get sample
 
; Add this statement to play unsigned samples!!

        ;Add     al, 128

        Xlat                                        ; Translate sample
        Out     042h, al                            ; Send it to the 8253

        Xor     ax, ax                              ; Add the step rate to the
        Mov     bx, [ds:StepRate]                   ; offset
        Add     [ds:OffsetRemainder], bl            ; Adjust the remainder
        Mov     al, bh                              ; Add whole portion+carry
        Adc     si, ax
        Mov     [ds:SampleOffset], si               ; Save it

        Cmp     si, [ds:SampleEnd]                  ; Are we too far?
        Jae     EndOfSample                         ; Yup.
ExitInterrupt:
        Pop     bx                                  ; Pop all regs and return
        Pop     si
        Pop     es
        Pop     ds

        Mov     al, 020h
        Out     020h, al
        Pop     ax
        Iret
        Even
EndOfSample:                                        ; No more samples left
        Mov     [ds:EndFlag], ah                    ; Fix flag
        Jmp     short ExitInterrupt                 ; Jump back
NewInterrupt endp
Even
PlaySound proc far                                  ; Lets the interrupt
                                                    ; play a sample
;Stack frame...
;PlaySound Offset%, Segment%, Length%, Frequency%
;             12         10       8      6

        Push    bp
        Mov     bp, sp
        Push    ds
        Push    si
        Push    di

        Mov     ax, cs
        Mov     ds, ax

        Mov     ax, [ss:bp+06]          ; Frequency in range?
        Cmp     ax, 40000
        Ja      ExitPlaySound           ; Nope
        And     ax, ax
        Jz      ExitPlaySound           ; Nope

        Xor     dx, dx                  ; Multiply frequency by 256
        Mov     dl, ah                  ; (shift it left 8 places)
        Mov     ah, al
        Mov     al, dh

        Div     [ds:Ifreq]              ; Divide it by the interrupt rate
                                        ; to find the step rate(which will
                                        ; actually be multiplied by 256)
        Cli                             ; Turn off interrupts
        Mov     [ds:StepRate], ax       ; Save the step rate

        Mov     bx, [ss:bp+12]          ; Save the offset and segment of sample
        Mov     [ds:SampleOffset], bx
        Mov     ax, [ss:bp+10]
        Mov     [ds:SampleSegment], ax
        Add     bx, [ss:bp+8]
        Mov     [ds:SampleEnd], bx      ; Save the end of the sample

        Mov     [ds:OffsetRemainder], 0 ; Clear the remainder
        Mov     [ds:EndFlag], 0ffh      ; Let it rip!
        Sti

ExitPlaySound:
        Pop     di
        Pop     si
        Pop     ds
        Pop     bp
        Ret     8
PlaySound endp
Even
TweakOff proc far                       ; Disables the driver.
        Push    ds

        Mov     ax, 03508h              ; Check to make sure the interrupt
        Int     021h                    ; 08h vector is pointing to my routine

        Cmp     bx, offset NewInterrupt
        Jne     AlreadyChanged          ; Nope
        Mov     ax, cs
        Mov     ds, ax                  ; ds = cs
        Mov     bx, es
        Cmp     ax, bx
        Jne     AlreadyChanged          ; Nope

        Cli                             ; Disable interrupts

        Mov     al, 00110110b           ; Reprogram the timer to 18.206hz
        Out     043h, al
        Xor     al, al
        Out     040h, al
        Out     040h, al

        Lds     dx, dword ptr [ds:OldOfs]   ; restore the old vector
        Mov     ax, 02508h
        Int     021h

        Sti                             ; Let the interrupts go

        In      al, 061h                ; Turn the speaker off
        And     al, NOT 03h             ; (should this be "And  al, 254" ?)
        Out     061h, al

AlreadyChanged:
        Pop     ds                      ; All done or interrupt 08h vector
        Ret     0                       ; isn't pointing to our routine
TweakOff endp
even
TweakStatus proc far                    ; Checks the state of the sample
        Mov     al, [cs:EndFlag]        ; Get flag
        Cbw                             ; Make it a word
        Ret     0                       ; Exit
TweakStatus endp
cseg ends
end
