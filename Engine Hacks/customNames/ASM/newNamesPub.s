.thumb
add	r1,#0x20
add	r1,r0
ldr	r0,[r1]
mov	r1,#0
ldr	r3,=#0x80C7EA4
mov	lr,r3
.short	0xF800
ldr	r3,=#0x805FE00
mov	lr,r3
.short	0xF800
