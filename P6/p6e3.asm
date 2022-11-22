# Mapa de registos
# i = $t0
# j = $t1
# array[i] [j] = $t2
	.data
	.eqv printString, 4
	.eqv printChar, 11
	.eqv printInt, 1
	.eqv SIZE, 3
array: 	.word str1, str2, str3 
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3: 	.asciiz "ponteiros"
str4: 	.asciiz " \nString #"
str5: 	.asciiz ": "
	.text 
	.globl main
main:	
	li $t0,0
for: 	
	bge $t0,SIZE,endFor
	
	la $a0,str4
	li $v0,printString
	syscall
	
	move $a0, $t0
	li $v0,printInt
	syscall
	
	la $a0,str5
	li $v0,printString
	syscall 
	
	li $t1,0
	while: 	
		la $t2,array 
		sll $t3,$t0,2
		addu $t2,$t2,$t3
		lw $t2,0($t2)
		addu $t2,$t2,$t1
		lb $a0,0($t2)
		beq $a0,'\0',endWhile
		
		li $v0,printChar
		syscall
		
		li $a0,'-'
		li $v0,printChar
		syscall
		
		addiu $t1,$t1,1
		j while
	endWhile:
	
	addiu $t0,$t0,1
	j for
endFor:
	jr $ra
