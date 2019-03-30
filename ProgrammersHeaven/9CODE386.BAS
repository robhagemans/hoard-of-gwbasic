DECLARE SUB CPYDEMO ()                 'demonstrating .386 blockcopy
DECLARE FUNCTION GETSCREEN13$ ()
DECLARE FUNCTION PUTSCREEN13$ ()
DECLARE FUNCTION BLOCKCPY$ ()          'aligned blockcopy

DECLARE SUB CPU386ID ()                'do we have 386+
DECLARE SUB MULLEA ()                  'demonstrating multiply with LEA
DECLARE SUB PMODE.DETECT ()            'are we in pmode ?

'ASSEMBLY IN QBASIC 9: .386 CODING.(rick@tip.nl)
'------------------------------------
CLS
'INTRODUCTION
'------------
'
'Although most people run there programs on a pentium nowadays, most
'programmers still consider the .386 the last real change. The .386
'PC added a lot of new instructions to the set, it added the use
'of 32 bit wide extended registers, and it added a usable pmode.
'Compared to the changes mentioned the changes the .486 ( pipeline)
'and pentium( double pipeline) added were only minor. In this article
'I will shortly touch upon the various .386 topics and include also
'a paragraph about the meaning of the .486 for your code. Pentium
'optimizing goes unnoticed here. It is hoped that after reading
'this article you have an idea how to use .386 codes inside QBASIC and
'also have some basic feeling for .386/.486 optimizing. That will give
'you a start when studying 'real' optimizing texts..

'--------------------------------------
'A)INTRODUCTION TO EXTENDED REGISTERS
'--------------------------------------
'Since a lot of QBASIC users do not have .386 assemblers but only debug
'or valarrow at their disposal, they might have trouble to find out that
'QBASIC is quit capable of executing .386 codes too. That is why I
'will summarize the rules for extended register use below.

'I will assume that everyone has the ability to get the .286
'instructions decoded with debug, and will only add the rules
'needed to extend those instructions.

'1)EXTENDED REGISTERS AS REGISTERS:
'RULE: ADD &H66 BEFORE THE 8086 MACHINE CODE

'EXAMPLES:
'   MOV AX,BX    =      &H8B &HC3
'   MOV EAX,EBX  = &H66 &H8B &HC3

'   XCHG AX,[BX] =      &H87 &H7
'   XCHG EAX,[BX]= &H66 &H87 &H7

'   MOV [BX],AX  =      &H89 &H7
'   MOV [BX],EAX = &H66 &H89 &H7

'   XOR AX,AX    =      &H31 &HC0
'   XOR EAX,EAX  = &H66 &H31 &HC0

'2) EXTENDED REGISTERS IN MEMORY REFERENCES:
'RULE: ADD &H67 BEFORE THE 8086 MACHINE CODE

'EXAMPLES:
'   MOV AX, [BX] =      &H8B &H07
'   MOV AX,[EBX] = &H67 &H8B &H07

'   XCHG AX,[BX] =      &H87 &H7
'   XCHG AX,[EBX]= &H67 &H87 &H7

'   MOV [BX],AX  =      &H89 &H7
'   MOV [EBX],AX = &H67 &H89 &H7

'3) EXTENDED REGISTERS IN REGISTERS AND MEMORY REFERENCES:
'RULE: ADD &H67 &H66 BEFORE THE 8086 MACHINE CODE

'EXAMPLES:
'   MOV AX , [BX] =           &H8B &H07
'   MOV AX ,[EBX] = &H67      &H8B &H07
'   MOV EAX,[EBX] = &H67 &H66 &H8B &H07
'   MOV AX ,[BX]  =      &H66 &H8B &H07

'   XCHG AX ,[BX] =           &H87 &H07
'   XCHG AX ,[EBX]= &H67      &H87 &H07
'   XCHG EAX,[EBX]= &H67 &H66 &H87 &H07
'   XCHG EAX,[BX] =      &H66 &H87 &H07

'   MOV [BX] ,AX  =           &H89 &H07
'   MOV [EBX],AX  = &H67      &H89 &H07
'   MOV [EBX],EAX = &H67 &H66 &H89 &H07
'   MOV [BX] ,EAX =      &H66 &H89 &H07
	 
'B) INTRODUCTION TO NEW AND EXTENDED INSTRUCTIONS

'The .386 instruction set has a lot of new instructions and
'(dword)extended old instructions. I will introduce them and the
'rules to get them from debug's 8086 codes.

'1) MOVSD,STOSD,LODSD
'RULE: ADD &H66 BEFORE THE 8086 WORD MACHINE CODES

'EXAMPLES:
'   MOVSW      =      &HA5
'   MOVSD      = &H66 &HA5
	
'   STOSW      =      &HAB
'   STOSD      = &H66 &HAB

'   LODSW      =      &HAD
'   LODSD      = &H66 &HAD

'2) SHIFTS FOR MORE THEN ONE WITHOUT USING CL

'RULE: REPLACE THE FIRST BYTE OF THE 8086 MACHINE CODE BY &HC1
'      AND ADD THE NUMBER OF SHIFTS AS LAST BYTE

'EXAMPLES:
'   SHL DX,1   =      &HD1 &HE2
'   SHL DX,CL  =      &HD3 &HE2
'   SHL DX,2   =      &HC1 &HE2 &H2
'   SHL EDX,4  = &H66 &HC1 &HE2 &H4

'   SHR AX,1   =      &HD1 &HE8
'   SHR AX,CL  =      &HD3 &HE8
'   SHR AX,5   =      &HC1 &HE8 &H5
'   SHR EAX,9  = &H66 &HC1 &HE8 &H9

'3)CALL DWORDPOINTERS
'RULE:SUBSTRACT 9 FROM THE REGISTER SPECIFIC 8086 POINTERS
'     (WHICH IS THE SECOND BYTE)
 
'EXAMPLES:
'   CALL  WORDPTR[BX] = &HFF &H1F
'   CALL DWORDPTR[BX] = &HFF &H17

'   CALL  WORDPTR[SI] = &HFF &H1C
'   CALL DWORDPTR[SI] = &HFF &H14

'   CALL  WORDPTR[DI] = &HFF &H1D
'   CALL DWORDPTR[DI] = &HFF &H15

'4)POPA( POPAD)/PUSHA( PUSHAD)=

'This is a relativaly cheap way of pushing and popping all
'general purpose registers( that is ax,cx,dx,bx,sp,bp,si,di)
'totals up to 16 bytes pushed on the stack:

'EXAMPLES: PUSHA = &H60  CLOCKS ON 486: 11
'          POPA  = &H61  CLOCKS ON 486: 9

'SO THIS TOTALS UP TO:If you have to push/pop more then
'three of the general purpose registers you could optimize
'for speed by PUSHA/POPA SEQUENCE instead of push/pop
'of 4 clocks each.

'Of course the extended register can be pushed/popped by
'adding &h66 before the opcode for PUSHA/POPA

'EXAMPLES: PUSHAD = &H66 &H60
'          POPAD  = &H66 &H61

'5) LEA instruction.

'The LEA instruction is extended in two directions. First of all it
'can have every register as memory reference, secondly it allows you
'put some simple adress multiplications INSIDE the LEA instruction.
'Together that adds up to that you can use LEA to do some quick
'multiplications.

'GENERAL FORM: LEA Ereg,[Ereg*2^N+[Ereg]+[displacement]
'                        N IN [0..3]

'EXAMPLES: LEA EAX,[EAX*8-EAX] CALCULATES EAX*7

'RULE= ALWAYS PREFIXING &H66 &H67 &H8D( EXT,EXT, LEA)
'      AFTER THAT SOME CODES POINTING TO THE REGISTERS AND
'      MEMORY OPERANDS USED.

'Alas, the rules for getting to the other bytes are beyond me.
'So you can not use those in QBASIC when you do not have a .386
'assembler to verify that. As sort of a patch I will give the
'opcodes for LEA instructions I use most.


'EXAMPLES:
' LEA EAX,[EAX]        = &H66 &H67 &H8D &H00
' LEA EAX,[EAX*2]      = &H66 &H67 &H8D &H04 &H45 &H00000000
' LEA EAX,[EAX*2+4]    = &H66 &H67 &H8D &H04 &H45 &H00000004
' LEA EAX,[EAX*2]      = &H66 &H67 &H8D &H04 &H45 &H00000000
' LEA EAX,[EAX*2+EAX]  = &H66 &H67 &H8D &H04 &H40
' LEA EAX,[EAX*2+EBX]  = &H66 &H67 &H8D &H04 &H43
' LEA EAX,[EAX*2+EAX+4]= &H66 &H67 &H8D &H44 &H40 &H04
' LEA EAX,[EAX*2+EBX+4]= &H66 &H67 &H8D &H44 &H43 &H04
'
' LEA EAX,[EAX*4]      = &H66 &H67 &H8D &H04 &H85 &H00000000
' LEA EAX,[EAX*4+3]    = &H66 &H67 &H8D &H04 &H85 &H00000003
' LEA EAX,[EAX*4+EAX]  = &H66 &H67 &H8D &H04 &H80
' LEA EAX,[EAX*4+EBX]  = &H66 &H67 &H8D &H04 &H83
' LEA EAX,[EAX*4+EAX+4]= &H66 &H67 &H8D &H84 &H80 &H00000004
' LEA EAX,[EAX*4+EBX+4]= &H66 &H67 &H8D &H84 &H83 &H00000004

' LEA EAX,[EAX*4]      = &H66 &H67 &H8D &H04 &HC5 &H00000000
' LEA EAX,[EAX*4+3]    = &H66 &H67 &H8D &H04 &HC5 &H00000003
' LEA EAX,[EAX*4+EAX]  = &H66 &H67 &H8D &H04 &HC0
' LEA EAX,[EAX*4+EBX]  = &H66 &H67 &H8D &H04 &HC3
' LEA EAX,[EAX*4+EAX+4]= &H66 &H67 &H8D &H44 &HC0 &H00000004
' LEA EAX,[EAX*4+EBX+4]= &H66 &H67 &H8D &H44 &HC3 &H00000004

'After a little thought we might agree that the displacement is viewed
'as a long value( use MKL$ for that), that the byte thats before that
'is signifying the number of the multiplication( &hC, &h8, &h4 for multiples
'by 8,4,2) and also the register used for multiply(&h3=(e)bx,&h5=(e)ax, etc
'you can get that with debug).

'To know what you can do with LEA I have prepared some example code
'It will give a short example of a program to use for multiplication by 1021.

'At first it might look more difficult then using MUL, but :

'a) It is not, since MUL puts results in DX:AX and you have to get that
'    back too.
'b) It is a lot faster. In general LEA is better to use when you have
'   to do a multiplication by a constant which you can hardcode..

'look for *all* information about multiplying with a constant using
'the most optimized methods on Paul Hsiehs homepage at:
'HTTP://WWW.GEOCITIES.COM/SILICONVALLEY/9498/amult.html

CALL MULLEA


'6)SET CC INSTRUCTIONS

'On .386 processors there are a lot of SET instructions available
'which can be used to avoid JUMPS in a relativaly cheap way.
'In general all JUMPS have there eguivalent in SETS like:

'SETNZ , SETZ, SETC, SETNC, SETAE, SETB, etc etc

'The SET instructions needs one 8 bit operand. It can be a 8 bit memory
'reference or an eight bit register:

'SETZ AL OKE
'SETZ AH OKE
'SETZ AX ERROR

'SETZ BYTE PTR [BX] OKE
'SETZ BYTE PTR [100] NOT OKE( Not a memory reference but immidiate.

'The opcode consist of three parts: The opcode for SET, the opcode for
'the FLAVOR OF SET(Z,NZ,G,B,L etc.etc.) and the opcode for the register
'or memory reference to set. I will give a few examples from which it must
'be possible to put every set instruction together:

'SETZ  AL =&H0F &H94 &HC0
'SETNZ AL =&H0F &H95 &HC0
'SETNZ[BX]=&H0F &H95 &H07


'RULES:

'THE FIRST  OPCODE &H0F = PREFIX FOR EVERY SET CODE
'THE SECOND OPCODE      = POINTING TO THE SORT OF SET = THE JUMPCODE+&H20
'EXAMPLES:
'       JNZ  =&H75 ..
'       SETNZ=&H95

'THE THIRD OPCODE       = THE OPERAND [AL=&HC0, [BX]=&H07 ETC ETC..]=SAME
'                         FOR ALL INSTRUCTIONS


'Since you might wonder why this SET instruction set is there I have
'prepared some example code. In general you can use this SET instructions
'to avoid jumps. We will see why avoiding jumps is very important sometimes.
'In the example we determine if the user has at least a .386 PC. I thought
'translating that widely used INTEL code to QBASIC was worth it, since
'without it we CAN NOT make use of all the goodies in this text!

CALL CPU386ID


'C) THE .486 PIPELINED MACHINES: AVOIDING AGI'S

'As i have been saying the .486 PC is not so big a deal. There is however
'one programming concept that you have to know when you are programming
'for .486 and above and that concept will be the topic in this section.

 
'The .486 and pentium do not execute every instruction behind each
'other. At one moment in time the processor is handling as much as 5
'instructions, all at different stages of processing. I will not explain
'everything in detail( I wonder If I even could(g)), but the main thing to
'know is that there can be pipeline stalls, when the processor can not
'progress in a normal way. When one instruction use a register as destiny
'of an adress calculation and the next instruction is using the same
'register as source, then the processor can not execute both instructions
'at the same time. It has to wait until the first is done.

'EXAMPLES:

'(0)mov bx,[bp+08]
'(1)mov di,[bp+06]
'(2)mov ax,[di]

'Normallly both instructions (1)and (2) will be in the pipeline at different
'stages of processing, but when the processor looks at something like this
'it does not process mov ax,[di] until di is calculated in (1).
'Therefore, although it might look strange at first it is more optimal to
'use:

'EXAMPLES:

'GET POINTERS FROM THE STACK
'mov di,[bp+06]
'mov bx,[bp+08]

'GET VALUES
'mov ax,[di]
'mov cx,[bx]

'Another more obvious source of pipelinestalls is every JUMP. When you are
'thinking about it this might be obvious: After a JUMP CS:IP is changed so
'the processor has to empty his pipeline and fill it again..

'This sort of stalls is the reason why SET on condition instructions are
'often used instead of JUMP on condition instructions. The SET instructions
'do not execute a pipelinestall.

'EXAMPLE:

'STATEMENT TRANSLATED: IF A THEN A=0 ELSE A=1

'1) OR AX,AX
'2) JNZ else
'3) MOV AX,1
'4) JMP done
'else:  MOV AX,0
'done:  ....etc

'When the processor reaches 'JNZ else' he is executing 5 instructions at
'different levels. But when the jump is taken( i.e. AX<>0) then he has
'to start all over again. All previously loaded instruction have become
'worthless. That is why jump taken costs more then jump not taken!
'The same process however is done again for the condition that AX= 0
'when we reach JMP done...That is why the code above should be replaced
'by:

' OR AX,AX
' SETNZ AL

'No pipeline problems here!

'Before turning to example codes showing .386 copying routines we have
'to go through another very important feature called aligning. When you
'use aligned data that will speed up your routines considerably, certainly
'when you use REP MOV instructions. Aligning is meaning that WORD operands
'have to be at adresses that are divisable by 2, and DWORD operands that
'are divisable by 4. Knowing that moving double words is faster then
'moving bytes or words, Paul Hsieh has developed an optimized copy routine
'which I ported to QBASIC. The routine is demonstrated after a somewhat more
'straightforward example of screen13 grabbing( no need for aligning there).
'Paul has set up his routine to include an aligned dword copy middle. That
'is why he has to copy some bytes before and some after in some not aligned
'cases. If you wanna know more about the theory behind it you are referred
'again to Paul Hsiehs site: HTTP://WWW.GEOCITIES.COM/SILICONVALLEY/9498


CALL CPYDEMO


'If you wanna know more about optimizing, .386 and 486 processors, then there
'are a few good sources at: HTTP://ANNOUNCE.COM/AGNER/ASSEM/PENTOPT.ZIP


'D) PMODE on .386 + MACHINES

'Of course a very important feature of .386 PC s is that it has made
'possible a handsome (g) protected mode. On .286 you could only get IN
'protected mode and never out again, but in .386 + machines getting back
'to real mode is possible too.

'I will not go into everything about PMODE, but will try to make a very BASIC
'introduction. Often people are already just scared of by the very name of it,
'and well I do not think PMODE is basically that difficult. You could use it
'in a difficult manner, and a lot of the information is not readily available,
'or encryted, or spread over a lot of sources, but it is not difficult perse.


'IMHO the basics of pmode looking at it from RMODE are:

'a)extra registers
'b)different segmentadressing
'c)different interruptadressing

'a) Extra registers.

'A .386 machine has some extra registers:

'1) Control registers CR0, CR1, CR2, CR3
'2) Table registers GDTR, IDTR, LDTR
'3) Extra segment registers FS, GS

'FS and GS are just extra segment registers like ES. In general you
'should not use them in your ASM$ routines in QBASIC because
'the are accesses slower then ES and DS.

'From the Control registers( CR0..CR3) the CR0 is the only
'one that is very important to know anything off. This register
'has at the lowest 5 bits a few important flags, from which
'the bit 0 is the PMODE flag. If this bit is set then we are in
'PMODE/V86 mode. If it is not set then we are in REAL mode.

'I prepared some example code which determins from CR0 values if
'you are in REAL MODE. Run it both in PLAIN DOS and from a DOSBOX
'and notice the difference

CALL PMODE.DETECT

'The CR0 condition described is also sufficient conditions for
'getting into PMODE/RMODE. So when you are in real mode( PLAIN DOS)
'then the code

'mov eax,cr0
'or al,1
'mov cr0,eax  =&HF &H22 &HC0

'is sufficient to get you in PMODE. Easy isn't it ?

'Not that you can do anything with that at this moment, but you are in the
'PZONE>.

'The last three registers (IDTR/GDTR/LDTR) will be handled below since they
'have to do with segment and interrupt adressing.

'b) Another segment adressing

'When we are in real mode we are used to think that the values we
'load in segment registers are memory references. Since CS, DS, ES, FS, GS
'are only 16 bit wide this can not work for memory references which
'exceeds 1 MB( the maximum reachable space with 16 bits segments).

'That is why INTEL designed something for it. You load your segments
'in pmode not with memory values, but with an index in a table which
'points( among other things) to a memory value. This index is called
'a SELECTOR. Since every index takes up 8 bytes, the indici are always
'a multiple of 8. Also the first index is reserved so that would make
'indici 8, 16, 24, 32 etc available. So in pmode you get something like:

'MOV AX,8
'MOV DS,AX
'MOV AX,24
'MOV ES,AX

'Which does NOT point DS to &h8, but to the first index in some table.

'This table is called the GDT. It can be virtually everywhere in memory
'so we need a pointer to where it is too. That pointer is called the
'GDT register( GDTR) which expects a 48 bit absolute value. An absolute
'value is nothing more or less then segment*16+offset. So when we make
'a GDT then we have to pass a pointer to it by loading the absolute
'value of it with the GDTR instruction.

'This table the GDT consists of 8 byte descriptors. That is why it is
'called General Descriptor Table. The descriptor contains information
'about the adress of the selector, the size of it( called that limit),
'some newflags and the privilige level of the selector . The only things
'that are really new about this are the privilige level and the newflags.

'The privilige level is were protected mode got its name from. You can make
'descriptors of all kinds, which can have all kinds of access or not. I am
'not going into it in detail here, but I quickly mention that normally you
'can not write to your code segments in pmode. That is why mostly the
'codesegments base/limit is aliased( copied) as a datasegment. By writing to
'the datasegment you can still write to the same memory as the codesegment
'that way.

'A DESCRIPTOR:

'DW LIMIT(low 16)
'DW BASE (low 16)
'DB BASE (middle 8)
'DB ACCESS
'DB LIMIT(high 4)+newflags
'DW BASE (high 8)

'As you can see you have to fill in a LIMIT of 20 bits( absolute adress)
'and a BASE of 32 bits( absolute adress) and in addition a few other things.
'The access I have shortly been speaking about. You have to read up on
'the referred texts to fully get that. But a value of &h92 will give
'you an highest access normal datasegment.

'What I left out for a moment was the newflags. They are most important
'for flat mode. You might already have noticed that the limit field is
'only 20 bit wide. So that makes up for 20 bit absolute adressing which
'is nothing more then 1 MB.

'BYTE 6:
'newflag| lim(h)
'       |
'G|D|0|5|4|3|2|1
 

'The newflags however contains a flag G that is called GRANULARITY. When this
'bit is set then the limit is indicating PAGES instead of BYTES. Since a page
'is 4 KB this will extend the limits possibilities to the advertised 4 GB !.

'The other important newflag D is determining the default segmentsize.
'If this bit is set then you can use the full 32 bit adressing , and if
'zeroed then you can only use 16 bit adressing( which in a 4 GB segment
'will not help you much). The flag called 0 is not important ( must be zero)
'and bit 5 is for use by programmers( free).

'This is all coming down to a descriptor set up like this for a 4 GB
'adressable segment:

DIM GDT(7)
GDT(4) = &HFFFF 'LIMIT LOW= &HFFFF
GDT(5) = 0      'BASE ADRESS =0
GDT(6) = &H9200 'ACCESS RIGHTS= &H92, BASE MIDDLE=0
GDT(7) = &HCFFF 'LIMIT HIGH =&HFF, NEWFLAGS=&HCF(GRAN SET, DEF SET)

'This is basically all there is about segment adressing in pmode. You load
'up your GDT with GDTR to point at your new GDT( remember to take the
'absolute adress) and thats that. There are a few more tricks, like
'setting up the pointer to your GDT in the zero desriptor( works nice),
'etc, but for that I have to refer to Peters PMODE page, which describes
'all of this and more at:  HTTP://GLOBALSERVE.NET/~SUBDEATH/


'c) Another interrupt adressing

'In real mode the interrupt vector table is stored at 0:0 but in pmode
'the interrupt vector table can be anywhere in memory. In addition the
'boundery of 256 interrupts in rmode is left in pmode. You can assign
'less if you want. The way things are handles in pmode parralells the
'segment adressing very much: by the way of tables.
'In fact IDT uses exactly the same 8 byte descriptors although the have
'a different meaning. Since however setting up an IDT requires handling
'the pmode exceptions( int < 32) and in a lot of cases the resetting
'of the PIC I will not go into detail. The only thing you have to know
'is that when you are in pmode that it is not necessarily so that your
'interrupts are pointing to the real mode interrupts. You have to redirect
'them.

'Well basic assemblers this was about it. The ASM in QBASIC series will
'end here, at least my contributions to it. Maybe some other will take over.
'In fact I hope so. But I really do not know very much more to tell you all.
'You will see a lot of techniques I explained in other articles by me and
'other people on a variety of topics. But basically I have the feeling that
'I was doing more ASM then QBASIC lately, so that called for two other
'approaches: 1) building a QBASIC compiler which also handles some
'               restricted asm keywords.
'            2) Transferring my main programming to MASM alltogether.

'I will try to keep you all posted on that ones! And for this moment thanks
'for your attentions and reactions.

'Good bye.

'Rick

DEFSTR A-Z
FUNCTION BLOCKCPY
'-----------------------------------------------------------
'This is an aligned blockcopy which makes use of
'Paul Hsiehs align method and .386 coding

'STACKPASSING: BYVAL(SRCSEG),BYVAL(SRCOFF)
'              BYVAL(DESTSEG),BYVAL(DESTOFF),NROFBYTES


'-----------------------------------------------------------
''SET UP STACKFRAME
ASM = ASM + CHR$(&H55)                              'PUSH BP
ASM = ASM + CHR$(&H89) + CHR$(&HE5)                 'MOV BP,SP
ASM = ASM + CHR$(&H1E)                              'PUSH DS
ASM = ASM + CHR$(&H6)                               'PUSH ES
'GET LEN POINTER FROM THE STACK
ASM = ASM + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)     'MOV BX,[BP+06]>LEN
'LOADS SOURCE TO DS[SI], DEST TO ES[DI], LEN TO CX
ASM = ASM + CHR$(&HC4) + CHR$(&H7E) + CHR$(8)       'LES DI,[BP+8]
ASM = ASM + CHR$(&H8B) + CHR$(&HF)                  'MOV CX,[BX]
ASM = ASM + CHR$(&HC5) + CHR$(&H76) + CHR$(&HC)     'LDS SI,[BP+C]
'ALIGN THE START OF THE COPYROUTINE TO ES[DI]MOD 4 =0
ASM = ASM + CHR$(&H89) + CHR$(&HC8)                 'MOV AX,CX
ASM = ASM + CHR$(&H29) + CHR$(&HF9)                 'SUB CX,DI
ASM = ASM + CHR$(&H29) + CHR$(&HC1)                 'SUB CX,AX
ASM = ASM + CHR$(&H81) + CHR$(&HE1) + MKI$(&H3)     'AND CX,3
ASM = ASM + CHR$(&H29) + CHR$(&HC8)                 'SUB AX,CX
ASM = ASM + CHR$(&H7E) + CHR$(13)                   'JLE +13 ONLY_ENDBYTES
'COPY THE FIRST BYTES LEFT OVER WITH MOVSB
ASM = ASM + CHR$(&HF3) + CHR$(&HA4)                 'REP MOVSB
'ALIGN THE NUMBER OF BYTES FOR MAIN COPYLOOP TO LEN MOD 4=0
ASM = ASM + CHR$(&H89) + CHR$(&HC1)                 'MOV CX,AX
ASM = ASM + CHR$(&H25) + CHR$(&H3) + CHR$(&H0)      'AND AX,3
ASM = ASM + CHR$(&HC1) + CHR$(&HE9) + CHR$(2)       'SHR CX,2 <386
'MAIN COPY LOOP WITH THE BLAZE OF MOVSD
ASM = ASM + CHR$(&HF3) + CHR$(&H66) + CHR$(&HA5)    'REP MOVSD< 386
'END_BYTES: COPY THE LEFT OVER BYTES WITH MOVSB
ASM = ASM + CHR$(&H1) + CHR$(&HC1)                  'ADD CX,AX
ASM = ASM + CHR$(&HF3) + CHR$(&HA4)                 'REP MOVSB
'WE ARE DONE :RETURN TO QBASIC
ASM = ASM + CHR$(&H7)                               'POP ES
ASM = ASM + CHR$(&H1F)                              'POP DS
ASM = ASM + CHR$(&H5D)                              'POP BP
ASM = ASM + CHR$(&HCA) + MKI$(10)                   'RETF A

BLOCKCPY = ASM

END FUNCTION

DEFSNG B-Z
SUB CPU386ID
'----------------------------------------------------------------------
'This is an INTEL procedure to detect if
'a .386 processor is available...

'Theory is that bits 12..15 are always zero
'on pre_386 processors like 286/8088/8086
'-----------------------------------------------------------------------
ASM = ASM + CHR$(&H55)                           'PUSH BP
ASM = ASM + CHR$(&H89) + CHR$(&HE5)              'MOV BP,SP
ASM = ASM + CHR$(&HB9) + CHR$(&H0) + CHR$(&H70)  'MOV CX,7000H SET BIT 12..15
ASM = ASM + CHR$(&H51)                           'PUSH CX
ASM = ASM + CHR$(&H9D)                           'POPF  CX > FLAGS
ASM = ASM + CHR$(&H9C)                           'PUSHF PUSH THEM AGAIN
ASM = ASM + CHR$(&H58)                           'POP AX AND GET THEM BACK
ASM = ASM + CHR$(&H25) + CHR$(&H0) + CHR$(&H70)  'AND AX,7000H MASK BITS 12..15
ASM = ASM + CHR$(&HF) + CHR$(&H95) + CHR$(&HC0)  'SETNZ 386
ASM = ASM + CHR$(&H30) + CHR$(&HE4)              'XOR AH,AH ZERO IT
ASM = ASM + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)  'MOV BX,[BP+06]
ASM = ASM + CHR$(&H89) + CHR$(&H7)               'MOV [BX],AX
ASM = ASM + CHR$(&H5D)                           'POP BP
ASM = ASM + CHR$(&HCA) + CHR$(&H2) + CHR$(&H0)   'RETF 2

PRINT : COLOR 0, 7: PRINT "CPUID DEMO"; : COLOR 7, 0: PRINT : PRINT

'________________________________________
codeoff% = SADD(ASM)
DEF SEG = VARSEG(ASM)
CALL ABSOLUTE(CPUid%, codeoff%)
'________________________________________
DEF SEG
IF CPUid% THEN PRINT "386+ AVAILABLE" ELSE PRINT "SORRY, NO 386+ AVAILABLE"
END SUB

DEFINT A-Z
SUB CPYDEMO

'In this sub I will demonstrate dword copying from mem to mem
'(the one thats left over from speed.)
'In addition to a full screen copier, I also demonstrate an
'optimized copier which you can use for instance to cpy only
'a part of the screen very fast...[it uses aligning methods]

PRINT "press a key for next demo": SLEEP


'1) SCREENGRABBING...

'INITIALIZE

DIM save13%(32000)
GETCPY$ = GETSCREEN13$: PUTCPY$ = PUTSCREEN13$
SCREEN 13

'LETS PUT SOME ONSCREEN
FOR X = 1 TO 100
	CIRCLE (159, 99), X OR 8, 2 + 3 * X
NEXT

'AND COPY BACK AND FORTH

PRINT "PRESS KEY TO LET PICTURE VANISH": SLEEP:
DEF SEG = VARSEG(GETCPY$): CALL ABSOLUTE(save13%(), SADD(GETCPY$))
CLS : PRINT "PRESS KEY TO GET PIC BACK": SLEEP
CALL ABSOLUTE(save13%(), SADD(PUTCPY$))
LOCATE 1, 1: PRINT "PRESS KEY FOR ALGINED COPY DEMO": SLEEP: SCREEN 0: WIDTH 80, 25

'2) OPTIMIZED MEM TO MEM COPYING (F.I FOR PARTS OF THE SCREEN)

CPY$ = BLOCKCPY$

DIM SRC AS STRING * 10: SRC$ = "0WAT EEN!": SRCSEG = VARSEG(SRC$): SRCOFF = VARPTR(SRC)
DIM DEST AS STRING * 10: DEST$ = "1" + SPACE$(9): SRCSEG = VARSEG(DEST$): DESTOFF = VARPTR(DEST)

COLOR 0, 7: PRINT "OPTIMIZED BLOCKCOPY DEMO"; : COLOR 7, 0: PRINT : PRINT

CALL ABSOLUTE(BYVAL (SRCSEG), BYVAL (SRCOFF), BYVAL (SRCSEG), BYVAL (DESTOFF), 10, SADD(CPY$))
PRINT "DESTINY: "; DEST: PRINT
DEF SEG


END SUB

DEFSTR A-Z
FUNCTION GETSCREEN13
'-------------------------------------------------------------------
'This function gets a screen 13 to an QBASIC array. 386 + routine
'STACKPASSING: ARRAY%()
'IN          : SCREEN 13 EMPTY
'OUT         : ARRAY%() FILLED
'-------------------------------------------------------------------
'SET UP STACKFRAME
ASM = ASM + CHR$(&H55)                              'PUSH BP
ASM = ASM + CHR$(&H89) + CHR$(&HE5)                 'MOV BP,SP
ASM = ASM + CHR$(&H1E)                              'PUSH DS
ASM = ASM + CHR$(&H6)                               'PUSH ES
'GET POINTER TO ARRAY FROM STACK
ASM = ASM + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)     'MOV BX,[BP+06]>ARRAY()
'SET UP CX TO 64000/4, ES[DI] TO ARRAY, DS[SI] TO A000:0
ASM = ASM + CHR$(&HB9) + CHR$(&H80) + CHR$(&H3E)    'MOV CX,3E80h
ASM = ASM + CHR$(&HC4) + CHR$(&H3F)                 'LES DI,[BX] ARRAY()
ASM = ASM + CHR$(&H31) + CHR$(&HF6)                 'XOR SI,SI
ASM = ASM + CHR$(&HB8) + MKI$(&HA000)               'MOV AX,A000
ASM = ASM + CHR$(&H8E) + CHR$(&HD8)                 'MOV DS,AX SCREENSEG
'COPY IT USING THE BLAZE OF MOVSD
ASM = ASM + CHR$(&HF3) + CHR$(&H66) + CHR$(&HA5)    'REP MOVSD < 386
'WE ARE DONE :RETURN TO QBASIC
ASM = ASM + CHR$(&H7)                               'POP ES
ASM = ASM + CHR$(&H1F)                              'POP DS
ASM = ASM + CHR$(&H5D)                              'POP BP
ASM = ASM + CHR$(&HCA) + MKI$(2)                    'RETF 2

GETSCREEN13 = ASM

END FUNCTION

DEFSNG A-Z
SUB MULLEA

'This sub demonstrates multiplying constants by the use of LEA,
'which is much much faster then QBASICs * or ASMs mul.


COLOR 0, 7: PRINT "LEA MULTIPLICATION DEMONSTRATION";
COLOR 7, 0: PRINT : PRINT


'SET UP STACKFRAME
ASM$ = ASM$ + CHR$(&H55)                          'push bp
ASM$ = ASM$ + CHR$(&H89) + CHR$(&HE5)             'mov bp,sp

ASM$ = ASM$ + CHR$(&H8B) + CHR$(&H7E) + CHR$(&H6) 'mov di,[bp+06]
ASM$ = ASM$ + CHR$(&H66) + CHR$(&H8B) + CHR$(&H5) 'mov eax,[di]
ASM$ = ASM$ + CHR$(&H66) + CHR$(&H89) + CHR$(&HC3)'mov ebx,eax
ASM$ = ASM$ + CHR$(&H66) + CHR$(&HC1) + CHR$(&HE0)
ASM$ = ASM$ + CHR$(&HA)                       'shl eax,10 eax=eax*1024
ASM$ = ASM$ + CHR$(&H66) + CHR$(&H67) + CHR$(&H8D)
ASM$ = ASM$ + CHR$(&H1C) + CHR$(&H5B)      'lea ebx,[ebx*2+ebx]ebx*3
ASM$ = ASM$ + CHR$(&H66) + CHR$(&H2B) + CHR$(&HC3)'sub eax,ebx
ASM$ = ASM$ + CHR$(&H66) + CHR$(&H89) + CHR$(&H5) 'mov [di],eax

ASM$ = ASM$ + CHR$(&H5D)                         'pop bp
ASM$ = ASM$ + CHR$(&HCA) + CHR$(&H2) + CHR$(&H0) 'retf 2

'MULTIPLYING 89*1021
A& = 89: DEF SEG = VARSEG(ASM$): CALL ABSOLUTE(A&, SADD(ASM$)): DEF SEG
PRINT "VALUE BY ASM LEA ROUTINE : "; A&
PRINT "VALUE BY QBASIC '*'      : "; 89 * 1021&

END SUB

DEFSTR A
SUB PMODE.DETECT

'Below is some detection routine which should give different results in plain
'dos/windowed dos..Take notice that only Extended register can
'be loaded from CR0.


ligne% = CSRLIN: PRINT "press a key for next demo"; : SLEEP: LOCATE ligne%, 1
COLOR 0, 7: PRINT "PMODE DETECTION DEMONSTRATION"; : COLOR 7, 0: PRINT : PRINT


ASM = ASM + CHR$(&H55)                           'PUSH BP
ASM = ASM + CHR$(&H89) + CHR$(&HE5)              'MOV BP,SP
ASM = ASM + CHR$(&HF) + CHR$(&H1) + CHR$(&HE0)   'MOV EAX,CR0
ASM = ASM + CHR$(&H24) + CHR$(&H1)               'AND AL,1 MASK BIT 1(PE FLAG)
ASM = ASM + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)  'MOV BX,[BP+06]
ASM = ASM + CHR$(&H88) + CHR$(&H7)               'MOV [BX],AL
ASM = ASM + CHR$(&H5D)                           'POP BP
ASM = ASM + CHR$(&HCA) + CHR$(&H2) + CHR$(&H0)   'RETF 2

'determine if we are in REAL mode ?
DEF SEG = VARSEG(ASM): CALL ABSOLUTE(PM%, SADD(ASM)): DEF SEG
IF PM% THEN PRINT "We are in PMODE or V86 mode.." ELSE PRINT "Still in REAL mode.."

END SUB

DEFSTR B-Z
FUNCTION PUTSCREEN13
'-------------------------------------------------------------------
'This function gets a screen 13 to an QBASIC array. 386 + routine
'STACKPASSING: ARRAY()
'IN          : ARRAY() FILLED
'OUT         : SCREEN 13 FILLED
'-------------------------------------------------------------------
'SET UP STACKFRAME
ASM = ASM + CHR$(&H55)                              'PUSH BP
ASM = ASM + CHR$(&H89) + CHR$(&HE5)                 'MOV BP,SP
ASM = ASM + CHR$(&H1E)                              'PUSH DS
ASM = ASM + CHR$(&H6)                               'PUSH ES
'GET POINTER TO ARRAY FROM STACK
ASM = ASM + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)     'MOV BX,[BP+06]>ARRAY()
'SET UP CX TO 64000/4, ES[DI] TO ARRAY, DS[SI] TO A000:0
ASM = ASM + CHR$(&HB9) + CHR$(&H80) + CHR$(&H3E)    'MOV CX,3E80h
ASM = ASM + CHR$(&H31) + CHR$(&HFF)                 'XOR DI,DI
ASM = ASM + CHR$(&HB8) + MKI$(&HA000)               'MOV AX,A000
ASM = ASM + CHR$(&H8E) + CHR$(&HC0)                 'MOV ES,AX SCREENSEG
ASM = ASM + CHR$(&HC5) + CHR$(&H37)                 'LDS SI,[BX] ARRAY()
'COPY IT USING THE BLAZE OF MOVSD
ASM = ASM + CHR$(&HF3) + CHR$(&H66) + CHR$(&HA5)    'REP MOVSD < 386
'WE ARE DONE :RETURN TO QBASIC
ASM = ASM + CHR$(&H7)                               'POP ES
ASM = ASM + CHR$(&H1F)                              'POP DS
ASM = ASM + CHR$(&H5D)                              'POP BP
ASM = ASM + CHR$(&HCA) + MKI$(2)                    'RETF 2

PUTSCREEN13 = ASM

END FUNCTION

