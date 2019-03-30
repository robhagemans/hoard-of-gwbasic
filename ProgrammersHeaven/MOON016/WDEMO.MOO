''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'''                                                                    '''
''' WDEMO.MOO                  *** released to the public domain ***   '''
'''                                                                    '''
''' Originally by Rowan Crowe, Wednesday, 08-Jan-1996                  '''
'''   3:635/727.1@fidonet                                              '''
'''   rowan@jelly.freeway.DIALix.oz.au                                 '''
'''                                                                    '''
''' Demonstrates the use of an intermediate screen buffer to eliminate '''
''' jerkiness and flickering caused by redrawing of the screen areas.  '''
''' Compile with and without !SMOOTH define to see differences.        '''
'''                                                                    '''
''' Note: %WindowCount may be modified; range 1 to 9.                  '''
'''                                                                    '''
''' Requires MoonRock compiler v0.15 or higher:                        '''
'''   MRC wdemo/-m/-c                                                  '''
'''           or                                                       '''
'''   MRC wdemo/-m/-c !SMOOTH                                          '''
'''                                                                    '''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

begin def

%Escape    = 27
%Enter     = 13

%F1        = 59

set = 48,  %Key0, %Key1, %Key2, %Key3, %Key4, %Key5, %Key6, %Key7, _
           %Key8, %Key9

%CtlLeft   = 115
%CtlRight  = 116
%CtlUp     = 141
%CtlDown   = 145


%WindowCount = 4

dim windowx%[%WindowCount]
dim windowy%[%WindowCount]

sub UpdateScreen
sub CopyIntermediateToTrue

common currentwindow%

#ifdef smooth
  common screen_source%, screen_dest%
#endif

begin code

$outstream _tty_str_direct

cls

#ifdef smooth
  screen_dest% = getscreenseg       ' Save true screen buffer
  screen_source% = farmalloc(4000)  ' Allocate memory for our
                                    ' intermediate screen buffer
  setscreenseg(screen_source%)      ' Set _tty_str_direct to point
                                    ' to the intermediate buffer
#endif

for i% = 0 to %WindowCount
  windowx%[i%] = rand(60)    ' Select random positions for windows
  windowy%[i%] = rand(18)
next

@mov ah, 01h
@mov cx, 2000h
@int 10h
                             ' disable cursor.

call UpdateScreen

exitnow% = FALSE
while exitnow% = FALSE
  k% = inkey
  select case k%
    case -1
      timeslice
    case %Key0, %Key1, %Key2, %Key3, %Key4, %Key5, %Key6, %Key7, _
         %Key8, %Key9
      t% = k% - %Key0
      if t% <= %WindowCount then
        currentwindow% = t%
        call UpdateScreen
      endif
    case %Escape
      exitnow% = TRUE
    case 0                   ' extended keypress
      k% = inkey             ' get extended code
      select case k%
        case %CtlUp
          if windowy%[currentwindow%] > 0 then
            windowy%[currentwindow%] = windowy%[currentwindow%] - 1
            call UpdateScreen
          endif
        case %CtlDown
          if windowy%[currentwindow%] < 19 then
            windowy%[currentwindow%] = windowy%[currentwindow%] + 1
            call UpdateScreen
          endif
        case %CtlLeft
          if windowx%[currentwindow%] > 0 then
            windowx%[currentwindow%] = windowx%[currentwindow%] - 1
            call UpdateScreen
          endif
        case %CtlRight
          if windowx%[currentwindow%] < 59 then
            windowx%[currentwindow%] = windowx%[currentwindow%] + 1
            call UpdateScreen
          endif
        case %F1
          t$ = "Window " + str(currentwindow%)
          DrawWindow(t$, windowx%[currentwindow%], windowy%[currentwindow%], _
              20, 3, 15, 1, 8, 7)
          drawwindow("Help", 10, 8, 57, 9, 11, 1, 15, 7)
          mcursor 12,10
          colour 0,7
          print "þ Keys '0' - '" + str(%WindowCount)_
              + "' select current window."
          mcursor 12,11
          print "þ Ctrl-Left, Ctrl-Right, Ctrl-Up and Ctrl-Down move"
          mcursor 14,12
          print "the current window."
          mcursor 12,13
          print "þ Escape exits the program."
          DrawButton("OK", 33, 15, 10, 14, 1, 7)

#ifdef smooth
          call CopyIntermediateToTrue
#endif

          k% = -1
          while k% <> %Enter
            k% = inkey
          wend
          call UpdateScreen
        case else
          delay(1)
          soundon(400)
          delay(1)
          soundoff
      end select

    case else
      delay(1)
      soundon(400)
      delay(1)
      soundoff
  end select
wend

#ifdef smooth
  setscreenseg(screen_dest%)   ' Restore true screen buffer. Not
                               ' necessary when immediately terminating
                               ' program, but necessary if we are only
                               ' temporarily using double buffering.
  farmemfree(screen_source%)   ' Free intermediate buffer memory
#endif

colour ?,0
cls
@mov ah, 01h
@mov cx, 0607h
@int 10h
                             ' enable cursor
end

sub UpdateScreen
colour 3, 1
mcursor 0, 0
print repstr("±±±±±±±±±±", 200)
colour 11
mcursor 0, 24
print "         MoonRock demonstration program    F1 for help; _
  Esc to exit           "
for i% = 0 to %WindowCount
  t$ = "Window " + str(i%)
  DrawWindow(t$, windowx%[i%], windowy%[i%], 20, 3, 7, 1, 8, 7)
next

t$ = "Window " + str(currentwindow%)
DrawWindow(t$, windowx%[currentwindow%], windowy%[currentwindow%], _
      20, 3, 15, 1, 15, 7)

#ifdef smooth
  call CopyIntermediateToTrue
#endif

end sub

sub CopyIntermediateToTrue
' Copies intermediate screen buffer to true screen buffer
' Although only one line, included as a SUB for clarity.
'farmemcopy(screen_source%, 0, screen_dest%, 0, 4000)
farmemcopys(screen_source%, screen_dest%, 4000)
end sub
