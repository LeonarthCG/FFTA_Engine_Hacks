.equ checkAbility, newJobAbilityTable+4
.thumb
push	{lr}
push	{r4-r7}
mov	r4,r0		@pointer to unit
mov	r5,r1		@job ID
push	{r2}		@if not 0, check equipped items for abilities too
mov	r7,#0

@check the race of both
mov	r1,#0x34
mul	r1,r5
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
ldrb	r0,[r3,#4]
ldrb	r1,[r4,#6]
cmp	r0,r1
bne	EndFalse

@get custom ability list
ldr	r0,newJobAbilityTable
mov	r1,#16
mul	r1,r5
add	r0,r1
ldr	r6,[r0]
cmp	r6,#0
beq	vanillaMethod
mov	r7,#0
checkAbilityLoop:
ldrb	r1,[r6]
add	r6,#1
cmp	r1,#0
beq	endCheckAbilityLoop
mov	r0,r4
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
ldr	r3,[sp]
.short	0xF800
cmp	r0,#0
beq	checkAbilityLoop
add	r7,#1
b	checkAbilityLoop
endCheckAbilityLoop:
mov	r0,r7
b	End

@if it does not exist go with vanilla method
vanillaMethod:
@mov	r0,r5
@mov	r1,r5
@mov	r2,#0x25
@ldr	r3,=#0x80C8570	@get job starting ability index
@mov	lr,r3
@.short	0xF800
@mov	r6,r0
	@get job starting ability index
	mov	r1,#0x34
	mul	r1,r5
	ldr	r0,=#0x80C8598
	ldr	r0,[r0]
	add	r3,r1,r0
	mov	r0,#0x2E
	ldrb	r0,[r3,r0]
	mov	r6,r0
@mov	r0,r5
@mov	r1,r5
@mov	r2,#0x26
@ldr	r3,=#0x80C8570	@get job ending ability index
@mov	lr,r3
@.short	0xF800
@mov	r7,r0
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
bhi	endCheckAbilityVanillaLoop
mov	r1,r6
add	r6,#1
mov	r2,#0
push	{r3}
ldr	r3,checkAbility
mov	lr,r3
ldr	r3,[sp,#4]
.short	0xF800
pop	{r3}
cmp	r0,#0
beq	checkAbilityVanillaLoop
add	r3,#1
b	checkAbilityVanillaLoop
endCheckAbilityVanillaLoop:
mov	r0,r3
b	End

EndFalse:
mov	r0,#0

End:
pop	{r2}
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

newJobAbilityTable:
@POIN newJobAbilityTable
@POIN checkAbility
