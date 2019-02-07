.equ checkJobShow, highestJob+4
.equ checkForUnlocks, checkJobShow+4
.thumb
push	{r4-r7}
mov	r4,r0	@current unit
mov	r5,#0	@current job being checked
ldr	r6,highestJob
ldr	r7,checkJobShow

@reset a byte for the job change wheel
ldr	r0,=#0x2001F70
mov	r1,#0
strb	r1,[r0,#1]
strb	r1,[r0,#2]

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
ldr	r1,=#0x8076A78
ldr	r1,[r1]
ldr	r0,=#0x8076B10
mov	lr,r0
mov	r0,#0x11
.short	0xF800

EndFalse:
pop	{r4-r7}
ldr	r0,=#0x8076AFC
mov	lr,r0
.short	0xF800


.align
.ltorg

highestJob:
@WORD highestJob
@POIN checkJobShow
@POIN checkForUnlocks
