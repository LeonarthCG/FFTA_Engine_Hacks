.thumb

@vanilla stuff
mov	r1,#0xC
ldr	r3,=#0x808A268
mov	lr,r3
pop	{r3}
.short	0xF800
mov	r1,#0xB2
lsl	r1,#1

@load graphics
push	{r0-r3}
ldr	r0,pointer
ldr	r1,=#0x600B800
mov	r2,#0
loop:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
ldr	r3,=#0x3C0
cmp	r2,r3
beq	noLoop
add	r2,#4
b	loop
noLoop:

	@unset selection
	ldr	r2,=#0x2002FC4
	mov	r0,#0
	strb	r0,[r2]

@erase some tiles
@check if upper or lower section
ldr	r0,=#0x200FD43
ldrb	r1,[r0]
mov	r0,#0xC
and	r1,r0
ldr	r0,=#0x6005050
cmp	r1,#0
beq	upper
ldr	r0,=#0x6005490
upper:
mov	r1,#0
mov	r2,#0
loop2:
str	r1,[r0,r2]
add	r2,#4
cmp	r2,#0x2C
bhs	noLoop2
b	loop2
noLoop2:

ldr	r3,=#0x80736BC
mov	lr,r3
pop	{r0-r3}
.short	0xF800

.align
.ltorg

pointer:
