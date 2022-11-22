# $t0 - value 
# $t1 - bit 
# $t2 - i
# $t3 - flag
	.data
str1: 	.asciiz "Introduza um numero: \n"
str2: 	.asciiz "O valor em binario e: "
	.eqv printString,4
	.eqv readInt,5
	.eqv printChar,11
	.text
	.globl main
main:	li $t2,0 # i = 0
	li $t3,0 #flag = 0
	
	la $a0,str1 # load str1
	li $v0,printString # print str1
	syscall
	
	li $v0,readInt # le valor int do teclado
	syscall 
	
	move $t0,$v0 # $t0 = valor do teclado
	
	la $a0,str2 # load str2
	li $v0,printString # print str2
	syscall
	
do: # do while loop
	srl $t1,$t0,31 # bit = value >> 31
	
	bne $t3,1,secondCondition # flag == 1 ?
	j dontCheckSecondCondition
	
secondCondition:	
	beqz $t1,else# bit != 0 ?
	
dontCheckSecondCondition :
	li $t3,1 # flag = 1
	rem $t4,$t2,4 # $t4 = i % 4
	
	bne $t4,0,secondElse # if($t4 == 0)
	li $a0,' ' # load $a0 = ' '
	li $v0,printChar # print ' '
	syscall
	
secondElse: 
	addi $a0,$t1,0x30 # 0x30 (0) + bit 
	li $v0,printChar
	syscall
else:
	sll $t0,$t0,1	#shift left logical de 1 
	addi $t2,$t2,1 # i++
	blt $t2,32,do # do while i < 32

	jr $ra
	
