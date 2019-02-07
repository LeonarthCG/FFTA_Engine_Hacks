.thumb

ldr	r3,=#0x808392C
mov	lr,r3

ldr	r3,=#0x3002818
ldr	r3,[r3]
add	r3,#0xCC
ldr	r0,=#0x2CBA
add	r3,r0
mov	r0,#0
strb	r0,[r3,#1]

pop	{r3}

mov	r0,#0xCC
mov	r1,r10
mul	r1,r0
ldr	r0,=#0x3002818
ldr	r0,[r0]
add	r4,r1,r0

.short	0xF800
