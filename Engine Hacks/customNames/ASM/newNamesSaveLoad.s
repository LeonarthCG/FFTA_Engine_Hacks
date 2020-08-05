.equ	NewToOldName, newNameBuffer+4
.thumb
pop	{r3}
push	{r4-r7,lr}
mov	r7,r10
mov	r6,r9
mov	r5,r8
push	{r5-r7}
push	{r0-r1,r3-r7}
@check that the identifier is set
ldrh	r3,[r2]
ldr	r0,=#0xFFFF
cmp	r3,r0
bne	end

@if the identifier is set, convert name
mov	r0,r2	@name to translate
add	r0,#2
ldr	r1,newNameBuffer
ldr	r3,NewToOldName
mov	lr,r3
.short	0xF800
ldr	r2,newNameBuffer

end:
ldr	r3,=#0x801511C
mov	lr,r3
pop	{r0-r1,r3-r7}
sub	sp,#0x30
.short	0xF800
.align
.ltorg
newNameBuffer:
