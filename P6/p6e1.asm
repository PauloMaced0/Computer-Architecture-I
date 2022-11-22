# Mapa de registos 
# i = $t0
	.data 
	.eqv printString,4
	.eqv printChar,11
	.eqv SIZE, 3
array: 	.word str1, str2, str3
str1: 	.asciiz "Array"
str2:	.asciiz "de"
str3: 	.asciiz "ponteiros"
	.text
	.globl main
main: 	
	li $t0,0 # i = 0
for: 
	bge $t0,SIZE,endFor # for(i=0; i < SIZE; i++)
	
	la $t1,array 	# $t1 = &array[0]
	sll $t2,$t0,2	# i * 4
	addu $t2,$t2,$t1 # $t2 = &array[i]
	
	lw $a0,0($t2) 
	li $v0,printString
	syscall # printString str1, str2, str3
	
	li $a0,'\n' 
	li $v0,printChar
	syscall 	# print '\n'
		
	addiu $t0,$t0,1 # i++
	j for
endFor:
	jr $ra