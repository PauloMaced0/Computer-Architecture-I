#Acesso indexado
# i : $t0
# array : $t1
# array + i : $t2
# array[i] : $t3
# soma: $t4
	.data
array: 	.word 7692,23,5,234
	.eqv printInt,1
	.eqv SIZE, 4
	.text
	.globl main
main: 	
	li $t0,0 # i = 0
	li $t4,0 # soma = 0
	la $t1,array # $t1 = &array[0]
		
while:	
	li $t5,SIZE # $t5 = 4
	sub $t5,$t5,1 # $t5 = 3
	sll $t5,$t5,2 # $t5 = 3*4
	bgt $t0,$t5,endWhile # while(i < 4)
	addu $t2,$t1,$t0 # $t2 = endereço inical($t2) + i($t0)
	lw $t3,0($t2) # $t3 = endereço de $t2
	add $t4,$t4,$t3 # soma = soma + str[i]
	addi $t0,$t0,4 # i++(i += 4) !!!inteiro 4 bytes
	j while
	
endWhile:
	move $a0, $t4
	li $v0, printInt
	syscall
	jr $ra	
