.thumb

cmp	r1,#0x50
blo	dontset
cmp	r1,#0x78
bhi	dontset
push	{r4}
mov	r4,#1
lsl	r4,#0xF
orr	r1,r4	@animation ID | 0x8000
pop	{r4}
dontset:

ldr	r3,=#0x80975DC	@do the animation stuff
mov	lr,r3
mov	r3,#1
.short	0xF800

End:
ldr	r3,=#0x80988B8
mov	lr,r3
cmp	r5,#0
.short	0xF800
