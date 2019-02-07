.thumb

@set flags
ldr	r0,=#0x2001F70
mov	r1,#0x02
ldrb	r2,[r0]
orr	r1,r2
strb	r1,[r0]
mov	r1,#0x08
ldrb	r2,[r0,#6]
orr	r1,r2
strb	r1,[r0,#6]
ldr	r0,=#0x2002190
mov	r1,#0x03
strb	r1,[r0]

@set more flags
ldr	r0,=#0x2001FB0
mov	r1,#0x00
mov	r2,#0x03
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]
mov	r1,#0x04
mov	r2,#0x07
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]

@and set more flags
ldr	r0,=#0x2001FD0
mov	r1,#0x00
mov	r2,#0x03
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]
mov	r1,#0x27
mov	r2,#0x08
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]
mov	r1,#0x50
mov	r2,#0x01
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]
mov	r1,#0x54
mov	r2,#0x40
ldrb	r3,[r0,r1]
orr	r3,r2
strb	r3,[r0,r1]

End:
mov	r0,#0xBF
lsl	r0,#6
add	r4,r0
ldr	r1,=#0x8009854
ldr	r1,[r1]
mov	r0,r4
mov	r2,#4
ldr	r3,=#0x80097AA
mov	lr,r3
.short	0xF800
