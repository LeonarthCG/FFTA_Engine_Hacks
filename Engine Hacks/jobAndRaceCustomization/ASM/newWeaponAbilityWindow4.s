.thumb

push	{r4-r7}
add	r0,#0xB4
mov	r4,r0
ldr	r5,=#0x600592E

ldrh	r0,[r4]
strh	r0,[r5]
ldrh	r0,[r4,#2]
strh	r0,[r5,#2]
ldrh	r0,[r4,#4]
strh	r0,[r5,#4]
ldrh	r0,[r4,#6]
strh	r0,[r5,#6]
ldrh	r0,[r4,#8]
strh	r0,[r5,#8]

add	r4,#0x1A
add	r5,#0x40

ldrh	r0,[r4]
strh	r0,[r5]
ldrh	r0,[r4,#2]
strh	r0,[r5,#2]
ldrh	r0,[r4,#4]
strh	r0,[r5,#4]
ldrh	r0,[r4,#6]
strh	r0,[r5,#6]
ldrh	r0,[r4,#8]
strh	r0,[r5,#8]

pop	{r4-r7}
bx	lr
