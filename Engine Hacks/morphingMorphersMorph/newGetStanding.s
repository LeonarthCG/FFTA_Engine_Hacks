.thumb
push	{lr}

@r0 = base value of stat
@r1 = job
@r2 = stat that we got
@r3 = pointer to character in ram

cmp	r2,#0x23	@standing was checked
bne	End

mov	r2,#0xEA
ldrb	r2,[r3,r2]	@some status effects
mov	r1,#4		@check if morphed
and	r2,r1
cmp	r2,#0
beq	End

mov	r0,#0xE6
ldrb	r0,[r3,r0]	@species we morphed into
ldr	r1,pointer	@table of animations to use
ldrb	r0,[r1,r0]	@job to use the data of

@get animation
ldr	r1,=#0x80C8598
ldr	r1,[r1]		@job data table
mov	r2,#0x34
mul	r0,r2
add	r0,r1		@pointer to this job
mov	r1,#0x2B
ldrb	r0,[r0,r1]
lsr	r0,#4

End:
pop	{r1}
bx	r1

.align
.ltorg

pointer:
