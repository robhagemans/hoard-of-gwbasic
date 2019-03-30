  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~
                             THE BASIX FANZINE
                          Edited by  Peter Cooper
                                 Issue 7
  _____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~-----_____-----~~~~~

                         peco@trenham.demon.co.uk

  INTRODUCTION:

        More delays, sorry.  Two reasons, one, I am now manager of a new web
  design company which has absorbed much of my free time. The second... this
  is the worst reason. I wiped my hard disk and lost.. new submissions. Very
  sorry to all of you who sent in submissions.  It was a big system upgrade,
  I  can promise this won't happen again,  I now have a new backup system in
  place.  :) So please feel free to send in submissions, they will be backed
  up!

  Anyway, this has taken a long time, so sorry. I know it's no excuse, I will
  try to be more punctual in future.

  Cheers, =)

  Peter Cooper

=============================================================================
=
                                Contents Page
=============================================================================
=

 SECTION ONE) - Specialized Articles
  - Part [a] Series
    1) Coderz Series    More more more effects and stuff   QBasic+
    2) CDROM Series     Last part of CD Series-play a cd   QkBasic,VBDOS,PDS

  - Part [b] Topics and Articles
    1) NEW Wav Playr'   *New* DMA WAV player, =)           QBasic+

 SECTION TWO) - General Articles
    1) Useful sources   Places to get basic stuff on inet  Various
    2) Fandex           Back Issues-See what you missed!!  N/A

 SECTION THREE) - The Public Zone 
    1) Letters          Your comments and questions        Various
    2) Your programs    All of your programs.. here!       Various
    3) The Lighter Side Humor, Newsgroups, all here =)     N/A

 SECTION FOUR) - Administration and Usual Stuff
    1) Latest developments from Fanzine
    2) How do you contribute?
    3) Credits
    4) Last words + next month

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++
- SECTION ONE ---------------------------------------------------------------
--
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++

 Specialized articles:
_____________________________________________________________________________
_
| SECTION 1 PART A SUBPART 1 | Coderz Series Part 2 |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Coderz Series Part 2:
        Welcome back! Well this issue I'm going to go into how to create yet
 more effects for any possible demos you might be writing. Just some simple
 effects this issue, you need a break after last weeks indepth view into Sine
 waves!

The STATIC Effect:

        The STATIC effect is fairly convincing, although there is a little
 patterning which distinguishes it from a standard TVs effect. The standard
 TV static effect requires quite a lot of speed (unless you use a good
 randomising algorithm and fast graphics drawing) so using standard QBASIC
 commands will not do. This zine doesnt promote source that only works with
 the help of libraries so how can we do it fast, in QBASIC?

 Simple, we draw a random pattern of grey dots onto the screen once then we
 use some palette cycling to simulate the effect of the pixel color changing
 every time. If we do this fast enough it looks roughly like a standard
 static effect. So how exactly do we go about this.. Well here's the steps
 of the program:

  --> create 15 shades of grey from black to white

  --> draw a random pattern of these fifteen shades to the screen

  --> cycle the palette!  15 to 14   14 to 13   1 to 15  etc.....

 It's that simple, so simple the code doesnt need much explanation except
 the comments written in!

SCREEN 13

' Loop creates grey shades in colors 1 to 15

FOR c% = 1 TO 15
OUT &H3C8, c%
OUT &H3C9, (c% * 3) + 2
OUT &H3C9, (c% * 3) + 2
OUT &H3C9, (c% * 3) + 2
NEXT c%

' Draw random color (1-15) to each pixel on screen

FOR x% = 1 TO 320
FOR y% = 1 TO 200
c% = INT((15 - 1 + 1) * RND + 1)
PSET (x%, y%), c%
NEXT y%
NEXT x%
SLEEP

' Read in palette values and cycle round

DO
OUT &H3C7, 1
tr% = INP(&H3C9)
tg% = INP(&H3C9)
tb% = INP(&H3C9)
FOR t% = 2 TO 15
OUT &H3C7, t%
r% = INP(&H3C9)
g% = INP(&H3C9)
b% = INP(&H3C9)
OUT &H3C8, t% - 1
OUT &H3C9, r%
OUT &H3C9, g%
OUT &H3C9, b%
NEXT t%
OUT &H3C8, 15
OUT &H3C9, tr%
OUT &H3C9, tg%
OUT &H3C9, tb%

' Wait for vertical retrace so that no flickering occurs

WAIT &H3DA, 8
WAIT &H3DA, 8, 8
LOOP


WAV Playing:

 Sound effects and noises are a large part of demos, if you want to be able
 to  play  a  wave  sound  through your soundcard then we have a _fast_ WAV
 all here for you to use!
 It is in Section 1b1. :)


Please request what you would like to see in the coders section and we will
endeavour to find BASIC code to do it! We need your suggestions! =)

Cheers, (oh lameness...)
_____________________________________________________________________________
_
| SECTION 1 PART A SUBPART 2 | CD Programming Part 3 |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Part 3:  Getting Information About the Audio-CD

Hi!

I'm back! In the third part of the guide we are going to get some info 
about the Audio-CD which is hopefully inserted at this point. Actually, it
doesn't really matter whether you have an audio cd in the drive or not. So,
another WARNING at this point: NEVER EVER try to play DATA CD's with this 
program! I have never tried it, since others have warned me, so I'll just
pass
this warning along to you.

If you remember the last piece of code we wrote RESET the drive. Well, that's
nice isn't it, especially since it is so useful and impressive (I hope you 
catch the sarcasm). So ... what are we gonna do now? We have two more things
to do in order to play the entire disk: Determine the total playtime and 
instruct the drive to play all sectors from 0 to the lead-out track (end) of 
the CD. Oh, an IMPORTANT note: Whenever you have to DETERMINE something, you
use IOCTL INPUT and sometimes when you INSTRUCT the drive to do something, 
you use IOCTL OUTPUT. Remember when we reset the drive, we instructed the 
drive to perform an action, so we used IOCTL OUTPUT. The way we address these 
I/O functions is by modifying the request header command code field. In the 
reset code we used 12, which tells the driver to use OUTPUT. Since there are 
many instructions you can output to the drive (EJECT uses OUTPUT), we needed 
another control block to give the driver some extra info. The next routine 
will READ information from the drive in drv%. So we will use IOCTL INPUT
which 
is command code 3 in the request header. Compare the Reset and DiskInfo 
routines if you don't understand what I am talking about. This particular 
routine will need a buffer of 7 bytes where we put our information. This is 
also termed  the control block, since the first byte, cb(0), gives the driver 
instructions. In our routine cb(0) will be 10, which will return the lowest 
track number, highest track number and the location of the lead-out track
(end 
of CD). The code looks very similar to the reset routine. 

'Get DiskInfo
REDIM cb(6) AS STRING * 1     'We will resize our arrays, which sets them 
REDIM rh(25) AS STRING * 1    'also equal to zero

'Declare the contents we want in the buffer after the call
cb(0) = CHR$(10)     'Control block code: 10 is DiskInfo

'Construct our request header! Notice that the only differences are in rh(2)
'and rh(19)
rh(0) = CHR$(26)        'Length of request header in bytes
rh(2) = CHR$(3)         'Request header command code field: 3 is IOCTL Input
rh(14) = CHR$(lbyte%(VARPTR(cb(0))))   'The next four lines reference the
rh(15) = CHR$(hbyte%(VARPTR(cb(0))))   'address of our control block
rh(16) = CHR$(lbyte%(VARSEG(cb(0))))
rh(17) = CHR$(hbyte%(VARSEG(cb(0))))
rh(18) = CHR$(0)                       'Number of bytes to transfer;Highbyte
rh(19) = CHR$(7)                       'Number of bytes to transfer;Lowbyte
'Call interrupt again
inregsx.ax = &H1510
inregsx.es = VARSEG(rh(0))
inregsx.bx = VARPTR(rh(0))
inregsx.cx = drv%
CALL interruptx(&H2F, inregsx, outregsx)
'Looky here! Our control block now contains data!
CDEndMin = ASC(cb(5))
CDEndSec = ASC(cb(4))
CDEndFrm = ASC(cb(3))
'CDLength is the length of the CD in High Sierra sectors the formula for
'computing it is:
CDLength = CDEndMin * 60 * 75 + CDEndSec * 75 + CDEndFrm - 150
PRINT "Total Playtime of CD: "; CDEndMin; ":"; CDEndSec; "."; CDEndFrm

Oh, the lowest track number is in cb(1) and the highest track number in
cb(2).
Now we are ready to play the entire disk. I guess since the PLAY function is
used quite a bit, Microsoft gave it its own command code for the request
header, which is 132. The following routine does the play thing. It takes a
transfer mode value in rh(13). I used High Sierra format, since we will have
to use sectors to specify the playing time. Well...Here's the code.

' Play Audio
REDIM rh(21) AS STRING * 1          'Redimension our request header
rh(0) = CHR$(22)                    'Give it's length in bytes
rh(2) = CHR$(132)                   'Command code for PLAY
rh(13) = CHR$(0)                    'Transfer Mode (0 HSG/1 RBA)
rh(14) = CHR$(0)                    'Start Address
rh(15) = CHR$(0)                    'Start Address
rh(16) = CHR$(0)                    'Start Address
rh(17) = CHR$(0)                    'Start Address
rh(18) = CHR$((CDLength MOD 256))         'Number of Sectors to play
rh(19) = CHR$((CDLength MOD 65536) \ 256) 'Number of Sectors to play
rh(20) = CHR$(CDLength \ 65536)           'Number of Sectors to play
rh(21) = CHR$(&H0)                        'Number of Sectors to play
'Call our interrupt
inregsx.ax = &H1510
inregsx.es = VARSEG(rh(0))
inregsx.bx = VARPTR(rh(0))
inregsx.cx = drv%
CALL interruptx(&H2F, inregsx, outregsx)
END

That's it! A short note: If you want to start later in the disk you have to
decrease the length to play. For example, if you would want to start playing
at sector 150 (2 seconds) you would have to decrease the number of sectors to
play by 150. If you have reached this point of the guide and pretty much 
understand everything, I urge you to go get MSCDEX21.ZIP of the internet. The
documentation might confuse you at first, but look up the functions which I
discussed in the guide and you'll figure it out. Now, nothing can stop you!
Hope hearing from you, Marco Koegler (marco@umr.edu)!

_____________________________________________________________________________
_
| SECTION 1 PART B SUBPART 1 | New Kewl WAV Player! |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        A brand new DMA based WAV player written by Ken Rockot, (email in
 top comments of code. A super fast WAV player.  Enjoy!


'********************************************
'*                DMAWAV.BAS                *
'*              by Ken Rockot               *
'*  Insane7773@aol.com, Rockotman@juno.com  *
'********************************************
'NOTE: This program was tested with a Creative Labs Sound Blaster 16
'      on my 486 DX/2 running at 66MHz.  This is by far the FASTEST WAV
'      player for QBasic that I have seen.  Unlike other WAV players for
'      QBasic which can play WAVs too slow, because this uses DMA, it can
'      play WAVs too fast if you set the frequency too high (Most
'      commonly 11000, 22000, or 41000Hz).
'ANOTHER NOTE: You need to have an environment variable called BLASTER
'that 
'              tells what DMA and Base Address your SB is on.  Most Sound
'              Blasters' drivers set this in the AUTOEXEC.BAT
'automatically.
'YET ANOTHER NOTE:  You may receive the 'DSP failed to reset' error.  If
'this
'                   happens, run the program again.  I don't know why,
'but
'                   it usually doesn't work the first time.

DEFINT A-Z   'Sets all variables to integers unless specified otherwise
DECLARE SUB LoadWAV (File$)
DECLARE FUNCTION ResetDSP ()
DECLARE SUB OutDSP (Byte)
DECLARE FUNCTION ReadDSP ()
DECLARE FUNCTION DSPVersion! ()
DECLARE SUB PlayWAV (Segment&, Offset&, Length&, Frequency&)
DECLARE FUNCTION PlayDone ()
DECLARE SUB ReadBLASTER ()
DIM SHARED BaseAdd, DMA, LenPort, Length&      ' Set vars to shared so we
'can
DIM SHARED WaveBuffer(0) AS STRING * 32767      ' use in different subs
CLS
ReadBLASTER         'Read the BLASTER environment variable
rd = ResetDSP
IF ResetDSP THEN    'Reset DSP (Success = -1, Failure = 0)
        PRINT "DSP reset successfully."
ELSE
        PRINT "DSP failed to reset"
        END
END IF
INPUT "Enter filename: ", File$                 'Get user input for a WAV
'file
INPUT "Enter frequency: ", Frequency&           'Get input for frequency
LoadWAV File$
OUT BaseAdd + 12, &HD1                         'Turn on speakers
DO
        PlayWAV VARSEG(WaveBuffer(0)), VARPTR(WaveBuffer(0)), Length&,
Frequency&
        DO
        COLOR INT(RND * 15) + 1         'Print crap in colors
        PRINT "Looping WAV in the background while performing other
functions."
        LOOP UNTIL PlayDone                     'Loop until WAV is
LOOP UNTIL INKEY$ = CHR$(27)                    'Play the WAV over and
OUT BaseAdd + 12, &HD3                         'Turn off speakers

FUNCTION DSPVersion!
OutDSP &HE1     'Function to get DSP Version
A = ReadDSP     'High byte
B = ReadDSP     'Low byte
DSPVersion! = VAL(STR$(A) + "." + STR$(B))  'Set DSPVersion!
END FUNCTION

SUB LoadWAV (File$)
WaveBuffer(0) = ""          'Clear the WAV buffer
OPEN File$ FOR BINARY AS #1 'Open the WAV file
IF LOF(1) = 0 THEN CLOSE #1: KILL File$: PRINT "Non-existant file!": END
GET #1, 44, WaveBuffer(0)                       'Skip 44 bytes (file
'header)
Length& = LOF(1) - 44                           'Store the length of the
'WAV
IF Length& > 32766 THEN Length& = 32766         'Truncate the WAV
CLOSE #1                    'Close the file
END SUB

SUB OutDSP (Byte)
DO
LOOP WHILE INP(BaseAdd + 12) AND &H80      'Loop until we get an OK byte
OUT BaseAdd + 12, Byte         'Set a byte to the SB input register
END SUB

FUNCTION PlayDone
A = INP(LenPort)        '\___ Read two bytes from the length port
B = INP(LenPort)        '/
Count& = CLNG(A + 1) * CLNG(B + 1)            '\____ Check to see if it's
'done
IF (Count& - 1) >= &HFFFF& THEN PlayDone = -1 '/
END FUNCTION

SUB PlayWAV (Segment&, Offset&, Length&, Frequency&)
MemLoc& = Segment& * 16 + Offset&   'Area in memory of WAV buffer
Page = 0                            'DMA page to use
SELECT CASE DMA                     'Depending on DMA set vars to values
        CASE 0
                PgPort = &H87       'Set port to send page data to
                AddPort = &H0       'Set port to send memory address to
                LenPort = &H1       'Set port to send length to
                ModeReg = &H48      'Set mode to play in
        CASE 1
                PgPort = &H83
                AddPort = &H2
                LenPort = &H3
                ModeReg = &H49
        CASE 2
                PgPort = &H81
                AddPort = &H4
                LenPort = &H5
                ModeReg = &H4A
        CASE 3
                PgPort = &H82
                AddPort = &H6
                LenPort = &H7
                ModeReg = &H4B
        CASE ELSE
                PRINT "This program only supports DMA Channels 0-3."
                END
END SELECT
OUT &HA, &H4 + DMA              ' Send all
OUT &HC, 0                      ' the crap to
OUT &HB, ModeReg                ' the ports.
OUT AddPort, MemLoc& AND &HFF   ' More crap sending
OUT AddPort, (MemLoc& AND &HFFFF&) \ &H100 ' Yet more
IF (MemLoc& AND 65536) THEN Page = Page + 1     ' Set
IF (MemLoc& AND 131072) THEN Page = Page + 2    ' the
IF (MemLoc& AND 262144) THEN Page = Page + 4    ' correct
IF (MemLoc& AND 524288) THEN Page = Page + 8    ' memory page.
OUT PgPort, Page    ' Send page data
OUT LenPort, Length& AND &HFF               ' Send length
OUT LenPort, (Length& AND &HFFFF&) \ &H100  ' data
OUT &HA, DMA    ' Send DMA port
IF Frequency& < 23000 THEN
        TimeConst = 256 - 1000000 \ Frequency&  ' Set the freqency
        OutDSP &H40                             ' Byte to send frequency
        OutDSP TimeConst                        ' Send frequency
        OutDSP &H14                             ' Byte to send length
        OutDSP (Length& AND &HFF)               ' Send
        OutDSP ((Length& AND &HFFFF&) \ &H100)  ' length
ELSE
        IF DSPVersion! >= 3 THEN        ' If they got the right DMA to
'fast
 TimeConst = ((65536 - 256000000 \ Frequency&) AND &HFFFF&) \ &H100
                OutDSP &H40
                OutDSP TimeConst
                OutDSP (Length& AND &HFF)
                OutDSP ((Length& AND &HFFFF&) \ &H100)
        ELSE
                PRINT "You must have a DSP Version of 3.00 or greater to "
PRINT "use a high frequency."
                END
        END IF
END IF
END SUB

SUB ReadBLASTER
B$ = ENVIRON$("BLASTER")            'Get the BLASTER variable
IF B$ = "" THEN PRINT "BLASTER environment variable not found!": END
'Darn!
FOR X = 1 TO LEN(B$)            ' Basically simple crap to read the
'variable
        T$ = MID$(B$, X, 1)
        Y = X + 1
        SELECT CASE T$
                CASE "A"
                DO
                        Tp$ = MID$(B$, Y, 1)
                        IF Tp$ = " " THEN EXIT DO
                        Addr$ = Addr$ + Tp$
                        Y = Y + 1
                LOOP
                BaseAdd = VAL("&H" + Addr$)
                Tp$ = ""
                CASE "D"
                DO
                        Tp$ = MID$(B$, Y, 1)
                        IF Tp$ = " " THEN EXIT DO
                        DMAC$ = DMAC$ + Tp$
                        Y = Y + 1
                LOOP
                DMA = VAL(DMAC$)
                Tp$ = ""
        END SELECT
NEXT X
END SUB

FUNCTION ReadDSP
DO
LOOP UNTIL INP(BaseAdd + 14) AND &H80 ' If it's okay...
ReadDSP = INP(BaseAdd + 10)           ' Read a byte from the SB port
END FUNCTION

FUNCTION ResetDSP
OUT BaseAdd + 6, 1         ' Send byte to reset
FOR I = 1 TO 4              ' Read crap
   Temp = INP(BaseAdd + 6)
NEXT I
OUT BaseAdd + 6, 0         ' Send 'Done' byte
A = INP(BaseAdd + 14)      ' Read prototype byte
IF INP(BaseAdd + 14) AND &H80 = &H80 AND INP(BaseAdd + 10) = &HAA THEN
'Reset
   ResetDSP = -1
ELSE
   ResetDSP = 0
END IF
END FUNCTION

=)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++
- SECTION TWO ---------------------------------------------------------------
--
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++

 All levels articles:

 This is where general BASIC info is presented. People of different levels
 (novice,advanced etc) can use information in this section to their benefit.
_____________________________________________________________________________
_
| SECTION 2 SUBPART 1 | Useful Resources on the net!!! |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=============================================================================
 The Games Programmers Encyclopedia
  ftp://x2ftp.oulu.fi/pub/msdos/programming/gpe
=============================================================================
 Nemesis NetIndex (The way to find pages) (a quick plug! => )
  http://www.trenham.demon.co.uk/
=============================================================================
 Blood225s FTP Site
  ftp://users.aol.com/blood225/
=============================================================================
 Simtel
  ftp://src.doc.ic.ac.uk/pub/packages/simtel/msdos/
 Simtel-net
  ftp://ftp.simtel.net/
=============================================================================
 Programmers References Site-Finland
  ftp://x2ftp.oulu.fi/pub/msdos/programming
   - documentations of techniques -        /docs
   - information on formats -              /formats
   - games programmers encyclopedia -      /gpe
   - excellent programming FAQs -          /faq
=============================================================================
 Basix Fanzine site
  http://www.trenham.demon.co.uk/fanzine/
=============================================================================
 Jonathan Wests Great QBasic Page
  http://home.sprynet.com/sprynet/Jonath06
=============================================================================
 Wrox Press
  http://www.wrox.com/
=============================================================================
 Jumbo shareware
  http://www.jumbo.com/
=============================================================================
 PBSOUND WWW site
  http://www.snafu.de/~pbsound/
=============================================================================

Please tell me about others! :->
_____________________________________________________________________________
_
| SECTION 2 SUBPART 2 |  Fandex - Back Issues    |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Just a small reference into back issues, all available at the official site.
http://www.trenham.demon.co.uk/fanzine/

                                  ===Fandex===

 Graphics:
        - Screen 13 -                                   Issue 1
        - Zephyr Lib -                                  Issue 4
        - Colission Detection -                         Issue 4
        - PCX Viewer -                                  Issue 3
        - Coderz Sine FX -                              Issue 6
        - Palettes -                                    Issue 6
        - Graphics Tips -                               Issue 4
        - 3d Programming -                              Issue 4

 Sound:
        - SB Article -                                  Issue 1
        - WAV\Voc\Player 2 -                            Issue 2
        - PLAY Song -                                   Issue 3

 Series:
        - Basic Tutorial -                              Issue 2,3,4,5,6
        - PB & Qb Votes -                               Issue 1,2,3
        - CDROM Tutorials -                             Issue 5,6,7
        - Shareware Libs -                              Issue 2,3
        - Wrox Press Articles -                         Issue 1,3,4,5

 Others:
        - Accessing the CMOS -                          Issue 2
        - ANSI -                                        Issue 3
        - TSRMaker -                                    Issue 3
        - PopupTSR -                                    Issue 3
       
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++
- SECTION THREE -------------------------------------------------------------
--
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++

 Your Shout:

 Anything that is sent for use for the zine that doesn't fit into the other
 chapters is here. It's where your questions and programs go unless they fit
 into an article or if you actually write an article yourself.

_____________________________________________________________________________
_
| SECTION 3 SUBPART 1 |  Letters  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Letter from Chiok Ching Chaw:

 Hi peter! It's me again... I think I am one of the few Singaporeans still
 standing by Dos BASIC! :)
 Can i give u a few suggestions??

 1. can u summarised all the BASIC interpreters/compilers available?

 2. can u include a feature on the available Unix Basic?  think many of
 netusers would use a bit of tt info
 so far tts all...thanx :)

Reply:

 I'll try and take a look into unix basic. I dont know much about Unix at
 all except that many net servers run it. It's a pretty high end OS I
 thought, I will have to research.

 About the list of BASIC compilers\interpreters, it will be tried soon! :)

--
From Pinguelo1@aol.com:

 Hi, I have a few questions...

 1st. How do you play .MID files ?
 2nd. How to scroll graphics in Screen mode 13 ?
 3rd. How to put my graphics alltogether in 1 file, and how to retrieve them
      from that file ?

 Thank you very much !!!
 P.D.: You put fantastic information/documentation in this magazine !!!
 
Reply:

 a1) To play MID files you can either write your own full player with reader
     and synth controller or you can use interrupt with an external SB
     driver such as the SBSIM interfaces. Mike Huff provides source on
     playing MID files in the background on his web site, it escapes my mind
     but it's linked to by many of the best web sites.

 a2) Scrolling graphics in a _standard_ (not mode-x) screen mode $13 is just
     simply a matter of drawing something, moving it, and drawing again, it's
     that simple. In mode-x though there are a few registers and tricks you
     can use to scroll efficiently.

 a3) Putting graphics all toghether in a file involves packing them all
     toghether. You need to join all the files toghether and then only read
     the specific sections when you want a certain files. A table of file
     offsets and sizes would be useful in the first bit of the packed file.
     Then just use GET to read from byte locations.

 Many thanks for the compliments too! :^)



--
_____________________________________________________________________________
_
| SECTION 3 SUBPART 2 |  Your Programs  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A useful program (with ASM) that finds out the name of the executable that
is running. Could be useful to stop people renaming your programs, as some
sort of security? Many thanks to Cin Sieng < brandex@po.pacific.net.sg > for
this piece of code. Enjoy!

; B-O-F : EXENAME.ASM
; This program is copyrighted by Cin Sieng
; Released to public domain on 6 Nov 1996
;
; Use/Change this code anyway you want.
;
; Give credit please . . .
;
; You are encouraged improve this program
;
; Works fine with TASM and MASM

.MODEL MEDIUM,BASIC
.DATA

LenAddr dw 0,Offset Tmp
Tmp     db 65 dup(0)

.CODE

; This procedure will return the full path of the running program
; Works fine in QB 4.5 (VBDOS and BASIC PDS not tried)

Public EXEName
EXEName Proc Uses DS
 Mov AH,62h      ; DOS function to get the PSP addr.
 Int 21h
 Mov ES,BX       ; return : BX = Seg. of PSP, copy it to ES
 Mov AX,ES:[2Ch] ; Get the segment of env. at ES:002Ch
 Mov ES,AX       ; Change the segment for scanning/searching
 Xor DI,DI       ; start from Offset 0 --> ES:DI = ES:0000
 Mov AL,1        ; Search for ASCII 1 = 01
 Mov CX,-1       ; Search for 65535 bytes or -1
 RepNe ScaSb     ; Start search
 Inc DI          ; Now DI points to 1st letter
 Push DI         ; Save it on stack for use by SI
 Xor AX,AX       ; Search for ASCII 0
 Mov CL,0FFh     ; because we're sure that CH is 0FFh so just set CL to 0FFh
 RepNe ScaSb     ; Start search
 Not CX          ; Reverse the value of CX from - to +
 Dec CX          ; CX holds the length of the string
                 ; DI holds the last string +1
 Pop SI          ; Get DI from stack, SI=DI
 Mov LenAddr,CX  ; Store length to LenAddr
 Push DS         ; Save current DS
 Push DS         ; Ditto
 Push ES         ; Save current ES
 Pop DS          ; Make Destination become Source -> DS=ES
 Pop ES          ; Make Source become Destination -> ES=DS
 Lea DI,Tmp      ; DI = Offset of Tmp
 Shr CX,1        ; Div CX by 2
 Rep Movsw       ; Store 1 word/2 bytes from DS:SI to ES:DI
 Adc CX,CX       ; Add CX with carry, CX will have 0 or 1
 MovSb           ; Store the last byte if any.
 Pop DS          ; Restore current DS
 Mov AX,Offset LenAddr
 Ret
 EXEName EndP
 END
 ; E-O-F : EXENAME.ASM

 -------------------------- CUT HERE --------------------------------
 ' B-O-F : TESTEXE.BAS
 ' Must first compile the EXENAME.ASM to .OBJ and make a library file
 ' Run from QB 4.5
 DEFINT A-Z
 DECLARE FUNCTION EXEName$()
 PRINT "The current running program name is : "; EXEName$
 ' E-O-F : TESTEXE.BAS
 ---------------------------------------------------------------------


Now, some ye olde code digged out of the Basix Archives (hopefully not used
before :>) 

' ========================================================
' XPrint.Bas - Routine to print text at any pixel position
' --------------------------------------------------------
'               Written By Ben Ashley (C) 1995
' --------------------------------------------------------
DEFINT A-Z
SUB XPrint (x AS INTEGER, y AS INTEGER, Text$, col AS INTEGER)
   SCREEN 9, 0, 1, 0
   CLS
   LOCATE 1, 1
   COLOR col, 0: PRINT Text$
   x1! = 0
   y1! = 0
   x2! = LEN(Text$) * 8
   y2! = 12
   size% = 4 + INT(((PMAP(x2!, 0) - PMAP(x1!, 0) + 1) * (1) + 7) / 8) * 4 *
(PMAP(y2!, 1) - PMAP(y1!, 1) + 1)
   DIM Text%(size%)
   GET (x1!, y1!)-(x2!, y2!), Text%
   SCREEN 9, 0, 0, 0
   PUT (x, y), Text%
   ERASE Text%
END SUB



_____________________________________________________________________________
_
| SECTION 3 SUBPART 3 |  On the Lighter Side  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 What the acronyms _really_ mean?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        PCMCIA =>  People Can't Memorize Computer Industry Acronyms
        ISDN   =>  It Still Does Nothing
        APPLE  =>  Arrogance Produces Profit-Losing Entity
        IBM    =>  I Blame Microsoft
        DEC    =>  Do Expect Cuts
        CA     =>  Constant Acquisitions
        CD-ROM =>  Consumer Device, Rendered Obsolete in Months
        OS/2   =>  Obsolete Soon, Too.
        SCSI   =>  System Can't See It
        DOS    =>  Defunct Operating System
        BASIC  =>  Bill's Attempt to Seize Industry Control
        WWW    =>  World Wide Wait

Newsgroups:

 Thread Bill Gate$: A debate over Bill Gates, good or bad. Goes into
                    patches of discussing 'how great the amiga was/is'
                    and how poor Windows was\is etc, DOS, .....
                    , is that why we're mostly using PCs now? hmm..
                    the mind boggles

 Wormhole notes:    <for people who are having problems getting it going>

                    Wormhole 2 is posted fine but with overrunning lines
                    , using edit clean up the DECLARE SUB and SUB lines for
                    the rotate subroutine before loading up in QBASIC and
                    tidying, otherwise you'll have a nice big mess to
                    arrange. :)
                    
                    Wormhole 3 is posted fine, all you have to do is
                    join part 1 to part 2 using edit or another likewise
                    package. There are no overrunning lines.
 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++
- SECTION FOUR --------------------------------------------------------------
--
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++
 
 Details about the fanzine:

  This sction has been cut down this week to allow room for more goodies! :)

_____________________________________________________________________________
_
| SECTION 4 SUBPART 1 |  Latest Developments  | 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 i)   Web Archives
  To get the fanzine then come to the official site:
          http://www.trenham.demon.co.uk/fanzine/

 ii) HTML Fanzine
  Issue 1 of the zine is available at Joe Lawrences page.
          http://www.geocities.com/SiliconValley/Park/2323
  Hopefully there will be HTML versions on the main site too

 iii)  Mailing List
  To join the mailing list   :
          arelyea@vt.edu 
  with the following line in the subject header:

     subscribe basix-fanzine

  Any text in the body of the message will be ignored. The mailing list is
  run by Mr. Relyea and the Basix Fanzine claims no responsibility for any
  problems  with  the  mailing list.  Tom Lawrences HTML Fanzine is of his
  responsibility  and again the Basix Fanzine claims no responsibility for
  any problems.
_____________________________________________________________________________
_
| SECTION 4 SUBPART 2 |  How do you contribute?  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 So how do you contribute?
 All you have to do is e-mail all of your source code\articles and ideas to:

                peco@trenham.demon.co.uk    - with enquiries
                bmag@trenham.demon.co.uk    - with Q+A, articles, source

 Please, I appreciate it _so_ much if you could donate code, questions,
 answers, Basic stories, your own ideas for the fanzine etc. It all helps
 a lot.
_____________________________________________________________________________
_
| SECTION 4 SUBPART 3 |  Credits  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Greets go to (in no real order) :

   Marco Koegler,
    wrote the CDROM series

   Joe Lawrence,
    wrote the palette series

   Wolfgang Bruske,
    Excellent 3D Raycaster for PB

   Thomas Gohel,
    Lots of great PB code

   Tony Relyea,
    who is the maintainer of the mailing list and owns Russian-under Ware
    ,a software company, strangely enough!  (arelyea@vt.edu)

   Douggie Green,
    author of the two great FAQ documents - the newsgroup one and the code
one
    (douggie@blissinx.demon.co.uk)

 Other people who deserve some credit:
    Daniel Garlans
    SWAG team
    Wrox Press
    The rather wierd people on IRC #qbasic.. (just a joke!)
 
 Remember that this fanzine relies on your contributions. Cheers, ;-)

_____________________________________________________________________________
_
| SECTION 4 SUBPART 4 |  Last Words+Next month  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Next Issue:
        ARTICLES:
                [Series]
                Basic Tools - INDEPTH - Part 1
                [Topics and Articles]
                Basic Compilers
                PowerBasic Review
        OTHERS:
                WWW pages and FTP sites
        YOUR *SHOUT*:
                Your Questions, Answers and programs
        ADMIN\FINISHING:
                Yet still more of The usual
                Rundown on the Issue 9 fanzine.

 Last words:
        Wow, what a long time this has been coming, I cannot apologize
 enough. This issue I would like to give Brent Newhall congratulations
 on  WormHole,  I believe that Brent is one of the most useful regular
 members  of the comp.lang.basic.misc newsgroup. I would like to thank
 him for everyone who has found his help of great value.

 Ok,  I'm  not  going  to make any promises about the date of the next
 issue!  I  know  that when I do it always goes wrong, so perhaps if I
 say nothing it will be out in the next month. :)

 It's  just  been  snowing  outside,  raining, there was some thunder,
 lightning, lots of wind, and it has been around 5 degrees (44 f?)
 ahh.. lovely weather..... =)

 Cheers,

19th November 1996
Revision 3

[ Peter Cooper ] - [ peco@trenham.demon.co.uk ]
================================================
          Manager of Nemesis NetIndex
        http://www.trenham.demon.co.uk/
    'The Quality Way To Find Quality Sites'
