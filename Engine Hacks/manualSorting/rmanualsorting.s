.thumb
pop	{r3}
push	{r0-r7}

@unset selection
ldr	r2,=#0x2002FC4
mov	r0,#0
strb	r0,[r2]

cleanstars:
ldr	r4,pointer
ldr	r5,=#0x600618A
mov	r0,#0
mov	r1,#0
mov	r2,#0
cleanstarsloop:
ldrh	r1,[r4,r0]
strh	r2,[r5,r1]
add	r5,#10
strh	r2,[r5,r1]
sub	r5,#10
cmp	r0,#48
bhs	cleanstarsloopdone
add	r0,#2
b	cleanstarsloop
cleanstarsloopdone:

End:
ldr	r3,=#0x8073BBA
mov	lr,r3
pop	{r0-r7}
ldr	r1,[r6]
ldr	r5,=#0x98B
add	r1,r5
ldrb	r0,[r1]
mov	r4,#1
orr	r0,r4
.short	0xF800

.align
.ltorg

pointer:
