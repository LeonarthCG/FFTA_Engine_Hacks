.equ	checkEquippedamount, newItemTabs+4
.equ	maxItem, checkEquippedamount+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r1		@tab to fill
mov	r5,r0		@destination
mov	r6,#1		@item id
mov	r7,#0		@count

@for every item
loop:
ldr	r0,maxItem
cmp	r6,r0
bhi	end

@check if we own any
ldr	r0,=#0x2001940	@inventory data
ldrb	r0,[r0,r6]	@count for this item
cmp	r0,#0
beq	next

@check if it is the right tab for this item
ldr	r0,=#0x8079AEC
ldr	r0,[r0,#0x00]	@item table
lsl	r1,r6,#5	@item ID*size of item table entry (32)
add	r2,r0,r1	@location of item data for this item
ldrb	r0,[r2,#0x08]	@item type
ldr	r1,newItemTabs
ldrb	r0,[r1,r0]	@tab for this type of item
cmp	r0,r4		@check if it matches the tab we want
bne	next

@store id
strh	r6,[r5,#0x00]

@store owned
ldr	r0,=#0x2001940	@inventory data
ldrb	r0,[r0,r6]	@count for this item
strb	r0,[r5,#0x02]

@store equipped
mov	r0,r6
ldr	r3,checkEquippedamount
mov	lr,r3
.short	0xF800
strb	r0,[r5,#0x03]

@increase count and destination
add	r7,#1
add	r5,#4

@increase id
next:
add	r6,#1
b	loop

end:
@return count
mov	r0,r7
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
newItemTabs:
