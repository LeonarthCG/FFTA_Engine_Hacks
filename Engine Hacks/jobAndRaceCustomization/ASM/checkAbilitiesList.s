.equ highestJob, checkAbility+4
.equ newNoItemEquipJobs, highestJob+4
.equ checkAbilityCount, newNoItemEquipJobs+4
.equ checkJobShow, checkAbilityCount+4
.equ newJobAbilityTable, checkJobShow+4
.equ newItemJobs, newJobAbilityTable+4
.thumb

pop	{r3}
push	{r4-r7}
@prepare registers
mov	r5,r0		@ability type
mov	r6,r2		@ram stuff
mov	r7,#0		@counter of available abilities
mov	r0,r8
push	{r0}
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r4,[r2]		@current character pointer
@get the pointer to the race ability list
ldrb	r0,[r4,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
mov	r8,r0

@set up some ram stuff
ldr	r0,=#0x807DA14
ldr	r0,[r0]
str	r0,[r6,#4]
mov	r1,#0
strh	r1,[r6,#0xC]
strb	r1,[r6,#0x12]
strh	r1,[r6,#0x14]
mov	r1,#0xE
strb	r1,[r6,#0xE]
mov	r1,#0xD
strb	r1,[r6,#0xF]
ldr	r0,=#0x229
strh	r0,[r6,#0x10]
mov	r0,#0x10
strb	r0,[r6,#0x16]
strb	r0,[r6,#0x17]
mov	r0,#0x8C
lsl	r0,#2
add	r0,r6
str	r0,[r6,#0x18]
push	{r6}
ldr	r6,[r6,#0x18]

@check if action commands
cmp	r5,#1
beq	actionCommands

@check every ability
mov	r1,#1
loop:
mov	r0,r8
mov	r2,r1
lsl	r2,#3
add	r0,r2
ldrh	r3,[r0,#4]
cmp	r3,#0
beq	End
mov	r0,r4
push	{r1}	@ability to check
mov	r2,r5
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
pop	{r1}
cmp	r0,#0
beq	nextLoop
@if true
strh	r1,[r6,#6]	@set ability
mov	r0,r8
mov	r2,r1
lsl	r2,#3
add	r0,r2		@pointer to data for this ability
strh	r7,[r6]		@set index
mov	r2,#1
strh	r2,[r6,#2]	@set as usable
add	r7,#1
ldrh	r2,[r0,#2]
strh	r2,[r6,#12]	@set description
strh	r1,[r6,#14]	@set ability
strh	r1,[r6,#4]	@set ability
ldrh	r0,[r0]
lsl	r0,#2
ldr	r2,=#0x808C8E8
ldr	r2,[r2]
add	r0,r2
ldr	r0,[r0]
str	r0,[r6,#8]	@set name
add	r6,#20		@next entry
nextLoop:
add	r1,#1
b	loop

End:
pop	{r6}
str	r7,[r6]
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r3,=#0x1132
add	r0,r3
strb	r7,[r0]
mov	r0,r7
pop	{r1}
mov	r8,r1
pop	{r4-r7}
pop	{r1}
bx	r1

actionCommands:
@check if this job automatically gets item
ldr	r0,newItemJobs
mov	r1,#0
ldrb	r2,[r4,#7]
checkItemLoop:
ldrb	r3,[r0,r1]
cmp	r3,#0
beq	notAlchemist
cmp	r3,r2
beq	greyItem
add	r1,#1
b	checkItemLoop
@check if this job gets item or not
notAlchemist:
ldr	r0,newNoItemEquipJobs
mov	r1,#0
ldrb	r2,[r4,#7]
checkNoItemLoop:
ldrb	r3,[r0,r1]
cmp	r3,#0
beq	getItem
cmp	r3,r2
beq	noItem
add	r1,#1
b	checkNoItemLoop
getItem:
push	{r4}
mov	r4,#1
b	doItem
greyItem:
push	{r4}
mov	r4,#0
doItem:
@set the item command on the list
@get job name id
mov	r0,#0x34
ldr	r2,=#0x80C8598
ldr	r2,[r2]
add	r2,r0
ldrh	r0,[r2,#0x10]	@job command id
strh	r0,[r6,#14]
strh	r0,[r6,#4]
mov	r0,#0
strh	r0,[r6,#6]	@job id
ldr	r3,=#0x807DA78
ldr	r3,[r3]
add	r3,#4
ldrh	r1,[r3]
lsl	r1,#2
ldr	r0,=#0x807DA7C
ldr	r0,[r0]
add	r0,r1
ldr	r0,[r0]
str	r0,[r6,#8]
ldrh	r0,[r3,#2]
strh	r0,[r6,#12]
strh	r4,[r6,#2]
strh	r7,[r5]
add	r6,#20
add	r7,#1
pop	{r4}
noItem:

@now make a list of jobs that show for this unit
mov	r1,#2
checkJobsLoop:
ldrb	r0,[r4,#7]
cmp	r0,r1		@check if current job
beq	addGreyJob
@check if same race
mov	r2,#0x34
mul	r2,r1
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r0,r2
ldrb	r0,[r3,#4]
ldrb	r2,[r4,#6]
cmp	r0,r2
bne	nextJobsLoop
@check if extra show requirements are met
push	{r1}
ldr	r0,newJobAbilityTable
mov	r2,#16
mul	r2,r1
add	r0,r2
ldr	r0,[r0,#8]
cmp	r0,#0
beq	noCondition
mov	lr,r0
mov	r0,r4
.short	0xF800
pop	{r1}
cmp	r0,#0
beq	nextJobsLoop
b	jumppop
noCondition:
pop	{r1}
jumppop:
push	{r1}
mov	r0,r4
mov	r2,#1
ldr	r3,checkAbilityCount
mov	lr,r3
.short	0xF800
pop	{r1}
cmp	r0,#0
bne	addWhiteJob
b	nextJobsLoop 
push	{r1}
mov	r0,r4
ldr	r3,checkJobShow
mov	lr,r3
.short	0xF800
pop	{r1}
cmp	r0,#0
bne	addGreyJob
nextJobsLoop:
add	r1,#1
ldr	r0,highestJob
cmp	r1,r0
bhi	End
b	checkJobsLoop

addWhiteJob:
mov	r5,#1
b	addJob

addGreyJob:
mov	r5,#0
b	addJob

addJob:
strh	r1,[r6,#6]
push	{r1}
@get job name id
mov	r0,#0x34
mul	r0,r1
ldr	r2,=#0x80C8598
ldr	r2,[r2]
add	r2,r0
ldrh	r0,[r2,#0x10]	@job command id
strh	r0,[r6,#14]
strh	r0,[r6,#4]
ldr	r3,=#0x807DA78
ldr	r3,[r3]
lsl	r0,#2
add	r3,r0
ldrh	r1,[r3]		@name id
lsl	r1,#2
ldr	r0,=#0x807DA7C
ldr	r0,[r0]
add	r0,r1
ldr	r0,[r0]
str	r0,[r6,#8]
ldrh	r0,[r3,#2]
strh	r0,[r6,#12]
mov	r1,#1
strh	r5,[r6,#2]
strh	r7,[r5]
add	r6,#20
add	r7,#1
pop	{r1}
b	nextJobsLoop

.align
.ltorg

checkAbility:
@POIN checkAbility
@WORD highestJob
@POIN newNoItemEquipJobs
@POIN checkAbilityCount
@POIN checkJobShow
@POIN newJobAbilityTable
@POIN newItemJobs
