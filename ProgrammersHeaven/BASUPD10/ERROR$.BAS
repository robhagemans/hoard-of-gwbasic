'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |           BasUpd  Copyright (c) 1992  Thomas G. Hanlin III           |
'   |                                                                      |
'   |            See BASUPD.DOC for info on distribution policy            |
'   |                                                                      |
'   +----------------------------------------------------------------------+

   DEFINT A-Z

FUNCTION Error$ (ErrCode)
   SELECT CASE ErrCode
      CASE 1 : St$ = "NEXT without FOR"
      CASE 2 : St$ = "Syntax error"
      CASE 3 : St$ = "RETURN without GOSUB"
      CASE 4 : St$ = "Out of DATA"
      CASE 5 : St$ = "Illegal function call"
      CASE 6 : St$ = "Overflow"
      CASE 7 : St$ = "Out of memory"
      CASE 8 : St$ = "Label not defined"
      CASE 9 : St$ = "Subscript out of range"
      CASE 10: St$ = "Duplicate definition"
      CASE 11: St$ = "Division by zero"
      CASE 12: St$ = "Illegal in direct mode"
      CASE 13: St$ = "Type mismatch"
      CASE 14: St$ = "Out of string space"
      CASE 16: St$ = "String formula too complex"
      CASE 17: St$ = "Cannot continue"
      CASE 18: St$ = "Function not defined"
      CASE 19: St$ = "No RESUME"
      CASE 20: St$ = "RESUME without error"
      CASE 24: St$ = "Device timeout"
      CASE 25: St$ = "Device fault"
      CASE 26: St$ = "FOR without NEXT"
      CASE 27: St$ = "Out of paper"
      CASE 29: St$ = "WHILE without WEND"
      CASE 30: St$ = "WEND without WHILE"
      CASE 33: St$ = "Duplicate label"
      CASE 35: St$ = "Subprogram not defined"
      CASE 37: St$ = "Argument-count mismatch"
      CASE 38: St$ = "Array not defined"
      CASE 40: St$ = "Variable required"
      CASE 50: St$ = "FIELD overflow"
      CASE 51: St$ = "Internal error"
      CASE 52: St$ = "Bad file name or number"
      CASE 53: St$ = "File not found"
      CASE 54: St$ = "Bad file mode"
      CASE 55: St$ = "File already open"
      CASE 56: St$ = "FIELD statement active"
      CASE 57: St$ = "Device I/O error"
      CASE 58: St$ = "File already exists"
      CASE 59: St$ = "Bad record length"
      CASE 61: St$ = "Disk full"
      CASE 62: St$ = "Input past end of file"
      CASE 63: St$ = "Bad record number"
      CASE 64: St$ = "Bad file name"
      CASE 67: St$ = "Too many files"
      CASE 68: St$ = "Device unavailable"
      CASE 69: St$ = "Communication-buffer overflow"
      CASE 70: St$ = "Permission denied"
      CASE 71: St$ = "Disk not ready"
      CASE 72: St$ = "Disk-media error"
      CASE 73: St$ = "Feature unavailable"
      CASE 74: St$ = "Rename across disks"
      CASE 75: St$ = "Path/File access error"
      CASE 76: St$ = "Path not found"
      CASE ELSE: St$ = "Unprintable error"
   END SELECT
   Error$ = St$
END FUNCTION
