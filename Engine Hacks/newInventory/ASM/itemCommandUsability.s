.equ checkEquippedAmmount, newItemItems+4
.equ maxItem, checkEquippedAmmount+4
.thumb
push	{lr}
push	{r4-r5}
mov	r4,r8
mov	r5,r9
push	{r4-r7}
mov	r8,r0		@buffer
mov	r9,r1		@window geometry
ldr	r4,newItemItems
ldr	r5,[r1]		@ability list of this race (item)
mov	r6,#0		@ability id
mov	r7,#0		@count

@set the new buffers
mov	r1,r8
add	r1,#0x94
ldr	r0,=#0x203F000	@new ability ids list destination
str	r0,[r1,#0x00]
ldr	r0,=#0x203F800	@new usability destination
str	r0,[r1,#0x04]
mov	r1,r8
add	r1,#0x80
mov	r0,#0x0F
strb	r0,[r1,#0x0C]
mov	r0,#0x08
strb	r0,[r1,#0x0D]
mov	r0,r9
mov	r1,#0x02
strb	r1,[r0,#0x08]

@for every ability
loop:
@check if the end
ldrh	r0,[r4,#0x00]
ldr	r1,=#0xFFFF
cmp	r0,r1
beq	end

@check if we have the required item
ldrh	r0,[r4,#0x00]
cmp	r0,#0
beq	haveItem
ldr	r1,maxItem
cmp	r0,r1
bhi	next
ldr	r1,=#0x2001940
ldrb	r0,[r1,r0]
cmp	r0,#0
beq	next

@check if there are any free copies of the item left
ldrh	r0,[r4,#0x00]
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldrh	r1,[r4,#0x00]
ldr	r2,=#0x2001940
ldrb	r1,[r2,r1]
cmp	r0,r1
blo	haveItem
b	next

@check if we fulfill the extra condition
haveItem:
ldr	r0,[r4,#0x04]
cmp	r0,#0
beq	true
mov	lr,r0
.short	0xF800
cmp	r0,#0
beq	false
b	true

@set the usability
false:
mov	r0,#0
b	storeUsability
true:
mov	r0,#1
storeUsability:
mov	r1,r8
add	r1,#0x98
ldr	r1,[r1,#0x00]
strb	r0,[r1,r7]

@store the id
mov	r1,r8
add	r1,#0x94
ldr	r1,[r1,#0x00]
lsl	r2,r7,#2
str	r6,[r1,r2]

@get size of the name and store it if bigger than default
ldr	r0,=#0x8026CA0
ldr	r0,[r0,#0x00]
ldrh	r1,[r5,#0x00]
lsl	r1,#2
ldr	r0,[r0,r1]
ldr	r3,=#0x80161BC
mov	lr,r3
.short	0xF800
mov	r2,r9
ldrb	r1,[r2,#0x07]	@size of the window
cmp	r1,r0
bhi	isSmaller
strb	r0,[r2,#0x07]	@make it bigger
isSmaller:

@increase count
add	r7,#1

next:
add	r6,#1
add	r4,#8
add	r5,#8
b	loop

end:
@store the ammount
mov	r0,r9
strb	r7,[r0,#0x09]
pop	{r4-r7}
mov	r8,r4
mov	r9,r5
pop	{r4-r5}
pop	{r0}
bx	r0
.align
.ltorg
newItemItems:
