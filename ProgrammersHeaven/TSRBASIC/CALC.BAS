1000 ' calc.bas - simple terminate and stay resident calculator
1010 '
1020 ' press esc to terminate and stay resident
1030 ' press control-shift-b from dos to resume calculator 
1040 ' press control-c to terminate calculator
1050 '
1060 on error goto 2660
1070 first_suspend = 1
1080 csroff
1090 foreground lookup ("white")
1100 background lookup ("black")
1110 intensity lookup ("high")
1120 wintop 0
1130 winleft 59
1140 winbottom 7
1150 winright 75
1160 border
1170 cls
1180 '
1190 ' the following line sets up a window for debug messages
1200 ' that can be displayed using print:
1210 '
1220 ' wintop 10 : winleft 0: winbottom 20 : winright 79 : border : cls
1230 '
1240 display 2, 60, copy (chr (196), 15)
1250 display 3, 60, " 7  8  9"
1260 display 4, 60, " 4  5  6"
1270 display 5, 60, " 1  2  3"
1280 display 6, 60, " 0  .  c"
1290 foreground lookup ("red")
1300 display 3, 70, "+  ^"
1310 display 4, 70, "-  ("
1320 display 5, 70, "*  )"
1330 display 6, 70, "/  ="
1340 this_key = ""
1350 expr = ""
1360 '
1370 ' main command loop, get a key-code and convert to character
1380 '
1390 gosub 2540 ' display expr
1400 last_key = this_key
1410 this_key = chr (getkey() mod 256)
1420 '
1430 ' if key is control-c then re-initialize and exit
1440 '
1450 if this_key = chr (3) ' control-c
1460    then
1470       init
1480       cls
1490       end
1500 end if
1510 '
1520 ' if key is escape then suspend to dos or application
1530 '
1540 if this_key = chr (27) ' escape
1550    then
1560       if first_suspend
1570          then
1580             first_suspend = 0
1590             blank
1600       end if
1610       suspend
1620       goto 1080
1630 end if
1640 ' 
1650 ' if key is backspace erase last character entered
1660 '
1670 if this_key = chr (8) ' backspace
1680    then
1690       expr_len = len (expr)
1700       if expr_len > 0
1710          then
1720             expr = left (expr, expr_len-1)
1730          else
1740             beep
1750    end if
1760    goto 1360
1770 end if
1780 '
1790 ' if key is a digit or decimal point then append to expression
1800 '
1810 if this_key >= "0" and this_key <= "9" or this_key = "."
1820    then
1830       if last_key = "=" or last_key = chr (13)
1840          then
1850             expr = this_key
1860          else
1870             expr = cat (expr, this_key)
1880       end if
1890       goto 1360
1900 end if
1910 '
1920 ' if input was an operator then append it to execute string
1930 '
1940 if instr ("+-*/^", this_key)
1950    then
1960	   '
1970       ' handle adjacent operators
1980       '
1990       if instr ("+-*/^", right (expr, 1))
2000          then
2010             expr = left (expr, len (expr) - 1)
2020       end if
2030       expr = cat (expr, this_key)
2040       goto 1360
2050 end if
2060 '
2070 ' if input was an equal sign then evaluate expression
2080 '
2090 if this_key = "="	or this_key = chr (13)
2100    then
2110       if expr <> ""
2120          then
2130             execute "expr = " + expr
2140       end if
2150       goto 1360
2160 end if
2170 '
2180 ' if input was the clear key then re-initialize everything
2190 '
2200 if this_key = "c"
2210    then
2220       expr = ""
2230       goto 1360
2240 end if
2250 '
2260 ' if input is a left paren and last char in execute
2270 ' string was an operator then append it to execute string
2280 '
2290 if this_key = "("
2300    then
2310	   if instr ("+-*/^(", right (expr, 1)) 
2320          then
2330             expr = expr + this_key
2340       end if
2350       goto 1360
2360 end if
2370 '
2380 ' if input is a right paren and last char in execute
2390 ' string was NOT an operator then append it to execute string
2400 '
2410 if this_key = ")"
2420    then
2430       if not instr ("+-*/^(", right (expr, 1)) 
2440          then
2450             expr = expr + this_key
2460       end if
2470       goto 1360
2480 end if
2490 '
2500 ' if key was not valid signal error and get next keystroke
2510 '
2520 beep
2530 goto 1360
2540 '
2550 ' subroutine to display expr 
2560 '
2570 if expr = ""
2580    then
2590       display_expr = 0
2600    else
2610       display_expr = right (expr, 14)
2620 end if
2630 display 1, 60, space (15)
2640 display 1, 74 - len (display_expr), display_expr
2650 return
2660 '
2670 ' error handler
2680 '
2690 expr = "Error"
2700 gosub 2540 ' display expr
2710 beep
2720 resume 1350
