'(QBXIOL 1.0 declares  05-May-1991}
DECLARE FUNCTION CreateFile% (pathname$, BYVAL attribute%)
DECLARE FUNCTION OpenDevice% (pathname$, BYVAL mode%, handle%, flen&)
DECLARE FUNCTION ReadDevice% (BYVAL handle%, BYVAL start&, BYVAL bytes&, BYVAL vseg%, BYVAL voff%)
DECLARE FUNCTION WriteDevice% (BYVAL handle%, BYVAL start&, BYVAL bytes&, BYVAL vseg%, BYVAL voff%)
DECLARE FUNCTION CloseDevice% (BYVAL handle%)

