.thumb
ldr	r3,=#0x814224C
mov	lr,r3
.short	0xF800

mov	r0,#1
ldr	r3,=#0x8002824
mov	lr,r3
.short	0xF800

@unlock default jobs
push	{r0-r7}
ldr	r0,newDefaultJobs
ldr	r7,=#0x2002AD0
defaultLoop:
ldrb	r1,[r0]		@job id
cmp	r1,#0
beq	endDefaultLoop
lsl	r2,r1,#0x10
lsr	r2,#0x13	@divide by 8
mov	r3,#1
divideDefault:
cmp	r1,#8
blo	dontDivideDefault
sub	r1,#8
b	divideDefault
dontDivideDefault:
lsl	r3,r1
ldrb	r1,[r7,r2]
orr	r1,r3
strb	r1,[r7,r2]
add	r0,#1
b	defaultLoop
endDefaultLoop:
pop	{r0-r7}

ldr	r3,=#0x800979E
mov	lr,r3
.short	0xF800
.align
.ltorg
newDefaultJobs:
