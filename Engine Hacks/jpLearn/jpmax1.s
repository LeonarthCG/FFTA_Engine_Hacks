.thumb
ldr	r0,=#9999
cmp	r5,r0
blo	noProblem
mov	r5,r0
noProblem:
mov	r0,#2
mov	r1,#1
mov	r2,#0x17

ldr	r3,=#0x8075758
mov	lr,r3

mov	r3,#0x5
.short	0xF800
