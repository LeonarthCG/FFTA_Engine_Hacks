.thumb

lsl	r0,#0x18
lsr	r1,#0x18
ldrb	r0,[r4,#1]
push	{r0,r1,r6}
cmp	r0,#0x1C
bne	End

@check if story is 0x10 or higher, if so skip montblanc check
ldr	r0,=#0x2002190
ldrb	r0,[r0]
cmp	r0,#0x10
bhs	checkMarche

@check if montblanc died, if so, game over
checkMontblanc:
mov	r0,#8
ldr	r3,=#0x8125578	@get character pointer
mov	lr,r3
.short	0xF800
mov	r6,r0
ldr	r3,=#0x80C8364	@check if stone?
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	gameOver
mov	r0,r6
ldr	r3,=#0x80C8364	@check if player unit?
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	gameOver
ldrh	r0,[r6,#0x18]
cmp	r0,#0
beq	gameOver

@check if marche died, if so, game over
checkMarche:
mov	r0,#2
ldr	r3,=#0x8125578	@get character pointer
mov	lr,r3
.short	0xF800
mov	r6,r0
ldr	r3,=#0x80C8364	@check if stone?
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	gameOver
mov	r0,r6
ldr	r3,=#0x80C8364	@check if player unit?
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	gameOver
ldrh	r0,[r6,#0x18]
cmp	r0,#0
beq	gameOver
b	End

@game over
gameOver:
ldr	r0,pointer
sub	r0,#4
ldrb	r1,[r4,#2]
ldrb	r2,[r4,#3]
lsl	r2,#8
orr	r1,r2
sub	r0,r1
str	r0,[r5,#0xC]
mov	r0,#0
strh	r0,[r5]

End:
pop	{r0,r1,r6}
cmp	r0,#0x1C
bne	noChange
mov	r0,r1
noChange:
cmp	r0,#0
bne	goto123BA4

goto123B86:
ldr	r3,=#0x8123B86
mov	lr,r3
.short	0xF800

goto123BA4:
ldr	r3,=#0x8123BA4
mov	lr,r3
.short	0xF800

.align
.ltorg

pointer:
