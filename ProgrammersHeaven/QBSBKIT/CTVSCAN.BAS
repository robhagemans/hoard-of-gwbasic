
'QBXSBC CTVSCAN.BAS
'detection scan example for the SoundBlaster routines
'5-May-1991

DEFINT A-Z

REM $INCLUDE: 'QBXIOL.BI'
REM $INCLUDE: 'QBXCTV.BI'
REM $INCLUDE: 'QBXFMI.BI'

DIM ports(1 TO 6)
ports(1) = &H210: ports(2) = &H220: ports(3) = &H230
ports(4) = &H240: ports(5) = &H250: ports(6) = &H260:
DIM irqs(1 TO 4)
irqs(1) = 2: irqs(2) = 3: irqs(3) = 5: irqs(4) = 7

CLS
PRINT "CTVSCAN.BAS for QBXSBC"
PRINT
PRINT "  PORT     IRQ       DMA"
PRINT "  210h      2        1"
PRINT "  220h      3"
PRINT "  230h      5"
PRINT "  240h      7"
PRINT "  250h"
PRINT "  260h"

FOR p = 6 TO 1 STEP -1
   LOCATE 3 + p, 2: PRINT ""
   FOR I = 1 TO 4
      pstat = CTVport(ports(p))
      LOCATE 3 + I, 12: PRINT ""
      istat = CTVirq(irqs(I))
      stat = CTVdetect
      IF stat = 0 THEN EXIT FOR
      LOCATE 3 + I, 12: PRINT " "
   NEXT
   IF stat = 0 THEN EXIT FOR
   LOCATE 3 + p, 2: PRINT " "
NEXT
LOCATE 11
IF stat THEN
   PRINT "Scan failed! SBC not found"
ELSE
   PRINT "SBC found!"
END IF

