.thumb

@if there is a counter, do not display stars
mov	r0,#0xD8
ldrb	r0,[r4,r0]
cmp	r0,#0
bne	noStars

@if inanimate, no counter
ldr	r0,pointer
ldrb	r1,[r4,#7]
loop:
ldrb	r2,[r0]
cmp	r2,#0
beq	notInanimate
cmp	r2,r1
beq	noStars
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
beq	noStars

@if zombie status, start counter
mov	r1,#0xE9
ldrb	r3,[r4,r1]
mov	r1,#0x08
and	r3,r1
cmp	r3,#0x08
beq	noStars

@if player, start counter
mov	r1,#0xF0
and	r1,r2
cmp	r1,#0
beq	noStars

@if non-generic, ko
ldrb	r0,[r4,#4]
cmp	r0,#1
bhi	doStars

@if judge or boss, ko
mov	r1,#0x50
and	r1,r2
cmp	r1,#0
beq	noStars

doStars:
mov	r0,#0x17
b	End

noStars:
mov	r0,#0

End:
ldr	r3,=#0x809DCBD
bx	r3

.align
.ltorg

pointer:
