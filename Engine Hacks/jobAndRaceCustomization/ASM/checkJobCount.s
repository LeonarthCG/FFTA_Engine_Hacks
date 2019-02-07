.equ checkJobShow, highestJob+4
.equ newItemJobs, checkJobShow+4
.equ newNoItemEquipJobs, newItemJobs+4

.thumb
push	{lr}
push	{r4-r7}
@r0 = pointer to unit
@r1 = check for items as a job (1) or not (0)
mov	r4,r0
mov	r5,r1
mov	r6,#0	@number of jobs
mov	r7,#0	@current job being checked

cmp	r5,#0
beq	notItems
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
@otherwise, unless the unit is on the no item list, they have items
checkNoItem:
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
add	r6,#1
notItems:

@now check for jobs
mov	r7,#2
loop:
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
beq	End
add	r7,#1
addJob:
add	r6,#1
b	nextEntry

End:
mov	r0,r6
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobShow
@POIN newItemJobs
@POIN newNoItemEquipJobs
