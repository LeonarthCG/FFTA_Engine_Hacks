.equ nameOffset, NewToOldName+4
.equ newNameBuffer, nameOffset+4
.thumb
push	{r1-r7}
ldr	r0,[r2]
@if marche name in ram, use that
ldr	r1,=#0x2001F1C
cmp	r0,r1
beq	ramname
@if other name, get the corresponding unit data spot
ldr	r3,nameOffset
add	r3,r2
@and check if there is a name there
ldrb	r1,[r3,#0x00]
ldrb	r2,[r3,#0x01]
orr	r1,r2
cmp	r1,#0
beq	end
mov	r0,r3
b	decode

@if marche name spot, check if identifier present
ramname:
ldrh	r1,[r0]
ldr	r2,=#0xFFFF
cmp	r1,r2
bne	end
add	r0,#2
b	decode

@decode name
decode:
@r0 is source
ldr	r1,newNameBuffer @destination
ldr	r3,NewToOldName
mov	lr,r3
.short	0xF800
ldr	r0,newNameBuffer
b	end

@otherwise just do vanilla
end:
ldr	r1,=#0x80C8178
mov	lr,r1
pop	{r1-r7}
.short	0xF800
.align
.ltorg
NewToOldName:
