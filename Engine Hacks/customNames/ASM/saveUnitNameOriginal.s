.equ defaultUnit, newNameBuffer+4
.equ defaultName, defaultUnit+4
.equ autofillNickname, defaultName+4
.equ newNicknameBuffer, autofillNickname+4
.thumb
mov	r4,r7

@check if autofillingNickname
ldr	r0,autofillNickname
cmp	r0,#0
beq	nonickname
ldr	r0,newNicknameBuffer
ldr	r1,[r0]
cmp	r1,#0
beq	nonickname

@fill with nickname
ldr	r1,newNicknameBuffer
b	end

@check if ram name unit
nonickname:
ldr	r1,=#0x2016678
ldr	r1,[r1]
ldr	r1,[r1]
ldr	r2,=#0x2001F1C
cmp	r1,r2
beq	isramname

@original unit name
ldr	r0,=#0x2016678
ldr	r0,[r0]
ldr	r0,[r0]
b	end

isramname:
ldr	r0,=#0x812A64C
ldr	r0,[r0]
ldr	r1,defaultName
lsl	r1,#2
ldr	r1,[r0,r1]

end:
@return
mov	r0,r4
ldr	r3,=#0x812A610
mov	lr,r3
.short	0xF800
.align
.ltorg
newNameBuffer:
@WORD newNameBuffer
@WORD defaultUnit
@WORD defaultName
