.equ maxStats, maxLevel+4
.equ levelHeal, maxStats+4
.thumb
push	{lr}
push	{r4-r7}
mov	r5,r0		@pointer to character in ram

@increase level
ldrb	r0,[r5,#0x09]	@level
add	r0,#1
strb	r0,[r5,#0x09]
mov	r0,#0
strb	r0,[r5,#0x0A]

@check if level is maxed
ldrb	r0,[r5,#0x09]
ldrb	r1,maxLevel
cmp	r0,r1
bls	notMaxed
strb	r0,[r5,#0x09]
mov	r0,#99
strb	r0,[r5,#0x0A]
mov	r0,#0
b	End
notMaxed:

@check if judge
ldrh	r0,[r5,#0x28]
mov	r1,#1
lsl	r1,#12		@0x1000, judge flag
and	r0,r1
cmp	r0,#0
bne	EndTrue

@HP and MP loop (unsigned), aditionally units can get healed by the max hp/mp they gained
mov	r4,#0x1A
@r5 is current character pointer
mov	r6,#0
mov	r7,#0	@a counter for getting the growths
hpmploop:
mov	r0,r5
mov	r1,#0x29
add	r1,r7
add	r7,#1
ldr	r3,=#0x80C92F0
mov	lr,r3
.short	0xF800
mov	r6,r0	@growth
mov	r1,#10
swi	#6
mov	r2,r1
ldrh	r1,[r5,r4]
add	r1,r0
strh	r1,[r5,r4]
ldr	r1,levelHeal
cmp	r1,#0
beq	dontheal1
sub	r4,#2
ldrh	r1,[r5,r4]
add	r1,r0
strh	r1,[r5,r4]
add	r4,#2
dontheal1:
ldrb	r0,[r5,#9]	@level
mov	r1,r0
sub	r1,#1		@level-1
mul	r0,r2
mul	r1,r2
push	{r1}
mov	r1,#10
swi	#6
pop	{r1}
push	{r0,r1}
mov	r0,r1
mov	r1,#10
swi	#6
mov	r3,r0
pop	{r0,r1}
mov	r1,r3
cmp	r0,r1
bls	noincreasehpmp
ldrh	r0,[r5,r4]
add	r0,#1
strh	r0,[r5,r4]
ldr	r1,levelHeal
cmp	r1,#0
beq	dontheal2
sub	r4,#2
ldrh	r0,[r5,r4]
add	r0,#1
strh	r0,[r5,r4]
add	r4,#2
dontheal2:
noincreasehpmp:
ldrh	r0,[r5,r4]
ldr	r1,maxStats
cmp	r0,r1
blo	nomaxedhpmp
mov	r0,r1
nomaxedhpmp:
strh	r0,[r5,r4]
sub	r4,#2
ldrh	r0,[r5,r4]
ldr	r1,maxStats
cmp	r0,r1
blo	nomaxedcurrenthpmp
mov	r0,r1
nomaxedcurrenthpmp:
strh	r0,[r5,r4]
add	r4,#2
cmp	r4,#0x1E
bhs	hpmploopdone
mov	r4,#0x1E
b	hpmploop
hpmploopdone:

@Every other stat loop
mov	r4,#0x20
@r4 is a counter for the current stat
@r5 is current character pointer
mov	r6,#0
mov	r7,#3
@r7 is a counter for the current growth
statsloop:
cmp	r4,#0x26
bls	notspeed
mov	r4,#0xD2
mov	r7,#2
notspeed:
mov	r0,r5
mov	r1,#0x29
add	r1,r7
add	r7,#1
ldr	r3,=#0x80C92F0
mov	lr,r3
.short	0xF800
mov	r6,r0	@growth
mov	r1,#10
swi	#6
mov	r2,r1
ldrh	r1,[r5,r4]
add	r1,r0
strh	r1,[r5,r4]
ldrb	r0,[r5,#9]	@level
mov	r1,r0
sub	r1,#1		@level-1
mul	r0,r2
mul	r1,r2
push	{r1}
mov	r1,#10
swi	#6
pop	{r1}
push	{r0,r1}
mov	r0,r1
mov	r1,#10
swi	#6
mov	r3,r0
pop	{r0,r1}
mov	r1,r3
cmp	r0,r1
bls	noincreasestats
ldrh	r0,[r5,r4]
add	r0,#1
strh	r0,[r5,r4]
noincreasestats:
ldrh	r0,[r5,r4]
ldr	r1,maxStats
cmp	r0,r1
blo	nomaxedstats
mov	r0,r1
nomaxedstats:
strh	r0,[r5,r4]
cmp	r4,#0xD2
bhs	statsloopdone
add	r4,#2
b	statsloop
statsloopdone:

EndTrue:
mov	r0,#1

End:
pop	{r4-r7}
pop	{r1}
bx	r1

.align
.ltorg

maxLevel:
@WORD maxLevel
@WORD maxStats
@WORD levelHeal
