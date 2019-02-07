.thumb
cmp	r5,#0xEC
blo	nevermind
ldr	r3,=#0x7FFF
cmp	r5,r3
bhi	nevermind
sub	r5,#0xEC
lsl	r5,#2
add	r5,#0xEC

nevermind:
add	r2,r5,r2
str	r2,[sp,#4]
mov	r2,#0
str	r2,[sp,#8]

ldr	r3,=#0x8097685
bx	r3
