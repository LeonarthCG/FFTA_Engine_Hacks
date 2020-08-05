.thumb
push	{lr}
push	{r4}
mov	r4,r0
mov	r0,#1
ldr	r1,nameCharacterLimit
ldr	r2,=#0x7340
loop:
ldrh	r3,[r4]
cmp	r3,r2
beq	blank
cmp	r3,#0
beq	blank
mov	r0,#0
b	end
blank:
add	r4,#2
sub	r1,#1
cmp	r1,#0
bne	loop
end:
pop	{r4}
pop	{r1}
bx	r1
.align
.ltorg
nameCharacterLimit:
