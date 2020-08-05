.thumb
ldr	r3,=#0x8121B78
mov	lr,r3
.short	0xF800

ldr	r0,=#0x20021B4
ldrh	r0,[r0,#0x00]
cmp	r0,#0x00
beq	vanilla
mov	r0,#0
b	end

vanilla:
ldrb	r0,[r6,#0x06]

end:
ldr	r3,=#0x80CEA80
mov	lr,r3
.short	0xF800

ldr	r3,=#0x812A3B4
mov	lr,r3
.short	0xF800
