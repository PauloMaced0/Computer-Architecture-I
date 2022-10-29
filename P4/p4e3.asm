#Acesso com ponteiros
# p : $t0
# pultimo : $t1
# *p : $t2
# soma: $t3
	.data
array: 	.word 7692,23,5,234
	.eqv printInt,1
	.eqv SIZE, 4
	.text
	.globl main
main: 	
	li $t3,0 # soma = 0
	li $t4,4 
	sub $t4,$t4,1 # $t4 = 3
	sll $t4, $t4, 2 # $t4 = 3*4
	la $t0, array # p= array
	addu $t1,$t0,$t4 # pultimo = array(p) + SIZE - 1
	
while:
	bgt $t0,$t1,endWhile # while(p <= pultimo)
	lw $t2,0($t0) # $t2 = *p
	add $t3,$t3,$t2 # soma = soma + *p
	addiu $t0,$t0,4 # p++
	j while
endWhile:
	move $a0, $t3
	li $v0, printInt
	syscall
	jr $ra	