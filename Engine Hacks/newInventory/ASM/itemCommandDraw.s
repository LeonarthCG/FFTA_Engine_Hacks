.equ checkEquippedAmmount, newItemItems+4
.equ maxItem, checkEquippedAmmount+4
.thumb
cmp	r0,#0
bne	noNumber
ldr	r2,newItemItems
lsl	r1,r4,#3
ldrh	r0,[r2,r1]
ldr	r1,maxItem
bhi	noNumber
cmp	r0,#0
beq	noNumber

@get ammount of equipped items
ldr	r2,newItemItems
lsl	r1,r4,#3
ldrh	r0,[r2,r1]
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800

@get ammount of owned items
ldr	r2,newItemItems
lsl	r1,r4,#3
ldrh	r3,[r2,r1]
ldr	r2,=#0x2001940
ldrb	r1,[r2,r3]

@owned - equipped
sub	r0,r1,r0

end:
ldr	r3,=#0x80259B8
mov	lr,r3
.short	0xF800

noNumber:
ldr	r3,=#0x8025A16
mov	lr,r3
.short	0xF800
.align
.ltorg
newItemItems:
