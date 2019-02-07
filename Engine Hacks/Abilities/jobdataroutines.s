.thumb

pop	{r3}

push	{r4-r6,lr}
lsl	r0,#0x18
lsr	r0,#0x18
lsl	r1,#0x18
lsr	r4,r1,#0x18
lsl	r2,#0x18
lsr	r5,r2,#0x18

	@prepare registers for the future
	push	{r1-r3}

push	{r3}
ldr	r3,=#0x80C857C
mov	lr,r3
pop	{r3}
.short	0xF800

	@get back values
	pop	{r1-r3}
	lsr	r1,#0x18
	lsr	r2,#0x18
	push	{r4-r7}
	mov	r4,r0
	mov	r5,r1
	mov	r6,r2
	mov	r7,r3
	@r4 = base value of stat
	@r5 = job
	@r6 = stat that we got
	@r7 = pointer to character in ram

@our loop
ldr	r2,pointers
loop:
ldr	r1,[r2]
cmp	r1,#0
beq	End
add	r2,#4
push	{r2}
mov	lr,r1
mov	r0,r4
mov	r1,r5
mov	r2,r6
mov	r3,r7
.short	0xF800
mov	r4,r0		@possible new value for the stat
pop	{r2}
b	loop

End:
mov	r0,r4
pop	{r4-r7}
pop	{r4-r6}
pop	{r1}
bx	r1

.align
.ltorg

pointers:
@POIN routines
