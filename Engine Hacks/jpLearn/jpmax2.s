.equ draw4digits, tiles+4
.thumb
ldrh	r1,[r0]		@jp
mov	r0,r7
ldr	r2,tiles
mov	r3,#0

push	{r3}
ldr	r3,draw4digits
mov	lr,r3
pop	{r3}
.short	0xF800

ldr	r3,=#0x802CD58
mov	lr,r3
.short	0xF800
.align
.ltorg
tiles:
