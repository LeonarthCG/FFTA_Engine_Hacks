.equ	checkEquippedamount, newItemTabs+4
.equ	maxItem, checkEquippedamount+4
.thumb
mov	r5,#0		@count
mov	r6,r1		@some flag about which items are unlocked
mov	r7,#1		@item id

loop:
ldr	r0,maxItem
cmp	r7,r0
bhi	end

@check it is unlocked
ldr	r0,=#0x80CBE7C
ldr	r0,[r0]
lsl	r1,r7,#5
add	r1,r0		@item data
ldrb	r0,[r1,#0x0C]
ldr	r1,[sp,#0x0C]
and	r0,r1
cmp	r0,#0
beq	next

@get the tab it belongs to
ldr	r0,=#0x80CBE7C
ldr	r0,[r0]
lsl	r1,r7,#5
add	r1,r0
ldrb	r1,[r1,#0x08]
ldr	r0,newItemTabs
ldrb	r0,[r0,r1]
cmp	r0,r9
bne	next

@get the offset of this items data
ldr	r4,[sp,#0x00]
lsl	r1,r5,#2
add	r4,r1

@and store the data
strh	r7,[r4,#0x00]	@item id
ldr	r0,=#0x2001940
ldrb	r0,[r0,r7]
strb	r0,[r4,#0x02]	@owned ammount
mov	r0,r7
ldr	r3,checkEquippedamount
mov	lr,r3
.short	0xF800
strb	r0,[r4,#0x03]	@equipped ammount

matched:
add	r5,#1
next:
add	r7,#1
b	loop

end:
mov	r0,r5
add	sp,#0x14
pop	{r3-r5}
mov	r8,r3
mov	r9,r4
mov	r10,r5
pop	{r4-r7}
pop	{r1}
bx	r1
.align
.ltorg
newItemTabs:

