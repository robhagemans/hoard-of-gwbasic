1000 ' Webb.bas, Version 2.0, Graphics Demo Program
1010 '
1020 print "Press ctrl-c to stop..."
1030 '
1040 ' Get graphics configuration and see if a
1050 ' graphics adapter is available
1060 '
1070 config xmax, ymax, colors, adapter, cmode
1080 if adapter = lookup ("mda")
1090    then
1100       print "No graphics adapter, or msherc not loaded."
1110       end
1120 end if
1130 '
1140 ' Select highest resolution graphics mode based 
1150 ' on type of graphics adapter
1160 '
1170 if adapter = lookup ("cga") then mode lookup ("hres2")
1180 if adapter = lookup ("ega") then mode lookup ("hres16")
1190 if adapter = lookup ("vga") then mode lookup ("vres16")
1200 if adapter = lookup ("hgc") then mode lookup ("herc")
1210 config xmax, ymax, colors, adapter, cmode
1220 type lookup ("graphics")
1230 on error goto 2710
1240 '
1250 ' Randomly generate coordinates of two points that will
1260 ' independently bounce around the screen. A line will
1270 ' be drawn between the two points to produce the desired
1280 ' visual effect.
1290 '
1300 randomize
1310 x1 = int (rnd () * xmax)
1320 x2 = int (rnd () * xmax)
1330 y1 = int (rnd () * ymax)
1340 y2 = int (rnd () * ymax)
1350 '
1360 ' Randomly generate deltas for subsequent points
1370 '
1380 dx1 = int (rnd () * 6) + 3
1390 dx2 = int (rnd () * 6) + 3
1400 dy1 = int (rnd () * 6) + 3
1410 dy2 = int (rnd () * 6) + 3
1420 '
1430 ' Initialize viewport so that min and max just
1440 ' barely fit inside screen
1450 '
1460 xmin1 = dx1
1470 xmin2 = dx2
1480 ymin1 = dy1
1490 ymin2 = dy2
1500 xmax1 = xmax - dx1
1510 xmax2 = xmax - dx2
1520 ymax1 = ymax - dy1
1530 ymax2 = ymax - dy2
1540 '
1550 ' Initialize two additional points based on the
1560 ' original points. These points will follow in the
1570 ' footsteps of the original points, erasing the lines
1580 ' between the original points.
1590 '
1600 x3 = x1
1610 x4 = x2
1620 y3 = y1
1630 y4 = y2
1640 '
1650 ' Initialize the deltas for the two points that
1660 ' will erase lines.
1670 '
1680 dx3 = dx1
1690 dx4 = dx2
1700 dy3 = dy1
1710 dy4 = dy2
1720 '
1730 ' Initialize cnt, which is used to select a new color,
1740 ' this_color, which keeps track of the current color, and
1750 ' countdown, which is the number of lines to draw before
1760 ' starting to erase any lines.
1770 '
1780 cnt = 0
1790 this_color = 1
1800 countdown = 100
1810 '
1820 ' If a point reaches a boundary then flip its delta. When
1830 ' looked at in one dimension at a time a point is just oscillating
1840 ' back and forth between its maxima and minima.
1850 '
1860 if x1 >= xmax1 or x1 <= xmin1
1870    then
1880       dx1 = -dx1
1890 end if
1900 if x2 >= xmax2 or x2 <= xmin2
1910    then
1920       dx2 = -dx2
1930 end if
1940 if y1 >= ymax1 or y1 <= ymin1
1950    then
1960       dy1 = -dy1
1970 end if
1980 if y2 >= ymax2 or y2 <= ymin2
1990    then
2000       dy2 = -dy2
2010 end if
2020 '
2030 ' Adjust a point by its delta, which is a signed
2040 ' number and may result in the point moving toward
2050 ' its maxima or toward its minima
2060 '
2070 x1 = x1 + dx1
2080 x2 = x2 + dx2
2090 y1 = y1 + dy1
2100 y2 = y2 + dy2
2110 '
2120 ' Connect the two points
2130 '
2140 moveto x1, y1
2150 lineto x2, y2
2160 '
2170 ' If the countdown timer has expired then start
2180 ' erasing lines. Otherwise jump back to beginning
2190 ' and draw the next line.
2200 '
2210 if countdown 
2220    then
2230       countdown = countdown - 1
2240       goto 1860
2250 end if
2260 '
2270 ' After the countdown timer expires, points 3
2280 ' and 4 follow exactly in the footsteps of points
2290 ' 1 and 2, erasing lines as they go.
2300 '
2310 if x3 >= xmax1 or x3 <= xmin1
2320    then
2330       dx3 = -dx3
2340 end if
2350 if x4 >= xmax2 or x4 <= xmin2
2360    then
2370       dx4 = -dx4
2380 end if
2390 if y3 >= ymax1 or y3 <= ymin1
2400    then
2410       dy3 = -dy3
2420 end if
2430 if y4 >= ymax2 or y4 <= ymin2
2440    then
2450       dy4 = -dy4
2460 end if
2470 x3 = x3 + dx3
2480 x4 = x4 + dx4
2490 y3 = y3 + dy3
2500 y4 = y4 + dy4
2510 color 0, 0
2520 moveto x3, y3
2530 lineto x4, y4
2540 '
2550 ' Select a new color, on devices capable of
2560 ' supporting multiple colors. Jump around this
2570 ' block of code if you do not want to change colors.
2580 '
2590 cnt = cnt + 1
2600 if cnt = 300
2610    then
2620       cnt = 0
2630       this_color = this_color + 1
2640       if this_color > colors
2650          then
2660             this_color = 1
2670       end if
2680 end if
2690 color this_color, 0
2700 goto 1860
2710 '
2720 ' Error Handler - This is designed to catch
2730 ' the control-c interrupt.
2740 '
2750 mode lookup ("default")
2760 type lookup ("direct")
2770 print erm()
2780 end
