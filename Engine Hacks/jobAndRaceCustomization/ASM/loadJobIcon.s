.thumb
push	{lr}
push	{r4-r6}
mov	r4,r0	@destination
mov	r5,r1	@job
mov	r6,r2	@no clue

@check if there is a new pointer for this icon
ldr	r0,pointer
mov	r1,r5
lsl	r1,#3
add	r0,r1
ldr	r1,[r0]
cmp	r1,#0
beq	vanilla

@copy the graphics
ldrh	r0,[r1,#2]
lsl	r0,#2
add	r1,#4
mov	r2,#0
loop:
ldr	r3,[r1,r2]
str	r3,[r4,r2]
add	r2,#4
cmp	r2,r0
bhs	End
b	loop

End:
pop	{r4-r6}
pop	{r0}
bx	r0

vanilla:
mov	r0,r4
mov	r3,r0
mov	r1,r5
lsl	r1,#0x18
lsr	r1,#0x18
ldr	r4,=#0x80CB9E8
mov	lr,r4
pop	{r4-r6}
.short	0xF800

.align
.ltorg

pointer:
