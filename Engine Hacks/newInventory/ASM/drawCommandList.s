.equ checkEquippedAmmount, newItemItems+4
.equ maxItem, checkEquippedAmmount+4
.equ listUselessEntries, maxItem+4
.thumb
push	{lr}
push	{r4-r5}
mov	r4,r8
mov	r5,r9
push	{r4-r7}
@set the buffers
mov	r8,r0		@some buffer stuff
add	r0,#0x80
mov	r9,r0
mov	r1,#0x94
ldr	r2,=#0x203F000
str	r2,[r0,r1]
mov	r1,#0x98
ldr	r3,=#0x203F800
str	r3,[r0,r1]
mov	r0,#0xC0
mov	r1,r8
add	r1,#0x80
ldr	r3,=#0x8005B28
mov	lr,r3
.short	0xF800
mov	r1,r0
mov	r0,r8
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

@find first empty slot
mov	r4,#0
ldr	r1,=#0x200F438
ldr	r1,[r1]
ldr	r1,[r1,#0x18]
add	r1,#0x2A
emptyloop:
ldrh	r0,[r1,#0x00]
cmp	r0,#0
beq	doneempty
add	r1,#2
add	r4,#1
doneempty:

@for every item
mov	r5,#1		@itemID
ldr	r6,maxItem
mov	r7,#0		@count
loop:
cmp	r5,r6
bhi	end

@check if there is any of them
ldr	r0,=#0x2001940
ldrb	r0,[r0,r5]
cmp	r0,#0
beq	next

@check if it is a weapon
mov	r0,r5
ldr	r3,=#0x80CB1F4
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	next

@check if the unit can use it
ldr	r0,=#0x200F438
ldr	r0,[r0]
ldr	r0,[r0,#0x18]
mov	r1,r5
ldr	r3,=#0x80CB450
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	next

@check if there are any free (owned - equipped), for usability
mov	r0,r5
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldr	r1,=#0x2001940
ldrb	r1,[r1,r5]
sub	r1,r0
cmp	r1,#0
beq	none
mov	r2,#1
b	usability
none:
ldr	r0,listUselessEntries
cmp	r0,#0
beq	next
mov	r2,#0
b	usability

@store usability (r2)
usability:
mov	r0,r8
mov	r1,#0x98
ldr	r0,[r0,r1]
strb	r2,[r0,r7]

@store the id (r5)
mov	r0,r8
mov	r1,#0x94
ldr	r0,[r0,r1]
lsl	r1,r7,#2
str	r5,[r0,r1]

@increase count
add	r7,#1

next:
add	r5,#1
b	loop

end:
@store the count
mov	r2,r9
strh	r7,[r2,#0x04]
mov	r1,#6
strb	r1,[r2,#0x03]
cmp	r7,#6
bhi	scroll
strb	r7,[r2,#0x03]
scroll:
cmp	r7,#4
bhi	store4
mov	r0,#7
cmp	r7,#3
blo	store7
mov	r0,#9
sub	r0,r7
b	storeheight
store4:
mov	r0,#4
b	storeheight
store7:
mov	r0,#7
b	storeheight
storeheight:
strb	r0,[r2,#0x01]

return:
pop	{r4-r7}
mov	r8,r4
mov	r9,r5
pop	{r4-r5}
pop	{r0}
bx	r0
.align
.ltorg
newItemItems:
