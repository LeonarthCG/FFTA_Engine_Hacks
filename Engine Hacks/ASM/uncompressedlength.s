.thumb
mov	r2,r0

ldrb	r0,[r2]
cmp	r0,#0xFF
bne	nothing1
mov	r0,#0
nothing1:
lsl	r0,#0x18

ldrb	r1,[r2,#1]
cmp	r1,#0xFF
bne	nothing2
mov	r1,#0
nothing2:
lsl	r1,#0x10
orr	r0,r1

ldrb	r1,[r2,#2]
lsl	r1,#0x08
orr	r0,r1

ldrb	r1,[r2,#3]
orr	r0,r1

bx	lr
