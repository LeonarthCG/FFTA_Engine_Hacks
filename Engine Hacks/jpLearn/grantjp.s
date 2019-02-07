.thumb

push	{r0-r3}

@@grant 20%
@push	{r2}		@character pointer
@ldrh	r0,[r4,#4]
@mov	r1,#20		@% to get
@mul	r0,r1
@mov	r1,#100
@swi	#6		@20%
@pop	{r2}
@cmp	r0,#0
@bne	not0
@mov	r0,#1
@not0:
	
@@grant exp% of exp as jp
@push	{r2}		@character pointer
@ldrh	r0,[r4,#4]
@mov	r1,r0		@% to get
@mul	r0,r1
@mov	r1,#100
@swi	#6		@20%
@pop	{r2}
@add	r0,#1

@@grant 8 + exp/4 JP
@ldrh	r0,[r4,#4]
@lsr	r0,#2
@add	r0,#8

@grant exp as JP
ldrh	r0,[r4,#4]

mov	r1,#0xD6
ldrh	r3,[r2,r1]	@JP
add	r3,r0		@new JP
ldr	r0,=#9999
cmp	r3,r0
blo	not999
mov	r3,r0
not999:
strh	r3,[r2,r1]
pop	{r0-r3}

ldrh	r1,[r4,#4]
add	r1,r0
lsl	r1,#16
lsr	r2,r1,#16
asr	r1,#16

ldrh	r3,=#0x80A71A3
bx	r3
