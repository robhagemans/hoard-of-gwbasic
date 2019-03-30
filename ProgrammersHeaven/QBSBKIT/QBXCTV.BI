'(QBXCTV 1.0 declares  05-May-1991}
DECLARE FUNCTION CTVver% (soft%, hard%)  'fn0
DECLARE FUNCTION CTVport% (BYVAL port%)  'fn1
DECLARE FUNCTION CTVirq% (BYVAL irq%)    'fn2
DECLARE FUNCTION CTVdetect% ()           'fn3
DECLARE FUNCTION CTVspeaker% (BYVAL onoff%)  'fn4
DECLARE FUNCTION CTVusrstat% (BYVAL vseg%, BYVAL voff%) 'fn5
DECLARE FUNCTION CTVoutput% (BYVAL vseg%, BYVAL voff%)  'fn6
DECLARE FUNCTION CTVinput% (BYVAL srate%, BYVAL lbytes&, BYVAL vseg%, BYVAL voff%) 'fn7
DECLARE FUNCTION CTVhalt% ()        'fn8
DECLARE FUNCTION CTVuninstall% ()   'fn9
DECLARE FUNCTION CTVpause% ()       'fn10
DECLARE FUNCTION CTVcontinue% ()    'fn11
DECLARE FUNCTION CTVskip% ()        'fn12
DECLARE FUNCTION CTVexternal% (BYVAL vseg%, BYVAL voff%) 'fn13
DECLARE FUNCTION CTVstatus% ()      'fnxx

