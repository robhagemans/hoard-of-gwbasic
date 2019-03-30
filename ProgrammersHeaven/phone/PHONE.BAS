'*****************************************************************************
'***************************       WELCOME      ******************************
'*****************************************************************************

' >>> PLEASE READ THE DISCLAIMER BEFORE RUNNING THIS PROGRAM <<<

' This file was originally created to solve a problem I had.
' I like listening to music in my room, and I like to listen to it loud!
' But I could never relax because I had no way of knowing if the telephone
' was ringing.  Therefore I decided to spend some time creating a program
' which was capable of detecting weather someone was trying to phone me or not.
' This is what I came up with.

' It may be simple but it does the job.

' Anthony Montiel
' montiel@gibnynex.gi

' Feel free to contact me for help and/or advice.
' (or just to let me know that someone downloaded my program :)

****************** DISCLAIMER ******************

' THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
' ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
' IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
' ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
' FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
' DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
' OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
' HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
' LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
' OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
' SUCH DAMAGE.

' BY USING THIS SOFTWARE YOU AGREE TO THE ABOVE TERMS

' IN SHORT , I AM NOT RESPONSIBLE FOR ANYTHING YOU DO WITH THIS PROGRAM, OR
' ANYTHING THAT HAPPENS AS A RESULT OF USING THIS PROGRAM.

' &H2E8 IS THE COM PORT TO WHICH MY MODEM IS CONNECTED
' YOU MAY NEED TO CHANGE THIS DEPENDING ON YOUR SETTINGS

count = 0
CLS
OUT &H2E8, 255
A = INP(&H2E8)
begin:
DO
IF count <> 0 THEN LOCATE 2, 55: COLOR 2: PRINT "Call Last detected at "; ltime$
IF count <> 0 THEN LOCATE 1, 1: PRINT "Press [C] to confirm detected call"
LOCATE 10, 30: COLOR 15: PRINT " Monitoring Phone Line "
LOCATE 23, 1: COLOR 7: PRINT "Press [ESC] to Exit"
x$ = INKEY$
IF x$ = CHR$(27) THEN END
IF UCASE$(x$) = "C" THEN
  count = 0
  LOCATE 1, 1: PRINT "                                         "
  LOCATE 2, 55: PRINT "                      "
END IF
LOOP WHILE INP(&H2E8) = A
here:
ltime$ = TIME$
count = count + 1
DO
OUT &H2E8, 255
COLOR 18, 0
LOCATE 10, 30: PRINT "Incomming Call Detected"
FOR b = 200 TO 3000 STEP 250
SOUND b, 70 / 100
NEXT b
FOR y = 1 TO 2
SLEEP 1
x$ = INKEY$
NEXT y
IF x$ = CHR$(27) THEN END
GOTO begin
LOOP UNTIL INP(&H2E8) = A
GOTO begin

