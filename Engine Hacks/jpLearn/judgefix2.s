.thumb

@get the jp prize
pop	{r3}
push	{r2-r3}
ldrh	r1,[r3,#0x00]	@current jp
ldrb	r0,[r2,#0x04]	@jp reward
ldr	r2,reward
mul	r0,r2	@20 if normal, 200 if hunting
add	r1,r0
ldr	r0,=#9999
cmp	r1,r0
blo	np
mov	r1,r0
np:
strh	r1,[r3,#0x00]	@new jp

end:
pop	{r2-r3}
ldr	r0,=#0x80BBB78
mov	lr,r0
.short	0xF800
.align
.ltorg
reward:
