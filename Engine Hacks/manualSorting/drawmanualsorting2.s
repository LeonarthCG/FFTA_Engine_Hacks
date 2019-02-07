.thumb

mov	r2,#0xF
mov	r9,r2
ldr	r0,=#0x20020D0
ldrb	r0,[r0,#0x15]

push	{r0-r3}
@erase some tiles
@check if upper or lower section
ldr	r0,=#0x200FD43
ldrb	r1,[r0]
mov	r0,#0xC
and	r1,r0
ldr	r0,=#0x6005050
cmp	r1,#0
beq	uppererase
ldr	r0,=#0x6005490
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

@if not sorting by number, clear ram
@check if sorting method is by number
ldr	r0,=#0x20020E5
ldrb	r0,[r0]
	cmp	r0,r0
beq	dontclear
push	{r0-r3}
ldr	r0,=#0x2002FC4
mov	r1,#0
mov	r2,#0
ldr	r3,=#0x104
cleanramloop:
str	r1,[r0,r2]
cmp	r2,r3
bhs	cleanramloopdone
add	r2,#4
b	cleanramloop
cleanramloopdone:
pop	{r0-r3}
cleanstars:
push	{r0-r5}
ldr	r4,pointer
ldr	r5,=#0x600618A
mov	r0,#0
mov	r1,#0
mov	r2,#0
cleanstarsloop:
ldrh	r1,[r4,r0]
strh	r2,[r5,r1]
add	r5,#10
strh	r2,[r5,r1]
sub	r5,#10
cmp	r0,#48
bhs	cleanstarsloopdone
add	r0,#2
b	cleanstarsloop
cleanstarsloopdone:
pop	{r0-r5}
dontclear:

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
ldr	r3,=#0x807263C
mov	lr,r3
pop	{r0-r3}
.short	0xF800

.align
.ltorg

pointer:
