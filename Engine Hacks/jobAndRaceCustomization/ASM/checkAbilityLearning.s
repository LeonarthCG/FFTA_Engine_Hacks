.thumb

@r0 is character
@r1 is ability id
mov	r2,#0	@any type
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0	@only learnt, not equipped
.short	0xF800

cmp	r0,#1
beq	false

true:
ldr	r3,=#0x80A7BE4
mov	lr,r3
.short	0xF800

false:
ldr	r3,=#0x80A7C10
mov	lr,r3
.short	0xF800

.align
.ltorg

checkAbility:
