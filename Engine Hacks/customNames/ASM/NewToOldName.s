.thumb
push	{r4-r7}
mov	r4,r0	@source
mov	r5,r1	@destination
ldr	r6,nameCharacterLimit	@size
ldr	r7,=#0x812AD98
ldr	r7,[r7]
add	r7,#8	@character table

@while size > 0
main:
cmp	r6,#0
beq	end
@for every character
ldrb	r0,[r4]	@character
cmp	r0,#0
beq	end
add	r4,#1	@increase source
sub	r6,#1	@decrease size
@as many times as the character value, check if valid table entry
mov	r1,#0	@offset for char table
charloop:
ldrb	r2,[r7,r1]	@char table entry
cmp	r2,#0x80	@if it has 0x80 as the first byte, valid
blo	checkspace
valid:
sub	r0,#1
cmp	r0,#0
beq	charmatch
add	r1,#2
b	charloop
checkspace:
ldrh	r2,[r7,r1]
ldr	r3,=#0x7340
cmp	r2,r3
beq	valid
@if not valid, increase table entry and check again
add	r1,#2
b	charloop
@write character and increase destination
charmatch:
ldrb	r2,[r7,r1]
add	r1,#1
ldrb	r3,[r7,r1]
strb	r2,[r5]
add	r5,#1
strb	r3,[r5]
add	r5,#1
b	main

end:
mov	r0,#0
strh	r0,[r5]
pop	{r4-r7}
bx	lr
.align
.ltorg
nameCharacterLimit:
