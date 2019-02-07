.thumb

mov	r3,#0
strb	r3,[r4,#5]	@mark as vanilla
mov	r10,r0
ldrb	r1,[r4,#4]	@get job
ldr	r2,newJobAbilityTable
mov	r3,#16
mul	r3,r1
ldr	r2,[r2,r3]	@get ability list
cmp	r2,#0
beq	EndVanilla	@if 0 go vanilla
mov	r3,#0xFF
strb	r3,[r4,#5]	@mark as not vanilla
ldrb	r0,[r2]
cmp	r0,#0
beq	EndNothing	@if no abilities... no abilities

End:
mov	r8,r0
ldr	r3,=#0x80270F0
mov	lr,r3
.short	0xF800

EndNothing:
ldr	r3,=#0x80271DE
mov	lr,r3
.short	0xF800

EndVanilla:
@need to get starting and ending abilities
ldrb	r0,[r4,#4]	@job
	@get job starting ability index
	mov	r1,#0x34
	mul	r1,r0
	ldr	r0,=#0x80C8598
	ldr	r0,[r0]
	add	r3,r1,r0
	mov	r0,#0x2E
	ldrb	r1,[r3,r0]
mov	r8,r1
ldrb	r0,[r4,#4]	@job
	@get job ending ability index
	mov	r1,#0x34
	mul	r1,r0
	ldr	r0,=#0x80C8598
	ldr	r0,[r0]
	add	r3,r1,r0
	mov	r0,#0x2F
	ldrb	r2,[r3,r0]
ldr	r3,=#0x80270EC
mov	lr,r3
.short	0xF800

.align
.ltorg
newJobAbilityTable:
