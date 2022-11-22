# p = $t0
# *p = $t1
# lista + Size = $t2
	.data
str1: 	.asciiz "; "
str2: 	.asciiz "\n Conteudo do array:\n"
lista: 	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
	.eqv printString, 4
	.eqv printInt, 1
	.eqv SIZE, 10
	.text
	.globl main
main: 	
	la $a0,str2
	li $v0,printString
	syscall
	
	la $t0,lista # p = lista 
	li $t2,SIZE # $t2 = 10
	sll $t2,$t2,2 # $t2 = 40
	addu $t2, $t2, $t0 # $t2 = 40
while: 	
	bge $t0, $t2, endWhile # while p < 40
	lw $t1, 0($t0) # load word em lista[i]
	
	move $a0, $t1 # move conteudo de $t1 para $a0
	li $v0, printInt # print int
	syscall
	
	la $a0, str1 # print ;
	li $v0, printString
	syscall
	
	addiu $t0,$t0,4 # p++
	j while
endWhile:	
	jr $ra
