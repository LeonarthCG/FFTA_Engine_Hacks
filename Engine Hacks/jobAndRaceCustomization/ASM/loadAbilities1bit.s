.thumb

mov	r1,#0
sub	r1,#1
mov	r0,r8
add	r0,#20
ldr	r2,[r0]
cmp	r2,r1
bne	notExtended
ldr	r2,[r0,#4]
cmp	r2,r1
bne	notExtended
ldr	r2,[r0,#8]
cmp	r2,r1
bne	notExtended
ldr	r2,[r0,#12]
cmp	r2,r1
bne	notExtended
ldr	r0,[r0,#16]

extended:
mov	r1,#1
b	load

notExtended:
mov	r1,#0

load:
mov	r3,r7
add	r3,#0x40
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
cmp	r1,#0
beq	End
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]
add	r0,#4
add	r3,#4
ldr	r2,[r0]
str	r2,[r3]

End:
ldr	r3,=#0x80CA046
mov	lr,r3
.short	0xF800
