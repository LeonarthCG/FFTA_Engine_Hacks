.equ checkJobAvailability, newJobAbilityTable+4
.equ neverShow, checkJobAvailability+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@pointer to unit
mov	r5,r1		@job ID

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

@check if unlock bit is set
mov	r0,r5
mov	r1,#8
swi	#6
ldr	r3,=#0x2002AD0
ldrb	r0,[r3,r0]
mov	r2,#1
lsl	r2,r1
and	r0,r2
cmp	r0,#0
bne	checkExtra

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
beq	False

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
beq	False
b	True

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

.align
.ltorg

newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkJobAvailability
@POIN neverShow
