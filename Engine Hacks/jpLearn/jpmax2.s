.thumb
ldrh	r1,[r0]		@jp
mov	r0,r7
ldr	r2,tiles
push	{r4-r7}
mov	r4,r1		@jp
mov	r5,r0		@tilemap buffer
ldr	r6,=#0xD01E	@base tile
mov	r7,r4		@remainder after division
lsl	r2,#0x10
lsr	r2,#0x0F
add	r5,r2

ldr	r0,=#9999
cmp	r4,r0
blo	not5digits
mov	r4,r0
not5digits:

@draw the fourth digit
ldr	r0,=#1000
cmp	r4,r0
blo	not4digits
mov	r0,r4
ldr	r1,=#1000
swi	#6
mov	r7,r1
add	r0,r6
strh	r0,[r5,#0x00]
not4digits:

@draw the third digit
ldr	r0,=#100
cmp	r4,r0
blo	not3digits
mov	r0,r7
ldr	r1,=#100
swi	#6
mov	r7,r1
add	r0,r6
strh	r0,[r5,#0x02]
not3digits:

@draw the second digit
ldr	r0,=#10
cmp	r4,r0
blo	not2digits
mov	r0,r7
ldr	r1,=#10
swi	#6
mov	r7,r1
add	r0,r6
strh	r0,[r5,#0x04]
not2digits:

@draw the last 0
strh	r6,[r5,#0x06]

@draw the first digit
ldr	r0,=#1
cmp	r4,r0
blo	not1digits
mov	r0,r7
ldr	r1,=#1
swi	#6
mov	r7,r1
add	r0,r6
strh	r0,[r5,#0x06]
add	r5,#2
not1digits:

end:
pop	{r4-r7}
ldr	r3,=#0x802CD58
mov	lr,r3
.short	0xF800
.align
.ltorg
tiles:
