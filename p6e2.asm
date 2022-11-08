#Mapa de registos
# **p = $t0
# **pUltimo = $t1
	.data
	.eqv printString,4
	.eqv printChar,11
	.eqv SIZE,3
array: 	.word str1, str2, str3
str1: 	.asciiz "Array"
str2: 	.asciiz "de"
str3: 	.asciiz "ponteiros"
	.text 
	.globl main
main: 	
	la $t0,array # $t0 = &array[0]
	 
	li $t1,SIZE 
	sll $t1,$t1,2
	
	addu $t1,$t1,$t0 # $t1 = SIZE + &array[0]
for:
	bge $t0,$t1,endFor # for( p < pultimo)
	
	lw $a0,0($t0)
	li $v0,printString
	syscall # printString str1, str2, str3
	
	li $a0,'\n'
	li $v0,printChar
	syscall # print '\n'
	
	addiu $t0,$t0,4 # p++
	j for
endFor:
	jr $ra