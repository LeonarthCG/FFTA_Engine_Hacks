.thumb
ldr	r1,=#0x2001940
ldrb	r2,[r1,r0]
sub	r2,#1
strb	r2,[r1,r0]
bx	lr
