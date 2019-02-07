.thumb

ldr	r0,=#0x201F4FC
ldrh	r2,[r0]
mov	r0,#0xB

push	{r0,r2}

@r6 is char pointer
mov	r0,r6
ldr	r3,getMissionTextListOffset
mov	lr,r3
.short	0xF800

ldrb	r1,[r0,#8]

End:
pop	{r0,r2}
ldr	r3,=#0x80354AC
mov	lr,r3
.short	0xF800
ldr	r0,=#0x3002810
ldr	r0,[r0]
ldr	r3,=#0x80481FC
mov	lr,r3
.short	0xF800

.align
.ltorg

getMissionTextListOffset:
@POIN getMissionTextListOffset
