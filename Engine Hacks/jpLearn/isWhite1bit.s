.thumb

ldr	r3,=#0x3002818
push	{r2,r3}
ldr	r0,[r3]
ldr	r1,=#0x1BE4
add	r0,r1
mov	r1,r6
mov	r2,#0
ldr	r3,pointer
mov	lr,r3
mov	r3,#1
.short	0xF800
cmp	r0,#0
beq	False
b	True

False:
mov	r0,#0
b	End

True:
mov	r0,#0x80
b	End

End:
ldr	r3,=#0x807C50E
mov	lr,r3
pop	{r2,r3}
.short	0xF800

.align
.ltorg
pointer:
