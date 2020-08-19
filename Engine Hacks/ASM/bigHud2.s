.equ tiles, stat+4
.equ cleargarbage, tiles+4
.equ return, cleargarbage+4
.equ destination, return+4
.thumb
@r0 is the buffer
ldr	r1,[r6,#0xC]
ldr	r2,stat
ldrh	r1,[r1,r2]
ldr	r2,tiles

ldr	r3,=#9999
cmp	r1,r3
blo	np
mov	r1,r3
np:

@check if we should clear the tiles
push	{r0-r7}
ldr	r0,cleargarbage
cmp	r0,#0
beq	endcleargarbage
@clear first line of first sprite
ldr	r0,=#0x6013940
ldr	r1,=#0x6013A00
bl	clean
@clear second line of first sprite
ldr	r0,=#0x6013A40
ldr	r1,=#0x6013B00
bl	clean
@clear the second sprite
ldr	r0,=#0x6013D00
ldr	r1,=#0x6013D80
bl	clean
endcleargarbage:
pop	{r0-r7}

@draw the thing
mov	r3,r8
push	{r3}
push	{r4-r7}
ldr	r4,destination
lsl	r1,#0x10
lsr	r6,r1,#0x10	@the number
lsl	r2,#0x10
lsr	r2,#0x10
@mov	r8,r2
ldr	r1,=#0x200F440
ldr	r5,[r1]
ldr	r1,=#0x65C
add	r7,r5,r1
mov	r8,r7
mov	r7,r6		@remainder

@draw the red 0
mov	r0,#0
lsl	r1,r0,#5
ldr	r3,=#0xB1C
add	r1,r5,r3
mov	r0,#0x60
add	r0,r4
mov	r2,#0x20
push	{r2-r3}
ldr	r2,=#0x802BC74
ldr	r2,[r2]
ldr	r3,[r2]
mov	lr,r3
pop	{r2-r3}
.short	0xF800
cmp	r6,#0
beq	end

@draw the 1000s
ldr	r1,=#1000
cmp	r6,r1
blo	not1000
mov	r0,r7
swi	#6
mov	r7,r1
lsl	r1,r0,#5
@add	r1,r7
mov	r2,r8
add	r1,r2
mov	r0,#0x00
add	r0,r4
mov	r2,#0x20
push	{r2-r3}
ldr	r2,=#0x802BC74
ldr	r2,[r2]
ldr	r3,[r2]
mov	lr,r3
pop	{r2-r3}
.short	0xF800
not1000:

@draw the 100s
ldr	r1,=#100
cmp	r6,r1
blo	not100
mov	r0,r7
swi	#6
mov	r7,r1
lsl	r1,r0,#5
@add	r1,r7
mov	r2,r8
add	r1,r2
mov	r0,#0x20
add	r0,r4
mov	r2,#0x20
push	{r2-r3}
ldr	r2,=#0x802BC74
ldr	r2,[r2]
ldr	r3,[r2]
mov	lr,r3
pop	{r2-r3}
.short	0xF800
not100:

@draw the 10s
ldr	r1,=#10
cmp	r6,r1
blo	not10
mov	r0,r7
swi	#6
mov	r7,r1
lsl	r1,r0,#5
@add	r1,r7
mov	r2,r8
add	r1,r2
mov	r0,#0x40
add	r0,r4
mov	r2,#0x20
push	{r2-r3}
ldr	r2,=#0x802BC74
ldr	r2,[r2]
ldr	r3,[r2]
mov	lr,r3
pop	{r2-r3}
.short	0xF800
not10:

@draw the 1s
ldr	r1,=#1
cmp	r6,r1
blo	not1
mov	r0,r7
swi	#6
mov	r7,r1
lsl	r1,r0,#5
@add	r1,r7
mov	r2,r8
add	r1,r2
mov	r0,#0x60
add	r0,r4
mov	r2,#0x20
push	{r2-r3}
ldr	r2,=#0x802BC74
ldr	r2,[r2]
ldr	r3,[r2]
mov	lr,r3
pop	{r2-r3}
.short	0xF800
not1:

end:
pop	{r4-r7}
pop	{r0}
mov	r8,r0
ldr	r3,return
mov	lr,r3
.short	0xF800

clean:
mov	r2,#0
cleanloop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
bne	cleanloop
bx	lr

.align
.ltorg
stat:
