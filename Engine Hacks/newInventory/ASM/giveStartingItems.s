.equ maxItem, startingItems+4
.thumb
push	{r4-r7}
ldr	r4,startingItems
ldr	r5,maxItem
ldr	r6,=#0x2001940
loop:
ldrh	r0,[r4,#0x00]
cmp	r0,#0
beq	end
cmp	r0,r5
bhi	end
ldrh	r1,[r4,#0x02]
ldrb	r2,[r6,r0]
add	r2,r1
cmp	r2,#99
blo	np
mov	r2,#99
np:
strb	r2,[r6,r0]
add	r4,#4
b	loop

end:
pop	{r4-r7}
ldr	r3,=#0x800982E
mov	lr,r3
.short	0xF800
.align
.ltorg
startingItems:
