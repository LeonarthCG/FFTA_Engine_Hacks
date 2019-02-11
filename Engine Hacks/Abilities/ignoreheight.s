.thumb
push	{r0-r2}
@check if the unit has ignore height
ldr	r0,[r4]
mov	r2,#0x3C
ldrb	r1,[r0,r2]	@combo/movement ability
ldrb	r2,[r0,#6]	@race
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
b	End

@if not, do the normal check
Vanilla:
pop	{r0-r2}
ldsb	r5,[r0,r5]
add	r0,#1
mov	r2,#0
ldsb	r2,[r0,r2]
ldr	r3,=#0x8099EBC
mov	lr,r3
.short	0xF800

End:
pop	{r0-r2}
mov	r5,#0x60
add	r0,#1
mov	r2,#0
ldsb	r2,[r0,r2]
ldr	r3,=#0x8099EBC
mov	lr,r3
.short	0xF800
