.thumb

ldr	r3,=#0x8099560
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	nomarche
mov	r0,#2
ldr	r3,=#0x8125578
mov	lr,r3
.short	0xF800
mov	r2,r0
ldr	r3,=#0x81226CC
mov	lr,r3
.short	0xF800

nomarche:
ldr	r3,=#0x8122640
mov	lr,r3
.short	0xF800
