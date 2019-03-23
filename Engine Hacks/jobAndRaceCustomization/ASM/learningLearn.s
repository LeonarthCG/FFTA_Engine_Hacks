.thumb

ldr	r0,[r7]
ldr	r0,[r0]
@r0 is character pointer
mov	r1,r6
@r1 is ability

ldr	r3,masterAbility
mov	lr,r3
.short	0xF800

ldr	r3,=#0x80A7BF0
mov	lr,r3
.short	0xF800

.align
.ltorg

masterAbility:
