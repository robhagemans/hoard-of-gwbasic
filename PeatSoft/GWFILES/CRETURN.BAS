2 INPUT"INPUT THE FILENAME THAT WAS DOWNLOADED WITHOUT CR (d:filename)  ",A$
4 INPUT"INPUT THE NEW NAME FOR THE DOWNLOADED FILE (d:filename)  ",B$
5 ' CHANGE THE INPUT AND OUTPUT NAMES TO THE NAMES OF THE FILES YOU WANT AS
6 ' INPUT AND OUTPUT  PRIMARILY USED TO COPY FILES WITH NO CARRIAGE RETURNS
7 ' IN THEM SO THAT YOU CAN EDLIN THEM   CONTRIBUTED BY DON WITHROW
10 OPEN A$ FOR INPUT AS #1
20 OPEN B$ FOR OUTPUT AS #2
30 IF EOF(1) THEN 100 ELSE LINE INPUT #1, THELIN$
40 PRINT #2, THELIN$
50 GOTO 30
100 CLOSE:END
120 'This program will add Carriage Returns to a downloaded file that does
130 'not appear to have them when you try to list it using the DOS TYPE
140 'command. The file has to be a basic program, patch or subroutine.
150 'After adding CRs to the file you can then use EDLIN to remove direct
160 'statements from the file.
