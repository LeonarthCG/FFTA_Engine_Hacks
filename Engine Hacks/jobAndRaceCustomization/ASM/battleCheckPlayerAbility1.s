.thumb

@check if we already did this
mov	r3,#0xFF
ldrb	r2,[r6,#4]
cmp	r2,r3
bne	firstTimeOrVanilla
ldrb	r2,[r6,#5]
cmp	r2,r3
bne	firstTimeOrVanilla
b	End

@get current character pointer
firstTimeOrVanilla:
ldr	r3,=#0x200F438
ldr	r3,[r3]
ldr	r3,[r3,#0x18]	@current character pointer
ldr	r2,[sp]
ldrb	r2,[r2,#8]	@5 for first command, 6 for second
cmp	r2,#5
blo	End
cmp	r2,#6
bhi	End
add	r2,#2
ldrb	r3,[r3,r2]	@job id
ldr	r2,pointer	@new job table
mov	r1,#16
mul	r1,r3
ldr	r3,[r2,r1]	@ability list
cmp	r3,#0		@if 0 use vanilla
beq	End
ldrb	r1,[r6,#4]
sub	r0,r1		@index
ldrb	r0,[r3,r0]	@ability ID
cmp	r0,#0
beq	debug		@this should never happen
mov	r10,r0
mov	r1,#0xFF
strb	r1,[r6,#4]
strb	r1,[r6,#5]

End:
lsl	r1,r0,#3
ldr	r0,[r6]
add	r5,r0,r1
ldrb	r0,[r5,#6]
ldr	r3,=#0x8026D78
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
