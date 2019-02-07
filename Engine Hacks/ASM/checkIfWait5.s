.thumb

ldr	r3,=#0x80C9574
mov	lr,r3
.short	0xF800

ldr	r0,=#0x202DE44
mov	r1,#0xFF
strb	r1,[r0]

ldr	r0,[r6,#4]
add	r0,#0x80
ldr	r0,[r0]
mov	r1,#1
ldr	r3,=#0x80968DA
mov	lr,r3
.short	0xF800
