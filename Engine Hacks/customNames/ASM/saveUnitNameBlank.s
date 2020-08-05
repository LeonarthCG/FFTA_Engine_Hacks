.thumb
mov	r1,#0xC9
lsl	r1,#2
add	r0,r6,r1
strb	r5,[r0]
ldr	r2,=#0x812A654
ldr	r2,[r2]
add	r0,r6,r2
strb	r5,[r0]

mov	r0,r6
ldr	r3,=#0x812AE8C
mov	lr,r3
.short	0xF800

ldr	r3,=#0x812A658
mov	lr,r3
.short	0xF800
