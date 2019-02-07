.equ damageup, damage+4
.equ damagedown, damageup+4

.thumb

push	{r4-r7}

mov	r3,#0x26
ldrb	r3,[r5,r3]

add	r0,#0xD6
add	r1,#0xD6
ldrh	r5,[r0]		@attacker jp
ldrh	r6,[r1]		@defender jp
ldr	r4,damage

cmp	r6,#0
beq	noDamage

ldr	r0,=#9999
cmp	r5,r0
bhs	noDamage

checkIfAction:
cmp	r3,#0x80
bne	checkDamage

@get random damage
ldr	r0,damageup
ldr	r1,damagedown
add	r7,r0,r1	@total damage variance

push	{r3}
ldr	r3,=#0x08002804	@get next rng
mov	lr,r3
.short	0xF800
@r0 = random number
mov	r1,r7
swi	#6
pop	{r3}
ldr	r2,damagedown
cmp	r1,r2
bhi	moreDamage

lessDamage:
ldr	r2,damage
cmp	r1,r2		@if damage would fall to 0, make it 1
bhs	damage1
sub	r4,r1
b	checkDamage

moreDamage:
add	r4,r1
b	checkDamage

damage1:
mov	r4,#1

checkDamage:
cmp	r4,#0
bne	np
mov	r4,#1
np:
@make sure we did not go above enemy total jp
cmp	r4,r6
blo	checkTotal
mov	r4,r6

checkTotal:
add	r5,r4
ldr	r0,=#9999
cmp	r5,r0
blo	End
sub	r0,r5
mov	r4,r0
b	End

noDamage:
mov	r4,#0

End:
mov	r0,r4
pop	{r4-r7}
ldr	r3,=#0x81314C8
mov	lr,r3
.short	0xF800

.align
.ltorg
damage:
@POIN damage
@POIN damageup
@POIN damagedown
