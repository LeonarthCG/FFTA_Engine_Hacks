.thumb
pop	{r3}
mov	r2,sp
push	{r3}
mov	r3,r2

@checking if the bit is set
ldrb	r1,[r0]		@ability ID
lsr	r6,r1,#3	@ability ID/8...
ldrb	r0,[r3,r6]	@gets us the byte the flag is on

mov	r6,#7
and	r6,r1		@ability ID%8...
mov	r2,#1
lsl	r2,r6		@gets us the right bit

and	r0,r2
cmp	r0,#0
beq	notSet
b	set

notSet:
@first of all, set the bit for future checks
lsr	r6,r1,#3	@ability ID/8...
ldrb	r0,[r3,r6]	@gets us the byte the flag goes on, again
orr	r0,r2		@we set it
strb	r0,[r3,r6]	@and store it

@and we go back to vanilla code
push	{r3}
ldr	r3,=#0x812FB4C
mov	lr,r3
pop	{r3}
pop	{r3}
.short	0xF800

set:
push	{r3}
ldr	r3,=#0x812FC56
mov	lr,r3
pop	{r3}
pop	{r3}
.short	0xF800
