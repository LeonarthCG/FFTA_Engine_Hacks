.equ checkAbility, newJobAbilityTable+4
.equ bitMode, checkAbility+4
.thumb

lsl	r0,#2
add	r0,r8
strh	r7,[r0,#0xC]

push	{r0-r3}
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1C1A
add	r0,r1
ldrb	r0,[r0]
mov	r10,r0
ldr	r1,newJobAbilityTable
ldr	r3,=#0x3002818
ldr	r3,[r3]
push	{r2}
ldr	r2,=#0x1BE4
add	r3,r2
pop	{r2}
ldrb	r3,[r3,#8]
mov	r0,#16
mul	r3,r0
ldr	r1,[r1,r3]
cmp	r1,#0
beq	EndVanilla

@using the new lists
mov	r0,r8
mov	r1,r9
push	{r0-r1}
push	{r4-r6}
@r4 is the list to the buffer thing we need
mov	r5,#0		@counter for the loop
ldr	r6,newJobAbilityTable
ldr	r0,=#0x3002818
ldr	r0,[r0]
push	{r2}
ldr	r2,=#0x1BE4
add	r0,r2
pop	{r2}
ldrb	r0,[r0,#8]
mov	r1,#16
mul	r0,r1
add	r6,r0
ldr	r6,[r6]		@ability lists
mov	r7,#0		@ability count, stored after the return
ldr	r1,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r1,[r1]
add	r1,r3
ldr	r3,[r1]
mov	r8,r3		@current character pointer
mov	r9,r2		@some list we need

loop:
@check if end of list
ldrb	r1,[r6,r5]
cmp	r1,#0
beq	End
@check if the ability is available
mov	r0,r8
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
push	{r0-r2}
.short	0xF800
cmp	r0,#0
bne	drawMastered
pop	{r0-r2}
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
cmp	r0,#0
bne	drawWhite
@check if player
mov	r0,#0x29
mov	r1,r8
ldrb	r0,[r1,r0]
mov	r1,#0xB0	@0xB0 = 1 (enemy) 0 (boss) 1 (guest) 1 (judge) 0 0 0 0
and	r0,r1
cmp	r0,#0
bne	nextLoop
@check if out of battle
ldr	r1,=#0x203778C
mov	r2,r8
cmp	r1,r2
beq	nextLoop
b	drawGrey

drawWhite:
ldr	r0,bitMode
cmp	r0,#0
bne	drawWhiteBit
@get ap
ldrb	r1,[r6,r5]
mov	r3,r8
add	r3,#0x40
add	r3,r1
ldrb	r0,[r3]
mov	r1,#0x80
orr	r0,r1
b	draw
drawWhiteBit:
mov	r0,#0x80
b	draw

drawMastered:
pop	{r0-r2}
mov	r0,#0xE4
b	draw

drawGrey:
ldr	r0,bitMode
cmp	r0,#0
bne	drawGreyBit
@get ap
ldrb	r1,[r6,r5]
mov	r3,r8
add	r3,#0x40
add	r3,r1
ldrb	r0,[r3]
mov	r1,#0x7F
and	r0,r1
b	draw
drawGreyBit:
mov	r0,#0
b	draw

draw:
@some more generic stuff for the entry
mov	r2,r9
ldrb	r1,[r6,r5]
strh	r1,[r2]		@ability ID
strh	r5,[r4]		@index
strh	r1,[r4,#2]	@ability ID, vanilla stores 0 which is never read
strb	r0,[r4,#0x0E]
add	r7,#1		@incrase number of abilities
@get data for the ability
mov	r0,r8
ldrb	r0,[r0,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
ldrb	r1,[r6,r5]
lsl	r1,#3		@*size of entry
add	r0,r1		@entry of the ability
ldrh	r1,[r0,#0x00]
strh	r1,[r4,#0x08]
ldrh	r1,[r0,#0x02]
strh	r1,[r4,#0x0C]
ldrb	r1,[r0,#0x07]
strb	r1,[r4,#0x0F]
ldrb	r1,[r0,#0x06]
strb	r1,[r4,#0x10]
@prepare for next entry
add	r4,#0x14	@next entry
mov	r0,r9
add	r0,#2
mov	r9,r0		@next entry
b	nextLoop

@to r2 the ability id
@to r4   index
@to r4+2 0 in vanilla, ability ID now
@to r4+e AP, 0 if grey, 0x80 if white
@to r4+8 name id
@to r4+c description id
@to r4+f ap cost
@to r4+0x10 ability type
@then r4+0x14

nextLoop:
add	r5,#1		@next index
b	loop

End:
sub	r4,#0x14
pop	{r4-r6}
pop	{r0-r1}
mov	r8,r0
mov	r9,r1
ldr	r3,=#0x807C548
mov	lr,r3
pop	{r0-r3}
.short	0xF800

EndVanilla:
mov	r4,r5
sub	r4,#1
ldrb	r6,[r4]
ldrb	r5,[r5]
cmp	r6,r5
bgt	EndVanilla2
ldr	r3,=#0x807C486
mov	lr,r3
pop	{r0-r3}
mov	r2,#0
mov	r9,r2
lsl	r0,r6,#3
add	r5,r0,r1
.short	0xF800

EndVanilla2:
ldr	r3,=#0x807C548
mov	lr,r3
pop	{r0-r3}
.short	0xF800

.align
.ltorg
newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkAbility
@WORD bitMode
