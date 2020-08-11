.thumb
pop	{r3}
push	{r4-r7,lr}
mov	r7,r9
mov	r6,r8
push	{r6,r7}
sub	sp,#0x20
mov	r9,r0
mov	r4,r1

mov	r6,sp
mov	r5,#0
str	r5,[r6,#0x00]
str	r5,[r6,#0x04]
str	r5,[r6,#0x08]
str	r5,[r6,#0x0C]
str	r5,[r6,#0x10]
str	r5,[r6,#0x14]
str	r5,[r6,#0x18]
str	r5,[r6,#0x1C]
mov	r6,#0

push	{r3}
ldr	r3,=#0x812FB0C	
mov	lr,r3
pop	{r3}
.short	0xF800
