	.text
exchange: lb $t0,0($a0) 
	lb $t1,0($a1)   
	sb $t1,0($a0) # $t1 = $t0
	sb $t0,0($a1) # $t0 = $t1
	jr $ra
	
strrev:	addiu $sp,$sp,-16 # alocar espço na stack 
	sw $ra,0($sp) # salvaguarda das variaveis
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)

	move $s0,$a0 # Valor a devolver na funçao
	move $s1,$a0 # *p1 = $s1
	move $s2,$a0 # *p2 = $s2
while1:	lb $t0,0($s2)
	beq $t0,'\0',endWhile1 # while(p2 != 0)
	addiu $s2,$s2,1 # p2++
	j while1
endWhile1: 
	addiu $s2,$s2,-1 # p1--
while2: bge $s1,$s2,endWhile2 # while (p1 < p2)
	move $a0,$s1 # 1 argumento de entrada
	move $a1,$s2 # 2 argumento de entrada
	jal exchange # chamda a funçao
	addiu $s1,$s1,1 # p1++
	addiu $s2,$s2,-1 # p2--
	j while2
endWhile2:
	move $v0,$s0 # valor a devolver da funçao 
	lw $ra,0($sp) # retoma dos valores guardados
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,16($sp)
	addiu $sp,$sp,16 # estabelecer valor inicial da stack
	jr $ra
	
	.data
str: 	.asciiz "ITED - orievA ed edadisrevinU"
	.eqv printString,4
	.text
	.globl main
main:	la $a0,str # argumneto de entrda da funçao
	addiu $sp,$sp,-4 # definir espaço para guardar dados 
	sw $ra,0($sp) # salvaguarda de $ra
	jal strrev # chamda a funçao
	
	move $a0,$v0 # print rev string
	li $v0,printString
	syscall
	
	lw $ra,0($sp) # retoma do valor de $ra
	addiu $sp,$sp,4 # estabelecer valor inicial da stack
	jr $ra




