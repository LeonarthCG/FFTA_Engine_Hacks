.equ firstPartJP, pointers
.equ secondPartJP, pointers+4
.equ jobTester, secondPartJP+4
.equ purchaseForbiddenList, jobTester+4
.equ checkAbility, purchaseForbiddenList+4
.equ install1bitAbilities, checkAbility+4
.thumb

pop	{r3}

push	{r4}

mov	r0,#0xCC
mov	r4,r7
mul	r4,r0
add	r0,r4,r3
mov	r2,#0xB4
lsl	r2,#6
add	r0,r2
add	r1,r4,r3
ldr	r3,=#0x2D20
add	r1,r3
ldrb	r1,[r1,#0x11]
lsl	r1,#0x18
asr	r1,#0x18

push	{r3}
ldr	r3,=#0x8017B68
mov	lr,r3
pop	{r3}
.short	0xF800

mov	r2,r8
ldr	r1,[r2]
add	r2,r1,r4
ldr	r3,=#0x2CD0
add	r1,r3
add	r1,r4
ldr	r1,[r1]
lsl	r0,#0x18
asr	r0,#0x18
ldr	r3,[r1,#0x18]
lsl	r1,r0,#2
add	r1,r0
lsl	r1,#2
add	r1,r3
mov	r0,r1
mov	r3,#0xB3
lsl	r3,#6
add	r2,r3
pop	{r3}

@prepare registers
push	{r4-r7}

ldr	r1,=#0x3002818		@if no job, stop
ldr	r1,[r1]
push	{r2}
ldr	r2,=#0x1BE4
add	r1,r2
pop	{r2}
ldrb	r1,[r1,#8]
cmp	r1,#1
bls	EndNoMessageTrampolin

mov	r4,r0
mov	r5,r1
mov	r6,r2

@check if during battle
ldr	r0,=#0x20320F7
cmp	r0,r3
beq	EndNoMessageTrampolin

@r4 = pointer to description
@r5 = job
@r6 = place to store the ability to
@r7 = counter/ability id for this race

@check if not player
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer
mov	r2,#0x29
ldrb	r2,[r3,r2]
mov	r3,#0xB0	@0xB0 = 1 (enemy) 0 (boss) 1 (guest) 1 (judge) 0 0 0 0
and	r2,r3
cmp	r2,#0
bne	EndNoMessageTrampolin

@check if the unit is jailed or dispatched
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer
mov	r2,#0x28
ldrb	r2,[r3,r2]
mov	r3,#0x0C	@mission and jail
and	r2,r3
cmp	r2,#0
bne	EndNoMessageTrampolin

@check if the unit is this job, if so skip next check
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer
ldrb	r3,[r3,#7]	@current job
cmp	r3,r5
beq	skipJobCheck

@check if this job is available to this unit
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
mov	r1,r5
ldr	r3,jobTester
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	EndNoMessageTrampolin

skipJobCheck:
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
ldrh	r1,[r4,#2]	@ability ID
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
.short	0xF800
cmp	r0,#0
bne	noMatch
ldrh	r7,[r4,#2]
b	match

noMatch:
ldr	r0,=#0x651
strh	r0,[r6]
b	EndNoMessage

match:
ldrb	r1,[r4,#0xF]	@ap cost/10
@check if 0
cmp	r1,#0
beq	EndNoMessageTrampolin
mov	r2,#10
mul	r1,r2		@ap cost

b	EndNoMessageTrampolinSkip
EndNoMessageTrampolin:
b	EndNoMessage
EndNoMessageTrampolinSkip:

@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer

mov	r2,#0xD6
ldrh	r2,[r3,r2]	@JP

push	{r0-r3}
@check if the ability is blacklisted from buying
@get race
ldr	r2,=#0x3002818
ldr	r1,=#0x1D0C
ldr	r2,[r2]
add	r2,r1
ldr	r2,[r2]		@current character pointer
ldrb	r2,[r2,#6]	@race
ldr	r1,purchaseForbiddenList
forbiddenLoop:
ldrb	r0,[r1]
cmp	r0,#0
beq	endForbidden
cmp	r0,r2
bne	nextForbidden
ldrb	r0,[r1,#1]
cmp	r0,r7
beq	EndTrampolinForbidden
nextForbidden:
add	r1,#2
b	forbiddenLoop
EndTrampolinForbidden:
pop	{r0-r3}
b	EndNoMessageTrampolin
endForbidden:
pop	{r0-r3}

ldr	r0,install1bitAbilities
cmp	r0,#0
bne	allthejp

mov	r0,#0x40
add	r0,r7
ldrb	r0,[r3,r0]	@AP for this ability
mov	r3,#0x7F
and	r0,r3		@remove equipped bit
mov	r3,#10
mul	r0,r3
b	skip0

allthejp:
mov	r0,#0

skip0:

@if 1000, then change it to 999
ldr	r3,=#1000
cmp	r1,r3
bne	no1000
ldr	r1,=#999
no1000:

@ r0 = AP gained
@ r1 = AP cost
@ r2 = JP accumulated

@check if the skill is mastered
cmp	r0,r1
bhs	EndNoMessage

@check if there is enough JP
sub	r1,r0		@missing ap
mov	r4,r7		@ability
mov	r7,r1
cmp	r1,r2
bhi	notEnough
b	congrats

notEnough:
ldr	r0,=#0x651
strh	r0,[r6]
b	End

congrats:
ldr	r0,=#0x650
strh	r0,[r6]

@draw the text
ldr	r2,=#0x2035610	@our buffer
ldr	r0,firstPartJP	
ldr	r1,secondPartJP
firstLoop:
ldrb	r3,[r0]
strb	r3,[r2]
add	r0,#1
add	r2,#1
cmp	r0,r1
beq	endFirstLoop
b	firstLoop

endFirstLoop:
mov	r3,r2

@save the jp and job
ldr	r0,=#0x203560C
strh	r7,[r0]		@jp cost
strh	r4,[r0,#2]	@ability

@draw the JP
push	{r0-r3}
mov	r0,r7
ldr	r1,=#1000
swi	#6
mov	r4,r0
pop	{r0-r3}
cmp	r4,#0
beq	no1000s

@store number
yes1000s:
mov	r0,#0xA6
add	r0,r4
strb	r0,[r2,#1]
mov	r0,#0x80
strb	r0,[r2]
add	r2,#2

no1000s:
push	{r0-r3}
mov	r0,r7
ldr	r1,=#1000
swi	#6
mov	r0,r1
mov	r1,#100
swi	#6
mov	r4,r0
pop	{r0-r3}

@check if there are thousands
ldr	r0,=#1000
cmp	r7,r0
bhs	yes100s

cmp	r4,#0
beq	no100s

@store number
yes100s:
mov	r0,#0xA6
add	r0,r4
strb	r0,[r2,#1]
mov	r0,#0x80
strb	r0,[r2]
add	r2,#2

no100s:
push	{r0-r3}
mov	r0,r7
mov	r1,#100
swi	#6
mov	r0,r1
mov	r1,#10
swi	#6
mov	r4,r0
pop	{r0-r3}
cmp	r4,#0
bne	yes10

@check if there are hundreds
cmp	r3,r2
beq	after10s

yes10:

@store number
mov	r0,#0xA6
add	r0,r4
strb	r0,[r2,#1]
mov	r0,#0x80
strb	r0,[r2]
add	r2,#2

after10s:
push	{r0-r3}
mov	r0,r7
mov	r1,#100
swi	#6
mov	r0,r1
mov	r1,#10
swi	#6
mov	r4,r1
pop	{r0-r3}

@store number
mov	r0,#0xA6
add	r0,r4
strb	r0,[r2,#1]
mov	r0,#0x80
strb	r0,[r2]
add	r2,#2

secondLoop:
ldrb	r3,[r1]
strb	r3,[r2]
add	r1,#1
add	r2,#1
cmp	r3,#0
bne	secondLoop
ldrb	r3,[r1]
cmp	r3,#0
bne	secondLoop
strb	r3,[r2]

End:
pop	{r4-r7}
ldr	r2,=#0x8083C9D
bx	r2

EndNoMessage:
pop	{r4-r7}
mov	r0,#4
ldr	r2,=#0x8083F9F
bx	r2

.align
.ltorg

pointers:
@POIN first pointer
@POIN second pointer
@POIN jobTester
@POIN purchaseForbiddenList
@POIN checkAbility
@WORD install1bitAbilities
