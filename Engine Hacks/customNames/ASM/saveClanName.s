.equ newNameBuffer, OldToNewName+4
.thumb
@save identifier
ldr	r1,=#0x20021A0
mov	r0,#0xFF
strb	r0,[r1,#0x00]
strb	r0,[r1,#0x01]

@store name
mov	r0,r5	@source
ldr	r1,=#0x20021A2 @destination
ldr	r3,OldToNewName
mov	lr,r3
.short	0xF800

@check if level is 0, if so set to 1
ldr	r0,=#0x20021B4
ldrh	r1,[r0,#0x00]
cmp	r1,#0x00
bne	end
mov	r1,#0x01
strh	r1,[r0,#0x00]

@return
end:
ldr	r3,=#0x812A6EC
mov	lr,r3
.short	0xF800
.align
.ltorg
OldToNewName:
@POIN OldToNewName
@WORD newNameBuffer
