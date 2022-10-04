	.data
	#.eqv value,0x12345678
	.eqv value,0x862A5C1B
	.eqv shift_amount, 1 
	#.eqv shift_amount, 2
	#.eqv shift_amount, 4
	#.eqv shift_amount, 16
	.eqv binary, 2
	.eqv gray,3
	.text
	.globl main
main: 	li $t0,value # $t0 = value 
	sll $t2,$t0,shift_amount # shift left logical de shift amount vezes
	srl $t3,$t0,shift_amount # shift right logical de shift amount vezes
	sra $t4,$t0,shift_amount # shift right arithmetic de shift amount vezes
	
	
	#BINARIO PARA CODIGO DE GRAY
	li $t0,binary		# Guarda o valor em $t0
	srl $t1,$t0,shift_amount# shift right logical 1 vez e armazena em $t1
	xor $t1,$t1,$t0 # armazena o codigo de gray em $t1
	
	#CODIGO DE GRAY PARA BINARIO
	li $t0,gray	# $t0 = codigo de gray
	srl $t1,$t0,4	# shift right logical de 4 posiçoes sobre o conteudo de $t0 e armazenado em $t1
	xor $t1,$t1,$t0 # $t1 = $t1 ^ $t0
	or $t2,$0,$t1	# armazenar o conteudo de $t1 em $t2
	srl $t1,$t1,2	# shift right logical de 2 posiçoes sobre o conteudo de $t1 e armazenado em $t1
	xor $t1,$t1,$t2	# $t1 = $t1 ^ $t2
	or $t2,$0,$t1	# armazenar o conteudo de $t1 em $t2
	srl $t1,$t1,1	# shift right logical de 1 posiçoes sobre o conteudo de $t1 e armazenado em $t1
	xor $t1,$t1,$t2	# $t1 = $t1 ^ $t2
	jr $ra
	