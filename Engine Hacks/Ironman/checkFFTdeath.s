.thumb

@if inanimate, no counter
ldr	r0,pointer
ldrb	r1,[r4,#7]
loop:
ldrb	r2,[r0]
cmp	r2,#0
beq	notInanimate
cmp	r2,r1
beq	noCounter
add	r0,#1
b	loop

notInanimate:

@0x08 undead
@0x10 judge
@0x20 guest
@0x40 boss
@0x80 enemy

@get flags
mov	r0,#0x29
ldrb	r2,[r4,r0]

@if undead, start counter
mov	r1,#0x08
and	r1,r2
cmp	r1,#0x08
beq	startCounter

@if zombie status, start counter
mov	r1,#0xE9
ldrb	r3,[r4,r1]
mov	r1,#0x08
and	r3,r1
cmp	r3,#0x08
beq	startCounter

@if player, start counter
mov	r1,#0xF0
and	r1,r2
cmp	r1,#0
beq	startCounter

@if non-generic, no counter
ldrb	r0,[r4,#4]
cmp	r0,#1
bhi	noCounter

@if judge or boss, no counter
mov	r1,#0x50
and	r1,r2
cmp	r1,#0
bne	noCounter

startCounter:
ldr	r3,=#0x8097461
b	End

noCounter:
ldr	r3,=#0x8097471

End:
mov	r0,r4
bx	r3

.align
.ltorg

pointer:
