100 DEF SEG=&H1F94  'Dependent upon your memory
110 '   This sample program serves as both an example and the documentation
120 '   for the FCBREAD.BSV routine that will read the directory of a
130 '   disk and present the matching file name back to the BASIC program.
140 '   Also available to the program is the directory information that
150 '   contains the size and time/date information. This routine is
160 '   faster than OPENing the file since it does not incur that overhead.
170 '   Also the user can present an arbitrary string to match on.
180 '
190 '   To use, BLOAD the routine into any available free memory. It
200 '   has 2 entry points (INIT and GETNEXT). INIT (offset 2) is used
210 '   to define the disk drive (0=default, 1=A, 2=B, ....) and the
220 '   pattern to be used to match on. The pattern MUST BE a string of
230 '   length 11; the first 8 are the filename and the last 3 are the
240 '   extension. A "?" is used to match any character. For example to
250 '   get all the BASIC files on the disk, "????????BAS" would be used
260 '   as the input parameter. After INIT has been called, calls to
270 '   GETNEXT (offset 5) are made to retrieve matching file names.
280 '   The two parameters are the string in which the match is returned
290 '   (which must be of length 14) and an INTEGER (..%) return value.
300 '   If the status return is <0, no more matched have been found. If
310 '   status >=0, it is the FILE ATTRIBUTE (as defined in the DOS Disk
320 '   Directory).
330 '
340 '   The INTEGER value at offsets 0,1 in the routine are the offset
350 '   to the directory entry for the file. For example, to obtain the
360 '   DATE information of the file, use the following statements:
370 '        B% = PEEK(0)+PEEK(1)*256   ' Get offset value
380 '        FDATE = PEEK(B%+26)*256 + PEEK(B%+25)
390 '
400 '   The offsets into the directory entry (25, 26 in this case) are
410 '   defined in the DOS manual.
420 '
430 '   The example program will print all the file names on the current
440 '   Directory plus their attributes.
450 BLOAD "fcbread.bsv",0
460 INIT%=2:GETNEXT%=5
470 FILENAME$="???????????"
480 DISK%=0:CALL INIT%(DISK%,FILENAME$)
490 FILENAME$=SPACE$(14):CALL GETNEXT%(FILENAME$,STATUS%)
500 PRINT FILENAME$,STATUS%
510 IF STATUS%>=0 THEN GOTO 490
