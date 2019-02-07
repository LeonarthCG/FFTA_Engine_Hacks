.equ	newJobIconTable, highestJob+4
.thumb
push	{lr}
mov	r3,r8
push	{r3}
push	{r4-r7}
mov	r4,r0		@race
mov	r5,r1		@destination for tiles
mov	r6,r2		@destination for graphics
mov	r7,#2		@current job being checked
mov	r3,#0
mov	r8,r3		@ammount of icons drawn

checkJobLoop:
@check each job for race
mov	r1,#0x34
mul	r1,r7
ldr	r0,=#0x80C8598
ldr	r0,[r0]
add	r3,r1,r0
ldrb	r0,[r3,#4]
cmp	r0,r4
bne	nextCheckJobLoop
@check each job for being unlocked
mov	r0,r7
mov	r1,#8
swi	#6
mov	r2,r0
mov	r3,r1
ldr	r0,=#0x2001F70
add	r0,#0x10
ldrb	r0,[r0,r2]
mov	r1,#1
lsl	r1,r3
and	r0,r1
cmp	r0,#0
beq	nextCheckJobLoop
@check each job for being shown (second short on the job icon table)
ldr	r0,newJobIconTable
lsl	r1,r7,#3
add	r0,r1
ldrh	r1,[r0,#6]
cmp	r1,#0
beq	nextCheckJobLoop
@load the graphics
ldr	r0,=#0x2003CB0
mov	r1,r7
ldr	r3,=#0x80CB9E0
mov	lr,r3
.short	0xF800
ldr	r0,=#0x2003CB0
mov	r1,r6
mov	r2,#0x80
ldr	r3,=#0x814186C
mov	lr,r3
.short	0xF800
@figure out if the item can be equipped
@get item
ldr	r0,=#0x2002063
ldrb	r0,[r0]
cmp	r0,#2
beq	isShop
@get item id if party menu
mov	r0,#0
mov	r1,#0
mov	r2,#1
neg	r2,r2
ldr	r3,=#0x80876F4
mov	lr,r3
.short	0xF800
b	itemGot
@get item id if shop
isShop:
ldr	r0,=#0x200F428
ldr	r0,[r0]
ldr	r1,=#0x44EC
add	r0,r1
ldrh	r0,[r0]
itemGot:
mov	r1,r0
mov	r0,r7
ldr	r3,=#0x80CB5A8
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	checkShopPalette
mov	r0,#0xD
b	gotPalette
checkShopPalette:
ldr	r1,=#0x2002063
ldrb	r1,[r1]
cmp	r1,#2
bne	gotPalette
mov	r0,#7
gotPalette:
@now get the palette
ldr	r1,newJobIconTable
lsl	r2,r7,#3
add	r1,r2
ldrh	r1,[r1,#4]
add	r0,r1		@palette
lsl	r0,#0xC
@figure out tile number
mov	r1,#8
mov	r2,r8
mul	r1,r2
add	r0,r1
ldr	r3,=#0x2002063
ldrb	r3,[r3]
cmp	r3,#2
beq	shopTile
add	r0,#1		@tile attribute for this icon
b	gotTile
shopTile:
ldr	r3,=#0x180
add	r0,r3
gotTile:
@now do the actual drawing
mov	r1,#0
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
add	r0,#1
mov	r1,#0x40
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
add	r0,#1
add	r1,#2
strh	r0,[r5,r1]
nextIcon:
ldr	r0,=#256
add	r6,r0
mov	r0,r8
add	r0,#1
mov	r8,r0
mov	r1,#7
swi	#6
cmp	r1,#0
beq	wasSeventh
add	r5,#8
b	nextCheckJobLoop
wasSeventh:
add	r5,#0x90
nextCheckJobLoop:
ldr	r0,highestJob
cmp	r7,r0
bhs	End
add	r7,#1
b	checkJobLoop

End:
pop	{r4-r7}
pop	{r3}
mov	r8,r3
pop	{r0}
bx	r0

.align
.ltorg

highestJob:
@WORD highestJob
@POIN newJobIconTable
