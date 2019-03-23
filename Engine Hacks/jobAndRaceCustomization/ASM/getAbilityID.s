.thumb

push	{lr}
push	{r4-r7}

mov	r4,r0		@pointer to unit
ldrb	r4,[r4,#6]	@race ID
mov	r5,#0		@current ID we are checking for
mov	r6,r1		@ability effect ID we want

@check the first entry
mov	r0,r4
mov	r1,r5
ldr	r3,=#0x080CD480
mov	lr,r3
.short	0xF800

ldrh	r0,[r0,#4]
cmp	r0,r6
beq	End


loop:
add	r5,#1
mov	r0,r4
mov	r1,r5
ldr	r3,=#0x080CD480
mov	lr,r3
.short	0xF800
ldr	r1,[r0]
ldr	r2,[r0,#4]
orr	r1,r2
cmp	r1,#0
beq	noMatch
ldrh	r0,[r0,#4]
cmp	r0,r6
beq	match
b	loop

match:
mov	r0,r5
b	End

noMatch:
mov	r0,#0

End:
pop	{r4-r7}
pop	{r1}
bx	r1
