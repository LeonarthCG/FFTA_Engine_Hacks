.equ draw4digits, tiles+4
.equ return, draw4digits+4
.equ color, return+4
.thumb

ldr	r3,=#9999
cmp	r1,r3
blo	np
mov	r1,r3
np:

@r1 is stat
mov	r0,r7
ldr	r2,tiles
ldr	r3,color

push	{r3}
ldr	r3,draw4digits
mov	lr,r3
.short	0xF800
pop	{r3}

@draw the bars
ldr	r3,=#0xD0A7
mov	r2,#0x2E
lsl	r2,#1
strh	r3,[r7,r2]
mov	r2,#0x3F
lsl	r2,#1
strh	r3,[r7,r2]

ldr	r3,return
mov	lr,r3
.short	0xF800

.align
.ltorg
tiles:
