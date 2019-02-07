.thumb

.macro blh to, reg=r3
  push {\reg}
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
  pop {\reg}
.endm

.thumb

pop	{r3}

ldr	r5,[sp,#0x14]
ldr	r4,[sp,#0x18]
lsl	r3,#0x10
lsr	r3,#0x0F

push	{r4-r6}
mov	r4,r1
push	{r0-r3}
ldr	r6,pointer
loop:
ldr	r5,[r6]
cmp	r5,#0
beq	nomatch
mov	lr,r5
.short	0xF800
add	r6,#4
cmp	r0,#1
beq	match
b	loop

match:
mov	r4,r1
pop	{r0-r3}
mov	r2,r4
pop	{r4-r6}
b	End

nomatch:
pop	{r0-r3}
pop	{r4-r6}
add	r2,r1,r3
ldrh	r0,[r2]
add	r2,r1,r0

End:
push	{r0}
ldr	r0,=#0x8013EB1
mov	lr,r0
pop	{r0}
bx	lr

.align
.ltorg

pointer:
