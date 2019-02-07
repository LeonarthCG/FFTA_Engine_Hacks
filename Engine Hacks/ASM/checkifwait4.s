.thumb
mov	r0,#0x10
orr	r1,r0
mov	r2,r9
str	r1,[r2]
push	{r0-r3}

@check if we are confirming or waiting
ldr	r0,=#0x200F5B8
ldr	r1,[r0]
mov	r2,#1
lsl	r2,#0x1F	 @0x80000000, as far as I know it's not used
and	r1,r2
cmp	r1,#0
beq	wasWait

@otherwise it was confirming
ldr	r1,[r0]
mov	r2,#0x10
mvn	r2,r2
and	r1,r2
str	r1,[r0]
b	End

wasWait:
ldr	r1,[r0]
mov	r2,#0x10
orr	r1,r2
str	r1,[r0]

End:
ldr	r1,[r0]
mov	r2,#0x08
orr	r1,r2
mov	r2,#1
lsl	r2,#0x1F	 @0x80000000, as far as I know it's not used
mvn	r2,r2
and	r1,r2
str	r1,[r0]
ldr	r3,=#0x8096B00
mov	lr,r3
pop	{r0-r3}
.short	0xF800
ldr	r3,=#0x809561C
