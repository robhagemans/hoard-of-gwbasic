'Declarations for LOADGIF.ASM and ERROR.ASM

DECLARE FUNCTION LoadGIF _
(BYVAL MemPointer, BYVAL FileSeg, BYVAL FileOfs, _
BYVAL PScrType, BYVAL PScrOffset, BYVAL PScrWidth, _
BYVAL XRes, BYVAL YRes, BYVAL X0, BYVAL Y0, BYVAL X1, BYVAL Y1, _
BYVAL XOrg, BYVAL YOrg, BYVAL AdaptorType, BYVAL PalIgnore, _
BYVAL PalSeg, BYVAL PalOfs, PalColors)

DECLARE FUNCTION ErrorReport ()

DECLARE FUNCTION LoadGIFMem ()

