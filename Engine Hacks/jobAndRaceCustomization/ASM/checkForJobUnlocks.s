.equ checkJobAvailability, highestJob+4
.equ newDefaultJobs, checkJobAvailability+4
.equ newJobAbilityTable, newDefaultJobs+4
.equ neverShow, newJobAbilityTable+4
.thumb
push	{lr}
push	{r0-r7}

@unlock default jobs
ldr	r0,newDefaultJobs
ldr	r7,=#0x2002AD0
defaultLoop:
ldrb	r1,[r0]		@job id
cmp	r1,#0
beq	endDefaultLoop
lsl	r2,r1,#0x10
lsr	r2,#0x13	@divide by 8
mov	r3,#1
divideDefault:
cmp	r1,#8
blo	dontDivideDefault
sub	r1,#8
b	divideDefault
dontDivideDefault:
lsl	r3,r1
ldrb	r1,[r7,r2]
orr	r1,r3
strb	r1,[r7,r2]
add	r0,#1
b	defaultLoop
endDefaultLoop:

@unlock party jobs
ldr	r0,=#0x2000080
ldr	r5,=#0x108	@size of entry
ldr	r6,=#0x2001838	@last unit
ldr	r7,=#0x2002AD0
partyLoop:
ldrb	r1,[r0,#7]		@job id
cmp	r1,#0
beq	nextPartyLoop
lsl	r2,r1,#0x10
lsr	r2,#0x13	@divide by 8
mov	r3,#1
divideParty:
cmp	r1,#8
blo	dontDivideParty
sub	r1,#8
b	divideParty
dontDivideParty:
lsl	r3,r1
ldrb	r1,[r7,r2]
orr	r1,r3
strb	r1,[r7,r2]
nextPartyLoop:
add	r0,r5
cmp	r0,r6
bhi	endPartyLoop
b	partyLoop
endPartyLoop:

@first I try to reduce the checks as much as possible
@for every job, check if it has been unlocked yet, then check if it has neverShow
@if not for each unit check if they have unlocked it
ldr	r4,=#0x2000080		@first unit
ldr	r5,=#0x108		@size of entry
ldr	r6,highestJob		@last job
ldr	r7,=#0x2001838		@last unit
allJobsLoop:
mov	r0,r6
mov	r1,#8
swi	#6
ldr	r2,=#0x2002AD0
ldrb	r0,[r2,r0]
mov	r3,#1
lsl	r3,r1
and	r0,r3
cmp	r0,#0
bne	nextJobLoop
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r6
add	r0,r1
ldr	r0,[r0,#4]
ldr	r1,neverShow
cmp	r0,r1
beq	nextJobLoop
ldr	r4,=#0x2000080
allJobsLoopUnitLoop:
mov	r0,r4
ldr	r1,[r0]
cmp	r1,#0
beq	nextAllJobsLoopUnitLoop
mov	r1,r6
ldr	r3,checkJobAvailability
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	allJobsLoopUnlock
nextAllJobsLoopUnitLoop:
add	r4,r5
cmp	r4,r7
bhi	nextJobLoop
b	allJobsLoopUnitLoop
allJobsLoopUnlock:
mov	r0,r6
mov	r1,#8
swi	#6
ldr	r2,=#0x2002AD0
add	r0,r2
ldrb	r2,[r0]
mov	r3,#1
lsl	r3,r1
orr	r2,r3
strb	r2,[r0]
nextJobLoop:
cmp	r6,#0
beq	End
sub	r6,#1
b	allJobsLoop

End:
pop	{r0-r7}
pop	{r0}
bx	r0

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobAvailability
@POIN newDefaultJobs
@POIN newJobAbilityTable
@POIN neverShow
