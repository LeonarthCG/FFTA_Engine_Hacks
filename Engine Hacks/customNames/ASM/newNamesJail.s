.thumb
add	r0,#0x80
add	r0,r1
push	{r1-r2}
mov	r1,#0
ldr	r3,=#0x80C7EA4
mov	lr,r3
.short	0xF800
mov	r8,r0
ldr	r3,=#0x8057D2E
mov	lr,r3
pop	{r1-r2}
pop	{r3}
add	r1,r2
mov	r0,r1
.short	0xF800
