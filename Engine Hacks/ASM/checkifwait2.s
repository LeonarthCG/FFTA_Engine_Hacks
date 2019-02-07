.thumb

@we set wait usability to 0 if the unit just confirmed so we can check that to see if the turn is ending
ldr	r0,=#0x202DE44
ldrb	r1,[r0]
cmp	r1,#0xFF
bne	nevermind
mov	r1,#1
strb	r1,[r0]
nevermind:
ldr	r0,=#0x202DE44
ldrb	r1,[r0,#3]	@if status is 0 do nothing because it hasn't even loaded yet
cmp	r1,#0
beq	Continue
ldrb	r1,[r0,#2]
cmp	r1,#0
beq	End

Continue:
mov	r0,#4
mov	r1,#0
ldr	r3,=#0x80C9574
mov	lr,r3
.short	0xF800	

End:
mov	r6,r8
ldr	r0,[r6]
ldr	r3,=#0x8093014
mov	lr,r3
.short	0xF800
