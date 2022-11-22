# $t0 = n (incremento do while loop)
# $t1 = gray 
# $t2 = bin
# $t3 = mask 
	.data
str1: 	.asciiz "Introduza um numero: "		
str2: 	.asciiz "\n Valor em codigo de Gray: "
str3: 	.asciiz "\n Valor em binario: "
	.eqv printString,4
	.eqv readInt,5
	.eqv printInt16,34
	.text 
	.globl main
main: 	la $a0,str1 # load str1 para $a0
	li $v0, printString #print str1
	syscall
	
	li $v0,readInt # le valor do teclado 
	syscall
	
	move $t1, $v0 # $t1 = gray
	
	srl $t3,$t1,1 #shift right logical mask = gray >> 1
	move $t2,$t1 # bin = gray
	
while:	beqz $t3,endWhile #while != 0
	
	xor $t2, $t2, $t3 # bin = bin ^ mask 
	srl $t3, $t3,1 # mask = mask >> 1
	
	addi $t0,$t0,1 # n++
	j while
endWhile: 
	la $a0,str2
	li $v0,printString
	syscall
	
	move $a0, $t1
	li $v0,printInt16
	syscall
	
	la $a0,str3
	li $v0, printString
	syscall
	
	move $a0,$t2
	li $v0, printInt16
	syscall
	
	jr $ra