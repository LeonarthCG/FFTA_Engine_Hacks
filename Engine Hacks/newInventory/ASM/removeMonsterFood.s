.thumb
ldr	r4,=#0x2001940
add	r4,r0
mov	r5,r10
ldr	r0,[r5]
ldr	r1,=#0x10EC
add	r0,r1
ldr	r3,=#0x802AB5C
mov	lr,r3
.short	0xF800
ldrb	r1,[r4,#0x00]
sub	r1,r0
strb	r1,[r4,#0x00]
ldr	r3,=#0x805B87E
mov	lr,r3
.short	0xF800
