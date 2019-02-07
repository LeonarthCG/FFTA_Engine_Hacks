.thumb

mov	r2,r7
@r2 is current ability
ldrb	r0,[r4,#5]
cmp	r0,#0
beq	goVanilla

@ability lists
ldr	r0,newJobAbilityTable
ldrb	r1,[r4,#4]
mov	r3,#16
mul	r1,r3
ldr	r0,[r0,r1]	@job ability list
mov	r1,#0
loop:
ldrb	r3,[r0,r1]
cmp	r3,#0
beq	endLoop
cmp	r2,r3
beq	gotIndex
add	r1,#1
b	loop

gotIndex:
add	r1,#1
ldrb	r2,[r0,r1]
cmp	r2,#0
beq	endLoop
mov	r7,r2
b	continueLoop

goVanilla:
mov	r2,#1
add	r7,r2
ldrb	r0,[r4,#4]
	@get job ending ability index
	mov	r1,#0x34
	mul	r1,r0
	ldr	r0,=#0x80C8598
	ldr	r0,[r0]
	add	r3,r1,r0
	mov	r0,#0x2F
	ldrb	r0,[r3,r0]
cmp	r7,r0
ble	continueLoop

endLoop:
ldr	r3,=#0x80270A4
mov	lr,r3
.short	0xF800

continueLoop:
ldr	r3,=#0x8026FBE
mov	lr,r3
.short	0xF800

.align
.ltorg
newJobAbilityTable:
