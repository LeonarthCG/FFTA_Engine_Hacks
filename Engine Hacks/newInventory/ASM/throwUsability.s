.equ checkEquippedAmmount, newItemTabs+4
.equ maxItem, checkEquippedAmmount+4
.equ listUselessEntries, maxItem+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,#1	@first item
ldr	r5,maxItem
ldr	r6,=#0x2001940
ldr	r7,newItemTabs

@for every item
loop:
cmp	r4,r5
bhi	false

@check if we have any of it
ldrb	r0,[r6,r4]
cmp	r0,#0
beq	next

@check if it is a weapon
ldr	r0,=#0x8079AEC
ldr	r0,[r0,#0x00]	@item table
lsl	r1,r4,#5	@item ID*size of item table entry (32)
add	r2,r0,r1	@location of item data for this item
ldrb	r0,[r2,#0x08]	@item type
ldrb	r0,[r7,r0]	@item tab
cmp	r0,#2
bne	next

@check if we have any free copies
ldr	r0,listUselessEntries
cmp	r0,#0
bne	true
mov	r0,r4
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldrb	r1,[r6,r4]
cmp	r1,r0
bhi	true
b	false

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
newItemTabs:
