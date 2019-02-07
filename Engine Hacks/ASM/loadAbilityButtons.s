.equ AbilityButtons, PortraitPaletteTable+4

.thumb

pop	{r3}

ldrb	r1,[r2,#3]
orr	r0,r1
add	r0,r5,r0
mov	r1,r7

@check if there is a custom palette
push	{r1-r3}
@this checks if this is for the Action, Combo, etc button things
ldr	r2,=#0x807BDD5
mov	r1,lr
cmp	r1,r2
beq	abilitybuttons
ldr	r2,=#0x807BFA5
cmp	r1,r2
beq	abilitybuttons
	@might need to add lr checking if other routines conflict with this
	ldr	r2,=#0x83C5B25
	cmp	r0,r2
	beq	abilitybuttons
ldr	r1,PortraitPaletteTable
ldr	r2,=#0xFFFFFFFF
mov	r3,r8
lsl	r3,#2
ldr	r1,[r1,r3]
cmp	r1,r2
b	noPalette
mov	r0,r1
noPalette:
pop	{r1-r3}

push	{r3}
ldr	r3,=#0x80051C4
mov	lr,r3
pop	{r3}
.short	0xF800

End:
push	{r3}
ldr	r3,=#0x80053AA
mov	lr,r3
pop	{r3}
.short	0xF800

abilitybuttons:
ldr	r1,AbilityButtons
mov	r2,r8
lsl	r2,#2
ldr	r0,[r1,r2]
b	noPalette

.align
.ltorg
PortraitPaletteTable:
@POIN PortraitPaletteTable
@POIN AbilityButtons
