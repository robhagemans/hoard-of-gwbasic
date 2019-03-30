
DEFINT A-Z
'
SUB ReadARJ (File$, Dir$(), DirNum)

   FileN = FREEFILE
   OPEN File$ FOR BINARY AS FileN
   Size& = LOF(FileN)

   GET FileN, 3, n
   SEEK FileN, n + 13
   Jump& = Jump& + n + 13
   n$ = " "
   GET FileN, , n$
   n = ASC(n$)
   Jump& = Jump& + n

   DO
      n$ = SPACE$(n)
      GET FileN, , n$
      cnt = cnt + 1
      Dir$(cnt) = ""
      Fil$ = RIGHT$(n$, 16)
      n = INSTR(Fil$, " ")
      Fil$ = RIGHT$(Fil$, 16 - n)
      FOR x = 1 TO LEN(Fil$)
         n = ASC(MID$(Fil$, x, 1))
         IF n > 32 THEN
            Dir$(cnt) = Dir$(cnt) + CHR$(n)
         END IF
      NEXT
      IF LEN(Fil$) = 0 THEN
         EXIT DO
      END IF
      Jump& = SEEK(FileN) + CVL(MID$(n$, 14, 4)) + 9
      IF Jump& >= Size& THEN
         EXIT DO
      END IF
      SEEK FileN, Jump&
      n$ = " "
      GET FileN, , n$
      n = ASC(n$)
   LOOP

   DirNum = cnt - 1

END SUB

