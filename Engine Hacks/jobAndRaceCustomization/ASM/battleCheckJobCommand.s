.thumb
push	{lr}
push	{r4-r7}
mov	r6,r0
mov	r1,r0
ldr	r0,=#0x200F438
ldr	r0,[r0]
ldr	r4,[r0,#0x18]	@character pointer
add	r1,#1
ldrb	r5,[r4,r1]	@job id

@check if addled
mov	r0,#0xEC
ldrb	r0,[r4,r0]
mov	r1,#1
and	r0,r1
cmp	r0,#0
bne	False

@check if frogged
mov	r0,#0xE9
ldrb	r0,[r4,r0]
mov	r1,#1
and	r0,r1
cmp	r0,#0
bne	False

@check if item
mov	r0,r6
add	r0,#0x2F
ldrb	r0,[r4,r0]
cmp	r0,#1
beq	True

@if all other checks are ok then check ability count
mov	r0,r4
mov	r1,r5
mov	r2,#1
ldr	r3,pointer
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	True
b	False

True:
mov	r0,#1
b	End

False:
mov	r0,#0
b	End

End:
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

pointer:
