.thumb

mov	r3,#1
@check if there is an entry on the table
push	{r0-r3}
ldr	r3,pointer
lsl	r2,#2
ldr	r2,[r3,r2]
cmp	r2,#0
beq	EndVanilla

mov	r0,#0
loop:
ldr	r3,[r2,r0]
str	r3,[r1,r0]
add	r0,#4
cmp	r0,#0x60
bhs	End
b	loop

End:
pop	{r0-r3}
ldr	r3,=#0x80CB91E
mov	lr,r3
.short	0xF800

EndVanilla:
ldr	r3,=#0x8005318
mov	lr,r3
pop	{r0-r3}
.short	0xF800
ldr	r3,=#0x80CB91E
mov	lr,r3
.short	0xF800

.align
.ltorg
pointer:
