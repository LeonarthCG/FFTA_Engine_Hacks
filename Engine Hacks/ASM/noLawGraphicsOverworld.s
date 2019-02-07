.equ JPIconShop, movementButtonShop+4
.thumb

mov	r0,#0xC0
ldr	r1,=#0x20043B0
mov	r2,#0
mov	r3,#0
loop:
str	r3,[r1,r2]
add	r2,#4
cmp	r2,r0
beq	noloop
b	loop
noloop:

End:
ldr	r0,=#0x8031410
mov	lr,r0

ldr	r1,=#0x6010100
mov	r2,#0x88
lsl	r2,#2
mov	r0,r4

.short	0xF800

.align
.ltorg
movementButtonShop:
@POIN movementButtonShop
@POIN JPIconShop
