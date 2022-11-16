	.text
strlen: li $v0,0
while:	lb $t0,0($a0)
	addiu $a0,$a0,1
	beq $t0,'\0',endWhile
	addiu $v0,$v0,1
	j while 
endWhile: jr $ra

	.data
str:	.asciiz "Arquitetura de Computadores I"
	.eqv printInt,1
	.text
	.globl main
	
main:	addiu $sp,$sp,-4 # $sp - 4 
	sw $ra,0($sp) # salvaguarda de $ra
	la $a0,str # argumneto de entrada da funçao 
	
	jal strlen # chamda a funçao
	move $a0,$v0 # print int 
	li $v0,printInt
	syscall
	
	lw $ra,0($sp) # retomar o valor de $ra
	addiu $sp,$sp,4 # estabelecer valor da stack
	jr $ra