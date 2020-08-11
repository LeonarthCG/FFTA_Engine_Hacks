.thumb
ldr	r3,=#0x203FFF0
mov	r2,#0
strb	r2,[r3,#1]
mov	r2,#0xFF
strb	r2,[r3,#2]

End:
ldr	r3,=#0x808E490
mov	lr,r3
mov	r5,r13
add	r5,#0x30
str	r5,[sp,#0x98]
mov	r4,r5
.short	0xF800
