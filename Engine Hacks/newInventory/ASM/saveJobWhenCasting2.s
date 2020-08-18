.thumb
pop	{r3}
push	{r4-r7,lr}
mov	r7,r10
mov	r6,r9
mov	r5,r8
push	{r5-r7}
ldr	r4,=#0xFFFFFC90
add	sp,r4

push	{r0-r7}
ldr	r1,=#0x802547C
ldr	r1,[r1,#0x00]
ldr	r1,[r1,#0x00]
ldr	r1,[r1,#0x20]
add	r1,#0x34
add	r1,#0xB0
ldrh	r1,[r1,#0x00]
strh	r1,[r0,#0x1E]

end:
pop	{r0-r7}
push	{r3}
ldr	r3,=#0x80A3A06
mov	lr,r3
pop	{r3}
.short	0xF800
