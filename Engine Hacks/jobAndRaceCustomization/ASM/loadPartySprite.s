.thumb

add	r0,r1
ldrb	r2,[r0]
ldr	r0,=#0x8087BD8
ldr	r0,[r0]
mov	r1,r9
mov	r3,#1

push	{r4-r7,lr}
mov	r7,r8
push	{r7}
	push	{r5}	@to not lose the party member number
mov	r12,r1
lsl	r2,#16
lsr	r4,r2,#16
lsl	r3,#16
lsr	r6,r3,#16
mov	r5,r0
ldrb	r0,[r5,#2]
lsl	r0,#8
ldrb	r1,[r5,#3]
orr	r1,r0
cmp	r4,r1
bcc	goto533A
goto5336:
mov	r0,#1
b	goto53BE
goto533A:
cmp	r6,r1
bhi	goto5342
cmp	r6,#0
bne	goto5344
goto5342:
mov	r6,r1
goto5344:
add	r0,r4,r6
cmp	r0,r1
ble	goto5350
sub	r0,r1,r4
lsl	r0,#16
lsr	r6,r0,#16
goto5350:
mov	r8,r4
add	r2,r5,#4
ldrb	r1,[r5,#4]
lsl	r1,#24
ldrb	r0,[r2,#1]
lsl	r0,#16
orr	r1,r0
ldrb	r0,[r2,#2]
lsl	r0,#8
orr	r1,r0
ldrb	r0,[r2,#3]
orr	r1,r0
add	r7,r5,r1
mov	r1,#1
neg	r1,r1
ldr	r0,=#0x80053C8
ldr	r0,[r0]
mov	r2,r12
str	r2,[r0]
ldr	r0,=#0x80053CC
ldr	r0,[r0]
str	r1,[r0]
mov	r0,#0
strb	r0,[r2]
ldr	r1,=#0x80053D0
ldr	r1,[r1]
mov	r0,#0
str	r0,[r1]
add	r0,r6,r4
cmp	r4,r0
bge	goto53BC
goto5388:
lsl	r2,r4,#2
add	r2,#8
add	r2,r5,r2
ldrb	r0,[r2]
lsl	r0,#24
ldrb	r1,[r2,#1]
lsl	r1,#16
orr	r0,r1
ldrb	r1,[r2,#2]
lsl	r1,#8
orr	r0,r1
ldrb	r1,[r2,#3]
orr	r0,r1
add	r0,r5,r0
mov	r1,r7
	mov	r7,r0

@here goes our custom stuff
@first we get the palette
pop	{r1}		@get the party member number
push	{r1}
ldr	r2,=#0x108	@entry size of unit in ram
mul	r2,r1
ldr	r3,=#0x2000080	@starting offset of party units
add	r2,r3		@unit entry
ldrb	r3,[r2,#4]	@character id
cmp	r3,#1		@check if generic
bhi	isCharacter
ldrb	r3,[r2,#7]	@job id
b	notCharacter
isCharacter:
ldr	r2,PartySpriteTable
add	r2,#8
b	gotTable
notCharacter:
ldr	r2,PartySpriteTable
gotTable:
lsl	r3,#4		@*16
add	r2,r3
ldr	r3,[r2,#4]	@sprite
ldr	r2,[r2]		@palette
	cmp	r3,#0
	beq	noPalette
	@cmp	r2,#0
	@beq	noPalette
ldr	r0,=#0x8087BCC
ldr	r0,[r0]
ldr	r0,[r0]
ldr	r1,=#0xBCC
add	r0,r1
pop	{r1}		@get the party member number
push	{r1}
add	r0,r1
mov	r1,#0xF
and	r1,r2
strb	r1,[r0]
noPalette:

@then the sprite
mov	r0,r3
cmp	r0,#0
bne	Sprite
mov	r0,r7

ldr	r1,=#0x83B86EB
ldr	r2,=#0x83B5AA0
ldr	r3,=#0x80051C4
mov	lr,r3
ldr	r3,=#0x10000
.short	0xF800
cmp	r0,#0
endloop2:
beq	goto5336
add	r0,r4,r1
lsl	r0,#16
lsr	r4,r0,#16
mov	r1,r8
add	r0,r6,r1
cmp	r4,r0
blt	goto5388
goto53BC:
mov	r0,#0
goto53BE:
	pop	{r5}	@respecting the number of pushes
pop	{r3}
mov	r8,r3
pop	{r4-r7}
pop	{r1}
	@bx	r1	@we go back on our own so commented out

End:
ldr	r3,=#0x8087B97
bx	r3

Sprite:
push	{r0}
ldr	r1,=#0x83B86EB
ldr	r2,=#0x83B5AA0
ldr	r3,=#0x80051C4
mov	lr,r3
ldr	r3,=#0x10000
.short	0xF800
mov	r3,r0
pop	{r0}
push	{r3}
ldr	r1,=#0x2003CB0
ldr	r2,=#0x280
add	r2,r1
loop:
ldrb	r3,[r0]
strb	r3,[r1]
add	r0,#1
add	r1,#1
cmp	r1,r2
beq	endloop1
b	loop

endloop1:
pop	{r0}
b	endloop2

.align
.ltorg
PartySpriteTable:
@POIN PartySpriteTable
