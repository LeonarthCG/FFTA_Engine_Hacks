.thumb
ldr	r3,=#0x2001F70
mov	r2,#0
strb	r2,[r3,#1]
mov	r2,#0xFF
strb	r2,[r3,#2]

End:
ldr	r3,=#0x806AEDA
mov	lr,r3
ldr	r1,[r5,#0x14]
ldrb	r3,[r5,#0x0C]
ldrb	r2,[r5,#0x0D]
mul	r2,r3
orr	r2,r4
.short	0xF800
