.thumb
pop	{r3}
push	{r4-r7,lr}
mov	r7,r8
push	{r7}
push	{r1-r2}
ldr	r1,table
b	loopstart
loop:
add	r1,#2
loopstart:
ldrb	r2,[r1]
cmp	r2,r0
bne	loop
ldrb	r0,[r1,#1]
pop	{r1-r2}
mov	r4,r0
lsl	r4,#0x10
lsr	r4,#0x10
push	{r3}
ldr	r3,=#0x805D248
mov	lr,r3
pop	{r3}
.short	0xF800
.align
.ltorg
table:
