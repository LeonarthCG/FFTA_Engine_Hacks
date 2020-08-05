.thumb
ldr	r2,animation
ldr	r3,=#0x80DDF68
mov	lr,r3
mov	r3,#1
.short	0xF800
str	r0,[r7,#0x28]
ldr	r0,[r7,#0x0C]
ldr	r3,=#0x80F8F2E
mov	lr,r3
.short	0xF800
.align
.ltorg
animation:
