.equ maxItem, checkEquippedAmmount+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,#1		@first id
ldr	r5,=#0x2001940	@inventory
ldr	r7,maxItem

@for every item
loop:
cmp	r4,r7
bhi	false
@check if the player owns this item
ldrb	r6,[r5,r4]	@get count
cmp	r6,#0
beq	next
@check if the player has any of them free
mov	r0,r4
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
cmp	r0,r6
blo	true
next:
add	r4,#1
b	loop

true:
mov	r0,#1
b	end

false:
mov	r0,#0
b	end

end:
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
checkEquippedAmmount:
