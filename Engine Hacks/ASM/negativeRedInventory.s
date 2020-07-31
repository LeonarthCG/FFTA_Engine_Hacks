.thumb
pop	{r3}
lsl	r3,#0x10
asr	r3,#0x10
cmp	r3,#0
bge	notRed
ldr	r6,=#0xA000
neg	r3, r3
notRed:
lsl	r1,#0x10
lsr	r1,#0x10
mov	r12,r1
lsl	r2,#0x10
lsr	r2,#0x10
mov	r8,r2
push	{r3}
ldr	r3,=#0x80899CE
mov	lr,r3
pop	{r3}
.short	0xF800
