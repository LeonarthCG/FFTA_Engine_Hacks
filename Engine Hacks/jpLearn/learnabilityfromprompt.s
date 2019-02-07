.equ masterAbility, unlockJobs+4
.thumb

ldr	r0,[r2]
ldr	r3,=#0x42B
add	r0,r3
mov	r1,#10
push	{r0-r3}

@check if yes was selected
ldr	r3,=#0x2003CB0
mov	r1,#0x43
mov	r2,#0x41
ldrb	r0,[r3,r1]
cmp	r0,#0x1E
bne	End		@if not 0x1E, it was not a choice
ldrb	r0,[r3,r2]
cmp	r0,#0xFF	@if 0xFF, the player pressed B
beq	End
cmp	r0,#1		@if 1, the player selected No
beq	End

@make the learning happen
ldr	r1,=#0x203560C
ldrh	r0,[r1]		@jp cost

@first we remove jp from the unit
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r3,[r2]		@current character pointer

mov	r2,#0xD6
ldrh	r2,[r3,r2]	@JP
sub	r0,r2,r0
mov	r2,#0xD6
strh	r0,[r3,r2]	@reduced jp stored

@now set the ability as learnt
push	{r0}
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
ldrh	r1,[r1,#2]	@ability
ldr	r3,masterAbility
mov	lr,r3
.short	0xF800
pop	{r0}

@reduce it in this other place too
ldr	r3,=#0x3002818
ldr	r3,[r3]
ldr	r2,=#0x1BE4
add	r3,r2
ldr	r2,=#0xD6
strh	r0,[r3,r2]	@reduced jp stored

@update tiles
push	{r0-r3}
ldr	r1,=#9999
cmp	r0,r1
blo	noProblem
mov	r0,r1
noProblem:
mov	r1,#4
mov	r2,r0
ldr	r3,=#0x8035A68
mov	lr,r3
ldr	r3,=#0xF000
cmp	r2,#0
bne	notRed
ldr	r3,=#0xA000
notRed:
ldr	r0,=#0x3000A94
ldr	r0,[r0]
add	r0,#0xA0
add	r0,#0xA0
add	r0,#0x2E
.short	0xF800
pop	{r0-r3}

@and update the jp for the ability tab too
ldrh	r2,[r1,#2]	@ability
add	r2,#40
mov	r0,#0xE4
strb	r0,[r3,r2]

@update graphics
ldr	r0,=#0x3000EC7
mov	r1,#0
strb	r1,[r0]

@get current character pointer
push	{r4,r5}
mov	r5,#0
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r1,[r2]		@current character pointer
add	r1,#0xD6
ldrh	r4,[r1]		@reamining jp
ldr	r1,=#9999
cmp	r4,r1
blo	noProblem2
mov	r4,r1
noProblem2:

@clear tiles
mov	r0,#0
ldr	r2,=#0x600616C
strh	r0,[r2]
strh	r0,[r2,#2]
strh	r0,[r2,#4]

@update background
mov	r1,#4
mov	r2,r4
ldr	r3,=#0x8035A68
mov	lr,r3
ldr	r3,=#0xF000
cmp	r2,#0
bne	notRed2
ldr	r3,=#0xA000
notRed2:
ldr	r0,=#0x600616E
.short	0xF800

EndDraw:
pop	{r4,r5}

End:
@get current character pointer
ldr	r2,=#0x3002818
ldr	r3,=#0x1D0C
ldr	r2,[r2]
add	r2,r3
ldr	r0,[r2]		@current character pointer
ldr	r3,unlockJobs
mov	lr,r3
.short	0xF800
ldr	r3,=#0x808452C
mov	lr,r3
pop	{r0-r3}
.short	0xF800

.align
.ltorg

unlockJobs:
@POIN unlockJobs
@POIN masterAbility
