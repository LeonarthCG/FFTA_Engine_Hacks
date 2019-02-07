.equ missionTextCharacter, missionTextRace+4
.thumb

@r4 is current character
@first check if character id matches
ldrb	r0,[r4,#4]	@char id
ldr	r1,missionTextCharacter
charloop:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	checkrace
add	r1,#2
b	charloop

@check if race id matches
checkrace:
ldrb	r0,[r4,#6]	@race id
ldr	r1,missionTextRace
raceloop:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	match
add	r1,#2
b	raceloop

match:
ldrb	r0,[r1,#1]	@result

End:
pop	{r4}
pop	{r1}
bx	r1

.align
.ltorg

missionTextRace:
@POIN missionTextRace
@POIN missionTextCharacter
