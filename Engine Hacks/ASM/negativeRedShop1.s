.thumb
pop	{r3}
lsl	r3,#0x10
asr	r3,#0x10
cmp	r3,#0
bge	notRed

red:
neg	r3,r3
mov	r5,r3
push	{r0-r1}
ldr	r0,=#0x203F000
mov	r1,#0x01
str	r1,[r0]
pop	{r0-r1}
b	end

notRed:
mov	r5,r3
push	{r0-r1}
ldr	r0,=#0x203F000
mov	r1,#0x00
str	r1,[r0]
pop	{r0-r1}
b	end

end:
lsr	r0,#0x10
lsl	r1,#0x10
lsr	r1,#0x10
lsl	r2,#0x18
lsr	r2,#0x18
mov	r8,r2
push	{r3}
ldr	r3,=#0x806F586
mov	lr,r3
pop	{r3}
.short	0xF800
