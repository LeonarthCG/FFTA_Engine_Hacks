.thumb
ldrh	r0,[r7,#0x1A]
mov	r4,#0
cmp	r0,#0
bne	not0
mov	r0,#1
strh	r0,[r7,#0x1A]

not0:
strh	r0,[r7,#0x18]
ldrh	r0,[r7,#0x1E]
strh	r0,[r7,#0x1C]

End:
ldrh	r0,=#0x80C9AA6
mov	lr,r0
mov	r0,r7
mov	r1,r8
.short	0xF800
