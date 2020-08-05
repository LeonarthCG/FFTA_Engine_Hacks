.equ nameOffset, OldToNewName+4
.thumb
@check if ram name
ldr	r1,=#0x2016678
ldr	r1,[r1]
ldr	r1,[r1]
ldr	r2,=#0x2001F1C
cmp	r1,r2
bne	notramname
mov	r2,#0xFF
strb	r2,[r1]
strb	r2,[r1,#1]
add	r1,#2
@store the name
mov	r0,r7	@source
@r1 is destination
ldr	r3,OldToNewName
mov	lr,r3
.short	0xF800

@make the destination for name in unit data
notramname:
ldr	r1,=#0x2016678
ldr	r1,[r1]
ldr	r2,nameOffset
add	r1,r2
@store the name
mov	r0,r7	@source
@r1 is destination
ldr	r3,OldToNewName
mov	lr,r3
.short	0xF800

@return
end:
mov	r0,#0 @prevent "erase all save data" message
ldr	r3,=#0x812A65C
mov	lr,r3
.short	0xF800
.align
.ltorg
OldToNewName:
@POIN OldToNewName
@WORD nameOffset
