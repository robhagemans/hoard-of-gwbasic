
#include <dos.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>

#include "BULLET.h"

/*
 bb_lai10.c 31-May-92 chh
 bb_lai10.c 22-Apr-93 chh fix Reindex return value to AP.stat
  
 --test raw speed using 32-bit long integer key, unique
 1) this test uses a non-standard binary field as a sort field
 2) this code is for raw speed tests--it's straight inline

 Note: memory model must be medium, large, or huge

For Turbo C 2.0:

 C>tcc -mm bc_lai10 BULLET.lib


For Quick C 2.50 (v2.50 *must not* use ATEXITXB (define QC250 to not)):

 C>tcl -Am bc_lai10 BULLET.lib

*/

/* #define QC250 sux */

struct memorypack MP;
struct initpack IP;
struct exitpack EP;
struct fielddesctype fieldlist[2];
struct createdatapack CDP;
struct createkeypack CKP;
struct dosfilepack DFP;
struct openpack OP;
struct accesspack AP;
struct exitpack EP;

int	rez, level;
div_t	div_rez;
time_t	starttime, endtime;

char	tmpstr[129];

char 	NameDAT[] = ".\\BINTEST.DBB\0";
char 	NameIX1[] = ".\\BINTEST.IX1\0";

char	kx1[] = "CODENUMBER\0";

unsigned handdat, handix1;

struct testrectype {
	char  tag[1];
	long  codenumber;
	char  codename[11];
}; /* 16 */
struct testrectype testrec;

char	keybuffer[64];

long	recs2add;
long	low;
long	high;
long	i;


int main()
{

   strcpy(fieldlist[0].fieldname, "CODENUMBER");
   strcpy(fieldlist[0].fieldtype, "B");
   fieldlist[0].fieldlen = 4;
   fieldlist[0].fielddc = 0;
   strcpy(fieldlist[1].fieldname, "CODENAME");
   strcpy(fieldlist[1].fieldtype, "C");
   fieldlist[1].fieldlen = 11;
   fieldlist[1].fielddc = 0;

   /* yes, it's been a while since my last C coding, like 1985  */
   /* ...just something to get used to...it's okay, though      */

   /* clrscr(); */
   printf("BC_LAI10.C - LONG INT, SIGNED, UNIQUE long int, add/reindex speed test\n");
   printf("--uses non-standard data files with binary field values, not DBF\n");
   printf(">> USING DIRECTORY : .\\ \n\n");

   level = 100;
   MP.func = MEMORYXB;
   rez = BULLET(&MP);
   printf("memory avail   : %lu\n",MP.memory);

   if (MP.memory < 40000l) {
      rez = 8;
      goto Abend;
   }

   level = 110;
   IP.func = INITXB;
   IP.jftmode = 0;
   rez = BULLET(&IP);
   if (rez != 0) goto Abend;

   /* --------------------------------------------------------------------
      Quick C uses a near _atexit for both medium and large standard LIBs
      This is of course a bug! and it prevents the use of ATEXITXB. This
      is with at least QC 2.50. If you experience a lock-up using ATEXITXB
      then you know what the problem is. Easy enough to get a fix. Call MS.
      And the problem is also in crt0dat. Turbo C operates correctly. */

#ifndef QC250
   level = 120;
   EP.func = ATEXITXB;
   rez = BULLET(&EP);
   if (rez != 0) goto Abend;
#endif

   level = 130;				/* disregard not found errors */
   DFP.func = DELETEFILEDOS;
   DFP.filenameptr = NameDAT;
   rez = BULLET(&DFP);
   DFP.filenameptr = NameIX1;
   rez = BULLET(&DFP);

   level = 1000;
   CDP.func = CREATEDXB;
   CDP.filenameptr = NameDAT;
   CDP.nofields = 2;
   CDP.fieldlistptr = fieldlist;
   CDP.fileid = 255;
   rez = BULLET(&CDP);
   if (rez !=0) goto Abend;

   level = 1010;
   OP.func = OPENDXB;
   OP.filenameptr = NameDAT;
   OP.asmode = READWRITE | DENYNONE;
   rez = BULLET(&OP);
   if (rez !=0) goto Abend;
   handdat = OP.handle;

   level = 1100;
   CKP.func = CREATEKXB;
   CKP.filenameptr = NameIX1;
   CKP.keyexpptr = kx1;
   CKP.xblink = handdat;
   CKP.keyflags = cLONG | cSIGNED | cUNIQUE;
   CKP.codepageid = -1;
   CKP.countrycode = -1;
   CKP.collateptr = NULL;
   rez = BULLET(&CKP);
   if (rez !=0) goto Abend;

   level = 1110;
   OP.func = OPENKXB;
   OP.filenameptr = NameIX1;
   OP.asmode = READWRITE | DENYNONE;
   OP.xblink = handdat;
   rez = BULLET(&OP);
   if (rez !=0) goto Abend;
   handix1 = OP.handle;

   AP.func = ADDRECORDXB;
   AP.handle = handdat;
   AP.recptr = &testrec;
   AP.keyptr = keybuffer;
   AP.nextptr = NULL;

   strcpy(testrec.tag," \0");
   strcpy(testrec.codename, "xxxSAMExxxx\0");

   printf("Recs to add/reindex: ");
   gets(tmpstr);
   recs2add = atol(tmpstr);
   if (recs2add == 0L) recs2add = 5L;

   level = 1200;
   low = -3L;
   high = low + recs2add - 1L;
   printf("Adding %ld records ( keys %ld to %ld )... ",recs2add,low,high);

   time(&starttime);
   for (i = low; i < (recs2add+low); i++) {
      testrec.codenumber = i;
      rez = BULLET(&AP);
      if (rez !=0) goto Abend;
   }
   time(&endtime);
   printf("%lu secs.\n",(endtime - starttime));

   level = 1210;
   printf("Reindexing... ");
   AP.func = REINDEXXB;
   AP.handle = handix1;
   time(&starttime);
   rez = BULLET(&AP);
   time(&endtime);
   if (rez != 0) {
      rez = AP.stat;    /* MUST take AP.stat since a xaction routine */
      goto Abend;       /* see docs and !README2.TXT for more */
   }
   printf("%lu secs\n\n",(endtime - starttime));

   level = 1300;
   AP.func = GETFIRSTXB;
   rez = BULLET(&AP);
   printf("  The first 5 key/recs\n");
   printf("%7lu %7ld %.11s\n",AP.recno,testrec.codenumber,testrec.codename);
   for (i=1;i < 5; i++) {
      if (rez != 0) break;
      AP.func = GETNEXTXB;
      rez = BULLET(&AP);
      printf("%7lu %7ld %.11s\n",AP.recno,testrec.codenumber,testrec.codename);
   }
   if (rez == 202) rez = 0;
   if (rez != 0) goto Abend;
   puts(" ");

   level = 1310;
   AP.func = GETLASTXB;
   rez = BULLET(&AP);
   printf("  The last 5 key/recs\n");
   printf("%7lu %7ld %.11s\n",AP.recno,testrec.codenumber,testrec.codename);
   for (i=1;i < 5; i++) {
      if (rez != 0) break;
      AP.func = GETPREVXB;
      rez = BULLET(&AP);
      printf("%7lu %7ld %.11s\n",AP.recno,testrec.codenumber,testrec.codename);
   }
   if (rez == 203) rez = 0;
   if (rez != 0) goto Abend;

   puts("Okay.");
   EP.func = EXITXB;
   rez = BULLET(&EP);
   return(0);
   /* program exit */


   /*----------------------------------------------*/
   /* that's right, we go to a termination routine */

Abend:
   printf("Error: %u at level %u while performing ",rez,level);
   switch (level) {
   case 100:
      printf("a memory request of 140K.\n");
      break;
   default:
      printf("(See source)\n");    /* just check the source */
   }

   exit(1);
}

