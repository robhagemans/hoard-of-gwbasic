;3-D Rotation & Perspective
;By Rich Geldreich
;May 27th, 1992

;TASM v2.00 source code follows... set tab stops to 8, don't insert spaces

;Also see 3dexp2.bas from which this code was derived from.

;The following keys may be used in the program:(turn NumLock on!)

;spacebar.................stops all rotation
;"r" key..................resets all three angles
;"n" & "m" key............controls the third angle
;arrow keys...............controls the other two angles
;numeric keypad...........controls your position relative to the stars
;escape key...............quits

ideal
model small
dosseg
stack 1024

NumPoints = 765
P_Scaler = 4000
Z_Plane_Threshold = 130

;-------------------------------------------------------------------------------

dataseg 
even

;used for setting points...
line_table:
b=0
rept 200
	dw b*320
	b=b+1
endm

points_to_rotate:
include "pnt.asm"

	even
;simple bitmapped character font
characters:
	db 01110000b
	db 10011000b
	db 10011000b
	db 10101000b
	db 11001000b
	db 11001000b
	db 01110000b
	db 00000000b
		 
	db 00100000b
	db 01100000b
	db 10100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 11111000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 00010000b
	db 00100000b
	db 01000000b
	db 10000000b
	db 11111000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 00001000b
	db 00110000b
	db 00001000b
	db 10001000b
	db 01110000b
	db 00000000b
	            
	db 10001000b
	db 10001000b
	db 10001000b
	db 11111000b
	db 00001000b
	db 00001000b
	db 00001000b
	db 00000000b
	
	db 11111000b
	db 10000000b
	db 10000000b
	db 11110000b
	db 00001000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 10000000b
	db 11110000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 11111000b
	db 00001000b
	db 00010000b
	db 00100000b
	db 01000000b
	db 10000000b
	db 10000000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 10001000b
	db 01111000b
	db 00001000b
	db 10001000b
	db 01110000b
	db 00000000b
minus_sign:
	db 00000000b
	db 00000000b
	db 00000000b
	db 01111110b
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b
space:
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b
	db 00000000b

letters:
	db 00100000b
	db 01010000b
	db 10001000b
	db 11111000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 00000000b
	
	db 11110000b
	db 10001000b
	db 10001000b
	db 11110000b
	db 10001000b
	db 10001000b
	db 11110000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 11110000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 11110000b
	db 00000000b

	db 11111000b
	db 10000000b
	db 10000000b
	db 11110000b
	db 10000000b
	db 10000000b
	db 11111000b
	db 00000000b

	db 11111000b
	db 10000000b
	db 10000000b
	db 11110000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 00000000b
		  
	db 01110000b
	db 10001000b
	db 10000000b
	db 10111000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b
         
	db 10001000b
	db 10001000b
	db 10001000b
	db 11111000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 00000000b

	db 11111000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 11111000b
	db 00000000b
	     
	db 00001000b
	db 00001000b
	db 00001000b
	db 00001000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b

	db 10001000b
	db 10010000b
	db 10100000b
	db 11000000b
	db 10100000b
	db 10010000b
	db 10001000b
	db 00000000b

	db 10000000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 11111000b
	db 00000000b


	db 10001000b
	db 11011000b
	db 10101000b
	db 10101000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 00000000b

	db 10001000b
	db 11001000b
	db 10101000b
	db 10011000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 00000000b

	db 01110000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 11110000b
	db 10001000b
	db 10001000b
	db 11110000b
	db 10000000b
	db 10000000b
	db 10000000b
	db 00000000b

	db 01110000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10101000b
	db 10011000b
	db 01110000b
	db 00000000b

	db 11110000b
	db 10001000b
	db 10001000b
	db 11110000b
	db 10100000b
	db 10010000b
	db 10001000b
	db 00000000b
	
	db 01110000b
	db 10001000b
	db 10000000b
	db 01110000b
	db 00001000b
	db 10001000b
	db 01110000b
	db 00000000b

	db 11111000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00000000b
	
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 01110000b
	db 00000000b
	
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 01010000b
	db 00100000b
	db 00000000b
	
	db 10001000b
	db 10001000b
	db 10001000b
	db 10001000b
	db 10101000b
	db 10101000b
	db 11011000b
	db 00000000b
	
	db 10001000b
	db 10001000b
	db 01010000b
	db 00100000b
	db 01010000b
	db 10001000b
	db 10001000b
	db 00000000b

	db 10001000b
	db 10001000b
	db 01010000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00100000b
	db 00000000b
	
	db 11111000b
	db 00001000b
	db 00010000b
	db 00100000b
	db 01000000b
	db 10000000b
	db 11111000b
	db 00000000b


	even
;sine table; 360 values each entry multiplied by 16,384
		
sine_table:

dw  0, 285, 571, 857, 1142, 1427, 1712, 1996, 2280, 2563, 2845, 3126, 3406
dw  3685, 3963, 4240, 4516, 4790, 5062, 5334, 5603, 5871, 6137, 6401, 6663
dw  6924, 7182, 7438, 7691, 7943, 8192, 8438, 8682, 8923, 9161, 9397, 9630
dw  9860, 10086, 10310, 10531, 10748, 10963, 11173, 11381, 11585, 11785
dw  11982, 12175, 12365, 12550, 12732, 12910, 13084, 13254, 13420, 13582
dw  13740, 13894, 14043, 14188, 14329, 14466, 14598, 14725, 14848, 14967
dw  15081, 15190, 15295, 15395, 15491, 15582, 15668, 15749, 15825, 15897
dw  15964, 16025, 16082, 16135, 16182, 16224, 16261, 16294, 16321, 16344
dw  16361, 16374, 16381, 16384, 16381, 16374, 16361, 16344, 16321, 16294
dw  16261, 16224, 16182, 16135, 16082, 16025, 15964, 15897, 15825, 15749
dw  15668, 15582, 15491, 15395, 15295, 15190, 15081, 14967, 14848, 14725
dw  14598, 14466, 14329, 14188, 14043, 13894, 13740, 13582, 13420, 13254
dw  13084, 12910, 12732, 12550, 12365, 12175, 11982, 11785, 11585, 11381
dw  11173, 10963, 10748, 10531, 10310, 10086, 9860, 9630, 9397, 9161, 8923
dw  8682, 8438, 8191, 7943, 7691, 7438, 7182, 6924, 6663, 6401, 6137, 5871
dw  5603, 5334, 5062, 4790, 4516, 4240, 3963, 3685, 3406, 3126, 2845, 2563
dw  2280, 1996, 1712, 1427, 1142, 857, 571, 285, 0,-285,-571,-857,-1142
dw -1427,-1712,-1996,-2280,-2563,-2845,-3126,-3406,-3685,-3963,-4240,-4516
dw -4790,-5062,-5334,-5603,-5871,-6137,-6401,-6663,-6924,-7182,-7438,-7691
dw -7943,-8192,-8438,-8682,-8923,-9161,-9397,-9630,-9860,-10086,-10310
dw -10531,-10748,-10963,-11173,-11381,-11585,-11785,-11982,-12175,-12365
dw -12550,-12732,-12910,-13084,-13254,-13420,-13582,-13740,-13894,-14043
dw -14188,-14329,-14466,-14598,-14725,-14848,-14967,-15081,-15190,-15295
dw -15395,-15491,-15582,-15668,-15749,-15825,-15897,-15964,-16025,-16082
dw -16135,-16182,-16224,-16261,-16294,-16321,-16344,-16361,-16374,-16381
dw -16384,-16381,-16374,-16361,-16344,-16321,-16294,-16261,-16224,-16182
dw -16135,-16082,-16025,-15964,-15897,-15825,-15749,-15668,-15582,-15491
dw -15395,-15295,-15190,-15081,-14967,-14848,-14725,-14598,-14466,-14329
dw -14188,-14043,-13894,-13740,-13582,-13420,-13254,-13084,-12910,-12732
dw -12550,-12365,-12175,-11982,-11785,-11585,-11381,-11173,-10963,-10748
dw -10531,-10310,-10086,-9860,-9630,-9397,-9161,-8923,-8682,-8438,-8191
dw -7943,-7691,-7438,-7182,-6924,-6663,-6401,-6137,-5871,-5603,-5334,-5062
dw -4790,-4516,-4240,-3963,-3685,-3406,-3126,-2845,-2563,-2280,-1996,-1712
dw -1427,-1142,-857,-571,-285, 0, 285, 571, 857, 1142, 1427, 1712, 1996
dw  2280, 2563, 2845, 3126, 3406, 3685, 3963, 4240, 4516, 4790, 5062, 5334
dw  5603, 5871, 6137, 6401, 6663, 6924, 7182, 7438, 7691, 7943, 8192, 8438
dw  8682, 8923, 9161, 9397, 9630, 9860, 10086, 10310, 10531, 10748, 10963
dw  11173, 11381, 11585, 11785, 11982, 12175, 12365, 12550, 12732, 12910
dw  13084, 13254, 13420, 13582, 13740, 13894, 14043, 14188, 14329, 14466
dw  14598, 14725, 14848, 14967, 15081, 15190, 15295, 15395, 15491, 15582
dw  15668, 15749, 15825, 15897, 15964, 16025, 16082, 16135, 16182, 16224
dw  16261, 16294, 16321, 16344, 16361, 16374, 16381, 16383, 16381, 16374
dw  16361, 16344

even
;current angles of rotation
angle_1 	dw 0
angle_2 	dw 0
angle_3 	dw 0
;cosine and sine of each angle
cos_1 		dw 0
sin_1 		dw 0

cos_2 		dw 0
sin_2 		dw 0

cos_3 		dw 0
sin_3 		dw 0
;perspective variables...
s_pos		dw -200
m_pos		dw 0
;current origon
origon_x	dw 0
origon_y	dw 70
origon_z	dw -1500
;added to each angle every frame...
delta_1		dw 1
delta_2		dw 1
delta_3		dw 2
;added to the origon every frame....
move_x		dw 0
move_y		dw 0
move_z		dw 0
;temporary variables for the rotate32 procedure
Y1		dw 0
X2		dw 0
Y3		dw 0
;current coordinates of points being rotated
Xo		dw 0
Yo		dw 0
Zo		dw 0
;highest & lowest Z coordinates used for intensity of each pixel
lowest_z	dw 0
highest_z	dw 0
;temporary variables used by rotate32
source		dw 0
dest		dw 0
;frames per second stuff
frames		dw 0
frames_sec	dw 0
;used for printing numbers
number_buffer	dw 0,0,0,0,0,0
;buffer for the points to erase
point_loc	dw offset point_buffer_2
;number of points left to rotate used by rotate32
points_left	dw 0

;my stupid title
string_1:
	db 9,0,'3D ROTATION AND PERSPECTIVE',0
	db 12,1,'BY RICH GELDREICH 1992',0
	db 6,9,'IF YOU HAVE ANY QUESTIONS OR IDEAS',0
	db 12,11,'I CAN BE CONTACTED AT',0
	db 16,13,'410 MARKET ST',0
	db 11,15,'GLOUCESTER CITY NJ 08030',0
	db 16,17,'609-742-8752',0
	db 11,24,'PRESS ANY KEY TO BEGIN',0

;each holds x,y,z coordinates		
even
point_buffer_1	dw NumPoints*3 dup(?)		;for plotting
point_buffer_2	dw NumPoints*3 dup(?)		;for erasing

;-------------------------------------------------------------------------------

codeseg
	even
start:
	mov 	ax, @data
	mov	ds, ax
	mov	es, ax
	
	cld
	assume ds:@data,es:nothing,ss:nothing
	
	mov  	ax, 013h
	int	010h
	call	print_title
	call	set_palette

;notice that I fool with the timer tick count in BIOS memory... not
;cool but it works!
	
	push	es
	mov	ax, 040h
	mov	es, ax
	mov	[word es:06ch], 0
	pop	es

 	even
@@main_loop:
;have we done enough frames for a good estimate of speed?
	mov	ax, [ds:frames]
	inc	ax
	cmp	ax, 61
	jne	@@notyet
	push	es
;yup; get # clicks
	mov	ax, 040h
	mov	es, ax
	xor	cx, cx
	xchg	cx, [es:06ch]
	pop	es
;multiply be 60*18 and then scale the answer by 10 
;so we have one decimal digit too
	mov	ax, (60*18*10)
	xor	dx, dx
	and	cx, cx
;don't divide by zero(just in case...)
	jnz	@@timable
	xor	ax, ax
	jmp	short @@notyet
	even
@@timable:
	div	cx
	mov	[ds:frames_sec], ax
	xor	ax, ax
@@notyet:
	mov	[ds:frames], ax
;update user's origon		
	mov	ax, [ds:move_x]
	add	[ds:origon_x], ax
	
	mov	ax, [ds:move_y]
	add	[ds:origon_y], ax
	
	mov	ax, [ds:move_z]
	add	[ds:origon_z], ax
;update the angles of rotation	
	mov	ax, [ds:angle_1]
	add	ax, [ds:delta_1]
	cmp	ax, 359
	jng 	@@05
	xor	ax, ax
@@05:
	and	ax, ax
	jnl	@@05a
	mov	ax, 359
@@05a:
	mov	[ds:angle_1], ax

	mov	ax, [ds:angle_2]
	add	ax, [ds:delta_2]
	cmp	ax, 359
	jng 	@@06
	xor	ax, ax
@@06:
	and	ax, ax
	jnl	@@06a
	mov	ax, 359
@@06a:
	mov	[ds:angle_2], ax
			      
	mov	ax, [ds:angle_3]
	add	ax, [ds:delta_3]
	cmp	ax, 359
	jng 	@@07
	xor	ax, ax
@@07:
	and	ax, ax
	jnl	@@07a
	mov	ax, 359
@@07a:
	mov	[ds:angle_3], ax

	mov	ax, @data
	mov	es, ax
;set the cosine and sine for each angle
	call	set_angles

;rotate the points	
	mov 	si, offset points_to_rotate
	mov	di, offset point_buffer_1
	mov 	cx, NumPoints
	
	mov	[ds:lowest_z], 32767
	mov	[ds:highest_z], -32768
	
	call	rotate_32

;get ready to write to screen	       
	mov	ax, 0a000h
	mov	es, ax

;put v_wait in if your computer's too fast	
	;call	v_wait
;erase the old points	
	call	erase
;fix up the highest_z(highest_z=higest_z-lowest_z)	
	mov	ax, [ds:highest_z]
	sub	ax, [ds:lowest_z]
	and	ax, ax
	jnz	@@15
;handle special case when highest_z=lowest_z(which doesn't happen
;at all in this version)
	inc	ax
	mov	[ds:lowest_z], -1
@@15:
	mov	[ds:highest_z], ax
;plot the new points		
	mov	si, offset point_buffer_1
	mov	cx, Numpoints
	call	plot

;print the numbers at bottom of screen
	mov	ax, [ds:angle_1]
	mov	di, 320*192+10
	mov	dl, 66
	call	print_number
	
	mov	ax, [ds:angle_2]
	mov	di, 320*192+10+50
	call	print_number
	
	mov	ax, [ds:angle_3]
	mov	di, 320*192+10+100
	call	print_number

	mov	ax, [ds:origon_x]
	mov	di, 320*192+10+150
	call	print_number

	mov	ax, [ds:origon_y]
	mov	di, 320*192+10+200
	call	print_number
	
	mov	ax, [ds:origon_z]
	mov	di, 320*192+10+250
	call	print_number
	
	mov	ax, [ds:frames_sec]
	xor	di, di
	call	print_number				
;check key	
@@20:
	mov 	ah, 011h
  	int 	16h
    	jnz 	@@30
	jmp 	@@main_loop
@@30:    	
	mov	ah, 010h
	int	16h
;PLEASE IGNORE THE FOLLOWING CODE TO PROCESS EACH KEY: I WASN'T FEELING
;THAT WELL WHEN I MADE IT... I should of used a damn jump table!

	cmp 	al, '4'
	jne	@@k1
	inc	[move_x]
	jmp	@@main_loop
	even
@@k1:
	cmp	al, '6'
	jne	@@k2
	dec 	[ds:move_x]
	jmp	@@main_loop
	even
@@k2:
	cmp	al, '8'
	jne	@@k3
	inc	[ds:move_y]
	jmp	@@main_loop
	even
@@k3:
	cmp	al, '2'
	jne	@@k4
	dec	[ds:move_y]
	jmp	@@main_loop
	even
@@k4:
	cmp	al, '5'
	jne	@@k5
	xor	ax, ax
	mov	[ds:move_x], ax
	mov	[ds:move_y], ax
	mov	[ds:move_z], ax
	jmp	@@main_loop
	even
@@k5:
	cmp	al, 'r'
	jne	@@k4a
	xor	ax, ax
	mov	[ds:delta_1], ax
	mov	[ds:delta_2], ax
	mov	[ds:delta_3], ax
	mov	[ds:angle_1], ax
	mov	[ds:angle_2], ax
	mov	[ds:angle_3], ax
	jmp	@@main_loop
	even
@@k4a:	
	cmp	al, ' '
	jne	@@k5a
	xor	ax, ax
	mov	[ds:delta_1], ax
	mov	[ds:delta_2], ax
	mov	[ds:delta_3], ax
	jmp	@@main_loop
	even
@@k5a:
	cmp	al, 'm'
	jne	@@k5b
	inc	[ds:delta_2]
	jmp	@@main_loop
	even
@@k5b:
	cmp	al, 'n'
	jne	@@k5c
	dec	[ds:delta_2]
	jmp	@@main_loop
	even
@@k5c:
	cmp	al, '+'
	jne	@@k6
	dec	[ds:move_z]
	jmp	@@main_loop
	even
@@k6:
	cmp	al, '-'
	jne	@@k7
	inc	[ds:move_z]
	jmp	@@main_loop
	even
@@k7:	
	cmp	al, 27
	je	@@exit
	
	cmp	ah, 72
	jne	@@k9
	inc	[ds:delta_1]
	jmp	@@main_loop
	even
@@k9:
	cmp 	ah, 80
	jne	@@k10
	dec	[ds:delta_1]
	jmp	@@main_loop
	even
@@k10:
	cmp	ah, 75
	jne	@@k11
	dec	[ds:delta_3]
	jmp	@@main_loop
	even
@@k11:
	cmp	ah, 77
	jne	@@k12
	inc	[ds:delta_3]
	jmp	@@main_loop
	even
@@k12:
	jmp	@@main_loop	
@@exit:
	mov	ax, 00003h
        int	10h
        mov	ah, 4Ch
        int	21h
;-------------------------------------------------------------------------------
;rotation routine
	even
proc 	rotate_32
	mov	[ds:points_left], cx
	mov	[ds:source], si
	mov	[ds:dest], di
	
	even
@@10:

;copy the current points to rotate to a work area
       
	mov	si, [ds:source]
	mov	di, offset Xo
	mov	cx, 3
	rep	movsw
	mov	[ds:source], si
;do first calculation:
;X1 = (Xo * C1 - Yo * S1) \ 16384
 
	mov	bp, [ds:sin_1]
	mov	bx, [ds:cos_1]

	mov	ax, [ds:yo]
	imul	bp			;Yo*S1
	mov	si, ax
	mov	di, dx
	
	mov	ax, [ds:xo]
	imul	bx			;Xo*C1
	sub	ax, si
	sbb	dx, di
	
	
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1
	
	mov	cx, dx

;now do Y1 = (Xo * S1 + Yo * C1) \ 16384

	mov	ax, [ds:xo]
	imul	bp			;Xo*S1
	mov	si, ax
	mov	di, dx
	
	mov	ax, [ds:yo]
	imul	bx			;Yo*C1
	add	ax, si
	adc	dx, di
			
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1

	mov	[ds:y1], dx

;second vector
;X2 = (X1 * C2 - Zo * S2) \ 16384 - Mx + Ox
 
	mov	bp, [ds:sin_2]
	mov	bx, [ds:cos_2]

	mov	ax, [ds:zo]
	imul	bp
	mov	si, ax
	mov	di, dx

	mov	ax, bx
	imul	cx			;X1*c2
	sub	ax, si
	sbb	dx, di
	
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1

	add	dx, [ds:origon_x]
	mov 	[ds:x2], dx

;Z2 = (X1 * S2 + Zo * C2) \ 16384
	
	mov	ax, bp
	imul	cx			;X1*S2
	mov	si, ax
	mov	di, dx
	

	mov	ax, [ds:zo]
	imul	bx			;Zo*C2
	add	ax, si
	adc	dx, di
			
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1

	mov	cx, dx
	
;third vector
;Y3 = (Y1 * C3 - Z2 * S3) \ 16384 - My + Oy
 
	mov	bp, [ds:sin_3]
	mov	bx, [ds:cos_3]
	
	mov	ax, bp
	imul	cx			;Z2*S3
	mov	si, ax
	mov	di, dx

	
	mov	ax, bx
	imul	[ds:y1]			;Y1*C3
	sub	ax, si
	sbb	dx, di
	
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1

	add	dx, [ds:origon_y]
	mov	[ds:y3], dx

;Z4 = (Y1 * S3 + Z2 * C3) \ 16384
	
	mov	ax, bp
	imul	[ds:y1]			;Y1*S3
	mov	si, ax
	mov	di, dx
		
	mov	ax, bx
	imul	cx			;Z2*C3
	add	ax, si
	adc	dx, di
	
	sal	ax, 1
	rcl	dx, 1
	sal	ax, 1
	rcl	dx, 1

	mov	di, [ds:dest]

;save the z coordinate in the output table	
	mov 	[ds:di+4], dx

;check to see if lowest or highest z
	cmp	dx, [ds:lowest_z]
	jnl	@@notlower
	mov	[ds:lowest_z], dx
@@notlower:
	cmp	dx, [ds:highest_z]
	jng	@@notgreater
	mov	[ds:highest_z], dx
@@notgreater:
	add	dx, [ds:origon_z]

;now do V=(Spos-Z)/(Mpos-Z)
	
	neg	dx
	mov 	bx, dx
	add	bx, [ds:m_pos]
;is the point in view?
	cmp	bx, Z_Plane_Threshold
	jg	@@in_view
;nope	
	mov	ax, -32768
	mov	cx, 3
	rep	stosw
	mov	[ds:dest], di
	jmp 	@@next_point
	even
@@in_view:
;V= (p_scaler*(Spos-Z)) / (Mpos-Z)

	add	dx, [ds:s_pos]
	mov	ax, dx
	mov	cx, P_Scaler
	imul	cx
	
	idiv	bx
	neg	ax

;x=160+x2+(x2*-v)\p_scaler
;(or really x=160+x2+(-x2*v)\p_scaler )		
	mov	bx, ax
	mov	bp, [ds:x2]
	mov	ax, bp
	imul	bx		;x2 * v
	idiv	cx
	add	ax, bp
	add	ax, 160
	stosw
;y=100+y2+(y2*-v)\p_scaler
	mov	bp, [ds:y3]
	mov	ax, bp
	imul	bx
	idiv	cx
	add	ax, bp
	add	ax, 100
	stosw
;skip by the already stored Z coordinate	
	inc 	di
	inc 	di
	mov	[ds:dest], di
	
@@next_point:
	
	dec    	[ds:points_left]
	jz	@@20
	jmp	@@10
	even
@@20:
	ret
endp 	rotate_32
;-------------------------------------------------------------------------------
	even
;plots the points to the 320x200x256 screen
proc 	plot
	mov	[ds:point_loc], offset point_buffer_2
	even	
@@10:
	lodsw
	and 	ax, ax
	jl 	@@not_in_view_1
	cmp	ax, 319
	jg	@@not_in_view_1
	mov	di, ax
	lodsw
	and 	ax, ax
	jl	@@not_in_view_2
	cmp	ax, 190
	jg	@@not_in_view_2
	mov	bx, ax
	add	bx, bx
	add	di, [word ds:line_table+bx]

;color_of_point = 10 + ( 53*(Z-Lowest_Z) ) / Highest_Z	
;where color 10 is dark and color 63 is bright

	lodsw
	sub	ax, [ds:lowest_z]
	mov	bp, 53
	imul	bp
	idiv	[ds:highest_z]
	add	al, 10
	
	mov	bx, [ds:point_loc]
	mov	[ds:bx], di
	inc	bx
	inc	bx
	mov	[ds:point_loc], bx
	
	stosb
	
	loop 	@@10
	ret
	even
@@not_in_view_1:
	add	si, 4
	loop	@@10
	ret
	even
@@not_in_view_2:
	inc	si
	inc	si
	loop	@@10
	ret
endp	plot
;-------------------------------------------------------------------------------
	even
;erases points last set
proc 	erase
	xor 	bl, bl
	mov	dx, [ds:point_loc]
	mov	si, offset point_buffer_2
	cmp	si, dx
	je	@@exit
	even
@@10:
	rept	8
	lodsw
	mov	di, ax
	mov	al, bl
	stosb
	cmp	si, dx
	je	@@exit
	endm
	lodsw
	mov	di, ax
	mov	al, bl
	stosb
	cmp	si, dx
	jne	@@10
@@exit:
	
	ret
endp	erase
;-------------------------------------------------------------------------------
	even
;waits for vertical retrace
proc	v_wait
	mov	dx, 03dah
	mov	ah, 8

@@10:
	in	al, dx
	and	al, ah
	jnz 	@@10
	
	even
@@20:
	in	al, dx
	and	al, ah
	jz 	@@20
	ret
endp 	v_wait
;-------------------------------------------------------------------------------
	even
;sets up cosine and sign of each angle
;sine(A)=sine(A)
;cosine(A)=sine(A+90)
proc	set_angles
	mov	bx, [ds:angle_1]
	add	bx, bx
	mov	ax, [word ds:sine_table+bx]
	mov	[ds:sin_1], ax
	mov	ax, [word ds:sine_table+bx+90*2]
	mov	[ds:cos_1], ax

	mov	bx, [ds:angle_2]
	add	bx, bx
	mov	ax, [word ds:sine_table+bx]
	mov	[ds:sin_2], ax
	mov	ax, [word ds:sine_table+bx+90*2]
	mov	[ds:cos_2], ax
		
	mov	bx, [ds:angle_3]
	add	bx, bx
	mov	ax, [word ds:sine_table+bx]
	mov	[ds:sin_3], ax
	mov	ax, [word ds:sine_table+bx+90*2]
	mov	[ds:cos_3], ax
	ret
endp 	set_angles			
;-------------------------------------------------------------------------------
	even
;sets up the blue palette
proc	set_palette
	mov	dx, 03c7h
	mov	cx, 64
	xor	ax, ax
	even
@@10:
	out 	dx, al
	inc	dx
	out	dx, al
	inc	dx
	
	xchg	al, ah
	out	dx, al
	out	dx, al
	xchg	al, ah
	out	dx, al
		
	dec	dx
	dec	dx
	inc	ax
	loop	@@10
	
	ret
endp	set_palette
;-------------------------------------------------------------------------------
	even
;takes a binary number in ax and turns it into a series of digits
proc	make_number
	and	ax, ax
	jnl	@@00
	neg	ax
	mov	[ds:number_buffer], offset minus_sign
	jmp	short @@01
	even
@@00:
	mov	[ds:number_buffer], offset space
@@01:
	mov	bp, 10
	xor	bx, bx
	mov	cx, offset characters
		
	std
	mov	di, offset number_buffer+10
	
	rept	5
	mov	dx, bx
	div	bp
	xchg	ax, dx
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	stosw
	xchg	ax, dx
	endm
	
	cld
	
	ret
endp 	make_number
;-------------------------------------------------------------------------------
	even
proc	write_number
	
	mov	cx, 6
	push	offset number_buffer
	even
@@10:
	pop 	si
	lodsw
	push 	si
	mov	si, ax
	push	cx
	push 	di
	call	write_char
	pop	di
	pop	cx
	add	di, 7
	loop	@@10
	pop	ax
	ret
endp 	write_number
;-------------------------------------------------------------------------------
	even
;writes a bit-mapped font to screen
proc	write_char
	mov	bp, 320-5
	mov	cx, 7
	even
@@10:
	lodsb
	mov	bl, al
	mov	al, ch

	shl	bl, 1
	jc	@@write_1
	stosb
@@e1:
	shl	bl, 1
	jc	@@write_2
	stosb
@@e2:
	shl	bl, 1
	jc	@@write_3
	stosb
@@e3:
	shl	bl, 1
	jc	@@write_4
	stosb
@@e4:
	shl	bl, 1
	jc	@@write_5
	stosb
@@e5:
	add	di, bp
	loop	@@10
		
	ret
	even
@@write_1:
	xchg	al, dl
	stosb
	xchg	al, dl
	jmp	short @@e1
	even
@@write_2:
	xchg	al, dl
	stosb
	xchg	al, dl
	jmp	short @@e2
	even
@@write_3:
	xchg	al, dl
	stosb
	xchg	al, dl
	jmp	short @@e3
	even
@@write_4:
	xchg	al, dl
	stosb
	xchg	al, dl
	jmp	short @@e4
	even
@@write_5:
	xchg	al, dl
	stosb
	xchg	al, dl
	jmp	short @@e5
	even
endp	write_char
;-------------------------------------------------------------------------------
	even
;prints a number to the screen
proc	print_number
	mov 	bx, @data
	mov	es, bx
	
	push	dx
	push	di
	call	make_number
	pop	di
	pop	dx
		
	mov	ax, 0a000h
	mov	es, ax
	
	call	write_number

	ret
endp	print_number
;-------------------------------------------------------------------------------
even
;prints a asciz string to the screen
proc	print_string
	push	dx
	mov	al, bl
	mov	dl, 7
	mul	dl
	mov	di, ax
	
	mov	al, bh
	xor	ah, ah
	mov	bx, 320*8
	mul	bx
	add	di, ax
	pop	dx
		
	push 	si
	even
@@10:
	pop 	si
	lodsb
	push	si
	and	al, al
	jz 	@@exit
	
	sub	al, 'A'
	js	@@space
	xor	ah, ah
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	ax, offset letters
	mov	si, ax
@@cont:
	push	di
	call	write_char
	pop	di
	
	add	di, 7
	jmp 	@@10    
	even
@@exit:
	pop	si
	
	ret
	even
@@space:
	cmp	al, '0'-'A'
	jl	@@n1
	cmp	al, '9'-'A'
	jg	@@n1
	add	al, 'A'-'0'
	xor	ah, ah
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	ax, offset characters
	mov	si, ax
	jmp	short @@cont
	even
@@n1:
	cmp	al, '-'-'A'
	jne	@@n2
	mov	si, offset minus_sign
	jmp	short @@cont
	even
@@n2:
	mov 	si, offset space
	jmp 	short @@cont
endp 	print_string
even
;my stupid title...
proc	print_title
	mov	ax, 0a000h
	mov	es, ax
	
	mov	dx, 03c7h
	mov	al, 65
	out	dx, al
	inc	dx
	out	dx, al
	inc	dx
	xor	al, al
	rept	3
	out	dx, al
	endm
		
	mov	si, offset string_1
	mov	cx, 8
	mov	dl, 65
@@1:
	lodsw
	mov	bx, ax
	push	cx
	call	print_string
	pop	cx
	loop	@@1
	mov	cx, 0100h
	even	
@@2:
	call	v_wait
	mov	dx, 03c7h
	mov	al, 65
	out	dx, al
	inc	dx
	out	dx, al
	inc	dx
	
	xor	al, al
	out	dx, al
	out	dx, al
	mov	al, cl
	out	dx, al

	call	v_wait
	
	mov	dx, 03c7h
	mov	al, 65
	out	dx, al
	inc	dx
	out	dx, al
	inc	dx
	mov	al, 63
	out	dx, al
	xor	al, al
	out	dx, al
	out	dx, al

		
    	add	cl, ch
        cmp	cl, 64
	jne	@@20
	mov 	ah, 011h
  	int 	16h
    	jnz 	@@30
	neg	ch
	add	cl, ch
	even
@@20:		
	and	cl, cl
	jnl	@@2
	neg	ch
	add	cl, ch
	jmp	short @@2
	even
@@30:
	mov 	ah, 010h
  	int 	16h
	
	mov	cx, 32000
	xor	ax, ax
	mov	di, ax
	rep	stosw

	ret
endp 	print_title
;that's all have fun
end
		
