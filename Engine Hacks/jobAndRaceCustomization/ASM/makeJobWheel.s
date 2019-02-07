.equ checkJobShow, highestJob+4
.equ checkJobAvailability, checkJobShow+4
.thumb
push	{r0-r7}

@first clean the sprites because vanilla does not
ldr	r0,=#0x3000E30
ldr	r0,[r0,#4]
mov	r1,#0x1C
mov	r2,#12
mul	r1,r2
add	r1,r0
mov	r2,#0
cleanLoop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
bhs	stopClean
b	cleanLoop
stopClean:

@now clean some ram because we might have gone overboard
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x1270
add	r1,r2
add	r1,#8
mov	r0,#0
mov	r2,#0
cleanerLoop:
str	r0,[r1,r2]
cmp	r2,#0xFF
bhi	stopCleaner
add	r2,#4
b	cleanerLoop
stopCleaner:

@now we need to get the job count
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x1D0C
ldr	r4,[r0,r1]	@current character pointer
mov	r5,#2		@job counter
ldr	r6,highestJob	@last job
mov	r7,#0		@job total
countJobsLoop:
mov	r0,r4
mov	r1,r5
ldr	r3,checkJobShow
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	addToTotal
nextCountJobsLoop:
cmp	r5,r6
bhs	noCountJobsLoop
add	r5,#1
b	countJobsLoop
addToTotal:
add	r7,#1
b	nextCountJobsLoop
noCountJobsLoop:

@get number of wheels
mov	r0,r7
mov	r1,#12
swi	#6
cmp	r1,#0
beq	noRemainderWheel
add	r0,#1
noRemainderWheel:
sub	r0,#1
ldr	r2,=#0x2001F70
strb	r0,[r2,#2]
mov	r6,r0	@number of wheels

@if bigger than 1, draw the thing
cmp	r0,#0
bls	noDrawing
ldr	r0,=#0x2001F70
ldr	r3,=#0x6006210
ldr	r2,=#0xD0DD
strh	r2,[r3]
add	r3,#2
add	r2,#1
strh	r2,[r3]
add	r3,#2
add	r2,#1
strh	r2,[r3]
add	r3,#2
ldr	r2,=#0xD01F
ldrb	r1,[r0,#1]
add	r2,r1
strh	r2,[r3]
add	r3,#2
ldr	r2,=#0xD0A7
strh	r2,[r3]
add	r3,#2
ldr	r2,=#0xD01F
ldrb	r1,[r0,#2]
add	r2,r1
strh	r2,[r3]
add	r3,#2
ldr	r2,=#0xD095
strh	r2,[r3]
add	r3,#2
add	r2,#1
strh	r2,[r3]
add	r3,#2
add	r2,#1
strh	r2,[r3]
noDrawing:

@get the number of jobs for this wheel
mov	r0,r7		@number of jobs
mov	r1,r6
add	r1,#1
swi	#6
@r0 is now number of jobs on this wheel
ldr	r2,=#0x2001F70
ldrb	r2,[r2,#1]
cmp	r1,r2		@check if there is a remainder
bls	noRemainderAgain
add	r0,#1		@the extra job is always on the first wheel
noRemainderAgain:
ldr	r2,=#0x3002818
ldr	r2,[r2]
ldr	r3,=#0x1270
add	r2,r3		@location of all the job wheel stuff
str	r0,[r2]
mov	r0,#0
	@strb	r0,[r2,#5]	@set index of wheel to 0, if any job matches we will change it but otherwise it will stay as 0
	@apparently vanilla already does this so whatever



@@now we figure out where the list starts 
@mov	r0,r7		@number of jobs
@mov	r1,r6
@add	r1,#1
@swi	#6
@ldr	r2,=#0x2001F70
@ldrb	r2,[r2,#1]
@mul	r0,r2
@cmp	r1,#0
@beq	noRemainderAgainAgain
@cmp	r2,#0
@beq	noRemainderAgainAgain
@add	r0,#1
@noRemainderAgainAgain:
@mov	r6,r0		@number of jobs to skip
@mov	r7,#0		@number of jobs skipped

@now we figure out where the list starts 
mov	r0,r7		@number of jobs
mov	r1,r6
add	r1,#1
swi	#6
ldr	r2,=#0x2001F70
ldrb	r2,[r2,#1]
mul	r0,r2
cmp	r2,r1
bhi	addAllRemainder
add	r0,r2
b	noRemainderAgainAgain
addAllRemainder:
add	r0,r1
noRemainderAgainAgain:
mov	r6,r0		@number of jobs to skip
mov	r7,#0		@number of jobs skipped



@now make our list
@r4 is current unit
mov	r5,#2
@r5 is current job being checked
@r6 is how many jobs to skip
@first we are going to find out where we should starts
@if 0 then skip this part
cmp	r6,#0
beq	stopStart
wheelLoopStart:
mov	r0,r4
mov	r1,r5
ldr	r3,checkJobShow
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	matchStart
nextStart:
add	r5,#1
cmp	r7,r6
bhs	stopStart
b	wheelLoopStart
matchStart:
add	r7,#1
b	nextStart
stopStart:

@now to actually make the list!
ldr	r2,=#0x3002818
ldr	r2,[r2]
ldr	r3,=#0x1270
add	r2,r3		@location of all the job wheel stuff
@r4 is current unit
@r5 is job we are checking
ldr	r6,[r2]		@how many jobs we need to find
mov	r7,#0	@number of jobs we have added so far
wheelLoop:
mov	r0,r4
mov	r1,r5
ldr	r3,checkJobShow
mov	lr,r3
.short	0xF800
cmp	r0,#0
bne	addToWheel
nextWheelEntry:
add	r5,#1
cmp	r7,r6
bhs	checkCurrent
b	wheelLoop
addToWheel:
push	{r6}
ldr	r6,=#0x3002818
ldr	r6,[r6]
ldr	r3,=#0x1270
add	r6,r3
add	r6,#8
strb	r5,[r6,r7]	@store the job id
add	r6,#12
mov	r0,r7
mov	r1,#0x1C
mul	r0,r1
mov	r1,#0
strb	r1,[r6,r0]	@set job as unselectable for now
@check if this is the same as current job
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer
ldrb	r3,[r3,#7]
cmp	r3,r5
beq	endAdd
@check if the character can be this job
mov	r0,r4
mov	r1,r5
ldr	r3,checkJobAvailability
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	endAdd
@if the character can be this job set it as selectable
mov	r0,r7
mov	r1,#0x1C
mul	r0,r1
mov	r1,#1
strb	r1,[r6,r0]	@set job as unselectable for now
endAdd:
add	r7,#1
pop	{r6}
b	nextWheelEntry

@and now check if "changes are irreversible"
checkCurrent:
mov	r0,r4
ldrb	r1,[r4,#7]
ldr	r3,checkJobAvailability
mov	lr,r3
.short	0xF800
ldr	r1,=#0x3002818
ldr	r1,[r1]
ldr	r2,=#0x1270
add	r1,r2
strb	r0,[r1,#7]

End:
ldr	r0,=#0x8085CB4
mov	lr,r0
pop	{r0-r7}
mov	r4,#0
ldr	r0,[r6]
add	r0,r5
ldr	r0,[r0]
.short	0xF800

.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobShow
@POIN checkJobAvailability
