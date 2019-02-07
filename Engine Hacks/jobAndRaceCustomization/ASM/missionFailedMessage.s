.thumb

push	{r0,r2}

@r6 is char pointer
mov	r0,r6
ldr	r3,getMissionTextListOffset
mov	lr,r3
.short	0xF800

push	{r0}
ldr	r0,=#0x8002804	@get random number
mov	lr,r0
.short	0xF800
mov	r1,#3
swi	#6
add	r1,#5
pop	{r0}
ldrb	r1,[r0,r1]

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
