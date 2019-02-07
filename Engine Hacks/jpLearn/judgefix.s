.thumb

pop	{r3}
@get the jp prize
ldrb	r3,[r2,#4]
sub	r1,r3
ldr	r2,reward
mul	r2,r3	@20 if normal, 200 if hunting
add	r1,r2
ldr	r0,=#9999
cmp	r1,r0
blo	np
mov	r1,r0
np:
strh	r1,[r3]
ldr	r0,=#0x80BBB34
mov	lr,r0
ldrb	r0,[r2,#4]
add	r2,#8
.short	0xF800

.align
.ltorg
reward:
