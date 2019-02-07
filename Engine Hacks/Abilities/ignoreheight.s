.thumb

@check if the unit has ignore height
mov	r2,#0x3C
ldrb	r1,[r5,r2]	@combo/movement ability
ldrb	r2,[r5,#6]	@race
ldr	r3,=#0x80257E8
ldr	r3,[r3]		@pointer to ability by race table
lsl	r2,#2
add	r2,r3
ldr	r2,[r2]		@offset of the abilities for this race
lsl	r1,#3		@*8 because that's the size of an ability in this table
add	r1,r2		@offset of ability
ldrh	r1,[r1,#4]	@ID of the ability
mov	r2,#7		@target ability ID
cmp	r1,r2
bne	Vanilla
mov	r0,#0x7F
b	End

@if not, do the normal check
Vanilla:
mov	r0,r5
mov	r1,#0x1F
ldr	r3,=#0x80C92F0
mov	lr,r3
.short	0xF800
lsl	r0,#0x18
lsr	r4,#0x18

End:
ldr	r3,=#0x80CA30E
mov	lr,r3
.short	0xF800
