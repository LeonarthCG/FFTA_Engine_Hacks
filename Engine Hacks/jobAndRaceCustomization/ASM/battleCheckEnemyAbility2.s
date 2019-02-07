.thumb

@get current character pointer
	@ldr	r3,=#0x200F438
	@ldr	r3,[r3]
	@ldr	r3,[r3,#0x18]	@current character pointer
ldr	r2,[sp]
ldr	r2,[sp,#0xC]
cmp	r2,#2
bhi	Vanilla
add	r2,#6
ldrb	r3,[r6,r2]	@job id
ldr	r2,pointer	@new job table
mov	r1,#16
mul	r1,r3
ldr	r3,[r2,r1]	@ability list
cmp	r3,#0		@if somehow 0 use vanilla
beq	Vanilla
@figure out index
mov	r0,#0
mov	r1,r4
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
mov	r4,r0
@get the new pointer to the data
	@ldr	r3,=#0x200F438
	@ldr	r3,[r3]
	@ldr	r3,[r3,#0x18]	@current character pointer
ldrb	r3,[r6,#6]	@race
ldr	r2,=#0x80257E8
ldr	r2,[r2]		@table of race lists
lsl	r3,#2		@race*4
ldr	r5,[r2,r3]	@list of abilities of the race
lsl	r1,r4,#3	@*size of entry
add	r5,r1
b	KeepLoop

KeepLoop:
ldr	r3,=#0x8134000
mov	lr,r3
.short	0xF800

EndLoop:
ldr	r3,=#0x813407A
mov	lr,r3
.short	0xF800

Vanilla:
add	r4,#1
add	r5,#8
mov	r0,r8
ldrb	r0,[r0]
cmp	r4,r0
ldr	r3,=#0x8134078
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
