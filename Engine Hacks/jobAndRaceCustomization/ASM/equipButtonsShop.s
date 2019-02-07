.equ equipLR, equipRaces+4
.equ equipDraw, equipLR+4
.thumb

@check if there is only one race
ldr	r0,equipRaces
ldrb	r1,[r0]
cmp	r1,#0
beq	End
ldrb	r1,[r0,#1]
cmp	r1,#0
beq	End

@check if this is the first time we draw the list
ldr	r0,=#0x2001F70
ldrb	r1,[r0,#2]
cmp	r1,#0
beq	notFirst

@mark that we did this
ldr	r0,=#0x2001F70
mov	r1,#0
strb	r1,[r0,#2]

@first draw
@load L and R graphics
ldr	r0,equipLR
ldrh	r1,[r0,#2]
lsl	r1,#2
add	r0,#4
add	r0,r1
ldr	r2,=#0x600F000
mov	r3,r2
add	r2,r1
lrloop:
ldr	r1,[r0]
str	r1,[r2]
sub	r0,#4
sub	r2,#4
cmp	r2,r3
blo	stoplrloop
b	lrloop
stoplrloop:

@draw the buttons to the screen
ldr	r0,=#0x6005804
ldr	r1,=#0xD380
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]
add	r1,#1
add	r0,#0x40
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]
add	r1,#1
ldr	r0,=#0x6005832
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]
add	r1,#1
add	r0,#0x40
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]

@erase everything
bl	eraseEverything

@now get the race to draw the list for
ldr	r0,=#0x2001F70
ldrb	r0,[r0,#1]
@now draw the list
b	drawList

notFirst:
@check if L or R have been pressed
ldr	r0,=#0x3000000
ldrh	r0,[r0,#2]
ldr	r1,=#0x200
and	r1,r0
cmp	r1,#0
bne	LPress
ldr	r1,=#0x100
and	r1,r0
cmp	r1,#0
bne	RPress
b	End

LPress:
bl	eraseEverything
ldr	r0,=#0x2001F70
ldrb	r0,[r0,#1]
cmp	r0,#0
bne	noIssueL
bl	getListSize
b	drawList
noIssueL:
sub	r0,#1
b	drawList

RPress:
bl	eraseEverything
bl	getListSize
mov	r1,r0
ldr	r0,=#0x2001F70
ldrb	r0,[r0,#1]
cmp	r1,r0
bne	noIssueR
mov	r0,#0
b	drawList
noIssueR:
add	r0,#1
b	drawList

drawList:
@first set the new page
ldr	r1,=#0x2001F70
strb	r0,[r1,#1]
@get the race corresponding to the index
ldr	r1,equipRaces
ldrb	r0,[r1,r0]
@check if the race is the terminator, if so something went wrong, do not draw
cmp	r0,#0
beq	End
@now do the drawing
@r0 is the race
ldr	r1,=#0x6005882	@r1 where to draw to
ldr	r2,=#0x600B000	@r2 where to load graphics to
ldr	r3,equipDraw
mov	lr,r3
.short	0xF800

End:
ldr	r0,=#0x3000000
ldrh	r1,[r0,#2]
mov	r0,#3
and	r0,r1
cmp	r0,#0
bne	eraseLR
ldr	r3,=#0x806B19F
bx	r3

eraseLR:
ldr	r0,=#0x6005804
mov	r1,#0
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
add	r0,#0x40
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
ldr	r0,=#0x6005832
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
add	r0,#0x40
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
ldr	r3,=#0x806AFC7
bx	r3

eraseEverything:
ldr	r0,=#0x6005880
ldr	r1,=#0x6005CC0
mov	r2,#0
eraseLoop:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
blo	eraseLoop
bx	lr

getListSize:
ldr	r0,equipRaces
mov	r1,#0
getListSizeLoop:
ldrb	r2,[r0,r1]
cmp	r2,#0
beq	endGetListSizeLoop
add	r1,#1
b	getListSizeLoop
endGetListSizeLoop:
cmp	r1,#0
beq	noListSize
sub	r1,#1
noListSize:
mov	r0,r1
bx	lr


.align
.ltorg

equipRaces:
@POIN equipRaces
@POIN equipLR
@POIN equipDraw
