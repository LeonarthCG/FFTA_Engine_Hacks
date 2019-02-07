.thumb
@r0 is character pointer
@r1 is ability

push	{r0}
mov	r0,r1
cmp	r0,#0
beq	False
sub	r0,#1
mov	r1,#8
swi	#6
mov	r2,#1
lsl	r2,r1
pop	{r3}
add	r3,#0x40
add	r3,r0
ldrb	r0,[r3]
orr	r2,r0
strb	r2,[r3]
bx	lr

False:
pop	{r3}
bx	lr
