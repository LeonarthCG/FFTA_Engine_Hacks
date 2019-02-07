.macro blh to, reg=r3
  push {\reg}
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
  pop {\reg}
.endm

.thumb

push	{r4-r5}
ldr	r5,pointer
cmp	r4,r5
bne	nomatch

match:
pop	{r4-r5}
lsl	r3,#1
mov	r0,r1
ldr	r1,[r0,r3]
mov	r0,#1
b	End

nomatch:
pop	{r4-r5}
mov	r0,#0
bx	lr

End:
bx	lr

.align
.ltorg

pointer:
