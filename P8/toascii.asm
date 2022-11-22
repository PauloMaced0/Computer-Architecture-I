	.text
	.globl toascii
toascii: addi $a0,$a0,0x30
if:	ble $a0,0x39,endIf
	addiu $a0,$a0,7
	
endIf:	move $v0,$a0
	jr $ra
