.thumb

ldr	r3,=#9999
cmp	r0,r3
ble	End
mov	r0,r3

End:
strh	r0,[r2]
ldr	r3,=#0x081330F1
bx	r3
