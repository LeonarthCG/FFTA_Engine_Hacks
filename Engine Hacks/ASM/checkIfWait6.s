.thumb

ldr	r3,=#0x80C9574
mov	lr,r3
.short	0xF800

ldr	r0,=#0x202DE44
ldrb	r1,[r0]
cmp	r1,#0xFF
bne	nevermind
mov	r1,#1
strb	r1,[r0]
nevermind:

mov	r4,r8
ldr	r3,[r4,#4]
ldrh	r0,[r3,#8]
lsl	r0,#0x10
asr	r0,#0x15
lsl	r0,#0x10
lsr	r0,#0x10
ldr	r1,=#0x8096350
mov	lr,r1
.short	0xF800
