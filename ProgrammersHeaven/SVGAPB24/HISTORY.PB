REVISION HISTORY FOR SVGAPB.LIB - HI-RES, 256-COLOR GRAPHICS LIB FOR 
POWER BASIC INC'S POWER BASIC 3.x

SVGAPB21.ZIP is the inital release of the PB Inc. Power BASIC version 
of our graphics library.  However, we have had several releases of the 
MS QuickBASIC version.  Below is the history for the QuickBASIC versions:

-----------------------------------------------------------------------------
-1.0 Initial release - June, 1993.  SVGAQB10.ZIP                            -
-                                                                           -
-1.1 Release - August, 1993.  SVGAQB11.ZIP                                  -
-    Bugs Fixed: GIFGETINFO - not closing successful files                  -
-                DRWLINE - not always drawing endpoints                     -
-                DRWBOX - drawing incorrectly when X2<X1 and/or Y2<Y1       -
-    Improved:   FILLAREA - speed increase of about 150%                    -
-                FILLCOLOR - speed increase of about 65%                    -
-                Increased library's granularity                            -
-    Additions:  BYTECOPY, PALCOPY, GETMAXX, GETMAXY, GETARCCOS, GETARCSIN, -
-                    GETARCTAN, GETCOS, GETSIN, GETTAN                      -
-                                                                           -
-1.2 Release - August, 1993.  SVGAQB12.ZIP                                  -
-    Bugs Fixed: FILLAREA - not always making it to the far left            -
-                FILLCOLOR - not always making it to the far left           -
-                                                                           -
-1.2a Release - September, 1993. SVGAQB12a (registered version only)        -
-    Bugs Fixed: SPRITEPUT - had problems if spriteXloc = MAXX              -
-                SPRITEGAP - had problems if spriteXloc = MAXX              -
-                                                                           -
-2.0 Release - March, 1994. SVGAQB20.ZIP                                    -
-    Additions:  BLKRESIZE, BLKROTATE, BLKROTATESIZE, DRWFILBOX,            -
-                    DRWFILCIRCLE, DRWFILELLISPE, FILLSCREEN, FILLPAGE,     -
-                    GIFMAKE, PAGEDISPLAY, PAGEACTIVE, RES640L, SPRITEGET,  -
-                    SPRITECOLLDETECT, WHICHXMS, XMSALLOCATE, XMSFREE,      -
-                    XMSGET, XMSPUT, XMSCOPY, XMSERROR                      -
-                                                                           -
-2.0a Release - March, 1994 SVGAQB20a (registered version only)             -
-    Bugs Fixed: RES640L,RES640,RES800,RES1024 - Some VESA BIOSs were not   -
-                    preserving the processor SI & DI registers after a     -
-                    video mode change.                                     -
-                                                                           -
-2.0b Release - April, 1994 SVGAQB20b (registered version only)             -
-    Bugs Fixed: DRWFILLCIRCLE - not clipping properly                      -
-                DRWFILLELLIPSE - not clipping properly                     -
-    Improved:   DRWBOX - speed increase of about 102%                      -
-                DRWCIRCLE - speed increase of about 33%                    -
-                DRWELLIPSE - speed increase of about 44%                   -
-                DRWLINE - speed increase of about 42%                      -
-                DRWFILLBOX - speed increase of about 317%                  -
-                DRWFILLCIRCLE - speed increase of about 248%               -
-                DRWFILLELLIPSE - speed increase of about 190%              -
-                                                                           -
-2.1 Release - May, 1994.  SVGAQB21.ZIP                                     -
-    Bugs Fixed: SETCARD - setup needed for PAGEDISPLAY was not completed.  -
-    Improved:   DRWBOX - speed increase of about 8%                        -
-                DRWLINE - speed increase of about 42%                      -
-                DRWFILLBOX - speed increase of about 97%                   -
-                DRWFILLCIRCLE - speed increase of about 88%                -
-                DRWFILLELLIPSE - speed increase of about 80%               -
-                FILLVIEW - speed increase of about 62%                     -
-    Additions:  RES1280, FILLCONVEXPOLY                                    -
-                                                                           -
-----------------------------------------------------------------------------
                    
2.1 Initial release - May, 1994. SVGAPB21.ZIP

2.1a Release - August, 1994.  SVGAPB21a (registered version only)
      Bugs Fixed: DRWFILLCIRCLE,DRWFILLELLIPSE - When using the 'XOR' mode,
                       some lines were drawn twice resulting in a 'sun set'
                       effect.
                  DRWLINE - using the 'AND' mode on a horizontal line 
                       resulted in the first few pixels (left most) actually
                       being drawn in the 'SET' mode; this bug also affected 
                       the following functions (only when using the 'AND' 
                       mode): DRWFILLBOX, DRWFILLCIRCLE, DRWFILLELLIPSE, 
                       FILLCONVEXPOLY, FILLVIEW.
                  Registered disks did not include the 'EDTMOUSE.TXT' and
                       'EDTFONT.TXT' as stated in the file 'PACKING.LST'. 
                       These files were however included in the main 
                       documentation files.
      Improved:   DRWFILLCIRCLE - speed increase of about 16%
                  DRWFILLELLIPSE - speed increase of about 30%

2.1b Release - September, 1994.  SVGAPB21b (registered version only)
      Bugs Fixed: Some newer VESA cards with dual 'window' support were not 
                       bank switching properly.

2.1c Release - November, 1994.  SVGAPB21c (registered version only)
      Bugs Fixed: Mouse routines rewritten to support ALL mice. 

2.2  Release - January, 1995.  SVGAPB22 (registered version only)
      Bugs Fixed: FILLAREA - not always making it to left edge when left edge
                       was the viewport and not the border color.
                  FILLCOLOR - not always making it to left edge when left 
                       edge was the viewport and not the border color.
                  GIFMAKE - under certain circumstances would produce a 
                       corrupt GIF file.
      Improved:   Increased library's granularity 
                  BLKGET - speed increase of about 33%
                  SCROLLDN - speed increase of about 39%
                  SCROLLLT - speed increase of about 25%
                  SCROLLRT - speed increase of about 72%
                  SCROLLUP - speed increase of about 26%
                  SPRITEGAP - speed increase of about 29%
                  SPRITEGET - speed increase of about 20%
                  FILLCONVEXPOLY - speed increase of about 5%
                  BYTECOPY - Changed the declaration in the header file to
                     allow more data types.  It will now support byte, 
                     integer, long integer, real, long real, and user 
                     defined arrays.
      Additions:  DRWCIRARC, DRWELLARC, DRWCUBICBEZIER, FILLPOLY, XMSBLKGET, 
                     XMSBLKPUT, XMSSCREENGET, XMSSCREENPUT

2.3  Release - January, 1995.  SVGAPB23.ZIP
      Removed:    GIFGETINFO, GIFMAKE, GIFPUT - Unisys, owner of patent on 
                     LZW compression, now requires paying royalties for use 
                     of technology.  LZW compression is used in the GIF 
                     specification.
      Additions:  PCXGETINFO, PCXMAKE, PCXPUT

2.3a Release - February, 1995.  SVGAPB23 (registered version only)
      Bugs Fixed: PCXMAKE - minor errors in header file

2.3b Release - February, 1995.  SVGAPB23 (registered version only)
      Bugs Fixed: PCXPUT - not correctly displaying PCX file whose width
                     is an odd number
                  XMSGET,XMSPUT - Changed the declaration in the header 
                     file to allow more data types.  It will now support 
                     byte, integer, long integer, real, long real, and user 
                     defined arrays.

2.3c Release - March, 1995.  SVGAPB23 (registered version only)
      Bugs Fixed:  BLKPUT - using the 'AND' mode resulted in most pixels 
                       being drawn in the 'XOR' mode; this bug also affected 
                       the following functions (only when using the 'AND' 
                       mode): DRWSTRING, DRWSTRINGDN, DRWSTRINGLT, 
                       DRWSTRINGRT, PCXPUT

2.3d Release - April, 1995.  SVGAPB23 (not offically released)
      Bugs Fixed:  D3PROJECT - not catching over/underflow properly

2.3e Release - April, 1995.  SVGAPB23 (registered version only)
      Improved:  WHICHXMS - changed internal structure 

2.4  Release - January, 1996.  SVGAPB24.ZIP
     Changed:    The order form (file name "ORDER.FRM") was simplified.
     Additions:  A new credit card order form (file name "CHARGEIT.FRM")


 