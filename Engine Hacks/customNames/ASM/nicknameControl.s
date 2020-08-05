.equ canRenameMain, nicknameButton+4
.equ canRenameSpecial, canRenameMain+4
.equ canRenameUniques, canRenameSpecial+4
.equ canRenameGenerics, canRenameUniques+4
.equ defaultUnit, canRenameGenerics+4
.equ newIndexBuffer, defaultUnit+4
.equ newNameBuffer, newIndexBuffer+4
.thumb
pop	{r3}
push	{r4-r7,lr}
mov	r7,r9
mov	r6,r8
push	{r6,r7}
sub	sp,#0x1C
mov	r7,r1
push	{r0-r7}

@check if returning from nicknaming
ldr	r0,newIndexBuffer
ldr	r1,[r0,#0x00]
ldr	r2,[r0,#0x04]
and	r1,r2
ldr	r2,=#0xFFFFFFFF
cmp	r1,r2
bne	notreturn
b	returning

returning:
@set the column and row
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r1,=#0x971
add	r0,r1
ldr	r1,newIndexBuffer
ldrb	r2,[r1,#0x0C]
ldrb	r3,[r1,#0x0D]
strb	r2,[r0,#0x00]
strb	r3,[r0,#0x01]
	@@check if we can set the mode
	@ldrb	r0,[r7]
	@cmp	r0,#3
	@bne	notreturn
	@@set the next mode
	@mov	r0,#4
	@strb	r0,[r7,#0x00]
	@mov	r0,#0
	@strb	r0,[r7,#0x01]
@check if we can clear ram yet
ldrb	r0,[r7]
cmp	r0,#3
bne	notreturn
@clean the ram
ldr	r0,newNameBuffer
ldr	r1,=#0x1000
mov	r2,#0
mov	r3,#0
cleanbuffers:
str	r3,[r0,r2]
add	r2,#4
cmp	r2,r1
bne	cleanbuffers
b	notreturn

@check if we are loading the party menu
notreturn:
ldrb	r0,[r7,#0x00]
cmp	r0,#0x00
bne	notstart
b	end

@check if we are in the menu the button will show up in
notstart:
ldrb	r0,[r7,#0x00]
cmp	r0,#0x09
bne	clearimage
ldrb	r0,[r7,#0x01]
cmp	r0,#0x02
beq	checkchar
b	clearimage

@check if the character is allowed to be nicknamed
checkchar:
@first check if the clan has ever been named, if not then nicknaming is not possible
ldr	r0,=#0x20021B4
ldrh	r0,[r0,#0x00]
cmp	r0,#0x00
beq	end
@get character data
ldr	r4,=#0x3002818
ldr	r4,[r4]
ldr	r0,=#0x1D0C
add	r4,r0
ldr	r4,[r4]
@check if main character, if so check if main character is allowed
ldr	r0,defaultUnit
ldrb	r1,[r4,#0x04]
cmp	r0,r1
bne	notdefault
ldr	r0,canRenameMain
cmp	r0,#0
bne	continuerename
b	end
@check if special character, if so check if special characters are allowed
notdefault:
ldrb	r1,[r4,#0x04]
cmp	r1,#2
blo	notspecial
ldr	r0,canRenameSpecial
cmp	r0,#0
bne	continuerename
b	end
@check if forced name, if so check if uniques are allowed
notspecial:
ldr	r0,=#0x106
ldrb	r0,[r4,r0]
cmp	r0,#1
bne	notunique
ldr	r0,canRenameUniques
cmp	r0,#0
bne	continuerename
b	end
@and finally check if generics are alowed
notunique:
ldr	r0,canRenameGenerics
cmp	r0,#0
bne	continuerename
b	end

@load the graphics for the nickname button
continuerename:
ldr	r0,nicknameButton
ldr	r1,=#0x600F800
ldr	r2,=#0x6010000
loadimageloop:
ldr	r3,[r0]
str	r3,[r1]
add	r0,#4
add	r1,#4
cmp	r1,r2
bne	loadimageloop
@and draw it
ldr	r0,=#0x600620E
ldr	r1,=#0xD3C0
mov	r2,#0
drawloop1:
strh	r1,[r0,r2]
add	r1,#1
add	r2,#2
cmp	r2,#20
bne	drawloop1
ldr	r0,=#0x600624E
mov	r2,#0
drawloop2:
strh	r1,[r0,r2]
add	r1,#1
add	r2,#2
cmp	r2,#20
bne	drawloop2
@if start is pressed, start nicknaming
ldr	r3,=#0x3000000
ldrh	r0,[r3,#2]
mov	r1,#0x08
and	r0,r1
cmp	r0,#0
beq	end
@set next event to load
mov	r0,#3
ldr	r3,=#0x8009AFC
mov	lr,r3
.short	0xF800
@save the index for the return
ldr	r1,newIndexBuffer
ldr	r0,=#0xFFFFFFFF
str	r0,[r1,#0x00]
str	r0,[r1,#0x04]
mov	r0,#0
str	r0,[r1,#0x08]
str	r0,[r1,#0x0C]
ldr	r0,=#0x3002818
ldr	r0,[r0]
ldr	r2,=#0x971
ldrb	r3,[r0,r2] @column
strb	r3,[r1,#0x0C]
add	r2,#1
ldrb	r3,[r0,r2]
strb	r3,[r1,#0x0D] @row
@mark unit as being in the renaming process
ldr	r0,newIndexBuffer
str	r4,[r0,#0x08]
@set next mode
ldr	r0,=#0x30034B8
ldr	r0,[r0]
mov	r1,#0x02
strh	r1,[r0,#0x04]
@force mode reset
ldr	r0,=#0x30027D0
mov	r1,#1
strb	r1,[r0]
mov	r1,#0xFD
strb	r1,[r0,#1]
@play sound
ldr	r0,=#0x8141540
mov	lr,r0
mov	r0,#0x64
.short	0xF800
b	end

@check if the graphics should be cleared
clearimage:
ldrb	r0,[r7,#1]
cmp	r0,#0x22
beq	doclear
cmp	r0,#0x1A
beq	doclear
b	end
@clear the graphics for the nickname button
doclear:
ldr	r1,=#0x600F800
ldr	r2,=#0x6010000
mov	r3,#0
clearimageloop:
str	r3,[r1]
add	r1,#4
cmp	r1,r2
bne	clearimageloop
@clear the map as well
ldr	r0,=#0x600620E
mov	r1,#0
mov	r2,#0
drawloop3:
strh	r1,[r0,r2]
add	r2,#2
cmp	r2,#20
bne	drawloop3
ldr	r0,=#0x600624E
mov	r2,#0
drawloop4:
strh	r1,[r0,r2]
add	r2,#2
cmp	r2,#20
bne	drawloop4
b	end

end:
ldr	r3,=#0x8073710
mov	lr,r3
pop	{r0-r7}
.short	0xF800

.align
.ltorg
nicknameButton:
