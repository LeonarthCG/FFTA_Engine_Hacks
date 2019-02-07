.equ damageup, damage+4
.equ damagedown, damageup+4

.thumb

push	{lr}

ldr	r0,[r0,#4]
add	r0,#0xD6
ldrh	r0,[r0]
mov	r3,r0
ldr	r1,damage
cmp	r0,r1
blo	checkIfAction
mov	r0,r1

checkIfAction:
push	{r4-r7}
@if 0, just do not bother
cmp	r0,#0
beq	End
@two different checks just in case
@r8 is 0 during the action, and a pointer to ram during the selection, so if r8 < 0x02000000 this is action
mov	r1,#2
lsl	r1,#24
mov	r2,r8
cmp	r2,r1
blo	Action
@r9 is a pointer to ram during action, and 0xFF otherwise, so if r9 >= 0x02000000 this is action
mov	r2,r9
cmp	r2,r1
bhs	Action
b	End

Action:
mov	r4,r0		@base damage
ldr	r5,damageup
ldr	r6,damagedown
add	r7,r5,r6	@total damage variance
push	{r3}
ldr	r3,=#0x08002804	@get next rng
mov	lr,r3
.short	0xF800
@r0 = random number
mov	r1,r7
swi	#6
pop	{r3}
cmp	r1,r6
bhi	moreDamage

lessDamage:
cmp	r1,r4
bhs	damage1
sub	r0,r4,r1
b	checkDamage

damage1:
mov	r0,#1
b	checkDamage

moreDamage:
add	r0,r4,r1

checkDamage:
cmp	r0,#0
bne	np
mov	r0,#1
np:
@make sure we did not go above enemy total jp
cmp	r0,r3
blo	End
mov	r0,r3

End:
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg
damage:
@POIN damage
@POIN damageup
@POIN damagedown
