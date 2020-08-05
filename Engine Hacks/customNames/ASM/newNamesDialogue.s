.equ	NewToOldName, newNameBuffer+4
.thumb
push	{r4-r5,lr}
mov	r4,r0
mov	r3,r4
cmp	r1,#0
beq	notarget
push	{r0-r7}
@check if using the new format
isname:
ldrh	r2,[r1,#0x00]
ldr	r0,=#0xFFFF
cmp	r2,r0
bne	notname

@translate new format to old format, copying it to the buffer
mov	r0,r1	@name to translate
add	r0,#2
ldr	r1,newNameBuffer
ldr	r3,NewToOldName
mov	lr,r3
.short	0xF800

end:
ldr	r3,=#0x8018C2E
mov	lr,r3
pop	{r0-r7}
ldr	r1,newNameBuffer
.short	0xF800

notarget:
push	{r3}
ldr	r3,=#0x8018C32
mov	lr,r3
pop	{r3}
.short	0xF800

notname:
ldr	r3,=#0x8018C2E
mov	lr,r3
pop	{r0-r7}
.short	0xF800

.align
.ltorg
newNameBuffer:
