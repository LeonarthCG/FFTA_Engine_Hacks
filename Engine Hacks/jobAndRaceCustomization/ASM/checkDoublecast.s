.equ	checkAbility, newJobAbilityTable+4
.thumb
push	{lr}
push	{r4-r7}
mov	r7,r9
mov	r6,r8
push	{r6,r7}
mov	r4,r0		@character pointer

ldrb	r5,[r4,#7]	@job
ldrb	r1,newJobAbilityTable
mov	r0,#16
mul	r0,r5
ldr	r0,[r1,r0]
cmp	r0,#0
bne	notVanilla1
bl	checkVanilla
b	doneCheck1
notVanilla1:
bl	checkNew
doneCheck1:

ldrb	r5,[r4,#8]	@second job
cmp	r5,#0
beq	doneCheck2
ldrb	r1,newJobAbilityTable
mov	r0,#16
mul	r0,r5
ldr	r0,[r1,r0]
cmp	r0,#0
bne	notVanilla2
bl	checkVanilla
b	doneCheck2
notVanilla2:
bl	checkNew
doneCheck2:

mov	r0,#0

End:
pop	{r3,r4}
mov	r8,r3
mov	r9,r4
pop	{r4-r7}
pop	{r1}
bx	r1

checkNew:
@get custom ability list
mov	r6,r0
mov	r7,lr
checkAbilityLoop:
ldrb	r5,[r6]
add	r6,#1
mov	r1,r5
cmp	r1,#0
beq	endCheckAbilityLoop
@check if this is doublecast
ldrb	r0,[r4,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
mov	r1,r5
lsl	r1,#3		@*size of entry
add	r0,r1
ldrb	r1,[r0,#6]	@ability type
cmp	r1,#4
beq	thisisgoodtoo1
cmp	r1,#1
bne	checkAbilityLoop
thisisgoodtoo1:
ldrh	r1,[r0,#4]	@effect id
cmp	r1,#0x21
bne	checkAbilityLoop
mov	r0,r4
mov	r1,r5
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
cmp	r0,#0
beq	checkAbilityLoop
mov	r0,#1
b	End
endCheckAbilityLoop:
mov	r0,#0
mov	r3,r7
mov	lr,r3
.short	0xF800

checkVanilla:
@get job starting ability index
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
mov	r0,#0x2E
ldrb	r0,[r3,r0]
mov	r6,r0		@starting ability
@get job ending ability index
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
mov	r0,#0x2F
ldrb	r0,[r3,r0]
mov	r7,r0		@ending ability
mov	r3,lr
mov	r8,r3
mov	r3,#0		@ability counter
checkAbilityVanillaLoop:
mov	r0,r4
cmp	r6,r7
bhi	endCheckAbilityVanillaLoopFalse
add	r6,#1
@check if this is doublecast
ldrb	r0,[r4,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]
lsl	r0,#2		@race*4
ldr	r0,[r2,r0]	@list of abilities of the race
sub	r6,#1
mov	r1,r6
add	r6,#1
lsl	r1,#3		@*size of entry
add	r0,r1
ldrb	r1,[r0,#6]	@ability type
cmp	r1,#4
beq	thisisgoodtoo2
cmp	r1,#1
bne	checkAbilityVanillaLoop
thisisgoodtoo2:
ldrh	r1,[r0,#4]	@effect id
cmp	r1,#0x21
bne	checkAbilityVanillaLoop
@check if mastered
sub	r6,#1
mov	r1,r6
add	r6,#1
mov	r2,#0
push	{r3}
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
pop	{r3}
cmp	r0,#0
beq	checkAbilityVanillaLoop
b	endCheckAbilityVanillaLoopTrue
endCheckAbilityVanillaLoopFalse:
mov	r0,#0
mov	r3,r8
mov	lr,r3
.short	0xF800
endCheckAbilityVanillaLoopTrue:
mov	r0,#1
b	End

.align
.ltorg

newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkAbility
