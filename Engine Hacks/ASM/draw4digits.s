.thumb
push	{r4-r7}
mov	r4,r1		@number
mov	r5,r0		@tilemap buffer
mov	r6,r3		@if this is not 0 and r4 is 0, the number will be drawn red
mov	r7,r4		@remainder after division
lsl	r2,#0x10
lsr	r2,#0x0F
add	r5,r2

ldr	r0,=#0
cmp	r4,r0
bhi	not0
cmp	r6,#0
beq	white
red:
ldr	r0,=#0xE01E
b	store0
white:
ldr	r0,=#0xD01E
b	store0
store0:
strh	r0,[r5,#0x06]
b	end
not0:

ldr	r0,=#9999
cmp	r4,r0
blo	not5digits
mov	r4,r0
not5digits:

@draw the fourth digit
ldr	r0,=#1000
cmp	r4,r0
blo	not4digits
mov	r0,r4
ldr	r1,=#1000
swi	#6
mov	r7,r1
ldr	r3,=#0xD01E
add	r0,r3
strh	r0,[r5,#0x00]
not4digits:

@draw the third digit
ldr	r0,=#100
cmp	r4,r0
blo	not3digits
mov	r0,r7
ldr	r1,=#100
swi	#6
mov	r7,r1
ldr	r3,=#0xD01E
add	r0,r3
strh	r0,[r5,#0x02]
not3digits:

@draw the second digit
ldr	r0,=#10
cmp	r4,r0
blo	not2digits
mov	r0,r7
ldr	r1,=#10
swi	#6
mov	r7,r1
ldr	r3,=#0xD01E
add	r0,r3
strh	r0,[r5,#0x04]
not2digits:

@draw the first digit
ldr	r0,=#1
cmp	r4,r0
blo	not1digits
mov	r0,r7
ldr	r1,=#1
swi	#6
mov	r7,r1
ldr	r3,=#0xD01E
add	r0,r3
strh	r0,[r5,#0x06]
add	r5,#2
not1digits:

end:
pop	{r4-r7}
bx	lr
