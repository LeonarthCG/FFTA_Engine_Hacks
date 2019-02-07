.thumb

@check if character
mov	r2,r8
ldrb	r2,[r2,#4]	@character
cmp	r2,#1
bls	job
mov	r3,#16
mul	r2,r3
ldr	r3,pointer
add	r3,r2		@pointer to our entry
add	r3,#8		@if character, add 8
b	load

@get job
job:
mov	r2,r8
ldrb	r2,[r2,#5]	@job
mov	r3,#16
mul	r2,r3
ldr	r3,pointer
add	r3,r2		@pointer to our entry
b	load

@check if vanilla
load:
ldr	r2,[r3,#4]
cmp	r2,#0
beq	vanilla

@set the palette
ldr	r0,[sp,#0x110]
sub	r0,#1
ldr	r1,[r3]
strb	r1,[r0]

@load the graphics
push	{r4}
ldr	r0,=#0x2003CB0	@destination
ldr	r1,[r3,#4]	@the graphics
mov	r2,#0		@counter
mov	r3,#0xA0	@size in words
lsl	r3,#2		@size in bytes
loop:
ldr	r4,[r1,r2]
str	r4,[r0,r2]
add	r2,#4
cmp	r2,r3
bhs	End
b	loop

End:
pop	{r4}
ldr	r3,=#0x8087D60
mov	lr,r3
.short	0xF800

vanilla:
lsl	r0,#1
add	r0,r1
ldrb	r2,[r0]
ldr	r0,=#0x8087D90
ldr	r0,[r0]
ldr	r3,=#0x8087D58
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
