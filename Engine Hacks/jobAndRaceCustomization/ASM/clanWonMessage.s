.thumb

mov	r0,#0xB
push	{r0,r2}

@r6 is char pointer
mov	r0,r6
ldr	r3,getMissionTextListOffset
mov	lr,r3
.short	0xF800

ldrb	r1,[r0,#4]

End:
pop	{r0,r2}
ldr	r3,=#0x80354AC
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8045668
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8047C56
mov	lr,r3
.short	0xF800

.align
.ltorg

getMissionTextListOffset:
@POIN getMissionTextListOffset
