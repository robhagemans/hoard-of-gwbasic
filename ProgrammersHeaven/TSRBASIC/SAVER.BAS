100 ' Screen Saver Demo Program, Version 1.0
110 ' 
120 ' The following line sets the saver delay interval,
130 ' in timer ticks, which are 18ths of a second. It
140 ' is set to 10 seconds for demo purposes.
150 '
160 saver_delay = 10 * 18
170 '
180 print "Press ctrl-shift-b to terminate saver."
190 '
200 ' The following statement does the actual terminate
210 ' and stay resident part. The parameters set up this
220 ' program to be recalled if a control-shift-b hotkey
230 ' sequence is entered or saver_delay ticks of keyboard
240 ' inactivity occur. 
250 '
260 suspend 0, 0x30, 0x06, 0, saver_delay, timer
270 '
280 ' The timer variable tells us why the suspend
290 ' statement returned. If it returned because the
300 ' hotkey sequence was entered then we terminate.
310 '
320 if not timer then cls : end
330 ' 
340 ' The following code is executed when the screen saver
350 ' kicks in. In this demo program it just saves the screen,
360 ' clears it and then waits for a keystroke. It could do
370 ' something much more elaborate, like the webb.bas
380 ' graphics display.
390 ' 
400 init
410 savescreen buf
420 blank
430 csroff
440 if inkey() = 0 then goto 440
450 restorescreen buf
460 goto 250
