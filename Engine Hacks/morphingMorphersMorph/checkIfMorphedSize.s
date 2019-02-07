.thumb
ldr	r3,[r4]		@pointer to unit
add	r3,#0x35
ldrb	r2,[r3]
cmp	r2,#0x1E
beq	Morpher
ldrb	r2,[r3,#1]
cmp	r2,#0x1E
beq	Morpher
ldrb	r2,[r3,#2]
cmp	r2,#0x1E
beq	Morpher
b	Got

Morpher:
mov	r0,#0x18
b	End

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
