.equ checkJobShow, highestJob+4
.equ newItemJobs, checkJobShow+4
.equ newNoItemEquipJobs, newItemJobs+4

.thumb

@check if action or not
ldrb	r3,[r0]
mov	r10,r3
ldr	r1,=#0x1131
add	r0,r2,r1
ldrb	r0,[r0]
cmp	r0,#1
bne	notJobsTrampolin
b	skipnotJobsTrampolin
notJobsTrampolin:
b	notJobs
skipnotJobsTrampolin:

@do the thing
push	{r0-r7}
mov	r0,r8
push	{r0}
mov	r0,lr
mov	r8,r0

@r0 = pointer to unit
@r1 = check for items as a job (1) or not (0)
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1D0C
add	r4,r0,r1
ldr	r4,[r4]
mov	r5,r1
mov	r6,#0	@number of jobs
mov	r7,#0	@current job being checked
cmp	r5,#0
beq	notItems
@if the unit has item command set, they get item
ldr	r2,=#0x3002818
ldr	r1,=#0x1D0C
ldr	r2,[r2]
add	r2,r1
ldr	r0,[r2]		@current character pointer
mov	r1,#0x36
ldrb	r0,[r0,r1]
cmp	r0,#1
beq	gotItem
@check items as job
ldr	r0,newItemJobs
mov	r1,#0
ldrb	r2,[r4,#7]
@if the unit gets item by default, like alchemist, they have items
itemLoop:
ldrb	r3,[r0,r1]
cmp	r3,#0
beq	checkNoItem
cmp	r3,r2
beq	gotItem
add	r1,#1
b	itemLoop
@if the unit is an enemy, no item
checkNoItem:
mov	r0,#0x29
ldrb	r0,[r4,r0]
mov	r1,#0xB0	@0xB0 = 1 (enemy) 0 (boss) 1 (guest) 1 (judge) 0 0 0 0
and	r0,r1
cmp	r0,#0
bne	notItems
@if this is during battle, no item
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x2031CCC
cmp	r0,r1
beq	notItems
@check if the unit is on the no item list
ldr	r0,newNoItemEquipJobs
mov	r1,#0
ldrb	r2,[r4,#7]
noItemLoop:
ldrb	r3,[r0,r1]
cmp	r3,#0
beq	gotItem
cmp	r3,r2
beq	notItems
add	r1,#1
b	noItemLoop
gotItem:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
add	r0,r1
add	r0,#2
mov	r1,#1
strb	r1,[r0]
add	r6,#1
notItems:

@now check for jobs
mov	r7,#2
loop:
@check if current job
mov	r1,r7
ldrb	r0,[r4,#7]
cmp	r0,r1
beq	addJob
mov	r0,r4
mov	r1,r7
ldr	r3,checkJobShow
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	addJob
nextEntry:
ldr	r0,highestJob
cmp	r7,r0
beq	Endloop
add	r7,#1
b	loop
addJob:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
add	r0,r1
add	r0,#2
strb	r7,[r0,r6]
add	r6,#1
b	nextEntry

Endloop:
@store number of abilities
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
add	r0,r1
mov	r1,#1
strb	r6,[r0]
@set the index based on what the menu is doing
@lr = 0x807CD85 if decreasing index
@lr = 0x807CE59 if increasing index
@lr = 0x807CA47 if reloading (set to actual job of the unit)
	@I want to be able to tell if we purchased something though...
	@this is a weird way to do it but I can check background layer 3 for tiles
	@If first loading instead of reloading after purchase, 0x60051C0 should be empty
@update the index
ldr	r0,=#0x807CD85
mov	r1,r8
cmp	r0,r1
beq	increasingIndex
ldr	r0,=#0x807CE59
mov	r1,r8
cmp	r0,r1
beq	decreasingIndex

ldr	r0,=#0x60051E0
ldrh	r0,[r0]
cmp	r0,#0
bne	purchasedSkill
b	firstLoad
.align

@get new index into r7
firstLoad:
mov	r7,#0
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
ldr	r2,=#0x1BE4
add	r2,r0,r2
ldrb	r2,[r2,#7]
add	r0,r1
add	r0,#2
mov	r7,#0
firstSkillLoop:
ldrb	r1,[r0,r7]
cmp	r1,r2
beq	setNewIndex
add	r7,#1
b	firstSkillLoop

wasitem:
b	setNewIndex

@purchasedSkill:
@ldr	r0,=#0x3002818
@ldr	r0,[r0]
@ldr	r1,=#0x1132
@ldr	r2,=#0x1BE4
@add	r2,r0,r2
@ldrb	r2,[r2,#8]
@add	r0,r1
@add	r0,#2
@mov	r7,#0
@purchasedSkillLoop:
@ldrb	r1,[r0,r7]
@cmp	r1,r2
@beq	setNewIndex
@add	r7,#1
@b	purchasedSkillLoop

purchasedSkill:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
add	r1,r0
ldr	r2,=#0x1BE4
add	r2,r0
ldrb	r7,[r1,#1]
add	r1,#2
ldrb	r1,[r1,r7]
strb	r1,[r2,#8]
b	setNewIndex

@load previous index as new index
@get job using index
@store job

increasingIndex:
@ldr	r0,=#0x3002818
@ldr	r0,[r0]
@ldr	r1,=#0x1132
@ldrb	r2,[r0,r1]	@max index
@add	r0,#1
@ldrb	r7,[r0,r1]	@current index
@cmp	r2,r7
@bne	increaseit
@	@mov	r7,#0
@b	setNewIndex
@increaseit:
@	@add	r7,#1
@b	setNewIndex

decreasingIndex:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
ldrb	r2,[r0,r1]	@max index
add	r0,#1
ldrb	r7,[r0,r1]	@current index
@cmp	r7,#0
@bne	decreaseit
@	@mov	r7,r2
@b	setNewIndex
@decreaseit:
@	@sub	r7,#1
b	setNewIndex

setNewIndex:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
add	r0,r1
strb	r7,[r0,#1]	@current index
add	r0,#2
ldrb	r7,[r0,r7]	@new job
cmp	r7,#1
bhi	noIssue
mov	r7,#0		@show no icon
noIssue:
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1132
ldr	r2,=#0x1BE4
add	r2,r0,r2
strb	r7,[r2,#8]
@store the job
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1C1A
add	r1,r0		@place to store job to
ldr	r2,=#0x1132
add	r2,r0
ldrb	r3,[r2,#1]		@index
add	r2,#2
ldrb	r3,[r2,r3]	@job
strb	r3,[r1]
b	End

@update the job (+8, not +7)

End:
ldr	r3,=#0x807C428
mov	lr,r3
pop	{r0}
mov	r8,r0
pop	{r0-r7}
.short	0xF800

notJobs:
push	{r3}
cmp	r0,#0
beq	notJobsEnd2
notJobsEnd1:
ldr	r3,=#0x807C306
notJobsEnd2:
ldr	r3,=#0x807C428
notJobsEnd:
mov	lr,r3
pop	{r3}
.short	0xF800

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobShow
@POIN newItemJobs
@POIN newNoItemEquipJobs
