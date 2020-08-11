.thumb
ldr	r3,=#0x802D934
mov	lr,r3
.short	0xF800

ldr	r3,=#0x802D824
mov	lr,r3
.short	0xF800

ldr	r3,=#0x80D2F2C
mov	lr,r3
.short	0xF800

push	{r0-r7}
@for each unit, restore elemental resistances
ldr	r4,=#0x2000080	@start of party unit data
ldr	r5,=#0x2001940	@end of party unit data
ldr	r6,=#0x108	@size of entry
elementalunitloop:
mov	r0,#1
strb	r0,[r4,#0x0C]	@reset non-elemental resistance
mov	r7,#0x0D	@set counter, start with 0x0C as this is the offset of the first resistance
elementaloop:
@get the elemental resistance from the job
mov	r0,r4		@unit
add	r1,r7,#1	@elemental resistance getter
ldr	r3,=#0x80C92F0	@job data getter
mov	lr,r3
.short	0xF800
strb	r0,[r4,r7]	@store the resistance for this element
add	r7,#1		@increase counter
cmp	r7,#0x15
blo	elementaloop	@if last element, fall through
add	r4,r6
cmp	r4,r5
blo	elementalunitloop
pop	{r0-r7}		@if last unit, fall through

end:
ldr	r3,=#0x8123878
mov	lr,r3
.short	0xF800
