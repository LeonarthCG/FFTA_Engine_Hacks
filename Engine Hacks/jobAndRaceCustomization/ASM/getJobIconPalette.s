.thumb
push	{lr}
push	{r1-r3}
push	{r4}
mov	r4,r0	@job

@check if there is a new icons
lsl	r0,#3
ldr	r1,pointer
add	r1,r0
ldr	r2,[r1]
cmp	r2,#0
beq	vanilla
@get the new palette
ldrh	r0,[r1,#4]
add	r0,#0xD

End:
pop	{r4}
pop	{r1-r3}
pop	{r1}
bx	r1

vanilla:
ldr	r0,=#0x80CBA1C
mov	lr,r0
mov	r0,r4
pop	{r4}
pop	{r1-r3}
lsl	r0,r0,#0x18
lsr	r1,r0,#0x18
cmp	r1,#0x52
.short	0xF800

.align
.ltorg

pointer:
