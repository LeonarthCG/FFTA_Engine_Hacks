.thumb
ldr	r0,=#0x16A	@first food item
ldr	r1,=#0x177	@last food item
ldr	r2,=#0x2001940	@inventory
loop:
ldrb	r3,[r2,r0]
cmp	r3,#0
bne	true
add	r0,#1
cmp	r0,r1
bhi	false
b	loop

false:
mov	r0,#0
bx	lr

true:
mov	r0,#1
bx	lr
