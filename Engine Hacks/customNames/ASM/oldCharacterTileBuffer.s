.thumb
pop	{r3}
mov	r2,#0xC0
lsl	r2,#2
add	r0,r6,r2
ldr	r0,=#0x203E2C4

ldr	r3,=#0x8022854
mov	lr,r3
.short	0xF800

ldr	r3,=#0x812A37E
mov	lr,r3
.short	0xF800
