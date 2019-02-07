.thumb
@r0 = pointer to character
@r1 = ability id
@r2 = type of ability to check
	@0 for any
	@1 for action
		@need to also check 4 if it is 1
	@2 for support
	@3 for reaction
	@5 for combo
@r3 = check equipped abilities
	@0 for not checking
	@1 for checking
	
push	{r2}
mov	r2,r3

@get AP
mov	r3,r0
add	r3,#0x40
add	r3,r1
ldrb	r3,[r3]
cmp	r2,#0
bne	equippedCounts
mov	r2,#0x7F
and	r3,r2		@ap
equippedCounts:

@check if AP is enough
ldrb	r0,[r0,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
lsl	r1,#3		@*size of entry
add	r0,r1
ldrb	r1,[r0,#7]	@ap cost
pop	{r2}
cmp	r3,r1
blo	False
cmp	r2,#0
beq	True
ldrb	r1,[r0,#6]	@ability type
cmp	r2,#1
beq	testAction
cmp	r1,r2
beq	True
b	False
testAction:
cmp	r1,#4
beq	True
cmp	r1,#1
beq	True
b	False

@endings
True:
mov	r0,#1
b	End

False:
mov	r0,#0
b	End

End:
bx	lr


