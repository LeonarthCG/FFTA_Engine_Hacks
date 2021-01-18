.equ checkEquippedamount, newItemTabs+4
.equ maxItem, checkEquippedamount+4
.equ listUselessEntries, maxItem+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@tab to fill
mov	r5,r1		@destination

@set up some data
ldr	r0,=#0x8079AD4
ldr	r0,[r0]
str	r0,[r5,#0x04]
mov	r0,#0
strb	r0,[r5,#0x0C]
strb	r0,[r5,#0x0D]
mov	r0,#21
strb	r0,[r5,#0x0E]
mov	r0,#13
strb	r0,[r5,#0x0F]
ldr	r0,=#0x229
strh	r0,[r5,#0x10]
mov	r0,#0
strh	r0,[r5,#0x12]
strh	r0,[r5,#0x14]
mov	r0,#16
strh	r0,[r5,#0x16]
ldr	r0,=#0x230
add	r0,r5
str	r0,[r5,#0x18]
push	{r5}		@save the original destination, so we can store the amount of items to it at the end
ldr	r0,=#0x230
add	r5,r0

@for every item
mov	r6,#1		@item ID to check, no use checking item 0
mov	r7,#0		@count
loop:
ldr	r0,maxItem	@max item id
cmp	r6,r0
bhi	end

@if there is more than 0 of this item
ldr	r0,=#0x2001940	@inventory data
ldrb	r0,[r0,r6]	@count for this item
cmp	r0,#0
beq	next

@if the item type goes on this tab
ldr	r0,=#0x8079AEC
ldr	r0,[r0,#0x00]	@item table
lsl	r1,r6,#5	@item ID*size of item table entry (32)
add	r2,r0,r1	@location of item data for this item
ldrb	r0,[r2,#0x08]	@item type
ldr	r1,newItemTabs
ldrb	r0,[r1,r0]	@tab for this type of item
cmp	r0,r4		@check if it matches the tab we want
bne	next

@check if useless entry
ldr	r0,listUselessEntries
cmp	r0,#0
bne	skip
@check if it can be equipped, store result
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1D0C
add	r0,r1
ldr	r0,[r0]		@unit data offset
mov	r1,r6		@item ID
ldr r2,=#0x3002818
ldr r2,[r2]
ldr r3,=#0xC1F
ldrb r2,[r2,r3] @inventory slot
ldr	r3,=#0x80CB48C
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	next
@and finally check if any free
mov	r0,r6		@item ID
ldr	r3,checkEquippedamount
mov	lr,r3
.short	0xF800
ldr	r1,=#0x2001940	@inventory data
ldrb	r1,[r1,r6]	@count for this item
cmp	r0,r1
blo	skip
b	next

@add the item to the list
skip:
ldr	r0,=#0x8079AEC
ldr	r0,[r0,#0x00]	@item table
lsl	r1,r6,#5	@item ID*size of item table entry (32)
add	r2,r0,r1	@location of item data for this item
@table format:
@+0x00	index in this list (same as item count)
@+0x02	1 if not selectable, 0 (or any other number, really) otherwise
@+0x04	item ID
@+0x08	name ID
@+0x0C	description ID
@+0x0E	amount equipped
@+0x0F	amount owned
@+0x10	always 0
@+0x12	index in the inventory (same as item ID for us)
strh	r7,[r5,#0x00]	@index in the list
str	r6,[r5,#0x04]	@item id
ldrh	r0,[r2,#0x00]	@load name ID
strh	r0,[r5,#0x08]	@name ID
ldrh	r0,[r2,#0x02]	@load description ID
strh	r0,[r5,#0x0C]	@description ID
ldr	r0,=#0x2001940	@inventory data
ldrb	r0,[r0,r6]	@count for this item
strb	r0,[r5,#0x0F]	@amount owned
mov	r0,#0
strh	r0,[r5,#0x10]	@always 0
strh	r6,[r5,#0x12]
@check if it can be equipped, store result
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1D0C
add	r0,r1
ldr	r0,[r0]		@unit data offset
mov	r1,r6		@item ID
ldr r2,=#0x3002818
ldr r2,[r2]
ldr r3,=#0xC1F
ldrb r2,[r2,r3] @inventory slot
ldr	r3,=#0x80CB48C
mov	lr,r3
.short	0xF800
mov	r1,#1
and	r0,r1
strh	r0,[r5,#0x02]	@can equip
@and finally check if there are any unequipped items, if not then it can not be equipped
mov	r0,r6		@item ID
ldr	r3,checkEquippedamount
mov	lr,r3
.short	0xF800
strb	r0,[r5,#0x0E]	@store equipped amount
ldrb	r1,[r5,#0x0F]	@get owned amount
cmp	r0,r1
blo	freeItems
mov	r0,#1
strh	r0,[r5,#0x02]	@can equip
freeItems:
@and prepare next
add	r7,#1		@increase count
add	r5,#20		@and increase the destination by size of entry (20)

next:
add	r6,#1
b	loop

end:
@store count
pop	{r5}
str	r7,[r5]
@make sure the tab is still safe
cmp	r7,#0
bne	safe
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0xC1E
ldrb	r2,[r0,r1]
cmp	r2,r4
bne	safe
mov	r2,#0xFF
strb	r2,[r0,r1]
@return count
safe:
mov	r0,r7
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
newItemTabs:
