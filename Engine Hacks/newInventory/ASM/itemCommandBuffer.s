.thumb
push	{lr}

@check if this is an item command buffer
ldr	r3,=#0x203F000
cmp	r1, r3
beq	match
ldr	r3,=#0x203F800
cmp	r1, r3
bne	end

@if it is, load the original buffer location
match:
sub	r1, #0x10
ldr	r1, [r1, #0x00]

end:
sub	r1, #0x0C
ldr	r3,=#0x8006FCC
mov	lr,r3
.short	0xF800
pop	{r0}
bx	r0
