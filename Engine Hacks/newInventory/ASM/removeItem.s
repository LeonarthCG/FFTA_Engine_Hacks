.thumb
push	{r4-r7}
ldr	r4,[r7]
ldr	r2,=#0x44EC
ldrh	r4,[r4,r2]
ldr	r5,=#0x2001940
ldrb	r1,[r5,r4]
sub	r1,r0
strb	r1,[r5,r4]
pop	{r4-r7}

lsl	r4,#0x10
lsr	r4,#0x0E
add	r4,r5

ldr	r0,=#0x806C94E
mov	lr,r0
.short	0xF800
