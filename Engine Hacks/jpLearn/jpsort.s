.thumb

ldr	r3,=#0x8035A68
mov	lr,r3
ldr	r3,=#9999
cmp	r2,r3
blo	noProblem
mov	r2,r3
noProblem:
cmp	r2,#99
bhi	match

nomatch:
mov	r1,#2
b	jump

match:
ldr	r3,=#999
cmp	r2,r3
bhi	match2
mov	r1,#3
b	jump

match2:
mov	r1,#4

jump:
lsr	r3,r7,#16
.short	0xF800

End:
push	{r3}
ldr	r3,=#0x8072B3C
mov	lr,r3
pop	{r3}
.short	0xF800

.align
