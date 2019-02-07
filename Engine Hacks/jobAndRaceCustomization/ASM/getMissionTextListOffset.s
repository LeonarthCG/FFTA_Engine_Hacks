.equ afterBattleTextCharacter, afterBattleTextRace+4
.thumb
push	{r4-r5}
mov	r4,r0		@char pointer

@check for character id first
ldrb	r0,[r4,#4]	@char id
ldr	r1,afterBattleTextCharacter
loopcharacter:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	checkrace
add	r1,#9
b	loopcharacter

@check for race id
checkrace:
ldrb	r0,[r4,#6]	@race id
ldr	r1,afterBattleTextRace
looprace:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	match
add	r1,#9
b	looprace

match:
mov	r0,r1

End:
pop	{r4-r5}
bx	lr

.align
.ltorg

afterBattleTextRace:
@POIN afterBattleTextRace
@POIN afterBattleTextCharacter
