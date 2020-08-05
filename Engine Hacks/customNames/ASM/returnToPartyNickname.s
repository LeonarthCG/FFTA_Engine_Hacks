.equ newIndexBuffer, newNameBuffer+4
.thumb
ldr	r0,newIndexBuffer
ldr	r1,[r0,#0x00]
ldr	r2,[r0,#0x04]
and	r1,r2
ldr	r2,=#0xFFFFFFFF
cmp	r1,r2
bne	vanilla

ldr	r0,=#0x30034D0
mov	r1,#0x01
strb	r1,[r0,#0x00]
mov	r1,#0x00
strb	r1,[r0,#0x01]
mov	r1,#0x03
strb	r1,[r0,#0x02]
mov	r1,#0x00
strb	r1,[r0,#0x03]
mov	r1,#0x01
strb	r1,[r0,#0x04]
mov	r1,#0x00
strb	r1,[r0,#0x05]
strb	r1,[r0,#0x06]
strb	r1,[r0,#0x07]

vanilla:
mov	r0,#1

ldr	r3,=#0x8035D00
mov	lr,r3
.short	0xF800

ldr	r3,=#0x8035E04
mov	lr,r3
.short	0xF800

ldr	r3,=#0x8031FDE
mov	lr,r3
.short	0xF800

.align
.ltorg
newNameBuffer:
