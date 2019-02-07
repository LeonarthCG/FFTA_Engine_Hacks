.thumb
ldrh	r1,[r0]		@jp
ldr	r0,=#9999
cmp	r1,r0
blo	noProblem1
mov	r1,r0
noProblem1:

ldr	r0,=#1000
cmp	r1,r0
blo	noProblem2
mov	r2,r1
mov	r1,r0
mov	r0,r2
swi	#6
mov	r3,r0
mov	r0,r7
add	r0,#0x9A
ldr	r2,=0xD01E
add	r2,r3
strh	r2,[r0]
noProblem2:

@r1 = JP
mov	r0,r7
mov	r2,#0x4E

ldr	r3,=#0x802CD54
mov	lr,r3

mov	r3,#0x1
.short	0xF800
