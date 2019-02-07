.thumb
pop	{r3}
ldr	r0,=#0x20020D0
ldrb	r0,[r0,#0x14]
mov	r2,r8
ldr	r1,[r2]
ldr	r7,=#0x9BA
add	r1,r7
push	{r0-r7}

ldr	r0,pointer
mov	lr,r0
.short	0xF800

End:
ldr	r3,=#0x8072C50
mov	lr,r3
pop	{r0-r7}
.short	0xF800

.align
.ltorg

pointer:
