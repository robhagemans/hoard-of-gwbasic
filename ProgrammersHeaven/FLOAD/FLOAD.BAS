
'           Fast Loader for QBasic/QuickBASIC v1.0 (freeware)

'            Written by Molnar \ Kucalaba Productions, 1996

'   This is a routine designed to give the relatively advanced QBasic
' programmer the ability to quickly load large amounts of data into arrays,
'  similar to BLOAD.  This program, when compiled and run on a 486 dx/33
'          computer read an amazing 73,555 bytes per second.

'   The reason that this is better than BLOAD is simple : it's much,
'   much more flexible.  For example, say you want to store multiple
'  sprites in a BSAVEed file.  Unless you painstakingly use your arrays
' before BSAVEing them, you're out of luck.  And even then, you can only
' save about 65,536 bytes worth of graphics.  FLoad fixes those problems.
'  You can not only specify what point of the file to start loading from,
' but you also controls what array it goes to; no more loading the whole file
'                            into one array.


DECLARE SUB FLoad (FileName$, FileOffset&, DataLength&, DestArray() AS INTEGER)
' Look at the SUB for an explanation of the parameters.


'$DYNAMIC

CLS
SCREEN 13

DIM Stamp%(850)  ' Integer array to load data into

'  This is how you use Fload (in general) : Say you want to save a sprite.
' You would first draw it on the screen somehow, most likely using a GIF or
' BMP loader.  Then you GET the image into an array.  Then, you PUT (file io)
' each element of the array into a file.  Now is wher you would use FLoad.


FLoad "fload.spr", 1, 850 * 2, Stamp%()

' The reason for 850 * 2 is that the argument is BYTES and not INTEGERS.  As
' you know, an integer is 2 bytes, so we multiply by two.
' This particular example isn't really a good one for speed, but it'll do.


FOR x% = 15 TO 255 STEP 40
  FOR y% = 20 TO 140 STEP 40
    PUT (x%, y%), Stamp%
  NEXT
NEXT

DO

  aa$ = INKEY$

LOOP WHILE aa$ = ""




' Here's the code that generated the stamp (except the BMP loading)
'
'GET (0, 0)-(40, 40), Stamp%
'OPEN "fload.spr" FOR BINARY AS #1
' FOR x% = 0 TO 850
'  PUT #1, , Stamp%(x%)
' NEXT
'CLOSE #1

REM $STATIC
SUB FLoad (FileName$, FileOffset&, DataLength&, DestArray() AS INTEGER)
'
' FLoad  -- Quickly loads a file's contents into specified integer array.
'
' --Parameters--
' FileName$  = The file name to load
' FileOffset& = The offset of the file to start loading
' DataLength& = The amount, in bytes, of data to load.
' DestArray() = The array to load all the data into.

IF FileOffset& = 0 THEN FileOffset& = 1

RemBytes& = DataLength&
BufferSize% = 32766   ' The buffer size to use.  If you get out of string
                      ' space errors, lower it.  (result : it's slower)
BufStart% = LBOUND(DestArray) ' Lowest element number of buffer

DEF SEG = VARSEG(DestArray(BufStart%)) ' The segment of the song buffer
Ptr& = VARPTR(DestArray(BufStart%))    ' Pointer to the song buffer

LeftBytes& = RemBytes& MOD BufferSize% ' The amount of left over bytes


 OPEN FileName$ FOR BINARY AS #1

  SEEK #1, FileOffset&

   IF (LeftBytes& < RemBytes&) THEN
     FOR QuickLoad% = 1 TO (DataLength& - LeftBytes&) / BufferSize%
        Buffer$ = SPACE$(BufferSize%)
        GET #1, , Buffer$
          FOR x% = 1 TO BufferSize%
             POKE Ptr&, ASC(MID$(Buffer$, x%, 1))
             Ptr& = Ptr& + 1
          NEXT
         Buffer$ = ""
        RemBytes& = RemBytes& - BufferSize%
     NEXT
   END IF
   IF (LeftBytes& > 0) THEN
     Buffer$ = SPACE$(LeftBytes&)
     GET #1, , Buffer$
      FOR x% = 1 TO LeftBytes&
         POKE Ptr&, ASC(MID$(Buffer$, x%, 1))
         Ptr& = Ptr& + 1
      NEXT
     Buffer$ = ""
    END IF
 
  DEF SEG
 
 CLOSE #1

END SUB

