'
' 3dDemo.BAS by Brent Ashley - free for anyone's use.
'
DECLARE SUB Strip3D (t%, l%, b%, r%, StripType%)
DECLARE SUB Fill (t%, l%, b%, r%, Fore%, Back%, Char$)
DECLARE SUB DrawBox (t%, l%, b%, r%, TLFore%, TLBack%, BRFore%, BRBack%, BoxDef$)
DECLARE SUB Box3D (t%, l%, b%, r%, BoxType%)
DEFINT A-Z

DIM SHARED BaseClr, HiClr, ShadClr, ContClr

DEF SEG = 0

IF (PEEK(&H449) = 7) THEN Colour = 0 ELSE Colour = -1

' uncomment this fo force black and white on a colour system:
' Colour = 0

IF Colour THEN
  BaseClr = 3
  HiClr = 15
  ShadClr = 8
  ContClr = 0
ELSE
  BaseClr = 7
  HiClr = 15
  ShadClr = 8
  ContClr = 0
END IF
Mark$ = "˛"


' first screen
COLOR ContClr, BaseClr: CLS
Box3D 2, 3, 21, 79, 0
Box3D 5, 5, 9, 30, 1
COLOR ContClr, BaseClr: LOCATE 7, 13: PRINT "Raised Box";
Box3D 5, 51, 9, 76, 2
COLOR ContClr, BaseClr: LOCATE 7, 58: PRINT "Recessed Box";
Box3D 15, 5, 19, 30, 3
COLOR ContClr, BaseClr: LOCATE 17, 12: PRINT "Raised Panel";
Box3D 15, 51, 19, 76, 4
COLOR ContClr, BaseClr: LOCATE 17, 57: PRINT "Recessed Panel";
Strip3D 11, 25, 13, 55, 3
COLOR BaseClr, ContClr: LOCATE 12, 32: PRINT "Raised Black Strip"
Strip3D 23, 26, 23, 55, 4
COLOR HiClr, ContClr: LOCATE 23, 27: PRINT " Press a key to continue... ";
SLEEP: DO: LOOP WHILE LEN(INKEY$)

' second screen
COLOR BaseClr, ContClr: CLS
Strip3D 3, 23, 3, 61, 1
COLOR ContClr, BaseClr: LOCATE 3, 27: PRINT "Dialog Boxes can look like this!";
Box3D 5, 5, 20, 75, 3
COLOR ContClr, BaseClr: LOCATE 8, 8: PRINT "Data Entry:";
Box3D 7, 20, 9, 73, 2
Fill 8, 21, 8, 72, 7, 0, " "
COLOR HiClr, ContClr: LOCATE 8, 22: PRINT "C:\DOS\FILENAME.EXT";

Box3D 11, 9, 19, 40, 1
Strip3D 12, 12, 18, 14, 1
COLOR ContClr, BaseClr
LOCATE 12, 13: PRINT Mark$;
LOCATE 12, 16: PRINT "This option"
LOCATE 13, 13: PRINT Mark$;
LOCATE 12, 16: PRINT "That option"
LOCATE 13, 16: PRINT "The other option"
LOCATE 14, 16: PRINT "Some further option"
LOCATE 15, 13: PRINT Mark$;
LOCATE 15, 16: PRINT "His option"
LOCATE 16, 16: PRINT "Her option"
LOCATE 17, 16: PRINT "Their option"
LOCATE 18, 13: PRINT Mark$;
LOCATE 18, 16: PRINT "Your option"

COLOR HiClr, BaseClr
LOCATE 10, 50: PRINT " Characters "
Strip3D 11, 45, 14, 70, 3
COLOR BaseClr, ContClr
LOCATE 11, 46: FOR i = 1 TO 24: PRINT CHR$(159 + i); : NEXT
LOCATE 12, 46: FOR i = 1 TO 24: PRINT CHR$(183 + i); : NEXT
LOCATE 13, 46: FOR i = 1 TO 24: PRINT CHR$(207 + i); : NEXT
LOCATE 14, 46: FOR i = 1 TO 24: PRINT CHR$(231 + i); : NEXT

Box3D 16, 48, 19, 66, 4
Strip3D 17, 59, 18, 62, 3
COLOR HiClr, ContClr
LOCATE 17, 60: PRINT "31";
LOCATE 18, 60: PRINT " 6";
COLOR ContClr, BaseClr
LOCATE 17, 52: PRINT "Row"
LOCATE 18, 52: PRINT "Column"

COLOR HiClr, ContClr: LOCATE 24, 27: PRINT " And thus ends the demo. ";

SUB Box3D (t, l, b, r, BoxType)
  SELECT CASE BoxType
    CASE 1 ' Raised
      BoxDef$ = "…Õ∏≥Ÿƒ”∫ "
      TLFore = HiClr: BRFore = ContClr
      TLBack = BaseClr: BRBack = BaseClr
    CASE 2 ' Recessed
      BoxDef$ = "…Õ∏≥Ÿƒ”∫ "
      TLFore = ContClr: BRFore = HiClr
      TLBack = BaseClr: BRBack = BaseClr
    CASE 3 ' Raised Panel
      BoxDef$ = "€ﬂ‹€€‹ﬂ€ "
      TLFore = HiClr: BRFore = ShadClr
      TLBack = BaseClr: BRBack = BaseClr
    CASE 4 ' Recessed Panel
      BoxDef$ = "€ﬂ‹€€‹ﬂ€ "
      TLFore = ShadClr: BRFore = HiClr
      TLBack = BaseClr: BRBack = BaseClr
    CASE ELSE ' Flat
      BoxDef$ = ""
      TLFore = ContClr: BRFore = ContClr
      TLBack = BaseClr: BRBack = BaseClr
   END SELECT
   DrawBox t, l, b, r, TLFore, TLBack, BRFore, BRBack, BoxDef$
END SUB

SUB DrawBox (t, l, b, r, TLFore, TLBack, BRFore, BRBack, BoxDef$)
  ' default box characters
  IF LEN(BoxDef$) = 0 THEN Box$ = "⁄ƒø≥Ÿƒ¿≥ " ELSE Box$ = BoxDef$
 
  ' top and left
  COLOR TLFore, TLBack
  LOCATE t, l: PRINT LEFT$(Box$, 1);
  FOR i = l + 1 TO r - 1
    LOCATE t, i: PRINT MID$(Box$, 2, 1);
  NEXT
  FOR i = t + 1 TO b - 1
    LOCATE i, l: PRINT MID$(Box$, 8, 1);
  NEXT
  LOCATE b, l: PRINT MID$(Box$, 7, 1);

  ' bottom and right
  COLOR BRFore, BRBack
  LOCATE t, r: PRINT MID$(Box$, 3, 1);
  FOR i = t + 1 TO b - 1
    LOCATE i, r: PRINT MID$(Box$, 4, 1);
  NEXT
  LOCATE b, r: PRINT MID$(Box$, 5, 1);
  FOR i = l + 1 TO r - 1
    LOCATE b, i: PRINT MID$(Box$, 6, 1);
  NEXT
  
  ' fill
  Fill t + 1, l + 1, b - 1, r - 1, TLFore, TLBack, MID$(Box$, 9, 1)

END SUB

SUB Fill (t, l, b, r, Fore, Back, Char$)
  COLOR Fore, Back
  FOR i = t TO b
    LOCATE i, l: PRINT STRING$(r - l + 1, Char$);
  NEXT
END SUB

SUB Strip3D (t, l, b, r, StripType)
  SELECT CASE StripType
    CASE 1 ' raised
      LFore = HiClr: RFore = ShadClr: MFore = BaseClr: Back = BaseClr
    CASE 2 ' recessed
      LFore = ShadClr: RFore = HiClr: MFore = BaseClr: Back = BaseClr
    CASE 3 ' raised black
      LFore = HiClr: RFore = ShadClr: MFore = ContClr: Back = ContClr
    CASE 4 ' recessed black
      LFore = ShadClr: RFore = HiClr: MFore = ContClr: Back = ContClr
  END SELECT
  wide = r - l - 1
  IF wide < 1 THEN wide = 1
  FOR i = t TO b
    LOCATE i, l
    COLOR LFore, Back: PRINT "›";
    COLOR MFore, BaseClr: PRINT STRING$(wide, "€");
    COLOR RFore, Back: PRINT "ﬁ";
  NEXT
END SUB

