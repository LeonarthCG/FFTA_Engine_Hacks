.equ checkAbility, purchaseForbiddenList+4
.equ isonebit, checkAbility+4
.thumb

ldr	r3,=#0xC078
mov	r2,r7

push	{r4-r7}
mov	r4,r0		@offset to draw to, 0x24 tiles between rows
mov	r5,r1		@cost of ability
mov	r6,r3		@palette

@first we are going to clear whatever was there
mov	r0,r4
mov	r1,#0x24
sub	r0,r1
mov	r1,#0
mov	r2,#0
mov	r3,#0x24
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]
add	r2,#2
add	r3,#2
strh	r1,[r0,r2]
strh	r1,[r0,r3]

add	r4,#2
mov	r2,#0x28
sub	r4,r2

@get cursor position if screen refresh
ldr	r3,=#0x3002818
ldr	r3,[r3]
add	r3,#0xCC
ldr	r1,=#0x2CBA
add	r3,r1
	ldrb	r2,[r3]
	cmp	r2,#4
	beq	notFirst
	mov	r1,#0
	strb	r1,[r3,#1]
	mov	r1,#4
	strb	r1,[r3]
	notFirst:
ldr	r0,=#0x08083B2F
cmp	r0,lr
bne	isScrolling
mov	r2,r10
ldrb	r0,[r2,#0x1A]
ldrb	r1,[r3,#1]
add	r0,r1
add	r1,#1
strb	r1,[r3,#1]
cmp	r1,#5
bne	getAP
mov	r1,#0
strb	r1,[r3,#1]
b	getAP

@get cursor position if first load
isFirst:
ldr	r0,=#0x08083B2F
cmp	r0,lr
bne	isScrolling
mov	r0,r10
ldr	r0,[r0,#12]
add	r0,#0x14
sub	r0,r4,r0
mov	r1,#0x48
swi	#6
b	getAP

@get cursor position if scrolling
isScrolling:
mov	r0,r10
mov	r1,#0x20
add	r1,r0
ldrb	r1,[r1,#0x11]
cmp	r1,#0
beq	scrollUp
add	r1,#2
scrollUp:
push	{r3}
ldr	r3,=#0x8017B68
mov	lr,r3
pop	{r3}
.short	0xF800
cmp	r0,r2
beq	nothing
add	r0,#1
nothing:
sub	r0,#1
@r0 = cursor position on list

@get AP
getAP:
mov	r6,r0	@cursor position

@get skill ID if looking at jobs
ldr	r3,=#0x60052B2
ldrh	r3,[r3]
ldr	r2,=#0xFFF
and	r2,r3
ldr	r3,=#0x22B
cmp	r2,r3
bne	notJobs

jobs:
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x2CD0
add	r1,r2
add	r1,#0xCC
ldr	r1,[r1]
ldr	r1,[r1,#0x18]
lsl	r2,r6,#2
add	r2,r6
lsl	r2,#2
add	r1,r2
ldrh	r0,[r1,#2]
b	gotID

@get skill ID otherwise
notJobs:
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x1134
add	r1,r2
ldrb	r0,[r1,r6]

gotID:
mov	r5,r0		@skill ID

@if job is 0, items, if job is 1, ability list for movement/combo, support or reaction
ldr	r0,=#0x3002818
ldr	r0,[r0]
push	{r2}
ldr	r2,=#0x1BE4
add	r0,r2
pop	{r2}
ldrb	r0,[r0,#8]
cmp	r0,#1
blo	EndTrampolin

b	skipEndTrampolin
EndTrampolin:
b	End
skipEndTrampolin:

done:

@check if there is no cost, if so draw mastered
cmp	r5,#0
bne	not0
b	drawMastered
not0:

@check if the ability is mastered
ldr	r2,=#0x3002818
ldr	r1,=#0x1D0C
ldr	r2,[r2]
add	r2,r1
ldr	r0,[r2]		@current character pointer
mov	r1,r5
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
.short	0xF800
cmp	r0,#0
beq	notMastered
b	drawMastered

notMastered:
@check if the ability is blacklisted from buying, if so draw nothing
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
cmp	r0,r5
beq	EndTrampolinForbidden
nextForbidden:
add	r1,#2
b	forbiddenLoop
EndTrampolinForbidden:
b	EndTrampolin
endForbidden:

@get skill AP cost
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x2CD0
add	r1,r2
add	r1,#0xCC
ldr	r1,[r1]
ldr	r1,[r1,#0x18]
lsl	r2,r6,#2
add	r2,r6
lsl	r2,#2
add	r1,r2
ldrb	r5,[r1,#0xF]

@get current AP cost
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x2CD0
add	r1,r2
add	r1,#0xCC
ldr	r1,[r1]
ldr	r1,[r1,#0x18]
lsl	r2,r6,#2
add	r2,r6
lsl	r2,#2
add	r1,r2
ldrb	r6,[r1,#2]

ldr	r2,=#0x3002818
ldr	r1,=#0x1D0C
ldr	r2,[r2]
add	r2,r1
ldr	r2,[r2]		@current character pointer
add	r2,#0x40
ldrb	r6,[r2,r6]

mov	r1,#0x7F
and	r6,r1
cmp	r6,#100
bls	noissues
mov	r6,#100
noissues:

add	r4,#6
ldr	r0,isonebit
cmp	r0,#0
bne	dontdrawap
sub	r4,#6

checkap100s:
cmp	r6,#0
beq	noapap
cmp	r6,#10
blo	noap100s
add	r4,#2
mov	r0,r6
mov	r1,#10
swi	#6
lsl	r0,#1
lsl	r1,#1
ldrh	r2,=#0xC064	@base tile attribute
add	r0,r2
add	r1,r2
mov	r3,#0x24
strh	r0,[r4]
add	r0,#1
strh	r0,[r4,r3]
drawap10s:
add	r4,#2
strh	r1,[r4]
add	r1,#1
strh	r1,[r4,r3]
b	draw0ap

noap100s:
add	r4,#2
mov	r0,r6
mov	r1,#10
swi	#6
ldrh	r2,=#0xC064	@base tile attribute
lsl	r1,#1
add	r1,r2
mov	r3,#0x24
b	drawap10s

noapap:
add	r4,#4

draw0ap:
add	r4,#2
ldrh	r0,=#0xC064	@base tile attribute
strh	r0,[r4]
add	r0,#1
mov	r3,#0x24
strh	r0,[r4,r3]

dontdrawap:
@draw ap cost if 999
cmp	r5,#100
bne	not9991
ldr	r0,isonebit
add	r4,#2
cmp	r0,#0
bne	noslash999
ldr	r0,=#0xC092
strh	r0,[r4]
add	r0,#1
mov	r3,#0x24
strh	r0,[r4,r3]
add	r4,#2
noslash999:
ldr	r3,=#0xC08A
mov	r0,r3
add	r0,#1
strh	r3,[r4]
mov	r2,#0x24
strh	r0,[r4,r2]
add	r4,#2
strh	r3,[r4]
strh	r0,[r4,r2]
add	r4,#2
strh	r3,[r4]
strh	r0,[r4,r2]
b	doneDraw2

not9991:

@draw cost
ldr	r0,isonebit
cmp	r0,#0
bne	noslash
add	r4,#2
ldr	r0,=#0xC092
strh	r0,[r4]
add	r0,#1
mov	r3,#0x24
strh	r0,[r4,r3]
noslash:
cmp	r5,#100
bne	not9992
add	r4,#2
ldr	r3,=#0xC08A
mov	r0,r3
add	r0,#1
strh	r3,[r4]
mov	r2,#0x24
strh	r0,[r4,r2]
add	r4,#2
strh	r3,[r4]
strh	r0,[r4,r2]
add	r4,#2
strh	r3,[r4]
strh	r0,[r4,r2]
b	doneDraw2

not9992:
@draw the 1000s
mov	r7,#0
mov	r0,r5
mov	r1,#100
swi	#6
lsl	r0,#1
cmp	r0,#0
beq	draw100s

mov	r7,#1
ldr	r3,=#0xC078
add	r3,r0
strh	r3,[r4]
mov	r2,#0x24
add	r3,#1
strh	r3,[r4,r2]

draw100s:
add	r4,#2
mov	r0,r5
mov	r1,#100
swi	#6
mov	r0,r1
mov	r1,#10
swi	#6
lsl	r0,#1
cmp	r0,#0
bne	draw100s2
cmp	r7,#1
beq	draw100s2
mov	r7,#0
b	draw10s

draw100s2:
ldr	r3,=#0xC078
add	r3,r0
strh	r3,[r4]
mov	r2,#0x24
add	r3,#1
strh	r3,[r4,r2]
mov	r7,#1

draw10s:
add	r4,#2
mov	r0,r5
@mov	r1,#100
@swi	#6
@mov	r0,r1
mov	r1,#10
swi	#6
mov	r0,r1
lsl	r0,#1
cmp	r0,#0
bne	draw10s2
cmp	r7,#1
beq	draw10s2
mov	r7,#0
b	draw1s

draw10s2:
ldr	r3,=#0xC078
add	r3,r0
strh	r3,[r4]
mov	r2,#0x24
add	r3,#1
strh	r3,[r4,r2]
mov	r7,#1

draw1s:
add	r4,#2
mov	r0,#0
ldr	r3,=#0xC078
add	r3,r0
strh	r3,[r4]
mov	r2,#0x24
add	r3,#1
strh	r3,[r4,r2]

doneDraw2:

End:
pop	{r4-r7}
ldr	r3,=#0x808379B
bx	r3

drawMastered:
add	r4,#4
ldr	r3,=#0xD0C1
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#0x1C
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
add	r3,#1
add	r4,#2
strh	r3,[r4]
b	End

.align
.ltorg
purchaseForbiddenList:
@POIN purchaseForbiddenList
@POIN checkAbility
@WORD isonebit
