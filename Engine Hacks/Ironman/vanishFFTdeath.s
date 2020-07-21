.thumb

push	{r2}

sub	r0,#1
strh	r0,[r2,#2]
cmp	r0,#0
bne	End

@check if the unit is set as dead
ldr	r0,[r7]
ldr	r0,[r0]
add	r0,#0x29
mov	r1,#1
ldrb	r2,[r0]
and	r2,r1
cmp	r2,#0
beq	End

@set unfielded, unset fielded
ldr	r0,[r7]
ldr	r0,[r0]
add	r0,#0x28
ldrb	r1,[r0]
mov	r2,#0xFE
and	r1,r2
mov	r2,#0x20
orr	r1,r2
strb	r1,[r0]

@get the pointer to the unit in the list so we can remove them
ldr	r0,=#0x201F508
ldr	r0,[r0,#4]
mov	r3,r0

loop:
ldr	r1,[r0]
ldr	r1,[r1]
ldr	r2,[r7]
ldr	r2,[r2]
cmp	r1,r2
bne	next
ldr	r0,[r0]
b	finishRemove
next:
mov	r3,r0
ldr	r0,[r0,#8]
cmp	r0,#0
beq	End
b	loop

finishRemove:
ldr	r3,=#0x80995C0
mov	lr,r3
.short	0xF800

End:
pop	{r2}
ldrh	r0,[r2,#2]
lsl	r0,#0x10
lsr	r0,#0x0F
ldr	r3,=#0x809F578
mov	lr,r3
mov	r3,r5
.short	0xF800
