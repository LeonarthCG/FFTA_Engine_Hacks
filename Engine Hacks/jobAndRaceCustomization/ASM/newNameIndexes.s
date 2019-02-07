.thumb

ldr	r1,pointer
loop:
ldrh	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	match
add	r1,#6
b	loop

match:
ldrh	r4,[r1,#4]
ldrh	r5,[r1,#2]

End:
ldr	r3,=#0x80C9E56
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
