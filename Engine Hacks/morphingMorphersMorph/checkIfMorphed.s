.thumb
push	{lr}

cmp	r0,#0
beq	End

ldrb	r1,[r0,#4]
cmp	r1,#1
bls	False

mov	r1,#0xEA
ldrb	r1,[r0,r1]
mov	r2,#0x04
and	r1,r2
cmp	r1,#0
beq	True

False:
mov	r0,#0
pop	{r1}
bx	r1

True:
mov	r0,#1
pop	{r1}
bx	r1

End:
pop	{r1}
bx	r1
