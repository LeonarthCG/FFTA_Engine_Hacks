.equ checkJobAvailability, highestJob+4
.equ newDefaultJobs, checkJobAvailability+4
.equ newJobAbilityTable, newDefaultJobs+4
.equ neverShow, newJobAbilityTable+4
.thumb
push	{lr}
push	{r4-r7}

@try to reduce the checks as much as possible
@for every job, check if it has been unlocked yet, then check if it has neverShow
@if not for each unit check if they have unlocked it
mov	r4,r0			@unit in ram
ldr	r5,=#0x2001F70		@unlocked jobs bitfield location
add	r5,#0x10
ldr	r6,highestJob		@last job
ldr	r7,neverShow
allJobsLoop:
mov	r0,r6
mov	r1,#8
swi	#6
ldrb	r0,[r5,r0]
mov	r3,#1
lsl	r3,r1
and	r0,r3
cmp	r0,#0
bne	nextJobLoop
ldr	r0,newJobAbilityTable
mov	r1,#12
mul	r1,r6
add	r0,r1
ldr	r0,[r0,#4]
cmp	r0,r7
beq	nextJobLoop
mov	r0,r4
mov	r1,r6
ldr	r3,checkJobAvailability
mov	lr,r3
.short	0xF800
cmp	r0,#1
beq	Unlock
b	nextJobLoop
Unlock:
mov	r0,r6
mov	r1,#8
swi	#6
ldrb	r2,[r5,r0]
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
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobAvailability
@POIN newDefaultJobs
@POIN newJobAbilityTable
@POIN neverShow
