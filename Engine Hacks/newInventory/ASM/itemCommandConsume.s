.equ maxItem, newItemItems+4
.thumb
ldrb	r0,[r2,#0x1E]
cmp	r0,#1
bne	false
ldrb	r3,[r2,#0x1F]
ldr	r1,newItemItems
lsl	r3,#0x03
add	r3,r1
ldrh	r0,[r3,#0x00]
cmp	r0,#0
beq	false
ldr	r1,maxItem
cmp	r0,r1
bhi	false
ldrh	r0,[r3,#0x00]	@item id
ldrh	r1,[r3,#0x02]	@chance
cmp	r1,#0
beq	false
cmp	r1,#99
bhi	true

push	{r3}
ldr	r3,=#0x08002804	@get next rng
mov	lr,r3
.short	0xF800
mov	r1,#100
swi	#6
pop	{r3}
ldrh	r0,[r3,#0x02]	@chance
cmp	r0,r1
bhi	false
b	true

true:
ldrh	r0,[r3,#0x00]	@item id
mov	r1,#1
ldr	r3,=#0x80CA9E8
mov	lr,r3
.short	0xF800
b	end

false:
mov	r0,#0
b	end

end:
ldr	r3,=#0x80A2EC4
mov	lr,r3
.short	0xF800
.align
.ltorg
newItemItems:
