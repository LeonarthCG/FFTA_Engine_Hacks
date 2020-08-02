.equ newMaxPoints, pointer+4
.thumb
@check if level up
cmp	r0,r7
bne	LevelUp
notLevelUp:
push	{r3}
ldr	r3,pointer
mov	lr,r3
pop	{r3}
.short	0xF800
pop	{r1}
bx	r1

LevelUp:
pop	{r1}
mov	lr,r1
push	{r4-r7,lr}
ldr	r7,newMaxPoints
mov	r5,r0
ldrb	r0,[r5,#9]
add	r0,#1
mov	r1,#0
strb	r0,[r5,#9]
strb	r1,[r5,#10]
mov	r0,r5
push	{r3}
ldr	r3,=#0x80C8298
mov	lr,r3
pop	{r3}
.short	0xF800
push	{r3}
ldr	r3,=#0x80C9BA0
mov	lr,r3
pop	{r3}
.short	0xF800
.align
.ltorg

pointer:
