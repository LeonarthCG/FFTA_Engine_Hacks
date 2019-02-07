.thumb
mov	r5,#0x1A
loop:
add	r5,#1
mov	r0,r6
mov	r1,r5
.short	0xF7FF		@bl	0x8132CB8 part 1
.short	0xFE3A		@bl	0x8132CB8 part 2
lsl	r0,#0x18
cmp	r0,#0
.short	0xD13D		@bne	0x81330C6
cmp	r5,#0x1D
.short	0xD03B		@beq	0x81330C6
b	loop
