.equ newItemJobs, newNoItemEquipJobs+4
.thumb

push	{r4}
mov	r4,r0	@current character pointer

cmp	r0,#0
beq	End

@check if item is equipped as second action
mov	r0,#0x36
ldrb	r0,[r4,r0]
cmp	r0,#1
bne	checkNewItem

@check if on the no item list
ldrb	r0,[r4,#7]	@job
mov	r1,#0
ldr	r2,newNoItemEquipJobs
newNoItemLoop:
ldrb	r3,[r2,r1]
cmp	r3,#0
beq	checkNewItem
cmp	r3,r0
beq	removeItem
add	r1,#1
b	newNoItemLoop
removeItem:
mov	r0,#0
mov	r1,#0x36
strb	r0,[r4,r1]

@check if on the item list
checkNewItem:
ldrb	r0,[r4,#7]	@job
mov	r1,#0
ldr	r2,newItemJobs
newItemLoop:
ldrb	r3,[r2,r1]
cmp	r3,#0
beq	False
cmp	r3,r0
beq	True
add	r1,#1
b	newItemLoop

True:
@set it just in case
mov	r0,#1
mov	r1,#0x37
strb	r0,[r4,r1]
b	End

False:
@unset it just in case
mov	r0,#0
mov	r1,#0x37
strb	r0,[r4,r1]
b	End

End:
pop	{r4}
bx	lr

.align
.ltorg

newNoItemEquipJobs:
@POIN newNoItemEquipJobs
@POIN newItemJobs

