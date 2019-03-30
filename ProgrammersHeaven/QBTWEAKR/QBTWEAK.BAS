'This programs demonstrates how to use the driver. A much better
'use of this driver would load samples off disk and play them. Due
'to space limitations, I can't give you any samples. Check out Amiga
'.MOD files, or perhaps .VOC files.
'Remember the driver as-is only plays signed samples!
'Please read the beginning of "TWEAKR.ASM" for more info!
DEFINT A-Z
'declarations:
DECLARE SUB TweakOn (BYVAL freq%)
DECLARE SUB TweakOff ()
DECLARE SUB PlaySound (BYVAL Offset%, BYVAL Segment%, BYVAL Length%, BYVAL freq%)
DECLARE FUNCTION TweakStatus ()
'2k stack
CLEAR , , 2048
'enable the driver(on slow computers 18,356hz may be too much!)
TweakOn 18356
'plays your BIOS at 15,000 hertz (offset 0, segment C000h)
PlaySound 0, &HC000, &HFFFF, 15000
'play it until done
DO: LOOP WHILE TweakStatus
'turn off driver
TweakOff
END

