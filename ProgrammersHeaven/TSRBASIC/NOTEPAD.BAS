1000 ' NotePad, Version 2.0
1010 '
1020 ' Press esc to terminate and stay resident
1030 ' Press control-shift-b from dos to resume notepad
1040 ' Press end to terminate notepad
1050 '
1060 on error goto 3670
1070 gosub 1150 ' initialize
1080 gosub 1570 ' display banner
1090 gosub 1800	' read file
1100 gosub 2200	' display command window
1110 gosub 2350	' display note window
1120 gosub 2450 ' display note
1130 gosub 2510 ' process command
1140 goto 1130
1150 '
1160 ' subroutine to initialize everything
1170 '
1180 dim notes (100)
1190 pathname = "notepad.dat"
1200 init
1210 cls
1220 csroff
1230 foreground lookup ("white")
1240 background lookup ("blue")
1250 intensity lookup ("high")
1260 '
1270 ' banner window
1280 '
1290 ban_top = 1
1300 ban_left = 1
1310 ban_bottom = 1
1320 ban_right = 40
1330 cnt_col = 23
1340 cnt_len = ban_right - cnt_col 
1350 '
1360 ' command window
1370 '
1380 cmd_top = 5
1390 cmd_left = 1
1400 cmd_bottom = 10
1410 cmd_right = 17
1420 '
1430 ' notepad text window
1440 '
1450 txt_top = 13
1460 txt_left = 0
1470 txt_bottom = 22
1480 txt_right = 78
1490 '
1500 ' message window
1510 '
1520 msg_top = 6
1530 msg_left = 30
1540 msg_bottom = 10
1550 msg_right = 70
1560 return
1570 '
1580 ' subroutine to display banner
1590 '
1600 wintop ban_top-1
1610 winleft ban_left-1
1620 winright ban_right+1
1630 winbottom ban_bottom+1
1640 border
1650 cls
1660 display ban_top, ban_left, "NotePad, Version 1.0, "
1670 return
1680 '
1690 ' subroutine to update record count
1700 '
1710 display ban_top, cnt_col, space (cnt_len)
1720 if rec = 0
1730    then
1740       msg = "Top of NotePad"
1750    else
1760       msg = "Note " + rec + " of " + tot
1770 end if
1780 display ban_top, cnt_col, msg
1790 return
1800 '
1810 ' subroutine to read file
1820 '
1830 rec = 0
1840 tot = 0
1850 temp = ""
1860 notes (0) = ""
1870 if not access (pathname) then return
1880 open #1, "r", pathname
1890 if not eof (1)
1900    then 
1910       line input #1, buf
1920       if buf = ".endnote"
1930          then
1940             tot = tot + 1
1950             notes(tot) = temp
1960             temp = ""
1970          else
1980             if temp = ""
1990                then
2000                   temp = buf
2010                else
2020                   temp = temp + chr(10) + buf
2030             end if
2040       end if   
2050       goto 1890
2060 end if
2070 close #1
2080 rec = tot
2090 return
2100 ' 
2110 ' subroutine to write file
2120 '
2130 open #1, "w", pathname
2140 for i = 1 to tot
2150    print #1, notes(i)
2160    print #1, ".endnote"
2170 next i
2180 close #1
2190 '
2200 ' subroutine to open command window
2210 '
2220 wintop cmd_top-1
2230 winleft cmd_left-1
2240 winbottom cmd_bottom+1
2250 winright cmd_right+1
2260 border
2270 cls
2280 display cmd_top,   cmd_left, "Ins - Insert Note"
2290 display cmd_top+1, cmd_left, "Del - Delete Note"
2300 display cmd_top+2, cmd_left, "End - Exit"
2310 display cmd_top+3, cmd_left, "Esc - Suspend"
2320 display cmd_top+4, cmd_left, chr(0x18) + "   - Move Up"
2330 display cmd_top+5, cmd_left, chr(0x19) + "   - Move Down"
2340 return
2350 '
2360 ' subroutine to open note window
2370 '
2380 wintop txt_top
2390 winleft txt_left
2400 winbottom txt_bottom
2410 winright txt_right
2420 border
2430 cls
2440 return
2450 '
2460 ' subroutine to display note
2470 '
2480 locate 0,0
2490 print notes(rec)
2500 return
2510 ' 
2520 ' subroutine to get and process command keys
2530 '
2540 gosub 1680 ' update record count
2550 row cmd_top
2560 column cmd_left
2570 key = getkey ()
2580 if key = 0x011b then gosub 2660 : return   ' escape
2590 if key = 0x4f00 then gosub 2780 : return   ' end
2600 if key = 0x4800 then gosub 2860 : return	' up
2610 if key = 0x5000 then gosub 2940 : return	' down
2620 if key = 0x5200 then gosub 3200 : return	' insert
2630 if key = 0x5300 then gosub 3550 : return	' delete
2640 beep
2650 return
2660 '
2670 ' subroutine to suspend
2680 '
2690 gosub 2100 ' write file
2700 csron
2710 init
2720 savescreen old_screen
2730 cls
2740 suspend
2750 restorescreen old_screen
2760 csroff
2770 return
2780 '
2790 ' subroutine to terminate
2800 '
2810 gosub 2100 ' write file
2820 csron
2830 init 
2840 cls 
2850 end
2860 '
2870 ' subroutine to move up
2880 '
2890 if rec = 0 then : beep : return
2900 rec = rec - 1
2910 gosub 2350 ' open note window
2920 gosub 2450 ' display note
2930 return
2940 '
2950 ' subroutine to move down
2960 '
2970 if rec >= tot then beep : return
2980 rec = rec + 1
2990 gosub 2350 ' open note window
3000 gosub 2450 ' display note
3010 return
3020 '
3030 ' subroutine to display a message
3040 '
3050 wintop msg_top
3060 winleft msg_left
3070 winbottom msg_bottom
3080 winright msg_right
3090 fore = foreground (lookup ("white"))
3100 back = background (lookup ("red"))
3110 brightness = intensity (lookup ("high"))
3120 border
3130 cls
3140 locate 0, 0
3150 print msg
3160 foreground fore
3170 background back
3180 intensity brightness
3190 return
3200 ' 
3210 ' subroutine to insert a note
3220 '
3230 msg = "Enter note, followed by extra return"
3240 gosub 3020 ' display message
3250 gosub 2350 ' open note window
3260 csron
3270 new_note = ""
3280 line input buf
3290 if buf <> ""
3300    then
3310       if new_note = ""
3320          then
3330             new_note = buf
3340          else
3350             new_note = new_note + chr (10) + buf
3360       end if
3370       goto 3280
3380 end if
3390 if new_note <> ""
3400    then
3410       rec = rec + 1
3420       tot = tot + 1
3430       for i = tot to rec+1 step -1
3440          notes (i) = notes (i-1)
3450       next i
3460       notes (rec) = new_note
3470       msg = "Note added"
3480    else
3490       gosub 2450 ' display note
3500       msg = "Note cancelled" 
3510 end if
3520 gosub 3020 ' display message
3530 csroff
3540 return
3550 '
3560 ' subroutine to delete a note
3570 '
3580 if rec = 0 or tot = 0 then beep : return
3590 tot = tot - 1
3600 for i = rec to tot
3610    notes (i) = notes (i+1)
3620 next i
3630 rec = rec - 1
3640 gosub 2350 ' open note window
3650 gosub 2450 ' display note
3660 return
3670 '
3680 ' error handler
3690 ' 
3700 init
3710 cls
3720 print "ERROR: "; erm(); " at "; erl()
3730 end
