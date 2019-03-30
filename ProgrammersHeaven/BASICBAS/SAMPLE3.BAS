


rem
rem This program is a standard Basic program which does not utilize
rem mouse, buttons, etc.  It shows how you can make Basic programs
rem designed to run under DOS, run under DOS or Windows with few, if
rem any, modifications.
rem
rem program prompts for $ amount, interest rate, and tax bracket.
rem
rem It displays before/after tax income for selected years.
rem


rem
rem The following  WINDOWS SIZE command is optional.  This program will
rem run in DOS and Windows without this command.  This command allows you
rem to put items centered on DOS's 80x25 screen in a smaller window when
rem running under Windows.
rem You would do this if the DOS screen had columns on the left and/or
rem rows on the top which were not used.  This lets you have a smaller
rem window in Windows. 

    rem   WINDOWS SIZE 13,3,72,22


rem
rem The following WINDOWS NAME command is optional.  It allows you to
rem specify the name to appear as window name when run under Windows.
rem The default window name is the name of the file compiled.  This
rem command is ignored in DOS mode.
rem

    REM windows name "Investment Analysis"



color 7,1
cls



   color 1,6
   locate 3,22:print "Before/After tax investment analysis";
   color 7,1
   locate 5,22:print "Enter desired values and press Enter";
   if ostype<>2 then
     locate 6,22:print "    (Enter -9 to exit program)";
  end if

   color 1,6
   for y=12 to 21
     locate y,15
     print space$(50);
   next y
   locate 12,32:print "ACCOUNT BALANCE";
   locate 14,29:print " Tax Free";
   locate 14,49:print " Taxable";
   locate 16,20:print "Year 1";
   locate 18,20:print "Year 5";
   locate 20,20:print "year 10";
   color 7,1
   di=6
   dt=15
   da=600

100

   rem
   rem get interest rate
   rem
   locate 8,20
   print using "Enter Annual Interest Rate(##.##%):           ";di;
   locate 8,56
   input "",i
   if i=-9 then stop
   if i=0 then i=di else di=i
   gosub doprojections


   rem
   rem get tax bracket
   rem

   locate 9,20
   print using "Enter Tax Bracket (##.##%):           ";dt;
   locate 9,48
   input "",t
   if t=-9 then stop
   if t=0 then t=dt else dt=t
   gosub doprojections


   rem
   rem get investment amount
   rem

   locate 10,20
   print using "Enter Annual amount to invest ($##,###.##):             ";da;
   locate 10,64
   input "",a
   if a=-9 then stop
   if a=0 then a=da else da=a
   gosub doprojections

   goto 100



rem
rem calculation section which tells what we would have in the future
rem

doprojections:

   color 1,6

   rem
   rem calculate after tax contribution
   rem
       ba=(1-(dt/100))*da

   rem
   rem calculate before tax effective interest earned
   rem
       bi=(1-(dt/100))*di

   rem
   rem after year 1
   rem

       before1=da*(1+di/100)
       after1=ba*(1+bi/100)

   locate 16,30:print using "###,###.##";before1;
   locate 16,50:print using "###,###.##";after1;

      for ii%=1 to 4
         before1=(before1*(1+di/100))+(da*(1+di/100))
         after1= (after1*(1+bi/100))+(ba*(1+bi/100))
      next ii%

   locate 18,30:print using "###,###.##";before1;
   locate 18,50:print using "###,###.##";after1;


      for ii%=1 to 5
         before1=(before1*(1+di/100))+(da*(1+di/100))
         after1= (after1*(1+bi/100))+(ba*(1+bi/100))
      next ii%

   locate 20,30:print using "###,###.##";before1;
   locate 20,50:print using "###,###.##";after1;
   color 7,1
   return

