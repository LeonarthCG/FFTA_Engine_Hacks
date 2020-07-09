.thumb

ldr	r0,[sp,#0x13C]
mov	r2,r4
ldr	r3,=#0x802AB64
mov	lr,r3
ldr	r3,[sp,#0x12C]
.short	0xF800

mything:
push	{r0-r7}
mov	r4,r6
@get pointer to item abilities
ldrh	r0,[r4,#4]
mov	r1,#0x12
ldr	r3,=#0x80CA7A4
mov	lr,r3
.short	0xF800
mov	r1,#20
mul	r0,r1
ldr	r1,=#0x808C8FC
ldr	r1,[r1]			@item abilities table
add	r0,r1
mov	r6,r0			@pointer to the abilities
@check if first draw
ldrb	r0,[r4,#1]
cmp	r0,#0
bne	notfirst
mov	r0,#1
strb	r0,[r4,#1]
b	draw
notfirst:
ldrb	r0,[r6]
cmp	r0,#3
bls	dontdraw
ldrb	r1,[r4,#1]
add	r1,#3
cmp	r1,r0
bls	store
mov	r1,#1
store:
strb	r1,[r4,#1]
draw:
bl	dodraw
dontdraw:
pop	{r0-r7}
ldr	r3,=#0x806FA73
bx	r3

dodraw:
push	{lr}
push	{r4-r7}
sub	sp,#4

@clean the tiles, except for item name and ability type
ldr	r0,=#0x600B340
ldr	r1,=#0x600C000
mov	r2,#0
cleanloop1:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
bhs	cleanloop1stop
b	cleanloop1
cleanloop1stop:

@erase JP symbol and cost
ldr	r0,=#0x6005A6C
mov	r1,#0
mov	r2,#0
ldr	r3,=#0x100
erasejploop:
strh	r1,[r0]
strh	r1,[r0,#2]
strh	r1,[r0,#4]
strh	r1,[r0,#6]
strh	r1,[r0,#8]
strh	r1,[r0,#10]
add	r2,#1
add	r0,r3
cmp	r2,#3
bhs	stoperasejploop
b	erasejploop
stoperasejploop:

@draw ability name bg data
ldr	r0,=#0x60059A2
ldr	r1,=#0xB19A
mov	r2,#0
bignameloop:
mov	r3,#0
nameloop:
strh	r1,[r0,r3]
add	r1,#1
add	r3,#0x40
strh	r1,[r0,r3]
add	r1,#1
sub	r3,#0x40
add	r3,#2
cmp	r3,#24
bhs	stopnameloop
b	nameloop
stopnameloop:
add	r0,#0xC0
add	r0,#0x40
add	r1,#2
add	r2,#1
cmp	r2,#3
bhs	stopbignameloop
b	bignameloop
stopbignameloop:

@draw ability stuff
ldrb	r7,[r4,#1]	@current ability
mov	r5,#1		@loop counter
abilities:

@draw the text for the abilities
mov	r0,#1
str	r0,[sp]
@get text
lsl	r0,r7,#1
add	r0,r6
ldrb	r2,[r0]
cmp	r2,#0
beq	nextabilitiestrampoline
cmp	r2,#1
beq	nextabilitiestrampoline
cmp	r2,#0xFF
beq	nextabilitiestrampoline
b	skipnextabilitiestrampoline
nextabilitiestrampoline:
b	nextabilities
skipnextabilitiestrampoline:
bl	getAbility
ldrh	r0,[r0]		@name id
lsl	r0,#2
ldr	r1,=#0x808C8E8
ldr	r1,[r1]
ldr	r2,[r0,r1]	@pointer to name
@buffer
ldr	r0,=#0x200FA44
@r2 is pointer to text
@destination
ldr	r3,=#0x340
mul	r3,r5
ldr	r1,=#0x600B000
add	r1,r3
@routine call
ldr	r3,=#0x8015110
mov	lr,r3
mov	r3,#1
.short	0xF800

@draw the AP/JP icon
ldr	r0,=#0x600596C
ldr	r1,=#0x806FCEC
ldr	r1,[r1]
ldr	r2,=#0x806FFC6
ldrb	r2,[r2]
cmp	r2,#0xF
bls	noissuejp
mov	r2,#0xD
noissuejp:
lsl	r2,#12
orr	r1,r2
ldr	r2,=#0x100
mul	r2,r5
add	r0,r2
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]

@draw the AP/JP ammount
lsl	r0,r7,#1
add	r0,r6
bl	getAbility
ldrb	r1,[r0,#7]
lsl	r0,r1,#2
add	r0,r1
lsl	r0,#1
ldr	r1,=#999
cmp	r0,r1
bne	not999
mov	r0,r1
not999:
ldr	r1,=#9999
cmp	r0,r1
blo	not9999
mov	r0,r1
not9999:
push	{r4-r7}
mov	r7,r0		@cost
ldr	r0,=#0x600596C
ldr	r1,=#0x100
mul	r1,r5
add	r0,r1
mov	r6,r0		@location
ldr	r5,=#0xF01E	@base tile

@draw 1s
mov	r0,r7
mov	r1,#10
swi	#6
add	r1,r5
strh	r1,[r6,#10]
cmp	r7,#10
blo	donedrawjp

@draw 10s
mov	r0,r7
mov	r1,#10
swi	#6
mov	r1,#10
swi	#6
add	r1,r5
strh	r1,[r6,#8]
cmp	r7,#100
blo	donedrawjp

@draw 100s
mov	r0,r7
mov	r1,#100
swi	#6
mov	r1,#10
swi	#6
add	r1,r5
strh	r1,[r6,#6]
ldr	r0,=#1000
cmp	r7,r0
blo	donedrawjp

@draw 1000s
mov	r0,r7
ldr	r1,=#1000
swi	#6
add	r0,r5
strh	r0,[r6,#4]
ldr	r0,=#10000
cmp	r7,r0
blo	donedrawjp

donedrawjp:
pop	{r4-r7}

@load icon tiles
ldr	r0,=#0x3007CC0
lsl	r1,r7,#1
add	r1,r6
ldrb	r1,[r1]
ldr	r3,=#0x80CB9E0
mov	lr,r3
.short	0xF800
ldr	r0,=#0x3007CC0
ldr	r2,=#0x100
mul	r2,r5
ldr	r1,=#0x600BC00
add	r1,r2
mov	r2,#0x80
ldr	r3,=#0x814186C
mov	lr,r3
.short	0xF800

@draw the icon
lsl	r0,r7,#1
add	r0,r6
ldrb	r0,[r0]
ldr	r3,=#0x80CBA14
mov	lr,r3
.short	0xF800
mov	r1,r0
lsl	r1,#12
ldr	r0,=#0x6005922
ldr	r2,=0x100
mul	r2,r5
add	r0,r2
ldr	r2,=#0x1E0
mov	r3,#8
mul	r3,r5
add	r2,r3
orr	r1,r2
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]
add	r1,#1
strh	r1,[r0,#6]
add	r1,#1
add	r0,#0x40
strh	r1,[r0]
add	r1,#1
strh	r1,[r0,#2]
add	r1,#1
strh	r1,[r0,#4]
add	r1,#1
strh	r1,[r0,#6]

nextabilities:
ldrb	r0,[r6]
cmp	r7,r0
bhs	stopabilities
cmp	r5,#3
bhs	stopabilities
add	r7,#1
add	r5,#1
b	abilities
stopabilities:

End:
add	sp,#4
pop	{r4-r7}
pop	{r0}
bx	r0

getAbility:
push	{lr}
@get the job
ldrb	r2,[r0]
@get the race of the job
mov	r1,#0x34
mul	r2,r1
ldr	r1,=#0x80C8DE4
ldr	r1,[r1]			@job data table
add	r2,r1			@pointer to job
@get the ability of the job
ldrb	r1,[r0,#1]		@ability id
ldrb	r0,[r2,#4]		@race id
@get the entry of that ability in this race ability list
ldr	r3,=#0x80CD480
mov	lr,r3
.short	0xF800
pop	{r1}
bx	r1
