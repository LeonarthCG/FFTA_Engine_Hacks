.thumb

lsl	r1,r0,#0x18
lsr	r1,#0x18
mov	r0,r5

@80071a8
push	{r4-r7}
	mov	r7,r1	@portrait number
mov	r4,r0
lsl	r1,#0x10
lsr	r5,r1,#0x10
mov	r6,r5
ldr	r3,=#0x80071E4
mov	lr,r3
.short	0xF800

lsl	r0,#0x10
lsr	r0,#0x10
cmp	r5,r0
bcc	goto71C2
mov	r0,#0
b	goto71DE
goto71C2:
ldrb	r0,[r4]
cmp	r0,#2
bne	goto71D4
add	r0,r4,#4
lsl	r1,r5,#1
add	r1,r1,r0
ldrh	r1,[r1]
add	r0,r1
b	goto71DE
goto71D4:
add	r0,r4,#4
lsl	r1,r6,#2
add	r1,r0
ldr	r1,[r1]
add	r0,r1

goto71DE:
@get custom oam if any
ldr	r4,PortraitTable
lsl	r7,#3
add	r4,r7
ldr	r4,[r4]
ldr	r5,=#0
cmp	r4,r5
beq	noOam
mov	r0,r4
noOam:
pop	{r4-r7}

End:
pop	{r4,r5}
pop	{r1}
bx	r1

.align
.ltorg
PortraitTable:
@POIN PortraitTable
