.thumb

@check if we are confirming or waiting
ldr	r0,=#0x2001F70
ldrb	r0,[r0]
mov	r1,#0x18
and	r0,r1
cmp	r0,#0x18
beq	Wait

@we set wait usability to 0 if the unit just confirmed so we can check that to see if the turn is ending
ldr	r0,=#0x202DE44
ldrb	r1,[r0,#3]	@if status is 0 do nothing because it hasn't even loaded yet
cmp	r1,#0
beq	noWait
ldrb	r1,[r0,#2]
cmp	r1,#0
beq	noWait

@check if we confirmed
ldr	r0,=#0x202DE44
ldrb	r1,[r0]
cmp	r1,#0xFF
beq	WaitPortrait

noWait:
ldr	r0,=#0x200F5B8
@unset flag just in case
ldr	r1,[r0]
mov	r2,#1
lsl	r2,#0x1F	 @0x80000000, as far as I know it's not used
mvn	r2,r2
and	r1,r2
str	r1,[r0]
@return 0
mov	r0,#0
b	End

WaitPortrait:
ldr	r0,=#0x200F5B8
@unset flag just in case
ldr	r1,[r0]
mov	r2,#1
lsl	r2,#0x1F	 @0x80000000, as far as I know it's not used
mvn	r2,r2
and	r1,r2
str	r1,[r0]
@skip setting the flag if not player controlled
ldr	r1,[r0]
mov	r2,#0x04	@this bit means AI controller
and	r1,r2
cmp	r1,#0
bne	Wait
@set a flag so we can tell if this was wait or confirm for the portrait animation
ldr	r1,[r0]
mov	r2,#1
lsl	r2,#0x1F	 @0x80000000, as far as I know it's not used
orr	r1,r2
str	r1,[r0]

Wait:
mov	r0,#4

End:
ldr	r3,=#0x80925BC
mov	lr,r3
.short	0xF800
