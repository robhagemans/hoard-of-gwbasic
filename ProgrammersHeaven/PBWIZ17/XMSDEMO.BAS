'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |         PBWIZ  Copyright (c) 1991-1993  Thomas G. Hanlin III         |
'   |                                                                      |
'   |                      PowerBASIC Wizard's Library                     |
'   |                                                                      |
'   +----------------------------------------------------------------------+

'  This provides a brief demo of the XMS routines.  It allocates enough
'  memory to hold a long integer array of dimensions 300 x 70 and loads
'  it sequentially with long integers.  Why?  Because someone requested
'  it, that's why!  Actually, they wanted 3003 x 70, which is nigh on to
'  a megabyte, and considerably more than PowerBASIC can handle on its own.
'  With these routines, 3003 x 70 is a snap, but I'm using a fraction of
'  the size to keep things reasonably quick.  The technique used here can
'  be used to simulate an array of any size, however.

   $DIM ARRAY

   DECLARE SUB XMSclose (INTEGER)
   DECLARE FUNCTION XMSexists% ()
   DECLARE FUNCTION XMSlfree& ()
   DECLARE SUB XMSopen (LONG, INTEGER, INTEGER)
   DECLARE SUB XMSread (INTEGER, LONG, LONG, INTEGER, INTEGER)
   DECLARE SUB XMSwrite (INTEGER, LONG, LONG, INTEGER, INTEGER)

   $LINK "pbwiz.pbl"

   DEFINT A-Z



   ' -- Set up variables.  We'll be simulating a 300x70 element array of
   ' -- long integers in XMS.  This would ordinarily look something like:
   ' -- DIM BigArray&(300,70) with OPTION BASE 1 on.

   Size1& = 300&                       ' elements in first dimension
   Size2& = 70&                        ' elements in second dimension
   BytesPerElement& = 4                ' bytes per element

   ArrayBytes& = Size1& * Size2& * BytesPerElement&  ' bytes needed for array
   ArrayKB& = (ArrayBytes& + 1023&) \ 1024&          ' Kbytes needed for array



   '-- Make sure XMS is installed and that there's enough of it.

   IF NOT XMSexists THEN
      PRINT "This demo requires XMS memory to run."
      END
   END IF

   IF ArrayKB& > XMSlfree& THEN
      PRINT "This demo requires more XMS memory than is available."
      END
   END IF



   '-- Open an area of XMS memory (like DIM for arrays).
   '-- If it succeeds, it will return a value in ArrayName
   '-- which we'll use to access the opened memory area.

   XMSopen ArrayKB&, ArrayName, ErrCode
   IF ErrCode THEN
      PRINT "Error allocating XMS.  Unable to proceed."
      END
   END IF

   CLS
   PRINT "XMS allocated for 300x70 long integer array.  Bytes ="; ArrayBytes&



   '-- Since we want the numbers we display to be right-justified, and
   '-- PRINT USING would be overkill (also slow), we'll use RSET to do
   '-- the work for us.  First, we need to define the string "fields".
   '-- We'll make them just large enough for the largest number we'll
   '-- display in each print position.

   First$ = SPACE$(LEN(STR$(Size1&)))
   Second$ = SPACE$(LEN(STR$(Size2&)))
   Third$ = SPACE$(LEN(STR$(Size1& * Size2&)))



   '-- Let's fill 'er up with sequential numbers starting from 1.
   LOCATE 4, 1
   PRINT "Filling XMS 'array' with sequential values..."
   Counter& = 1&
   ' get pointer to value to set
   DSeg = VARSEG(Counter&)
   DOfs = VARPTR(Counter&)
   FOR FirstElement = 1 TO Size1&
      RSET First$ = STR$(FirstElement)
      FOR SecondElement = 1 TO Size2&
         RSET Second$ = STR$(SecondElement)
         RSET Third$ = STR$(Counter&)
         LOCATE 5, 1
         PRINT "Array&("; First$; ", "; Second$; ") = "; Third$;
         ' calculate position within XMS memory
         Posn& = (CLNG(FirstElement - 1) * Size2& + CLNG(SecondElement - 1)) * BytesPerElement&
         ' set it
         XMSwrite ArrayName, Posn&, BytesPerElement&, DSeg, DOfs
         ' update the counter
         INCR Counter&
      NEXT
   NEXT



   '-- Let's read it back, by way of verification
   LOCATE 7, 1
   PRINT "Reading back from XMS 'array'..."
   ' get pointer to value to read
   DSeg = VARSEG(Counter&)
   DOfs = VARPTR(Counter&)
   FOR FirstElement = 1 TO Size1&
      RSET First$ = STR$(FirstElement)
      FOR SecondElement = 1 TO Size2&
         RSET Second$ = STR$(SecondElement)
         ' calculate position within XMS memory
         Posn& = (CLNG(FirstElement - 1) * Size2& + CLNG(SecondElement - 1)) * BytesPerElement&
         ' read it
         XMSread ArrayName, Posn&, BytesPerElement&, DSeg, DOfs
         LOCATE 8, 1
         RSET Third$ = STR$(Counter&)
         PRINT "Array&("; First$; ", "; Second$; ") = "; Third$;
      NEXT
   NEXT



   '-- We're all done, so let's return the XMS memory to the system.
   '-- This is IMPORTANT, because otherwise the XMS would remain
   '-- unavailable until the computer is rebooted.

   XMSclose ArrayName



   LOCATE 10, 1
   PRINT "Done"
