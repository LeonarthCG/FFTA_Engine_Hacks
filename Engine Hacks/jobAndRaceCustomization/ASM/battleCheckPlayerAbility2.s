.thumb

@check if vanilla
mov	r3,#0xFF
ldrb	r2,[r6,#4]
cmp	r2,r3
bne	Vanilla
ldrb	r2,[r6,#5]
cmp	r2,r3
bne	Vanilla

@get current character pointer
ldr	r3,=#0x200F438
ldr	r3,[r3]
ldr	r3,[r3,#0x18]	@current character pointer
ldr	r2,[sp]
ldrb	r2,[r2,#8]	@5 for first command, 6 for second
cmp	r2,#5
blo	Vanilla
cmp	r2,#6
bhi	Vanilla
add	r2,#2
ldrb	r3,[r3,r2]	@job id
ldr	r2,pointer	@new job table
mov	r1,#16
mul	r1,r3
ldr	r3,[r2,r1]	@ability list
cmp	r3,#0		@if somehow 0 use vanilla
beq	Vanilla
@figure out index
mov	r0,#0
mov	r1,r10
indexloop:
ldrb	r2,[r3,r0]
cmp	r2,r1
beq	gotindex
add	r0,#1
b	indexloop

gotindex:
add	r0,#1
ldrb	r0,[r3,r0]
cmp	r0,#0
beq	EndLoop
mov	r10,r0
b	KeepLoop

KeepLoop:
ldr	r3,=#0x8026D6E
mov	lr,r3
.short	0xF800

EndLoop:
ldr	r3,=#0x8026F78
mov	lr,r3
.short	0xF800

Vanilla:
mov	r2,#1
add	r10,r2
ldrb	r0,[r6,#5]
cmp	r10,r0
bgt	EndLoop
b	KeepLoop

.align
.ltorg
pointer:
