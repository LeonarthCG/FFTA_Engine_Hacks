.thumb
push	{r4-r7}
mov	r4,r0		@item to check for
ldr	r5,=#0x2000080	@start of unit data
ldr	r6,=#0x2001940	@end of unit data
ldr	r7,=#0x108	@size of unit data entry
mov	r0,#0		@count

loop:
ldrh	r3,[r5,#0x2A]
cmp	r3,r4
bne	noMatch1
add	r0,#1
noMatch1:
ldrh	r3,[r5,#0x2C]
cmp	r3,r4
bne	noMatch2
add	r0,#1
noMatch2:
ldrh	r3,[r5,#0x2E]
cmp	r3,r4
bne	noMatch3
add	r0,#1
noMatch3:
ldrh	r3,[r5,#0x30]
cmp	r3,r4
bne	noMatch4
add	r0,#1
noMatch4:
ldrh	r3,[r5,#0x32]
cmp	r3,r4
bne	next
add	r0,#1

next:
add	r5,r7
cmp	r5,r6
blo	loop

end:
pop	{r4-r7}
bx	lr
