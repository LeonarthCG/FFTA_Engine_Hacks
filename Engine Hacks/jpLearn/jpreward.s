.thumb

pop	{r3}
push	{r0-r3}
@check if first loop for unit, since it checks for every item
cmp	r2,#0
bne	End

@get reward
ldr	r2,=#0x201F514
ldrh	r2,[r2]
mov	r1,#10
mul	r2,r1

@get new JP
mov	r0,r8
add	r0,#0xD6
ldrh	r1,[r0]
add	r1,r2

@check max
ldr	r3,=#9999
cmp	r1,r3
blo	noProblem
mov	r1,r3
noProblem:

@store
strh	r1,[r0]

End:
pop	{r0-r3}
mov	r0,r8
add	r0,#0x2A
add	r0,r1
ldrh	r0,[r0]
add	r2,#1
push	{r3}
ldr	r3,=#0x8048FF0
mov	lr,r3
pop	{r3}
.short	0xF800
