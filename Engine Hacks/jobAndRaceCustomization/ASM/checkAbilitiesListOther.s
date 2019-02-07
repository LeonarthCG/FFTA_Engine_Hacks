.equ is1bit, checkAbility+4
.equ checkJobShowList, is1bit+4
.equ highestJob, checkJobShowList+4
.equ newJobAbilityTable, highestJob+4

.thumb

ldr	r3,=#0x50C
add	r3,sp
ldr	r3,[r3]

push	{lr}
push	{r4-r7}

mov	r4,r0		@unit pointer
mov	r5,r2		@ability type
mov	r6,r3		@place to store the entries at?

@get max ability
ldr	r7,=#0x8132DE8
ldrb	r7,[r7]

@r8 has pointer to the count of how many abilities will be displayed, set them to 0
mov	r1,r8
ldr	r0,[r1]
mov	r0,#0
str	r0,[r1]

@set job to list
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1BE4
add	r0,r1
mov	r1,#1
strb	r1,[r0,#8]

@get the pointer to this race ability list
ldr	r2,=#0x80CD538
ldr	r2,[r2]
ldrb	r1,[r4,#6]
lsl	r1,#2
add	r2,r1
ldr	r2,[r2]		@this race ability list
mov	r0,#0
ldrb	r1,[r2,#0x00]
add	r0,r1
ldrb	r1,[r2,#0x01]
add	r0,r1
ldrb	r1,[r2,#0x02]
add	r0,r1
ldrb	r1,[r2,#0x03]
add	r0,r1
ldrb	r1,[r2,#0x04]
add	r0,r1
ldrb	r1,[r2,#0x05]
add	r0,r1
ldrb	r1,[r2,#0x06]
add	r0,r1
ldrb	r1,[r2,#0x07]
add	r0,r1
cmp	r0,#0
bne	nevermind1
add	r2,#8
mov	r3,#1		@counter
b	gotlist
nevermind1:
mov	r3,#0		@counter
gotlist:
@for every ability, check type, if it matches, check if mastered
push	{r2-r3}
checkLoop:

@check if the list is over
mov	r0,#0
ldrb	r1,[r2,#0x00]
add	r0,r1
ldrb	r1,[r2,#0x01]
add	r0,r1
ldrb	r1,[r2,#0x02]
add	r0,r1
ldrb	r1,[r2,#0x03]
add	r0,r1
ldrb	r1,[r2,#0x04]
add	r0,r1
ldrb	r1,[r2,#0x05]
add	r0,r1
ldrb	r1,[r2,#0x06]
add	r0,r1
ldrb	r1,[r2,#0x07]
add	r0,r1
cmp	r0,#0
beq	endLoop

@check type
ldrb	r0,[r2,#6]
cmp	r0,r5
bne	nextLoop

@check if job available
push	{r2-r3}
mov	r0,r4
mov	r1,r3
bl	isAbilityUnlocked
pop	{r2-r3}
cmp	r0,#0
beq	nextLoop

@increase ammount of entries
mov	r1,r8
ldr	r0,[r1]
add	r0,#1
str	r0,[r1]

@check if mastered
push	{r2-r3}
mov	r0,r4
mov	r1,r3
mov	r2,r5
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
pop	{r2-r3}
cmp	r0,#0
beq	notMastered

@add it to the list
@ability ID
strb	r3,[r6,#0x02]
@some useless data
mov	r0,#0
strh	r0,[r6,#0x00]
strh	r0,[r6,#0x04]
strh	r0,[r6,#0x06]
strb	r0,[r6,#0x11]
strb	r0,[r6,#0x12]
strb	r0,[r6,#0x13]
@name
ldrh	r0,[r2,#0x00]
str	r0,[r6,#0x08]
@description
ldrh	r0,[r2,#0x02]
strh	r0,[r6,#0x0C]
@current ap
ldr	r0,is1bit
cmp	r0,#0
beq	doap1
ldrb	r0,[r2,#0x07]
mov	r1,#0x80
orr	r0,r1
strb	r0,[r6,#0x0E]
b	afterap1
doap1:
mov	r0,#0x40
add	r0,r3
ldrb	r0,[r4,r0]
mov	r1,#0x80
orr	r0,r1
strb	r0,[r6,#0x0E]
afterap1:
@cost
ldrb	r0,[r2,#0x07]
strb	r0,[r6,#0x0F]
@ability type
strb	r5,[r6,#0x10]
mov	r0,#0
@ability ID
add	r6,#20
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r0,=#0x1134
add	r0,r1
mov	r1,r8
ldr	r1,[r1]
sub	r1,#1
strb	r3,[r0,r1]
b	nextLoop

notMastered:
@add it to the list
@ability ID
strb	r3,[r6,#0x02]
@some useless data
mov	r0,#0
strh	r0,[r6,#0x00]
strh	r0,[r6,#0x04]
strh	r0,[r6,#0x06]
strb	r0,[r6,#0x11]
strb	r0,[r6,#0x12]
strb	r0,[r6,#0x13]
@name
ldrh	r0,[r2,#0x00]
str	r0,[r6,#0x08]
@description
ldrh	r0,[r2,#0x02]
strh	r0,[r6,#0x0C]
ldr	r0,is1bit
cmp	r0,#0
beq	doap2
mov	r0,#0
strb	r0,[r6,#0x0E]
b	afterap2
doap2:
mov	r0,#0x40
add	r0,r3
ldrb	r0,[r4,r0]
strb	r0,[r6,#0x0E]
afterap2:
@cost
ldrb	r0,[r2,#0x07]
strb	r0,[r6,#0x0F]
@ability type
strb	r5,[r6,#0x10]
mov	r0,#0
@ability ID
add	r6,#20
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r0,=#0x1134
add	r0,r1
mov	r1,r8
ldr	r1,[r1]
sub	r1,#1
strb	r3,[r0,r1]
b	nextLoop

nextLoop:
cmp	r3,r7
bhi	endLoop
add	r3,#1
add	r2,#8
b	checkLoop

endLoop:
pop	{r2-r3}

End:
pop	{r4-r7}
pop	{r1}
mov	r0,#0
bx	r1

@checks if any of the jobs the unit can change into has this ability
isAbilityUnlocked:
push	{lr}
push	{r4-r7}
mov	r4,r0
mov	r5,r1
mov	r6,#2
ldr	r7,highestJob

@for every job
unlockedLoop:
cmp	r6,r7
bhi	unlockedFalse

@check if the unit can change into this job
mov	r0,r4
mov	r1,r6
ldr	r3,checkJobShowList
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	nextUnlockedLoop

@check if this job has an ability list or not
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r6
ldr	r0,[r0,r1]
cmp	r0,#0
beq	vanillaList

@check if this ability is on the list
mov	r1,#0
customListLoop:
ldrb	r2,[r0,r1]
cmp	r2,#0
beq	nextUnlockedLoop
add	r1,#1
b	customListLoop

@check the vanilla way, if ability is between lowest and highest
vanillaList:
@get job starting ability index
mov	r1,#0x34
mul	r1,r6
ldr	r2,=#0x80C8598
ldr	r2,[r2]
add	r3,r1,r2
mov	r2,#0x2E
ldrb	r0,[r3,r2]
@get job ending ability index
mov	r1,#0x34
mul	r1,r6
ldr	r2,=#0x80C8598
ldr	r2,[r2]
add	r3,r1,r2
mov	r2,#0x2F
ldrb	r1,[r3,r2]
cmp	r5,r0
blo	nextUnlockedLoop
cmp	r5,r1
bhi	nextUnlockedLoop
b	unlockedTrue

nextUnlockedLoop:
add	r6,#1
b	unlockedLoop

unlockedTrue:
mov	r0,#1
pop	{r4-r7}
pop	{r1}
bx	r1

unlockedFalse:
mov	r0,#0
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg
checkAbility:
@POIN checkAbility
@WORD is1bit
@POIN checkJobShowList
@WORD highestJob
@POIN newJobAbilityTable
