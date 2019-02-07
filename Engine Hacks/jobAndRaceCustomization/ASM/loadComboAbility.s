.thumb

mov	r1,r9
ldrb	r0,[r1]
cmp	r0,#0
beq	noStoreVanilla
strb	r0,[r4,#6]
noStoreVanilla:

mov	r1,r9
add	r1,#7
ldrb	r0,[r1]
cmp	r0,#0
beq	End
strb	r0,[r4,#8]

End:
ldrb	r3,=#0x80CA057
bx	r3
