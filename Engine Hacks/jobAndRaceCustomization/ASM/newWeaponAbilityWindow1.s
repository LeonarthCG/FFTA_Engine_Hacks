.thumb

push	{lr}
push	{r0}
bl	thething
pop	{r0}
bl	mything
pop	{r0}
bx	r0

thething:
push	{lr}
push	{r4-r7}
mov	r7,r10
mov	r6,r9
mov	r5,r8
push	{r5-r7}
sub	sp,#0x4C
ldr	r1,=#0x808C63D
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
End:
add	sp,#4
pop	{r4-r7}
pop	{r0}
bx	r0
