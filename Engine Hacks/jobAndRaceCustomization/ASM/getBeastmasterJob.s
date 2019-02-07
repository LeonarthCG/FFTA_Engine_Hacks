.thumb

ldr	r3,=#0x80CCE60
mov	lr,r3

cmp	r1,#2
bhi	item
mov	r3,#6
add	r3,r1
ldrb	r3,[r0,r3]
cmp	r3,#0
beq	item
strb	r3,[r2,#2]
b	noitem

item:
mov	r3,#1
strb	r3,[r2,#2]
noitem:
mov	r3,sp
add	r3,#5

.short	0xF800

str	r0,[sp]

ldr	r3,=#0x802731C
mov	lr,r3
.short	0xF800
