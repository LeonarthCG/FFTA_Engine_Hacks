.thumb
ldr	r3,[r4]		@pointer to unit
mov	r2,#0xEA
ldrb	r2,[r3,r2]	@some status effects
mov	r1,#4		@check if morphed
and	r2,r1
cmp	r2,#0
beq	Got

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
ldrb	r1,[r0,#7]
ldrb	r2,[r0,#8]
lsl	r2,#8
orr	r1,r2		@animation
mov	r0,r1

Got:
ldr	r1,=#0x8021060
ldr	r1,[r1]
lsl	r0,#1
ldrh	r0,[r1,r0]

End:
lsl	r0,#0x10
lsr	r0,#0x10
mov	r8,r0
strh	r5,[r4,#0x36]
ldr	r3,=#0x80975FF
bx	r3

.align
.ltorg

pointer:
