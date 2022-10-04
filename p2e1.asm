	.data
	#.eqv val_1,0x1234
	#.eqv val_2,0x000F
	#.eqv val_1,0x1234
	#.eqv val_2,0xF0F0
	.eqv val_1,0x5C1B
	.eqv val_2,0xA3E4
	.text
	.globl main
main:	ori $t0,$0,val_1 # $t0 = $v0 (operando 1)
	ori $t1,$0,val_2 #$t0 = $v0 (operando2)
	
	and $t2,$t0,$t1 # $t2 = $t0 & $t1
	or $t3,$t0,$t1 # $t3 = $t0 | $t1
	nor $t4,$t0,$t1 # $t4 = ~($t0 | $t1)
	xor $t5,$t0,$t1 # $t5 = $t0 ^ $t1
	
	#li $t0,0x0F1E
	#li $t0,0x0614
	li $t0,0xE543
	
	nor $t1,$t0,$0
	
	jr $ra #fim do programa
	
	
