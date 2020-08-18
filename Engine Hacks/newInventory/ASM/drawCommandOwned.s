.thumb
ldr	r3,=#0x2001940
ldrb	r0,[r3,r6]
mov	r2,#2
cmp	r0,#9
bhi	two
mov	r2,#1
two:
mov	r4,r2
mov	r1,r0
ldr	r7,=#0x200F438
ldr	r0,[r7]
add	r0,#0x2C
ldr	r3,=#0x80142DC
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8025B06
mov	lr,r3
.short	0xF800
.align
.ltorg
