.equ dismissTextCharacter, dismissTextRace+4
.thumb

mov	r4,r0
ldrb	r0,[r4,#4]	@char id
ldr	r1,dismissTextCharacter
loopcharacter:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	checkrace
add	r1,#4
b	loopcharacter

checkrace:
ldrb	r0,[r4,#6]	@race id
ldr	r1,dismissTextRace
looprace:
ldrb	r2,[r1]
cmp	r2,r0
beq	match
cmp	r2,#0
beq	match
add	r1,#4
b	looprace

match:
add	r1,#1
mov	r4,r1
ldr	r0,=#0x8002804	@get random number
mov	lr,r0
.short	0xF800
mov	r1,#3
swi	#6		@divided by 3
ldrb	r4,[r4,r1]
mov	r0,#0

End:
ldr	r3,=#0x8086D08
mov	lr,r3
.short	0xF800

.align
.ltorg

dismissTextRace:
@POIN dismissTextRace
@POIN dismissTextCharacter
