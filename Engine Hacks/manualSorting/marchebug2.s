.thumb

ldr	r0,=#0x02000080
mov	r1,#0
ldr	r3,=#0x108

findMarche:
ldrb	r2,[r0,#4]
cmp	r2,#2
beq	match
add	r1,#1
cmp	r1,#24
bhs	noMatch
add	r0,r3
b	findMarche

noMatch:
mov	r0,#1
b	End

match:
ldrb	r0,[r0,#9]
b	End

End:
mov	r1,r4
add	r1,#0x2E
strb	r0,[r1]
ldr	r1,=#0x813BB27
bx	r1
