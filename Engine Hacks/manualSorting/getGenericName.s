.thumb
ldr	r0,=#0x2000080
mov	r1,#0
ldr	r3,=#0x80C7EA4	@get unit stat, 0 for name
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8142250
mov	lr,r3
mov	r1,r0
mov	r0,#0x1A
add	r0,r4
ldr	r3,[r5]
mov	r2,#0x14
.short	0xF800
ldr	r3,=#0x813BB1A
mov	lr,r3
.short	0xF800
