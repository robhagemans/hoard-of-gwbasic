#include <dos.h>
#include <stdlib.h>
#include <stdio.h>
#include <process.h>
#include <conio.h>
#include<io.h>
#include <fcntl.h>
#include <dir.h>
#include <string.h>
#include <mytype.h>
#include <ctype.h>
#include <vga256c.H>
#include <sprites.h>


int Savepalette(char *filename,unsigned char palette[768])
      {
   unsigned nwrite;
   int handle;
   // While there are input buffers with data, write them to disk
	 if (_dos_creat(filename, _A_NORMAL, &handle) != 0){
	    return 0;
	  }
      _dos_write(handle,palette,768,&nwrite);
      _dos_close(handle);

       if(nwrite==768)
	     return 1;
	       else
		return 0;
}

int loadpalette(char *filename,unsigned char  palette[768])
      {

FILE  *Handler;
unsigned char data;
unsigned int i;

  Handler = fopen(filename,"rb");/* open file */
  if(Handler== NULL){            /* Return 0 if file not open */
	  return 1;
       }

    for(i=0;i<768;i++){
    fread(&data,1,1,Handler);
    palette[i]=data;               /* Store bytes in Buffer       */
     }
    fclose(Handler);
 return 0;
}


int getcommand(char * com[])
{

if(!(strcmp(strupr(com[1]),"FADE_IN"))){
	   return 1;
	  }
if(!(strcmp(strupr(com[1]),"FADE_OUT"))){
	   return 2;
	  }

if(!(strcmp(strupr(com[1]),"SAV_PAL"))){

	   return 3;
	  }



return 0;
}




void main(int argc ,char* argv[])
{
if( argc < 2 ){
 printf("\nMode 13h Palette FX");
 printf(COPYRIGHT);
 printf("\nWarning: VGA mode 13h only\n");

 printf("\nCommand: fade_in|fade_out|sav_pal");
 exit(1);
}


switch(getcommand(argv))
 {
case 1:
loadpalette("PALETTE.PAL",palette_2);
Fade_In();
break;

case 2:
loadpalette("PALETTE.PAL",palette_1);
Fade_Out();
break;

case 3:
Get_Palette();
Savepalette("PALETTE.PAL",palette_1);
break;
    }
}







