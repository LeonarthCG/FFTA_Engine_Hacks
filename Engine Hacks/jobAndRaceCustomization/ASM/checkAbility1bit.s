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

push	{lr}
push	{r4-r7}
mov	r4,r0
mov	r5,r1
mov	r6,r2
mov	r7,r3

@check type
cmp	r6,#0
beq	truetype
ldrb	r0,[r4,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
mov	r1,r5
lsl	r1,#3		@*size of entry
add	r0,r1
ldrb	r1,[r0,#6]	@ability type
cmp	r6,#1
beq	testAction
cmp	r1,r6
beq	truetype
b	False
testAction:
cmp	r1,#4
beq	truetype
cmp	r1,#1
beq	truetype
b	False
truetype:

@check if cost is 0
ldrb	r0,[r4,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
lsl	r1,r5,#3	@ability id*size of entry
add	r0,r1
ldrb	r1,[r0,#7]	@ap cost
cmp	r1,#0
beq	True

@check bit
mov	r0,r5
cmp	r0,#0
beq	False
sub	r0,#1
mov	r1,#8
swi	#6
mov	r2,#1
lsl	r2,r1
add	r3,#0x40
add	r3,r4
ldrb	r0,[r3]
and	r2,r0
cmp	r2,#0
beq	checkItem
b	True

checkItem:
cmp	r7,#0
beq	False
mov	r0,r4
mov	r1,r5
ldr	r3,pointer
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	False
b	True

True:
mov	r0,#1
b	End

False:
mov	r0,#0
b	End

End:
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg
pointer:
