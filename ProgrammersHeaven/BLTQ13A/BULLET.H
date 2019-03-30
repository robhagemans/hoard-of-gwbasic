/*      bullet.h

        Defines the BULLET library's structs, consts, and function declaration

        v1.03 22-Apr-93

    ***********************************************************************
    * NOTE: BULLET is for medium, large, or huge models (do not use tiny, *
    * ---- small, or compact since these allow for only 1 code segment).  *
    ***********************************************************************

     Struct types must be standard byte packed; do not special align elements
*/

#pragma pack(1)

int     far pascal BULLET(void far *datapack);

#define INITXB          0            /* system */
#define EXITXB          1
#define ATEXITXB        2
#define MEMORYXB        3
#define BREAKXB         4
#define BACKUPFILEXB    5
#define STATHANDLEXB    6
#define GETEXTERRORXB   7
#define DVMONCXB        9

#define CREATEDXB       10           /* data control mid-level */
#define OPENDXB         11
#define CLOSEDXB        12
#define STATDXB         13
#define READDHXB        14
#define FLUSHDHXB       15
#define COPYDHXB        16
#define ZAPDHXB         17

#define CREATEKXB       20           /* key control mid-level */
#define OPENKXB         21
#define CLOSEKXB        22
#define STATKXB         23
#define READKHXB        24
#define FLUSHKHXB       25
#define COPYKHXB        26
#define ZAPKHXB         27

#define GETDESCRIPTORXB 30           /* data access mid-level */
#define GETRECORDXB     31
#define ADDRECORDXB     32
#define UPDATERECORDXB  33
#define DELETERECORDXB  34
#define UNDELETERECORDXB 35
#define PACKRECORDSXB   36

#define FIRSTKEYXB      40           /* key access mid-level */
#define EQUALKEYXB      41
#define NEXTKEYXB       42
#define PREVKEYXB       43
#define LASTKEYXB       44
#define STOREKEYXB      45
#define DELETEKEYXB     46
#define BUILDKEYXB      47
#define CURRENTKEYXB    48

#define GETFIRSTXB      60           /* key & data access high-level */
#define GETEQUALXB      61
#define GETNEXTXB       62
#define GETPREVXB       63
#define GETLASTXB       64
#define INSERTXB        65
#define UPDATEXB        66
#define REINDEXXB       67

#define LOCKXB          80           /* network control */
#define UNLOCKXB        81
#define LOCKKEYXB       82
#define UNLOCKKEYXB     83
#define LOCKDATAXB      84
#define UNLOCKDATAXB    85
#define DRIVEREMOTEXB   86
#define FILEREMOTEXB    87
#define SETRETRIESXB    88

#define DELETEFILEDOS   100          /* DOS file I/O low-level */
#define RENAMEFILEDOS   101
#define CREATEFILEDOS   102
#define OPENFILEDOS     103
#define SEEKFILEDOS     104
#define READFILEDOS     105
#define WRITEFILEDOS    106
#define CLOSEFILEDOS    107
#define ACCESSFILEDOS   108
#define EXPANDFILEDOS   109
#define MAKEDIRDOS      110

#define cUNIQUE         1            /* key type flags */
#define cCHAR           2
#define cINTEGER        16
#define cLONG           32
#define cNLS            0x4000       /* note: cNLS is set by BULLET */
#define cSIGNED         0x8000

#define READONLY        0            /* do NOT use O_RDONLY,O_WRONLY,O_RDWR */
#define WRITEONLY       1
#define READWRITE       2

#define COMPAT          0X0000       /* okay to use SH_DENYRW, etc. */
#define DENYREADWRITE   0x0010       /* or O_DENYREADWRITE, etc.    */
#define DENYWRITE       0x0020
#define DENYREAD        0x0030
#define DENYNONE        0x0040
#define NOINHERIT       0x0080


struct accesspack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        long            recno;       /* signed */
        void       far *recptr;
        void       far *keyptr;
        void       far *nextptr;
}; /* 22 */

struct breakpack {
        unsigned        func;
        unsigned        stat;
        unsigned        mode;
}; /* 6 */

struct copypack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        char       far *filenameptr;
}; /* 10 */

struct createdatapack {
        unsigned        func;
        unsigned        stat;
        char       far *filenameptr;
        unsigned        nofields;
        void       far *fieldlistptr;
        unsigned        fileid;
}; /* 16 */

struct createkeypack {
        unsigned        func;
        unsigned        stat;
        char       far *filenameptr;
        char       far *keyexpptr;
        unsigned        xblink;
        unsigned        keyflags;
        int             codepageid;
        int             countrycode;
        char       far *collateptr;
}; /* 24 */

struct fielddesctype {
        char            fieldname[11];
        char            fieldtype[1];
        unsigned long   fieldda;
        unsigned char   fieldlen;
        unsigned char   fielddc;
        long            fieldrez;
        char            filler[10];
}; /* 32 */

struct descriptorpack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        unsigned        fieldnumber;
        struct fielddesctype   fd;
}; /* 40 */

struct dosfilepack {
        unsigned        func;
        unsigned        stat;
        char       far *filenameptr;
        unsigned        handle;
        unsigned        asmode;
        unsigned        bytes;
        long            seekoffset;
        unsigned        method;
        void       far *bufferptr;
        unsigned        attr;
        char       far *newnameptr;
}; /* 30 */

struct dvmonpack {
        unsigned        func;
        unsigned        stat;
        unsigned        mode;
        unsigned        handle;
        unsigned        vs;
}; /* 10 */

struct exitpack {
        unsigned        func;
        unsigned        stat;
}; /* 4 */

struct handlepack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
}; /* 6 */

struct initpack {
        unsigned        func;
        unsigned        stat;
        unsigned        jftmode;
        unsigned        dosver;
        unsigned        version;
        unsigned long   exitptr;
}; /* 14 */

struct memorypack {
        unsigned        func;
        unsigned        stat;
        unsigned long   memory;
};

struct openpack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        char       far *filenameptr;
        unsigned        asmode;
        unsigned        xblink;
}; /* 14 */

struct remotepack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        unsigned        isremote;
        unsigned        flags;
        unsigned        isshare;
}; /* 12 */

struct setretriespack {
        unsigned        func;
        unsigned        stat;
        unsigned        mode;
        unsigned        pause;
        unsigned        retries;
}; /* 10 */

struct statdatapack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        unsigned char   filetype;
        unsigned char   dirty;
        unsigned long   recs;
        unsigned        reclen;
        unsigned        fields;
        char            f1;
        unsigned char   luyear;
        unsigned char   lumonth;
        unsigned char   luday;
        unsigned        hereseg;
        char            filler[10];
}; /* 32 */

struct statkeypack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        unsigned char   filetype;
        unsigned char   dirty;
        unsigned long   keys;
        unsigned        keylen;
        unsigned        xblink;
        unsigned long   xbrecno;
        unsigned        hereseg;
        unsigned        codepageid;
        unsigned        countrycode;
        unsigned        collatetablesize;
        unsigned        keyflags;
        char            filler[2];
}; /* 32 */

struct stathandlepack {
        unsigned        func;
        unsigned        stat;
        unsigned        handle;
        unsigned        id;
        char       far *filenameptr;
}; /* 12 */

struct xerrorpack {
        unsigned        func;
        unsigned        stat;
        unsigned        class;
        unsigned        action;
        unsigned        location;
}; /* 10 */

#pragma pack()

/* end of BULLET.H */
