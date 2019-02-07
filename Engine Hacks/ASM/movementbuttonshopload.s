.equ JPIconShop, movementButtonShop+4
.thumb

ldr	r0,movementButtonShop
ldr	r1,=#0x2005810
mov	r2,#0
loop1:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
mov	r3,#94
lsl	r3,#2
add	r2,#4
cmp	r2,r3
beq	noloop1
b	loop1
noloop1:

ldr	r0,JPIconShop
cmp	r0,#0
beq	noloop2
ldr	r1,=#0x20053B0
mov	r2,#0
loop2:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
mov	r3,#64
add	r2,#4
cmp	r2,r3
beq	noloop2
b	loop2
noloop2:

End:
ldr	r0,=#0x806E978
mov	lr,r0

mov	r1,#0xD4
lsl	r1,#4
add	r0,r4,r1
ldr	r1,=#0x6009800
mov	r2,#0x9C
lsl	r2,#3

.short	0xF800

.align
.ltorg
movementButtonShop:
@POIN movementButtonShop
@POIN JPIconShop
