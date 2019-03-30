     renum 0
     ' renum 0 tells TsrBasic to load this file in NO NUMBER mode.
     '
     ' PRINT.BAS - TSR to demonstrate printer management
     '
     ' The first three commands in the table are special commands
     ' that are handled based on the command number. See carriage
     ' return processing, below, for more information. The remaining
     ' commands are printer escape sequences that are sent to the
     ' printer, preceded by ESC, when selected. The default commands
     ' are for a STAR NP-10 (Epson Compatible). More commands can be
     ' added as long as num_cmds is set to the total number of commands.
     '
     data "Suspend       ", ""
     data "Quit          ", ""
     data "Test Pattern  ", ""
     data "Italic On     ", "4"
     data "Italic Off    ", "5"
     data "BoldFace On   ", "G"
     data "BoldFace Off  ", "H"
     data "PaperOut On   ", "9"
     data "PaperOut Off  ", "8"
     data "Elite On      ", "M"
     data "Pica On       ", "P"
     data "6 Lines/Inch  ", "2"
     data "8 Lines/Inch  ", "0"
     data "Reset Printer ", "@"
     num_cmds = 14
     cur_cmd = 1
     last_cmd = 0
     dim cmd_txt(num_cmds), cmd_esc(num_cmds)
     for i = 1 to num_cmds
        read cmd_txt(i), cmd_esc(i)
     next i
     '
     ' Terminate and Stay Resident
     '
     print "Terminate and Stay Resident Print Manager"
     print "   Type Control-Shift-B to resume"
1360 suspend 0
     savescreen old_screen
     csroff
     '
     ' Define command window
     '
     wintop 0
     winleft 10
     winbottom num_cmds + 1
     winright 25
     foreground lookup ("white")
     background lookup ("black")
     intensity lookup ("high")
     border
     cls
     '
     ' Display choices
     '
     for i = 1 to num_cmds
        display i, 11, cmd_txt(i)
     next i
     '
     ' Remove highlighting from last choice. Note last_cmd
     ' is not set on the first time through.
     ' 
     '
1600 if last_cmd
        then
           foreground lookup ("white")
           background lookup ("black")
           display last_cmd, 11, cmd_txt(last_cmd)
     end if
     last_cmd = cur_cmd
     '
     ' Then highlight current choice
     '
     foreground lookup ("black")
     background lookup ("white")
     display cur_cmd, 11, cmd_txt(cur_cmd)
     '
     ' Wait for keystroke and extract keyboard scan code
     '
1760 key = getkey ()
     scan_code = key \ 256
     char_code = key & 0xff
     '
     ' Check for up-arrow scan code
     '
     if scan_code = 72
        then
           if cur_cmd = 1
              then
                 cur_cmd = num_cmds
              else
                 cur_cmd = cur_cmd - 1
           end if
           goto 1600
     end if
     '
     ' Check for down-arrow scan code
     '
     if scan_code = 80
        then
           if cur_cmd = num_cmds
              then
                 cur_cmd = 1
              else
                 cur_cmd = cur_cmd + 1
           end if
           goto 1600
     end if
     '
     ' Check for carriage return scan code and process current command
     '
     if scan_code = 28
        then
           '
           ' Check for suspend command
           '
           if cur_cmd = 1
              then
                 restorescreen old_screen
                 goto 1360
           end if
           '
           ' Check for exit command
           '
           if cur_cmd = 2
              then
                 restorescreen old_screen
                 on error goto 3000
1900             execute "quit"  ' terminates both PRINT and TsrBasic
           end if
           '
           ' Check for test pattern command
           '
           if cur_cmd = 3
              then
                 open #1, "w", "lpt1"
                 print #1, "The quick brown fox jumps over the lazy dog."
                 close #1
                 goto 1760
           end if
           '
           ' Else must be printer escape sequence command
           '
           open #1, "w", "lpt1"
           print #1, chr(27) + cmd_esc(cur_cmd);
           close #1
           goto 1760
     end if 
     beep
     goto 1760
3000 '
     ' Error handler to execute in case unload of TSR fails
     ' because some other process has hooked into our interrupt
     ' vectors. This error handler suspends for 36 clock ticks,
     ' about 2 seconds, and then goes back to try to unload
     ' again. This continues until whatever process hooked
     ' into our interrupt vector restores them.
     '
     suspend 0, 0x30, 0x06, 36
     resume 1900
     
