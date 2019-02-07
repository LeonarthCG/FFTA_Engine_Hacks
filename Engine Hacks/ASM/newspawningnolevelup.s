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
push	{r4-r6,lr}
mov	r5,r0
ldrb	r0,[r5,#9]
add	r0,#1
mov	r1,#0
strb	r0,[r5,#9]
strb	r1,[r5,#10]
ldr	r0,=#0x80C9B9B
bx	r0

.align
.ltorg

pointer:
