.thumb
mov	r0,r6
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
mov	r2,#2
cmp	r0,#9
bhi	two
mov	r2,#1
two:
mov	r4,r2
ldr	r3,=#0x200F438
mov	r8,r3
mov	r1,r0
ldr	r0,[r3]
add	r0,#0x2C
ldr	r3,=#0x80142DC
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8025A90
mov	lr,r3
.short	0xF800
.align
.ltorg
checkEquippedAmmount:
