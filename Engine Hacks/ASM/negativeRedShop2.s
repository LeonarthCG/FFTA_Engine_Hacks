.thumb
ldr	r3,=#0x203F000
ldr	r3,[r3]
cmp	r3,#0
beq	vanilla
@get the new oam
ldr	r0,oam
push	{r0-r3}
@get the new palette...
@first we need the color mode
ldr	r1,=#0x80896B0
ldr	r1,[r1]
ldr	r0,=#0x2002FC2
add	r0,r2
ldrb	r0,[r0]
lsl	r0,#0x1E
lsr	r0,#0x1B
ldr	r0,[r1,r0]
ldr	r1,=#0x140
add	r0,r1	@our palette!
@ldr	r1,=#0x3002818
@ldr	r1,[r1]
@add	r1,#0x28
@ldr	r2,=#0x260
@add	r1,r2
@mov	r2,#16
@loop1:
@ldrh	r3,[r0,r2]
@strh	r3,[r1,r2]
@sub	r2,#2
@cmp	r2,#0
@bne	loop1
ldr	r1,=#0x5000260
mov	r2,#16
loop2:
ldrh	r3,[r0,r2]
strh	r3,[r1,r2]
sub	r2,#2
cmp	r2,#0
bne	loop2
pop	{r0-r3}
vanilla:
mov	r3,r9
asr	r2,r3,#0x10
mov	r3,#0
push	{r3}
ldr	r3,=#0x8001F34
mov	lr,r3
pop	{r3}
.short	0xF800
ldr	r3,=#0x806F5D8
mov	lr,r3
.short	0xF800
.align
.ltorg
oam:
