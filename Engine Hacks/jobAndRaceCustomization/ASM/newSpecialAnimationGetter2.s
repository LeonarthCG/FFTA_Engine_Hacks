.thumb
mov	r8,r0
mov	r6,#1
lsl	r0,r4,#0x18
asr	r0,r0,#0x18

cmp	r7,#0xEC
blo	nevermind
ldr	r3,=#0x1FFF
cmp	r7,r3
bhi	nevermind
sub	r7,#0xEC
lsl	r7,#2
add	r7,#0xEC

nevermind:
add	r7,r0
mov	r4,r5
add	r4,#0x4C
ldr	r0,[r5,#0x40]

ldr	r3,=#0x8097745
bx	r3
