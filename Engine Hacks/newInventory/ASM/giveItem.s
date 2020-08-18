.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@ID of the item to grant
mov	r5,r1		@ammount to give
ldr	r6,=#0x2001940	@inventory data

@check if the ID is 0, if so return -1
cmp	r4,#0
beq	notItem

@check if this ID is too high, if so return -1
ldr	r1,=#0x1FF
cmp	r4,r1
bhi	notItem

@increase ammount
ldrb	r0,[r6,r4]
add	r0,r5
cmp	r0,#99
bhi	capped
b	notCapped

@if capped, return how many items were lost
capped:
ldrb	r0,[r6,r4]
mov	r1,#99
strb	r1,[r6,r4]
sub	r0,r1
b	end

@if not capped, return 0
notCapped:
strb	r0,[r6,r4]
mov	r0,#0
b	end

@if ID is invalid, return -1
notItem:
mov	r0,#0
sub	r0,#1
b	end

end:
pop	{r4-r7}
pop	{r1}
bx	r1
