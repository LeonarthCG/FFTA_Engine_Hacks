.thumb

mov	r0,#1
bl	checkJudge
cmp	r0,#0
beq	True

False:
mov	r0,#0
b	End

True:
mov	r0,#1

End:
ldr	r3,=#0x8027C59
bx	r3

checkJudge:
push	{lr}
push	{r4}
mov	r4,r0
mov	r0,#0x40
ldr	r3,=#0x80C9540
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	ced8c
cmp	r4,#0
beq	ced98
ldr	r3,=#0x800A018
mov	lr,r3
.short	0xF800
lsl	r1,r0,#2
add	r1,r0
lsl	r1,#3
ldr	r0,=#0x80CED90
ldr	r0,[r0]
add	r1,r0
add	r1,#0x21
ldrb	r0,[r1]
cmp	r0,#0
beq	ced94

ced8c:
ldr	r3,=#0x80CED8D
bx	r3

ced94:
ldr	r3,=#0x8CED95
bx	r3

ced98:
ldr	r3,=#0x80CED99
bx	r3
