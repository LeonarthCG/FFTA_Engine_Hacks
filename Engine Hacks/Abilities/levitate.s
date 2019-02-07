.thumb

push	{lr}

@r0 = base value of stat
@r1 = job
@r2 = stat that we got
@r3 = pointer to character in ram

cmp	r2,#0x23	@standing was checked
bne	End

@get the ability
mov	r2,#0x3C
ldrb	r1,[r3,r2]	@combo/movement ability

@get the ability id
@get race so we can get the pointer to the abilities
ldrb	r2,[r3,#6]	@race
ldr	r3,=#0x80257E8
ldr	r3,[r3]		@pointer to ability by race table
lsl	r2,#2
add	r2,r3
ldr	r2,[r2]		@offset of the abilities for this race
lsl	r1,#3		@*8 because that's the size of an ability in this table
add	r1,r2		@offset of ability
ldrh	r1,[r1,#4]	@ID of the ability
mov	r2,#9		@target ability ID
cmp	r1,r2
bne	End

mov	r0,#4

End:
pop	{r1}
bx	r1
