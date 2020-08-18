.equ checkEquippedAmmount, newItemTabs+4
.equ maxItem, checkEquippedAmmount+4
.equ listUselessEntries, maxItem+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,#1	@first item
mov	r5,#0	@count
ldr	r6,=#0x2001940
mov	r7,r0	@buffer

@set the buffer stuff
mov	r0,#0xC0
mov	r1,r7
add	r1,#0x80
ldr	r3,=#0x8005B28
mov	lr,r3
.short	0xF800
mov	r1,r0
mov	r0,r7
add	r0,#0xA0
str	r1,[r0]
add	r1,#0x80
ldr	r0,=#0x8027844
ldr	r0,[r0,#0x00]
mov	r2,#0x20
ldr	r3,=#0x8005318
mov	lr,r3
mov	r3,#0x01
.short	0xF800
mov	r0,#0x80
add	r0,r7
ldr	r1,=#0x203F000
str	r1,[r0,#0x14]
ldr	r1,=#0x203F800
str	r1,[r0,#0x18]
add	r7,#0x80

@for every item
loop:
ldr	r0,maxItem
cmp	r4,r0
bhi	end

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
ldr	r1,newItemTabs
ldrb	r0,[r1,r0]	@item tab
cmp	r0,#2
bne	next

@check if we have any free copies
ldr	r0,listUselessEntries
cmp	r0,#0
bne	skip
mov	r0,r4
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldrb	r1,[r6,r4]
cmp	r1,r0
bhi	skip
b	next

@add it to the list
skip:
ldr	r3,=#0x203F000
lsl	r2,r5,#2
str	r4,[r3,r2]

@check which color
mov	r0,r4
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldrb	r1,[r6,r4]
cmp	r1,r0
bhi	grey
b	white

white:
mov	r0,#0
b	color

grey:
mov	r0,#1
b	color

color:
ldr	r3,=#0x203F800
strb	r0,[r3,r5]
add	r5,#1

next:
add	r4,#1
b	loop

end:
@store the count
strh	r5,[r7,#0x04]
mov	r1,#6
strb	r1,[r7,#0x03]
cmp	r5,#6
bhi	scroll
strb	r5,[r7,#0x03]
scroll:
cmp	r5,#4
bhi	store4
mov	r0,#7
cmp	r5,#3
blo	store7
mov	r0,#9
sub	r0,r5
b	storeheight
store4:
mov	r0,#4
b	storeheight
store7:
mov	r0,#7
b	storeheight
storeheight:
strb	r0,[r7,#0x01]

return:
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
newItemTabs:
