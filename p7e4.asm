	.text
strcpy:
	move $t0,$a0 #dst
	move $t1,$a1 #src
do:
	lb $t2,0($t1) # $2 = *p
	sb $t2,0($t0) # *p = *src
	addiu $t0,$t0,1  # dst++
	addiu $t1,$t1,1  # src++
doWhile: bne $t2,'\0',do # while (src[i] != 0)
	move $v0,$a0 # valor de return da funçao
	jr $ra
	
strcat:
	addiu $sp,$sp,-4 # definir espaço para $ra
	sw $ra,0($sp) # guardar $ra na stack
	
	move $t5,$a0
	move $t3,$a0 # *p = dst
while:	lb $t2,0($t3)  # *p = char
	beq $t2,'\0',endWhile #while (*p != 0)
	addiu $t3,$t3,1 # p++
	j while
endWhile:
	move $a0,$t3 # argumento 1 
			#argumento 2 implicito
	jal strcpy # chamada a funçao
	
	move $v0,$t5
	lw $ra,0($sp) # retoma do $ra
	addiu $sp,$sp,4 # estabelece o valor inicial da stack
	jr $ra 
	
	.data
str1: 	.asciiz "Arquitetura de "
str2: 	.space 50
str3: 	.asciiz "\n"
str4:	.asciiz "Computadores I"
	.eqv printString,4
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str2 # 1 argumento de entrada da funçao  
	la $a1,str1 # 2 argumneto de entrda da funçao 
	jal strcpy # chamada á funçao
	
	move $a0,$v0 # print(strcpy)
	li $v0,printString
	syscall
	
	la $a0,str3
	li $v0,printString
	syscall
	
	la $a0,str2
	la $a1,str4
	jal strcat
	
	move $a0,$v0
	li $v0,printString
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	