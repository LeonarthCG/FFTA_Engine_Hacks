.thumb
mov	r1,#4
mov	r2,r5
ldr	r3,=#9999
cmp	r2,r3
blo	noProblem
mov	r2,r3
noProblem:

ldr	r3,=#0x8035A68
mov	lr,r3
mov	r3,r6
.short	0xF800

push	{r3}
ldr	r3,=#0x80744D8
mov	lr,r3
pop	{r3}
.short	0xF800
