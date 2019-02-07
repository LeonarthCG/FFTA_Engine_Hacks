@ r0 = destination
@ r1 = source
.thumb

@check if uncompressed
ldrb	r3,[r1]
lsl	r3,#8
ldrb	r2,[r1,#1]
orr	r3,r2
ldr	r2,=#0xFFFF
cmp	r3,r2
beq	Uncompressed

Return:
ldr	r2,=#0x8005455
mov	lr,r2
ldrb	r2,[r1]
lsl	r2,#0x18
str	r2,[sp]
ldrb	r2,[r1,#1]
lsl	r2,#0x10
ldr	r3,[sp]
.short	0xF800

Uncompressed:
push	{r4}
@get image size
ldrb	r4,[r1,#3]
lsl	r4,#8
ldrb	r2,[r1,#2]
orr	r4,r2		@size
lsl	r4,#2
add	r1,#4
mov	r3,#0

loop:
ldrb	r2,[r1,r3]
strb	r2,[r0,r3]
add	r3,#1
cmp	r3,r4
bhi	End
b	loop

End:
sub	r1,#4
ldrb	r0,[r1,#2]
lsl	r0,#8
ldrb	r2,[r1,#3]
orr	r0,r2		@size
ldr	r4,=#0x800587D
mov	lr,r4
pop	{r4}
.short	0xF800
