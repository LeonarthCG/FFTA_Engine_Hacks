.thumb
push	{r4-r7}
mov	r4,r0	@source
mov	r5,r1	@destination
ldr	r6,nameCharacterLimit	@size
ldr	r7,=#0x812AD98
ldr	r7,[r7]
add	r7,#8	@character table

@clear the trailing spaces
lsl	r0,r6,#1	@size*2
add	r1,r4,r0	@end of destination
sub	r1,#2
ldr	r3,=#0x7340
mov	r0,#0
clearloop:
ldrh	r2,[r1]
cmp	r3,r2
bne	stopclear
cmp	r3,#0
beq	stopclear
strh	r0,[r1]
sub	r1,#2
b	clearloop
stopclear:

@write loop
loop:
cmp	r6,#0
beq	end
mov	r3,#0
mov	r1,r7
@get character
ldrh	r0,[r4]
cmp	r0,#0
beq	isempty
@get index of character
charloop:
ldrb	r2,[r1]
cmp	r2,#0x80
blo	checkspace
checkmatch:
ldrh	r2,[r1]
cmp	r2,r0
beq	match
b	next
checkspace:
ldrb	r2,[r1]
cmp	r2,#0x40
bne	notcharacter
ldrb	r2,[r1,#1]
cmp	r2,#0x73
beq	checkmatch
b	notcharacter
next:
add	r3,#1
cmp	r3,#0xFE
bhs	outofbounds
notcharacter:
add	r1,#2
b	charloop
outofbounds:
ldr	r0,=#0x7340
mov	r1,r7
mov	r3,#0
b	charloop
match:
add	r3,#1
isempty:
strb	r3,[r5]
add	r4,#2
add	r5,#1
sub	r6,#1
b	loop

end:
pop	{r4-r7}
bx	lr
.align
.ltorg
nameCharacterLimit:
