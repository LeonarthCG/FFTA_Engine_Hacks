.thumb

push	{r0,r4-r7}
sub	r0,#2
mov	r4,r0
ldrb	r1,[r4,#1]
add	r1,#1
strb	r1,[r4,#1]
mov	r0,r4
add	r0,#0x20
ldrh	r0,[r0]
@check if 0 jobs if so do nothing?
mov	r0,r4
add	r0,#0x20
ldrh	r0,[r0]
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
@otherwise check ammount of jobs I guess and compare to how many we displayed
ldrb	r0,[r4]
cmp	r0,#2
beq	alreadystarted
mov	r0,#1
strb	r0,[r4,#8]
mov	r1,#2
strb	r1,[r4]
mov	r1,#1
strb	r1,[r4,#1]
b	draws
alreadystarted:
ldrb	r0,[r6]
cmp	r0,#3
bls	dontdraws
next3:
ldrb	r0,[r4,#8]
add	r0,#3
ldrb	r2,[r6]
cmp	r0,r2
bls	stores
mov	r0,#1
stores:
strb	r0,[r4,#8]
draws:
mov	r0,r4
add	r0,#0x20
ldrh	r0,[r0]
ldrb	r1,[r4,#8]
push	{r5-r7}
ldr	r5,[r4]
ldr	r6,[r4,#4]
ldr	r7,[r4,#8]
bl	mything
str	r5,[r4]
str	r6,[r4,#4]
str	r7,[r4,#8]
pop	{r5-r7}
dontdraws:
pop	{r0,r4-r7}
ldr	r1,=#0x808CBAF
bx	r1

mything:
push	{lr}
push	{r4-r7}
sub	sp,#4
mov	r4,r0		@item ID
mov	r7,r1

@clean the tiles, except for item name and ability type
ldr	r0,=#0x600E460
ldr	r1,=#0x600EFA0
mov	r2,#0
cleanloop1:
str	r2,[r0]
add	r0,#4
cmp	r0,r1
bhs	cleanloop1stop
b	cleanloop1
cleanloop1stop:

@get pointer to item abilities entry
mov	r0,r4
mov	r1,#0x12
ldr	r3,=#0x80CA7A4
mov	lr,r3
.short	0xF800
@r0 item abilities id
mov	r1,#20
mul	r0,r1
ldr	r1,=#0x808C8FC
ldr	r1,[r1]			@item abilities table
add	r0,r1
mov	r6,r0			@pointer to the abilities

@draw the ability names
push	{r7}
sub	sp,#4
mov	r5,#1
abilityNames:

@draw the text for the abilities
mov	r0,#1
str	r0,[sp]
@get text
lsl	r0,r7,#1
add	r0,r6
ldrb	r2,[r0]
cmp	r2,#0
beq	nextabilitiesnametrampoline
cmp	r2,#1
beq	nextabilitiesnametrampoline
cmp	r2,#0xFF
beq	nextabilitiesnametrampoline
b	skipnextabilitiesnametrampoline
nextabilitiesnametrampoline:
b	nextabilitiesname
skipnextabilitiesnametrampoline:
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
ldr	r3,=#0x2C0
mul	r3,r5
ldr	r1,=#0x600E1A0
add	r1,r3
@routine call
ldr	r3,=#0x8015110
mov	lr,r3
mov	r3,#1
.short	0xF800
nextabilitiesname:
ldrb	r0,[r6]
cmp	r7,r0
bhs	stopabilitiesname
cmp	r5,#3
bhs	stopabilitiesname
add	r7,#1
add	r5,#1
b	abilityNames
stopabilitiesname:
add	sp,#4
pop	{r7}

@erase JP symbol and cost
ldr	r0,=#0x6006040
ldrh	r0,[r0]
ldr	r1,=#0xB00D
cmp	r0,r1
beq	erasejpleft

erasejpright:
ldr	r0,=#0x600526E
b	erasejp

erasejpleft:
ldr	r0,=#0x600524C
b	erasejp

erasejp:
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

@draw the abilities
mov	r5,#1
abilities:

@draw the icons
ldr	r0,=#0x2003CB0
lsl	r1,r7,#1
add	r1,r6
ldrb	r1,[r1]
cmp	r1,#0
beq	nextabilitiestrampoline
cmp	r1,#1
beq	nextabilitiestrampoline
cmp	r1,#0xFF
beq	nextabilitiestrampoline
b	skipnextabilitiestrampoline
nextabilitiestrampoline:
b	nextabilities
skipnextabilitiestrampoline:
ldr	r3,=#0x80CB9E0
mov	lr,r3
.short	0xF800
ldr	r0,=#0x2003CB0
ldr	r2,=#0x100
mul	r2,r5
ldr	r1,=#0x600EBA0
add	r1,r2
mov	r2,#0x80
ldr	r3,=#0x814186C
mov	lr,r3
.short	0xF800
lsl	r0,r7,#1
add	r0,r6
ldrb	r0,[r0]
ldr	r3,=#0x80CBA14
mov	lr,r3
.short	0xF800
mov	r1,r0
lsl	r1,#12
ldr	r0,=#0x6006040
ldrh	r0,[r0]
ldr	r2,=#0xB00D
cmp	r0,r2
beq	drawiconleft
drawiconright:
ldr	r0,=#0x6005124
b	drawicon
drawiconleft:
ldr	r0,=#0x6005102
b	drawicon
drawicon:
ldr	r2,=0x100
mul	r2,r5
add	r0,r2
ldr	r2,=#0x35D
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

@draw the AP/JP icon
ldr	r0,=#0x6006040
ldrh	r0,[r0]
ldr	r2,=#0xB00D
cmp	r0,r2
beq	drawjpiconleft
drawjpiconright:
ldr	r0,=#0x600516E
b	drawjpicon
drawjpiconleft:
ldr	r0,=#0x600514C
b	drawjpicon
drawjpicon:
ldr	r1,=#0x808C900
ldr	r1,[r1]
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
ldr	r1,=#1000
cmp	r0,r1
bne	not999
ldr	r0,=#999
not999:
@ldr	r1,=#10000
@cmp	r0,r1
@blo	not9999
@ldr	r0,=#9999
@not9999:
push	{r4-r7}
mov	r7,r0		@cost

ldr	r0,=#0x6006040
ldrh	r0,[r0]
ldr	r1,=#0xB00D
cmp	r0,r1
beq	drawjpleft
drawjpright:
ldr	r0,=#0x600516E
b	drawjp
drawjpleft:
ldr	r0,=#0x600514C
b	drawjp
drawjp:
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
