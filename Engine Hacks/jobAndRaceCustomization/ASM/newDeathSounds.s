.thumb

lsl	r0,#1
ldr	r1,pointer
ldrh	r0,[r0,r1]

ldr	r3,=#0x80DF750
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
