.thumb
pop	{r3}
push	{r4-r7}
ldr	r0,[r0,#0x00]
mov	r6,r0
lsl	r0,#0x03
add	r2,r0
ldrh	r0,[r2,#0x04]
str	r0,[r3,#0x14]

ldrb	r5,[r4,#0x08]
add	r5,#0x30
ldr	r7,=#0x200F438
ldr	r7,[r7,#0x00]
ldr	r7,[r7,#0x18]	@unit
ldrb	r5,[r7,r5]	@action command id
add	r4,#0xB0
strb	r5,[r4,#0x00]
strb	r6,[r4,#0x01]

end:
pop	{r4-r7}
push	{r3}
ldr	r3,=#0x8028A90
mov	lr,r3
pop	{r3}
.short	0xF800
