
   rem
   rem This program demonstrates the use of a custom dialog box to get a file
   rem name.  The radio buttons are included just to show that you can
   rem do multiple things with one dialog box if desired.
   rem

   a=mouseon

   rem go into graphics mode
   screen 12


   rem format of all my controls
   rem   type,left,top,xsize,ysize,id,text,(special)

   dim control$(100)

   control$(0)="ltext,50,0,200,30,140,&Filename"
   control$(1)="filename,50,26,200,30,151,"

   control$(2)="ltext,50,64,200,30,141,Pathname"
   control$(3)="filepath,50,90,200,30,150,"

   control$(4)="filelist,50,120,150,170,152,*.BMP,0

   control$(5)="OK,300,4,100,40,153,OK"
   control$(6)="pushbutton,300,48,100,40,154,&Cancel"

   control$(7)="radiobutton,300,180,110,25,105,Standard"
   control$(8)="radiobutton,300,210,110,25,106,Compress,1"
   control$(9)="group,290,150,146,110,107,File Size"

   rem call dialog
   dialog control$(0),10,10,10,450,300,"Select File to Read"

   rem display results of dialog
   print "pathname=";dialog$(150)
   print "filename=";dialog$(151)
   print "ok button=";dialog$(153)
   print "standard button=";dialog$(105)
   print "compress button=";dialog$(106)
   print "cancel button=";dialog$(154)


input z



