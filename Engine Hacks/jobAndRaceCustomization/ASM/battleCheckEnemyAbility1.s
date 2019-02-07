.thumb

add	r5,r2,r0
mov	r4,r1
mov	r1,r8
ldrb	r1,[r1]

@get current character pointer
	@ldr	r3,=#0x200F438
	@ldr	r3,[r3]
	@ldr	r3,[r3,#0x18]	@current character pointer
ldr	r2,[sp,#0xC]
cmp	r2,#2
bhi	End
add	r2,#6
ldrb	r3,[r6,r2]	@job id
ldr	r2,pointer	@new job table
mov	r1,#16
mul	r1,r3
ldr	r3,[r2,r1]	@ability list
cmp	r3,#0		@if somehow 0 use vanilla
beq	End
@get first ability
ldrb	r4,[r3]
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
mov	r1,r4

End:
ldr	r3,=#0x8133FF4
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
