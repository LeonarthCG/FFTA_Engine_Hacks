.thumb

ldr	r3,=#0x98B
add	r0,r3
ldrb	r1,[r0]
mov	r0,#0x20
and	r0,r1

push	{r0-r3}
@erase some tiles
@check if upper or lower section
ldr	r0,=#0x200FD43
ldrb	r1,[r0]
mov	r0,#0xC
and	r1,r0
ldr	r0,=#0x6005490
cmp	r1,#0
beq	uppererase
ldr	r0,=#0x6005050
uppererase:
mov	r1,#0
mov	r2,#0
erase:
str	r1,[r0,r2]
add	r2,#4
cmp	r2,#0x2C
bhs	erasestop
b	erase
erasestop:

@draw to the background
@check if sorting method is by number
ldr	r0,=#0x20020E5
ldrb	r0,[r0]
cmp	r0,#0
	@bne	dontdraw
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

@do the drawing
ldr	r1,=#0x71C0
ldr	r2,=#0x71CF
loop:
strh	r1,[r0]
add	r1,#1
add	r0,#2
cmp	r1,r2
bhs	stoploop
b	loop
stoploop:
dontdraw:

End:
ldr	r3,=#0x8074734
mov	lr,r3
pop	{r0-r3}
.short	0xF800
