.equ newNicknameBuffer, newIndexBuffer+4
.equ nameOffset, newNicknameBuffer+4
.equ nameCharacterLimit, nameOffset+4
.thumb
push	{r4-r5,lr}
push	{r1-r7}
@check if there is a unit being nicknamed
ldr	r4,newIndexBuffer
ldr	r4,[r4,#0x08]
cmp	r4,#0
beq	vanilla
@check if a nickname exists
ldr	r1,nameOffset
ldr	r0,[r4,r1]
cmp	r0,#0
beq	cleanloop
@check if unit has marche name
ldr	r0,[r4]
ldr	r1,=#0x2001F1C
cmp	r1,r0
beq	doramname
@copy the nickname to the nickname buffer
mov	r0,r4
mov	r1,#0
ldr	r3,=#0x80C7EA4	@get unit stat, 0 for name
mov	lr,r3
.short	0xF800
doramname:
mov	r1,r0
ldr	r0,newNicknameBuffer
ldr	r3,=#0x8018C24
mov	lr,r3
.short	0xF800
@clean the nickname
mov	r0,r4
ldr	r1,nameOffset
ldr	r2,nameCharacterLimit
mov	r3,#0
cleanloop:
strb	r3,[r0,r1]
add	r1,#1
sub	r2,#1
cmp	r2,#0
bne	cleanloop
@clean the name
ldr	r0,newNicknameBuffer
bl	cleanspaces
mov	r0,r4
pop	{r1-r7}
push	{r3}
ldr	r3,=#0x80C840E
mov	lr,r3
pop	{r3}
.short	0xF800

vanilla:
pop	{r1-r7}
lsl	r0,r0,#0x18
lsr	r3,r0,#0x18
cmp	r3,#0x01
bhi	goto80C83DC
b	goto80C840C

goto80C83DC:
push	{r3}
ldr	r3,=#0x80C83DC
mov	lr,r3
pop	{r3}
.short	0xF800

goto80C840C:
push	{r3}
ldr	r3,=#0x80C840C
mov	lr,r3
pop	{r3}
.short	0xF800

cleanspaces:
push	{r0-r7}
mov	r1,#0x20
ldr	r2,=#0x7340
spaceloop:
ldrh	r3,[r0,r1]
cmp	r3,#0
beq	nextspace
cmp	r3,r2
bne	endspace
nextspace:
mov	r3,#0
strh	r3,[r0,r1]
sub	r1,#2
cmp	r1,#0
bne	spaceloop
endspace:
pop	{r0-r7}
bx	lr

.align
.ltorg
newIndexBuffer:
