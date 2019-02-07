.equ checkAbility, newJobAbilityTable+4
.thumb

push	{lr}
push	{r4-r7}

mov	r4,r0		@character pointer
mov	r5,r1		@job

@check if custom list or vanilla list
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r6,[r0]
cmp	r6,#0
beq	vanillaMethod

@new method
mov	r7,#0
checkAbilityLoop:
ldrb	r1,[r6]
add	r6,#1
cmp	r1,#0
beq	Mastered
mov	r0,r4
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
.short	0xF800
cmp	r0,#0
beq	notMastered
add	r7,#1
b	checkAbilityLoop

vanillaMethod:
@get job starting ability index
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
mov	r0,#0x2E
ldrb	r0,[r3,r0]
mov	r6,r0
@get job ending ability index
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
mov	r0,#0x2F
ldrb	r0,[r3,r0]
mov	r7,r0

mov	r3,#0		@ability counter
checkAbilityVanillaLoop:
mov	r0,r4
cmp	r6,r7
bhi	Mastered
mov	r1,r6
add	r6,#1
mov	r2,#0
push	{r3}
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
.short	0xF800
pop	{r3}
cmp	r0,#0
beq	notMastered
add	r3,#1
b	checkAbilityVanillaLoop

notMastered:
mov	r0,#0
b	End

Mastered:
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
@POIN checkAbility
