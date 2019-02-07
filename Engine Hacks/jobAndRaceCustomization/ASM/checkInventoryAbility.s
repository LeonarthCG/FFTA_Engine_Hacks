.thumb

push	{lr}
push	{r4-r7}
mov	r4,r0		@current character
mov	r5,r1		@ability to check for
ldrb	r6,[r4,#7]	@job
mov	r7,#0		@counter
add	r4,#0x2A	@character items

itemsloop:
cmp	r7,#10
bhs	False
ldrh	r0,[r4,r7]
mov	r1,#0x12
ldr	r3,=#0x80CA7A4
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	next
mov	r1,#20
mul	r0,r1
ldr	r1,=#0x80CCF98
ldr	r1,[r1]
add	r0,r1
mov	r2,#2
ldrb	r3,[r0]
abilitiesloop:
cmp	r3,#0
beq	next
ldrb	r1,[r0,r2]
cmp	r1,r6
bne	nextability
add	r2,#1
ldrb	r1,[r0,r2]
sub	r2,#1
cmp	r1,r5
beq	True
nextability:
add	r2,#2
sub	r3,#1
b	abilitiesloop
next:
add	r7,#2
b	itemsloop

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
