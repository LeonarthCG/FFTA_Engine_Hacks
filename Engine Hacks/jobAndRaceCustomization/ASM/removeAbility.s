.thumb
@r0 is character pointer
@r1 is ability

add	r0,#0x40
add	r0,r1
mov	r1,#0
strb	r1,[r0]
bx	lr
