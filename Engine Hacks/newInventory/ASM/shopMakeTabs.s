.equ checkEquippedAmmount, newItemTabs+4
.equ maxItem, checkEquippedAmmount+4
.equ listUselessEntries, maxItem+4
.thumb
sub	sp,#0x08
mov	r0,#0
mov	r1,sp
str	r0,[r1,#0x00]
str	r0,[r1,#0x04]
@for every item
mov	r4,#1
loop:
ldr	r0,maxItem
cmp	r4,r0
bhi	dotabs

@check if we own any copy of it
ldr	r2,=#0x2001940
ldrb	r0,[r2,r4]
cmp	r0,#0
beq	next

@check if any of them are free
ldr	r0,listUselessEntries
cmp	r0,#0
beq	isfree
mov	r0,r4
ldr	r3,checkEquippedAmmount
mov	lr,r3
.short	0xF800
ldr	r2,=#0x2001940
ldrb	r1,[r2,r4]
cmp	r0,r1
blo	isfree
b	next

@check which tab it belongs to
isfree:
ldr	r0,=#0x8079AEC
ldr	r0,[r0,#0x00]	@item table
lsl	r1,r4,#5
add	r0,r1
ldrb	r0,[r0,#0x08]
ldr	r1,newItemTabs
ldrb	r0,[r1,r0]
cmp	r0,#5
bhi	next

@check if tab matches
mov	r2,sp
ldrb	r1,[r2,r0]
cmp	r1,#0
bne	next

@set that tab to true
mov	r1,#1
strb	r1,[r2,r0]

@increase tab count
ldrb	r0,[r6,#0x07]
add	r0,r1
strb	r0,[r6,#0x07]

next:
add	r4,#1
b	loop

@make the tabs
dotabs:
mov	r2,sp
ldrb	r1,[r6,#0x07]
mov	r3,#0
tabloop:
cmp	r1,#0
beq	end
ldrb	r0,[r2,r3]
cmp	r0,#0
beq	nexttab
strb	r3,[r6,#0x01]
add	r6,#1
sub	r1,#1
nexttab:
add	r3,#1
b	tabloop

end:
add	sp,#0x14
pop	{r4-r7}
pop	{r0}
bx	r0
.align
.ltorg
newItemTabs:
