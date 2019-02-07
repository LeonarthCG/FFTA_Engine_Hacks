.thumb

@first we check if the unit just plain waited
ldr	r0,=#0x2001F70
ldrb	r0,[r0]
mov	r1,#0x18
and	r0,r1
cmp	r0,#0
beq	Wait
	
@check if unit cannot act
ldr	r0,=#0x202DE44
ldrb	r0,[r0,#1]
cmp	r0,#0
beq	Wait

@check if the unit acted
ldr	r0,=#0x2001F70
ldrb	r0,[r0]
mov	r1,#0x08
and	r0,r1
cmp	r0,#0
bne	Wait

@if they unit moved and can no longer move, turn ends
@check if the unit moved
ldr	r0,=#0x2001F70
ldrb	r0,[r0]
mov	r1,#0x10
and	r0,r1
cmp	r0,#0
beq	Wait
@check if unit cannot move
ldr	r0,=#0x202DE44
ldrb	r0,[r0]
cmp	r0,#0
beq	Wait

b	noWait

Wait:
@set some flags
ldr	r0,=#0x2001F70
ldrb	r1,[r0]
mov	r2,#0x18
orr	r1,r2
strb	r1,[r0]
ldr	r0,[r4]
@continue with the waiting
ldr	r3,=#0x809F8EC
mov	lr,r3
.short	0xF800
b	End

noWait:
ldr	r0,=#0x202DE44
mov	r1,#0
strb	r1,[r0,#2]	@set wait as unusable as a flag

End:
mov	r0,r4
ldr	r3,=#0x8095658
mov	lr,r3
.short	0xF800
