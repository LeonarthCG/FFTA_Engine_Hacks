.equ checkJobShow, highestJob+4
.equ checkForUnlocks, checkJobShow+4
.equ newNoItemEquipJobs, checkForUnlocks+4
.equ newItemJobs, newNoItemEquipJobs+4
.thumb
push	{r4-r7}
mov	r4,r0	@current unit
mov	r5,#0	@current job being checked
ldr	r6,highestJob
ldr	r7,checkJobShow

@remove item command if the job is on the list
ldr	r0,newNoItemEquipJobs
ldrb	r1,[r4,#7]	@job
mov	r2,#0
itemLoop:
ldrb	r3,[r0,r2]
cmp	r3,#0
beq	stopItemLoop
cmp	r3,r1
beq	removeItem
add	r2,#1
b	itemLoop
removeItem:
mov	r0,#0x36
ldrb	r1,[r4,r0]
cmp	r1,#1
bne	stopItemLoop
mov	r1,#0
strb	r1,[r4,r0]
stopItemLoop:

@add item as third command if the job is on the other list
ldr	r0,newItemJobs
ldrb	r1,[r4,#7]	@job
mov	r2,#0
itemLoop2:
ldrb	r3,[r0,r2]
cmp	r3,#0
beq	stopItemLoop2
cmp	r3,r1
beq	addItem
add	r2,#1
b	itemLoop2
addItem:
mov	r0,#0x37
mov	r1,#1
strb	r1,[r4,r0]
stopItemLoop2:

@reset a byte for the job change wheel
ldr	r0,=#0x203FFF0
mov	r1,#0
strb	r1,[r0,#1]
strb	r1,[r0,#2]

@clear some tiles
ldr	r0,=#0x6006210
ldrh	r2,[r0]
ldr	r3,=#0xD0DD
cmp	r2,r3
bne	dontclear
mov	r1,#0
str	r1,[r0]
str	r1,[r0,#4]
str	r1,[r0,#8]
str	r1,[r0,#12]
str	r1,[r0,#16]
dontclear:

@just in case, check the party for new jobs
ldr	r0,checkForUnlocks
mov	lr,r0
.short	0xF800

loop:
ldrb	r0,[r4,#7]	@current job does not count
cmp	r0,r5
beq	nextLoop
mov	r0,r4
mov	r1,r5
mov	lr,r7
.short	0xF800
cmp	r0,#0
bne	EndTrue
nextLoop:
cmp	r5,r6
beq	EndFalse
add	r5,#1
b	loop

EndTrue:
pop	{r4-r7}
ldr	r0,=#0x80750F0
mov	lr,r0
mov	r0,#4
mov	r1,#1
mov	r2,#0
mov	r3,#7
.short	0xF800

EndFalse:
pop	{r4-r7}
ldr	r0,=#0x8075148
mov	lr,r0
.short	0xF800

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobShow
@POIN checkForUnlocks
@POIN newNoItemEquipJobs
@POIN newItemJobs
