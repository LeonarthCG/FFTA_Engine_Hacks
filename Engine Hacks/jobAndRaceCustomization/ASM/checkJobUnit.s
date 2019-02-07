.equ checkAbilityCount, newJobAbilityTable+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@pointer to unit
mov	r5,r1		@job ID

@check if the unit is the same race as the job
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
ldrb	r0,[r3,#4]
ldrb	r1,[r4,#6]
cmp	r0,r1
bne	False

@check for a-ability requirements
@get job requirement index
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
mov	r0,#0x30
ldrb	r0,[r3,r0]
lsl	r0,#2
ldr	r1,=#0x80C8B18
ldr	r1,[r1]
add	r6,r0,r1	@pointer to requirements
mov	r0,r4		@pointer to unit
ldrb	r1,[r6]		@job to check
mov	r2,#0
ldr	r3,checkAbilityCount
mov	lr,r3
.short	0xF800
ldrb	r1,[r6,#1]	@number of abilities of that job to check for
cmp	r0,r1
blo	noUnlock
mov	r0,r4		@pointer to unit
ldrb	r1,[r6,#2]		@job to check
mov	r2,#0
ldr	r3,checkAbilityCount
mov	lr,r3
.short	0xF800
ldrb	r1,[r6,#3]	@number of abilities of that job to check for
cmp	r0,r1
blo	noUnlock

@check custom requirement
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r0,[r0,#4]
cmp	r0,#0
beq	Unlock
mov	lr,r0
mov	r0,r4		@current unit
mov	r1,r5		@job id, just in case
.short	0xF800
cmp	r0,#0
beq	noUnlock

@routine endings
Unlock:
b	True

noUnlock:
b	False

True:
mov	r0,#1
b	End

False:
mov	r0,#0
b	End

End:
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkAbilityCount
