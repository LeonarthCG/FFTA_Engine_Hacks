.thumb
pop	{r3}
push	{r0-r3}

@if only one wheel, do nothing
ldr	r0,=#0x2001F70
ldrb	r1,[r0,#2]
cmp	r1,#0
beq	End

@check for button presses
ldr	r0,=#0x3000000
ldrh	r1,[r0,#2]
mov	r2,r1
ldr	r3,=#0x100
and	r2,r3
cmp	r2,#0
bne	moveRight
ldr	r3,=#0x200
and	r1,r3
cmp	r1,#0
bne	moveLeft
b	End

@increase index
moveRight:
ldr	r0,=#0x2001F70
ldrb	r1,[r0,#1]
ldrb	r2,[r0,#2]
cmp	r1,r2
bne	notMax
mov	r1,#0
b	EndRefresh
notMax:
add	r1,#1
b	EndRefresh

moveLeft:
ldr	r0,=#0x2001F70
ldrb	r1,[r0,#1]
ldrb	r2,[r0,#2]
cmp	r1,#0
bne	notMin
mov	r1,r2
b	EndRefresh
notMin:
sub	r1,#1
b	EndRefresh

EndRefresh:
strb	r1,[r0,#1]
ldr	r0,=#0x3000EC2
mov	r1,#0
strb	r1,[r0]

End:
ldr	r3,=#0x8086178
mov	lr,r3
pop	{r0-r3}
ldr	r2,[r0]
mov	r4,r2
add	r4,#0x25
ldrb	r3,[r4]
mov	r10,r0
.short	0xF800
