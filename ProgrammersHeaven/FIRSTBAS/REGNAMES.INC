'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                                   REGNAMES.INC                            ³
'³                                                                           ³
'³ This file is to be used as a $INCLUDE file whenever you use the CALL      ³
'³ INTERRUPT statement in your FirstBasic program. The file contains         ³
'³ named constants that represent the registers the CALL INTERRUPT statement ³
'³ can manipulate.                                                           ³
'³                                                                           ³
'³ In order to use this file include it in your programs using the $INCLUDE  ³
'³ metastatement:                                                            ³
'³                                                                           ³
'³   $INCLUDE "REGNAMES.INC"                                                 ³
'³                                                                           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

%FLAGS = 0
%AX    = 1
%BX    = 2
%CX    = 3
%DX    = 4
%SI    = 5
%DI    = 6
%BP    = 7
%DS    = 8
%ES    = 9
