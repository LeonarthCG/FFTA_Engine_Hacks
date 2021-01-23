.equ maxItem, checkEquippedAmmount+4
.equ listUselessEntries, maxItem+4
.thumb
push	{lr}
push	{r4-r7}
ldr	r4,=#0x200F438
ldr	r4,[r4,#0x00]
ldr	r4,[r4,#0x18]	@unit
ldr	r5,=#0x2001940
ldr	r6,maxItem

@check if we have any free hands
mov	r0,r4
ldr	r3,=#0x80269D8
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	false

@check if any of the weapons in the inventory are compatible with this unit
mov	r7,#1		@item ID
equiploop:
cmp	r7,r6
bhi	false
ldrb	r0,[r5,r7]
cmp	r0,#0
beq	nextequip
mov	r0,r4		@unit data offset
mov	r1,r7		@item ID
ldr r2,=#0x3002818
ldr r2,[r2]
ldr r3,=#0xC1F
ldrb r2,[r2,r3] @inventory slot
ldr	r3,=#0x80CB48C
mov	lr,r3
.short	0xF800
mov	r1,#1
and r0,r1
cmp	r0,#0
beq	match
nextequip:
add	r7,#1
b	equiploop

@if list equipped, then we are done, otherwise check if there are free copies
match:
ldr	r1,listUselessEntries
cmp	r1,#0
bne	true
mov	r0,r7
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldrb	r1,[r5,r7]
cmp	r0,r1
blo	true
b	nextequip

false:
mov	r0,#0
b	end

true:
mov	r0,#1
b	end

end:
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
checkEquippedAmmount:
