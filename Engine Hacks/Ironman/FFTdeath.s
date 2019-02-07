.thumb

push	{r6}
mov	r6,#0

@check if marche and check if montblanc before first jagd to cause a game over

@checking if undead
ldr	r2,[r7]
ldr	r2,[r2]
mov	r1,#0x29
ldrb	r0,[r2,r1]
mov	r1,#8		@undead flag
and	r0,r1
cmp	r0,#0
bne	isUndead
mov	r1,#0xE9
ldrb	r0,[r2,r1]
mov	r1,#8		@zombify status
and	r0,r1
cmp	r0,#0
bne	isUndead
b	afterUndeadCheck

isUndead:
mov	r6,#1
@check if unit is an exception (inanimate, bosses, judges and non-generics not controlled by the player), if so always raise
@0x08 undead
@0x10 judge
@0x20 guest
@0x40 boss
@0x80 enemy

@get flags
ldr	r2,[r7]
ldr	r2,[r2]
mov	r0,#0x29
ldrb	r2,[r2,r0]

@if player, roll dice
mov	r1,#0xF0
and	r1,r2
cmp	r1,#0
beq	undeadRoll

@if non-generic, raise
ldr	r0,[r7]
ldr	r0,[r0]
ldrb	r0,[r0,#4]
cmp	r0,#1
bhi	afterUndeadCheck

@if judge or boss, raise
mov	r1,#0x50
and	r1,r2
cmp	r1,#0
bne	afterUndeadCheck

undeadRoll:
@check for chance of dying instead of rising
ldr	r3,=#0x08002804	@get next rng
mov	lr,r3
.short	0xF800
mov	r1,#100
swi	#6
ldr	r0,pointer
cmp	r0,#0
beq	afterUndeadCheck
cmp	r0,r1
bhi	afterUndeadCheck
mov	r6,#0

afterUndeadCheck:
ldr	r0,=#0x15D
cmp	r6,#0
bne	undeadAnimtation
ldr	r0,=#0x169
undeadAnimtation:
ldr	r2,[r7]
mov	r1,#0
ldr	r3,=#0x80D3508
mov	lr,r3
.short	0xF800

str	r0,[r7,#4]
ldr	r0,[r7]
ldr	r0,[r0]
mov	r1,#20
ldr	r3,=#0x80C7EA4
mov	lr,r3
.short	0xF800

ldr	r1,[r7]
ldr	r1,[r1]
lsr	r0,#1
@strh	r0,[r1,#0x18]	@store new HP
mov	r0,#0x8F
ldr	r3,=#0x8141520
mov	lr,r3
.short	0xF800

mov	r2,r7
add	r2,#0xCC
mov	r3,#9
strh	r3,[r2]
cmp	r6,#0
beq	noNumber
ldrh	r1,[r2,#2]
add	r0,r1,#1
strh	r0,[r2,#2]
noNumber:
lsl	r1,#0x10
lsr	r1,#0x0F
mov	r0,r7
add	r0,#0xD0
add	r0,r1
cmp	r6,#0
beq	dontgetstuck
strh	r3,[r0]
dontgetstuck:
mov	r0,#0x19
strh	r0,[r2]

End:
@remove character if it died
cmp	r6,#0
bne	dontRemove

@check if game over
ldr	r0,[r7]
ldr	r0,[r0]
ldrb	r0,[r0,#4]	@character ID
cmp	r0,#2
beq	gameOver
cmp	r0,#8
bne	doneGameOver
ldr	r0,=#0x2002190
ldrb	r0,[r0]
cmp	r0,#0x10
bhs	doneGameOver
ldr	r0,=#0x2001F69
ldrb	r0,[r0]
ldr	r3,=#0x8036350
mov	lr,r3
.short	0xF800
cmp	r0,#0x1B
beq	doneGameOver

@cause game over
gameOver:
mov	r0,#0
ldr	r1,=#0x2000080
mov	r2,#0
mov	r3,#0x84
lsl	r3,#1
gameOverLoop:
strh	r2,[r1,#0x18]
add	r1,r3
add	r0,#1
cmp	r0,#0x24
beq	doneGameOver
b	gameOverLoop
doneGameOver:

@set the remove from clan bit
ldr	r0,[r7]
ldr	r0,[r0]
add	r0,#0x29
mov	r1,#1
ldrb	r2,[r0]
orr	r2,r1
strb	r2,[r0]

@@get the pointer to the unit in the list so we can remove them
@ldr	r0,=#0x201F508
@ldr	r0,[r0,#4]
@mov	r3,r0
@	@ldr	r0,[r0,#8]
@
@loop:
@ldr	r1,[r0]
@ldr	r1,[r1]
@ldr	r2,[r7]
@ldr	r2,[r2]
@cmp	r1,r2
@bne	next
@ldr	r0,[r0]
@b	finishRemove
@next:
@mov	r3,r0
@ldr	r0,[r0,#8]
@cmp	r0,#0
@beq	dontRemove
@b	loop
@
@finishRemove:
@ldr	r3,=#0x80995C0
@mov	lr,r3
@.short	0xF800

dontRemove:
pop	{r6}
push	{r3}
ldr	r3,=#0x809F779
mov	lr,r3
pop	{r3}
.short	0xF800

.align
.ltorg

pointer:
