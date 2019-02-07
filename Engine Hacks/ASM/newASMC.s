.thumb

push	{lr}

ldrb	r0,[r4,#4]
lsl	r0,#24
ldrb	r1,[r4,#3]
lsl	r1,#16
ldrb	r2,[r4,#2]
lsl	r2,#8
ldrb	r3,[r4,#1]
orr	r3,r2
orr	r1,r0
orr	r3,r1

mov	r0,r4
add	r0,#5		@pointer to optional arguments
bx	r3

mov	r0,#0x88
lsl	r0,#1
pop	{r1}
bx	r1
