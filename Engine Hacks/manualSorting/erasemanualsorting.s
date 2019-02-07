.thumb

@check if we should erase
pop	{r3}
push	{r0-r3}

ldrh	r0,[r5,#2]
mov	r1,#0xB
and	r0,r1
cmp	r0,#0
beq	End

@erase some tiles
@check if upper or lower section
ldr	r0,=#0x200FD43
ldrb	r1,[r0]
mov	r0,#0xC
and	r1,r0
ldr	r0,=#0x6005050
cmp	r1,#0
beq	uppererase
ldr	r0,=#0x6005490
uppererase:
mov	r1,#0
mov	r2,#0
erase:
str	r1,[r0,r2]
add	r2,#4
cmp	r2,#0x2C
bhs	erasestop
b	erase
erasestop:

	@@if not sorting by number, clear ram
	@push	{r0-r3}
	@ldr	r0,=#0x2002FC4
	@mov	r1,#0
	@mov	r2,#0
	@ldr	r3,=#0x104
	@cleanramloop:
	@str	r1,[r0,r2]
	@cmp	r2,r3
	@bhs	cleanramloopdone
	@add	r2,#4
	@b	cleanramloop
	@cleanramloopdone:
	@pop	{r0-r3}
cleanstars:
push	{r0-r5}
ldr	r4,pointer
ldr	r5,=#0x600618A
mov	r0,#0
mov	r1,#0
mov	r2,#0
cleanstarsloop:
ldrh	r1,[r4,r0]
strh	r2,[r5,r1]
add	r5,#10
strh	r2,[r5,r1]
sub	r5,#10
cmp	r0,#48
bhs	cleanstarsloopdone
add	r0,#2
b	cleanstarsloop
cleanstarsloopdone:
pop	{r0-r5}

End:
pop	{r0-r3}
ldrh	r1,[r5,#2]
mov	r0,#1
and	r0,r1
cmp	r0,#0
bne	end1
b	end2

end1:
push	{r3}
ldr	r3,=#0x80739C0
mov	lr,r3
pop	{r3}
.short	0xF800

end2:
push	{r3}
ldr	r3,=#0x8073AC8
mov	lr,r3
pop	{r3}
.short	0xF800

.align
.ltorg

pointer:
