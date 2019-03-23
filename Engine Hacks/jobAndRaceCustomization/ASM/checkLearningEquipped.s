.equ learnChance, learnJobs+4
.thumb

cmp	r4,#0
bne	nolearn

@rng roll, if false nolearn
ldr	r3,=#0x08002804	@get next rng
mov	lr,r3
.short	0xF800
mov	r1,#100
swi	#6
ldr	r0,learnChance
cmp	r1,r0
bhs	nolearn

@check if the unit has learn equipped, if so learn
ldr	r0,[r7]
ldr	r0,[r0]
ldr	r3,=#0x80CD50C
mov	lr,r3
.short	0xF800
cmp	r0,#0x0C
beq	learn

@check if the unit has learn as a passive, if so learn
ldr	r0,[r7]
ldr	r0,[r0]
ldrb	r0,[r0,#7]	@job id
ldr	r1,learnJobs
loop:
ldrb	r2,[r1]
cmp	r2,#0
beq	nolearn
cmp	r2,r0
beq	learn
add	r1,#1
b	loop

nolearn:
ldr	r3,=#0x80A7C10
mov	lr,r3
.short	0xF800

learn:
ldr	r3,=#0x80A7B98
mov	lr,r3
.short	0xF800

.align
.ltorg
learnJobs:
@POIN learnJobs
@WORD learnChance
