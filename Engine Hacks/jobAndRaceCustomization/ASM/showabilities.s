.equ checkAbility, pointer+4
.thumb

pop	{r3}
push	{r1-r4}
mov	r4,r0	@pointer to ability ap

@check if during battle
ldr	r1,=#0x203778C
mov	r2,r8
cmp	r1,r2
beq	checkHide

@check if enemy/guest
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer
mov	r2,#0x29
ldrb	r2,[r3,r2]
mov	r3,#0xB0	@0xB0 = 1 (enemy) 0 (boss) 1 (guest) 1 (judge) 0 0 0 0
and	r2,r3
cmp	r2,#0
beq	CheckInvisible

checkHide:
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
mov	r1,r4
sub	r1,r0
sub	r1,#0x40	@ability ID
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#1
.short	0xF800
cmp	r0,#0
bne	EndShow
ldr	r0,=#0x807C53A
mov	lr,r0
pop	{r1-r4}
.short	0xF800

CheckInvisible:
ldr	r0,pointer
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r2,[r2]		@current character pointer
@get race
ldrb	r1,[r2,#6]	@race
invisibleLoop:
ldrb	r2,[r0]		@check race
cmp	r2,#0
beq	EndShow
cmp	r2,r1		@check race
bne	nextLoop
ldrb	r2,[r0,#1]	@check ability
cmp	r2,r6
beq	checkHide
nextLoop:
add	r0,#2
b	invisibleLoop

EndShow:
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
mov	r1,r4
sub	r1,r0
sub	r1,#0x40	@ability ID
mov	r2,#0
ldr	r3,checkAbility
mov	lr,r3
mov	r3,#0
.short	0xF800
@if the ability is known without equip
cmp	r0,#0
beq	Equipped
mov	r0,#0xE4
b	End
@else
Equipped:
mov	r0,#0x80

End:
ldr	r3,=#0x807C4AE
mov	lr,r3
pop	{r1-r4}
.short	0xF800

.align
.ltorg
pointer:
@POIN pointer
@POIN checkAbility
