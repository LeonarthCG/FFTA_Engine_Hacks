.equ newCharacterTileBuffer, newNameBuffer+4
.equ autofillName, newCharacterTileBuffer+4
.equ defaultName, autofillName+4
.equ newIndexBuffer, defaultName+4
.equ newNicknameBuffer, newIndexBuffer+4
.equ nameOffset, newNicknameBuffer+4
.equ autofillName, nameOffset+4
.equ autofillNickname, autofillName+4
.thumb
pop	{r3}
push	{r0-r3}

ldr	r0,newNameBuffer
mov	r1,#0x40
bl	clean

ldr	r0,newCharacterTileBuffer
ldr	r1,=#0x600
bl	clean

@check if autofill is on
ldr	r0,autofillName
cmp	r0,#0
beq	autofillDone

@check if clan
ldrb	r0,[r6,#0x06]
cmp	r0,#0
beq	clanName
b	unitName

clanName:
ldr	r1,=#0x20021A0
b	copyName

unitName:
bl	getNicknameUnit
cmp	r0,#0
beq	autofillDone
mov	r1,r0
b	copyName

copyName:
ldr	r0,newNameBuffer @destination
@r1 is source
ldr	r3,=#0x8018C24
mov	lr,r3
.short	0xF800

autofillDone:
pop	{r0-r3}

mov	r2,#0xC0
lsl	r2,#2
add	r1,r6,r2
ldr	r0,newCharacterTileBuffer
str	r0,[r1]
mov	r0,#0xF0
ldr	r3,=#0x812A181
bx	r3

clean:
add	r1,r0
mov	r2,#0
cleanloop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
blo	cleanloop
bx	lr

getNicknameUnit:
push	{lr}
push	{r1-r7}
@check if there is a unit being nicknamed
ldr	r0,newIndexBuffer
ldr	r4,[r0,#0x08]
cmp	r4,#0
beq	marche
@check if nickname filling is active
ldr	r1,autofillNickname
cmp	r1,#0
beq	nonickname
@check if the unit has a nickname
ldr	r1,newNicknameBuffer
ldr	r1,[r1]
cmp	r1,#0
beq	nonickname
@get the nickname
ldr	r0,newNicknameBuffer
b	endfill
@check if name filling is active
nonickname:
ldr	r1,autofillName
cmp	r1,#0
beq	noname
ldr	r0,[r4]
b	endfill
@check if marche name
noname:
mov	r0,#0
ldr	r2,[r4]
ldr	r1,=#0x2001F1C
cmp	r2,r1
beq	marche
endfill:
pop	{r1-r7}
pop	{r1}
bx	r1

marche:
ldr	r0,=#0x812A64C
ldr	r0,[r0]
ldr	r1,defaultName
lsl	r1,#2
ldr	r1,[r0,r1]
ldr	r0,newNameBuffer
@r1 is source
ldr	r3,=#0x8018C24
mov	lr,r3
.short	0xF800
mov	r0,#0
pop	{r1-r7}
pop	{r1}
bx	r1

.align
.ltorg
newNameBuffer:
