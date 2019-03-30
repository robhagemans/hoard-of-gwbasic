'Include file for POW! Library for PowerBASIC

declare function sbdetect() as integer
declare function sbfmdetect() as integer
declare sub sbfmclear()
declare sub sbreset()
declare sub sbfmsetports(word,word)
declare sub sbfmportout(integer,integer)
declare sub sbfmnote(integer,integer,integer,integer,integer,integer,integer)
declare sub sbfmsound(integer,integer,integer)
declare sub sbfmrhythm(integer,integer,integer,integer,integer)
declare sub sbbeep()
declare sub sbfmparms(integer,integer,integer,integer,integer)
declare sub sbdelay(integer)
declare sub sbfmplay(string)
declare sub sbplayfile(string,integer)
declare sub sbsetbase(integer)
declare function sbspeech() as integer
declare function sbcpuspeed() as integer
declare sub sbsay(string)
declare function sbsample$(integer,integer)
declare sub sbplaypow(string,integer)
declare function sbcheckdma() as integer
declare sub sbsetint(integer)
declare sub sbpresetmixer()
declare sub sbpsetmixer(integer,integer,integer,integer,integer,integer,integer)
declare sub sbsetdma(integer)
declare function sbsamplebyte() as integer
declare sub sbplaystring(string,integer)
declare sub sbpasystem()
declare sub sbplaydma(string,integer,integer)
declare function sbgetpow$(string,integer,integer,integer)
declare function sbcmfdetect() as integer
declare sub sbcmfplay(f$,any)
declare function sbcmfcheck() as integer
declare sub sbcmfsetspeed(integer)
declare sub sbcmfpause()
declare sub sbcmfresume()
declare sub sbcmfcancel()
declare sub sbcmftranspose(integer)
declare function sbpowname$(string,integer)
declare function sbmidiread() as integer
declare sub sbmidiwrite(integer)
declare sub sbarrayrecord(integer,integer,integer)
declare sub sbarrayplay(integer,integer,integer)
declare sub sbarraysave(string,integer,integer,integer)
declare sub sbarrayload(string,integer,integer,integer)

