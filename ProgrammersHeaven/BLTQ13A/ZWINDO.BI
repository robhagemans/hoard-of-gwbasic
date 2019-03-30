'******* ZWINDO 1.00-31-May-92 *******
DECLARE FUNCTION ZWINDO% (SEG Packinfo AS ANY)

CONST SaveWIN = 10, BackWIN = 11, FillWIN = 12, PrintWIN = 13, CursorWIN = 14

TYPE WinSavePack
Func AS INTEGER         '10=save window,11=back window
Stat AS INTEGER
Mode AS INTEGER         '0=default screen,1=force mono,2=force color
Page AS INTEGER         '0 to max page
X0 AS INTEGER           'upper-left column (0-max col)
Y0 AS INTEGER           'upper-left row (0-max row)
Xsize AS INTEGER        'number of columns for window (1-max columns)
Ysize AS INTEGER        'number of rows for window (1-max rows)
BuffPtrOff AS INTEGER   'offset of window save buffer
BuffPtrSeg AS INTEGER   'segment
END TYPE '20

TYPE WinFillPack
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=default screen,1=force mono,2=force color
Page AS INTEGER         '0 to max page
X0 AS INTEGER           'upper-left column (0-max col)
Y0 AS INTEGER           'upper-left row (0-max row)
Xsize AS INTEGER        'number of columns to fill (1-max columns)
Ysize AS INTEGER        'number of rows to fill (1-max rows)
AttrChar AS INTEGER     'attr byte*256+fill char(char=0 then change attr only)
END TYPE '18            'e.g., &H1741 is fg=7,bg=1,char 41h ('A',CHR$(65))

TYPE WinPrintPack
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=default screen,1=force mono,2=force color
Page AS INTEGER         '0 to max page
X0 AS INTEGER           'upper-left column to start print (0-max col)
Y0 AS INTEGER           'upper-left row to start print (0-max row)
Xsize AS INTEGER        'max number of characters to print (1-?, or zero-term)
Xoffset AS INTEGER      'start position in string to start printing from
Attr AS INTEGER         'attribute to use, see FillPack
TextPtrOff AS INTEGER   'offset of text string
TextPtrSeg AS INTEGER   'segment
END TYPE '22

TYPE WinCursorPack      'if parm= -1 that function not changed
Func AS INTEGER
Stat AS INTEGER
Mode AS INTEGER         '0=get stat else set stats
Page AS INTEGER         '0 to max page
X0 AS INTEGER           'upper-left column for cursor
Y0 AS INTEGER           'upper-left row for cursor
cStart AS INTEGER       'scanline start for cursor
cEnd AS INTEGER         'scanline end for cursor
VMode AS INTEGER        'video mode to set BIOS to
END TYPE '18
'<End of ZWINDO.BI>

