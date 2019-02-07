.thumb

mov	r0,#0xB
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
mov	r1,#1
and	r1,r0		@either 1 or 0
add	r1,#2		@skip char/race id and win with bonus ids
pop	{r0}
ldrb	r1,[r0,r1]

End:
pop	{r0,r2}
ldr	r3,=#0x80354AC
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8047A3C
mov	lr,r3
.short	0xF800

.align
.ltorg

getMissionTextListOffset:
@POIN getMissionTextListOffset
