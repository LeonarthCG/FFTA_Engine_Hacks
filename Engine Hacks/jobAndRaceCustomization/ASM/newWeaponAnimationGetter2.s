.equ specialAnimationTable, weaponAnimationTable+4
.thumb

push	{lr}
push	{r4,r5}
mov	r5,r0
mov	r2,r1
ldr	r1,=#0x802102C
ldr	r1,[r1]		@animation table
lsl	r0,#2
add	r0,r1
ldr	r3,[r0]
mov	r0,#3

ldr	r4,=#0x7FF
cmp	r2,r4
bhi	custom
cmp	r2,#0xEC
bhs	special
b	regular
custom:
and	r2,r4
mov	r4,#0x54
ldr	r3,weaponAnimationTable
lsl	r5,#2
ldr	r3,[r3,r5]
and	r0,r2
sub	r2,r4
b	aftercustom
special:
and	r0,r2
sub	r2,#0xEC
ldr	r3,specialAnimationTable
lsl	r5,#2
ldr	r3,[r3,r5]
b	aftercustom
regular:
and	r0,r2
aftercustom:
cmp	r0,#2
bhi	goto8021030
cmp	r0,#1
blo	goto8021030

mov	r1,#4
neg	r1,r1
and	r1,r2
lsl	r0,r1,#1
add	r0,r1
lsl	r0,#1
add	r0,#0xC
mov	r2,#12
b	End

goto8021030:
mov	r1,#4
neg	r1,r1
and	r1,r2
lsl	r0,r1,#1
add	r0,r1
lsl	r0,#1
mov	r2,#0

End:
add	r0,r3
@if no animation, standing animation
ldr	r1,[r0]
cmp	r1,#0
bne	hasanimation
add	r0,r3,r2
hasanimation:
pop	{r4,r5}
pop	{r1}
bx	r1

.align
.ltorg

weaponAnimationTable:
@POIN weaponAnimationTable
@POIN specialAnimationTable
