
   rem
   rem This program is a simple demonstration of using a DIALOG
   rem
   rem Dialogs can be used in text mode or graphics mode.
   rem This program is set up to work only in graphics mode 12
   rem

   a=mouseon

   rem go into graphics mode
   screen 12

   rem format of all my controls
   rem   type,left,top,xsize,ysize,id,text,(special)

   dim control$(100)

   control$(0)="ltext,10,10,100,30,100,Name:"
   control$(1)="edit,110,10,200,30,101,"

   control$(2)="ltext,10,54,100,30,102,Address:"
   control$(3)="edit,110,54,200,30,103,"

   control$(4)="pushbutton,10,110,50,30,104,Done"

   control$(5)="radiobutton,130,120,110,25,105,Type A,1"
   control$(6)="radiobutton,130,154,110,25,106,Type B"
   control$(7)="group,118,90,180,90,107,Personality Type"

   control$(8)="checkbox,10,184,100,30,108,Widgets"
   control$(9)="checkbox,130,184,100,30,109,Gadgets,1"
   control$(10)="checkbox,250,184,100,30,110,Doodads"

   rem call dialog
   dialog control$(0),11,10,10,350,220,"Client Information"

   rem display results of dialog
   print "name=";dialog$(101)
   print "address=";dialog$(103)
   print "done=";dialog$(104)
   print "Type A=";dialog$(105)
   print "Type B=";dialog$(106)
   print "widgets=";dialog$(108)
   print "gadgets=";dialog$(109)
   print "doodads=";dialog$(110)

input z



