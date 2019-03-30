

rem
rem test program for windows print
rem


    screen 12


    rem
    rem create some graphics in a memory bitmap
    rem

    createbitmap 1,0,400,200
    selectbitmap 1
    line (0,0)-(400,200),15,bf       : rem clear bitmap
    for i=0 to 15
       line (0,i*10)-(200,(i*10)+8),i,bf
    next i


    rem
    rem read in a picture to a second bitmap
    rem

    createbitmap 2,0,167,126
    selectbitmap 2
    pxsize=167
    pysize=126
    loadbitmap "samplew3.bmp",0,0,0,0,0,pxsize,pysize,0,xmult,ymult




    selectdisplay

    rem
    rem copy from memory bitmap to display
    rem
    copybits 1,0,0,400,200,display,0,0,0

    copybits 2,0,0,167,126,display,100,200,0

    stretchbits 2,0,0,250,180,display,300,200,167,126,0




    rem
    rem Now talk to printer
    rem

    printcontrol 0:    rem this opens printer

    selectprint   :    rem this selects as output divice

    mmwide=device(4)
    pixelswide=device(8);   : rem how wide is print area in pixels
    pixelsdown=device(10)   : rem how tall is print area in pixels


    rem
    rem Now write something directly to print area
    rem

    line (0,400)-(400,400),15  : rem this sets background to white

    for i=0 to 15
       line (0,i*10)-(200,(i*10)+8),i,bf
    next i


    rem
    rem Copy bitmap 1 picture to print surface
    rem

    copybits 1,0,0,400,200,print,pixelswide-400,pixelsdown-500,0


    rem
    rem Copy entire bitmap 2 to printer
    rem
    copybits 2,0,0,167,126,print,pixelswide-200,600,0


    rem
    rem copy bottom 1/2 of bitmap 2 to printer.  The bottom half
    rem is copied because when copying to printer, all references
    rem to bitmap start from bottom
    rem
    copybits 2,0,0,167,63,print,100,600,0


    rem
    rem Now enlarge object on printer
    rem
    stretchbits 2,0,0,167,152,print,100,800,167,126,0


    printcontrol 2  : rem end document
    printcontrol 3  : rem end frame


    rem
    rem Select display as output device
    rem
    selectdisplay



    rem
    rem wait for user to press Enter
    rem

  input z














