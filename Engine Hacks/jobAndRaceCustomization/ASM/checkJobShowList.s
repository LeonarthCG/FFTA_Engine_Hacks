.equ checkJobAvailability, newJobAbilityTable+4
.equ neverShow, checkJobAvailability+4
.equ checkAbilityCountAny, neverShow+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@pointer to unit
mov	r5,r1		@job ID

@check if extra show requirements are met
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r0,[r0,#8]
cmp	r0,#0
beq	noCondition
mov	lr,r0
mov	r0,r4
mov	r1,r5
.short	0xF800
cmp	r0,#0
beq	False
noCondition:

@check if same race
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
ldrb	r0,[r3,#4]
ldrb	r1,[r4,#6]
cmp	r0,r1
bne	False

@check if not player unit
mov	r0,#0x29
ldrb	r0,[r4,r0]
mov	r1,#0xB0	@0xB0 = 1 (enemy) 0 (boss) 1 (guest) 1 (judge) 0 0 0 0
and	r0,r1
cmp	r0,#0
bne	notPlayer

@check if during battle
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x2031CCC
cmp	r0,r1
beq	notPlayer

@check if unlock bit is set
@mov	r0,r5
@mov	r1,#8
@swi	#6
@ldr	r3,=#0x2002AD0
@ldrb	r0,[r3,r0]
@mov	r2,#1
@lsl	r2,r1
@and	r0,r2
@cmp	r0,#0
@bne	checkExtra

@check if the character can set it
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r0,[r0,#4]
ldr	r1,neverShow
cmp	r0,r1
beq	False
mov	r0,r4
mov	r1,r5
ldr	r3,checkJobAvailability
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	FalseMaybe

@check extra conditions
checkExtra:
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r0,[r0,#8]
ldr	r1,neverShow
cmp	r0,r1
beq	False
cmp	r0,#0
beq	True
mov	lr,r0
mov	r0,r4
mov	r1,r5
.short	0xF800
cmp	r0,#0
beq	FalseMaybe
b	True

FalseMaybe:
b	notPlayer

False:
mov	r0,#0
b	End

True:
mov	r0,#1
b	End

End:
pop	{r4-r7}
pop	{r1}
bx	r1

@check if the unit has any abilities for that job
notPlayer:
@check for neverShow
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r0,[r0,#8]
ldr	r1,neverShow
cmp	r0,r1
beq	False
@check if the unit has any abilities in this job
mov	r0,r4
mov	r1,r5
mov	r2,#1
ldr	r3,checkAbilityCountAny
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	False
b	True

.align
.ltorg

newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkJobAvailability
@POIN neverShow
@POIN checkAbilityCountAny
