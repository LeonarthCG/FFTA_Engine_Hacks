.equ marcheswap, pointer+4
.equ montblancswap, marcheswap+4

.thumb

@check if L was pressed
cmp	r5,#0
beq	checkSelect

	@unset selection
	ldr	r2,=#0x2002FC4
	mov	r0,#0
	strb	r0,[r2]

mov	r0,#0x64
ldr	r3,=#0x8141540
mov	lr,r3
pop	{r3}
.short	0xF800
push	{r3}
ldr	r3,=#0x8073C48
mov	lr,r3
pop	{r3}
.short	0xF800

checkSelect:
push	{r0-r3}
ldr	r3,=#0x3000000
ldrh	r0,[r3,#2]
mov	r1,#0x2
and	r0,r1
cmp	r0,#2
bne	donteraseram
b	eraseram
donteraseram:
ldrh	r0,[r3,#2]
mov	r1,#0x4
and	r0,r1
cmp	r0,#0
bne	dontEnd
b	End
dontEnd:

@select has been pressed!
@check if marche is forbidden, if he is then check if the unit is marche
ldr	r0,marcheswap
cmp	r0,#0
bne	marcheallowed
ldr	r1,=#0x200FD40	@unit we are looking at
ldrb	r1,[r1]
ldr	r0,=#0x2000080
ldr	r2,=#0x108
mul	r1,r2
add	r0,r1		@pointer to this character
ldrb	r0,[r0,#4]	@character id
cmp	r0,#2
bne	marcheallowed
b	EndCant
marcheallowed:

@check if montblanc is forbidden, if he is then check if the unit is montblanc
ldr	r0,montblancswap
cmp	r0,#0
bne	montblancallowed
ldr	r1,=#0x200FD40	@unit we are looking at
ldrb	r1,[r1]
ldr	r0,=#0x2000080
ldr	r2,=#0x108
mul	r1,r2
add	r0,r1		@pointer to this character
ldrb	r0,[r0,#4]	@character id
cmp	r0,#8
bne	montblancallowed
b	EndCant
montblancallowed:

	@@check if sorting method is by number
	@ldr	r0,=#0x20020E5
	@ldrb	r0,[r0]
	@cmp	r0,#0
	@beq	dontEnd2
	@b	End
	@dontEnd2:
	
	@@check if sorting method is by number
	ldr	r0,=#0x20020E5
	mov	r1,#0
	strb	r1,[r0]
	@cmp	r0,#0
	@beq	dontEnd2
	@b	End
	@dontEnd2:
	
@we need to set last used order to by number and reorder everyone
ldr	r1,=#0x20020E4
mov	r0,#0x80
strb	r0,[r1]
ldr	r2,=#0x3002818
ldr	r1,[r2]
ldr	r3,=#0x9BA
add	r1,r3
ldr	r3,=#0x8072130
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8071378
mov	lr,r3
.short	0xF800
mov	r0,#0
ldr	r3,=#0x80725B8
mov	lr,r3
.short	0xF800

@check if the unit is the same as the one we already have
ldr	r2,=#0x2002FC4
ldrb	r2,[r2]
ldr	r1,=#0x200FD40	@unit we are looking at
ldrb	r1,[r1]
add	r1,#1
cmp	r2,r1
bne	dontworry
ldr	r2,=#0x2002FC4
mov	r0,#0
strb	r0,[r2]
b	eraseramding
dontworry:

@check if we already have a unit
ldr	r0,=#0x2002FC4
ldrb	r1,[r0]
cmp	r1,#0
beq	saveunit

@switch units!
sub	r1,#1
ldr	r2,=#0x200FD40	@unit we are looking at
ldrb	r2,[r2]
push	{r4,r5}
mov	r4,r1		@first unit selected
mov	r5,r2		@second unit selected

@copy first unit data into the first enemy slot
ldr	r0,=#0x2000080
ldr	r1,=#0x108
mul	r1,r4
add	r0,r1
ldr	r1,=#0x2002FC4
mov	r2,#0
copyunit1:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
ldr	r3,=#0x104
cmp	r2,r3
bhs	copyunit1done
add	r2,#4
b	copyunit1
copyunit1done:

@copy second unit data into the first unit slot
ldr	r0,=#0x2000080
ldr	r1,=#0x108
mul	r1,r5
add	r0,r1
ldr	r1,=#0x2000080
ldr	r2,=#0x108
mul	r2,r4
add	r1,r2
mov	r2,#0
copyunit2:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
ldr	r3,=#0x104
cmp	r2,r3
bhs	copyunit2done
add	r2,#4
b	copyunit2
copyunit2done:

@copy first unit data into the second unit slot
ldr	r0,=#0x2002FC4
ldr	r1,=#0x2000080
ldr	r2,=#0x108
mul	r2,r5
add	r1,r2
mov	r2,#0
copyunit3:
ldr	r3,[r0,r2]
str	r3,[r1,r2]
ldr	r3,=#0x104
cmp	r2,r3
bhs	copyunit3done
add	r2,#4
b	copyunit3
copyunit3done:

@clear ram
ldr	r0,=#0x2002FC4
mov	r1,#0
mov	r2,#0
ldr	r3,=#0x104
cleanramloop:
str	r1,[r0,r2]
cmp	r2,r3
bhs	cleanramloopdone
add	r2,#4
b	cleanramloop
cleanramloopdone:
cleanstars:
push	{r0-r5}
ldr	r4,pointer
ldr	r5,=#0x600618A
mov	r0,#0
mov	r1,#0
mov	r2,#0
cleanstarsloop:
ldrh	r1,[r4,r0]
strh	r2,[r5,r1]
add	r5,#10
strh	r2,[r5,r1]
sub	r5,#10
cmp	r0,#48
bhs	cleanstarsloopdone
add	r0,#2
b	cleanstarsloop
cleanstarsloopdone:
pop	{r0-r5}

@run sprites thing to reorder them
ldr	r0,=#0x8087B30
mov	lr,r0
mov	r0,#0xFF
.short	0xF800

@get the portrait to show up again
ldr	r3,=#0x3002818
ldr	r0,[r3]
ldr	r2,=#0x451
add	r2,r0
mov	r0,#0xFF
strb	r0,[r2]

ldr	r0,=#0x8141540
mov	lr,r0
mov	r0,#0x72
.short	0xF800

pop	{r4,r5}
b	End

@save unit to ram
saveunit:
ldr	r0,=#0x2002FC4	@first enemy on ram
ldr	r1,=#0x200FD40	@unit we are looking at
ldrb	r1,[r1]
add	r1,#1		@+1 so we can tell it apart from null
strb	r1,[r0]
@draw the stars
ldr	r1,=#0x200FD40	@unit we are looking at
ldrb	r3,[r1]
ldr	r2,=#0x200FD72	@list of the units, we need to find out what entry this unit is on this list
mov	r0,#0
loopindex:
ldrb	r1,[r2,r0]
cmp	r1,r3
beq	doneloopindex
add	r0,#1
b	loopindex
doneloopindex:
mov	r1,r0
ldr	r0,pointer
lsl	r1,#1
ldrh	r0,[r0,r1]
ldr	r1,=#0x600618A
ldr	r2,=#0xD090
add	r0,r1
strh	r2,[r0]
strh	r2,[r0,#10]

ldr	r0,=#0x8141540
mov	lr,r0
mov	r0,#0x64
.short	0xF800

b	End

End:
ldr	r3,=#0x8073C78
mov	lr,r3
pop	{r0-r3}
pop	{r3}
.short	0xF800

eraseram:
push	{r0-r3}
ldr	r0,=#0x2002FC4
mov	r1,#0
mov	r2,#0
ldr	r3,=#0x104
cleanramloop2:
str	r1,[r0,r2]
cmp	r2,r3
bhs	cleanramloopdone2
add	r2,#4
b	cleanramloop2
cleanramloopdone2:
pop	{r0-r3}
cleanstars2:
push	{r0-r5}
ldr	r4,pointer
ldr	r5,=#0x600618A
mov	r0,#0
mov	r1,#0
mov	r2,#0
cleanstarsloop2:
ldrh	r1,[r4,r0]
strh	r2,[r5,r1]
add	r5,#10
strh	r2,[r5,r1]
sub	r5,#10
cmp	r0,#48
bhs	cleanstarsloopdone2
add	r0,#2
b	cleanstarsloop2
cleanstarsloopdone2:
pop	{r0-r5}

b	End

EndCant:
ldr	r0,=#0x8141540
mov	lr,r0
mov	r0,#0x6A
.short	0xF800
b	End

eraseramding:
ldr	r0,=#0x8141540
mov	lr,r0
mov	r0,#0x68
.short	0xF800
b	eraseram


.align
.ltorg

pointer:
@POIN pointer
@WORD marcheswap
@WORD montblancswap
