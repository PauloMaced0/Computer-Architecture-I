
	.data
	.eqv readInt,5
	.eqv printString,4
str:	.space 33
str1: 	.asciiz"\n"
	.text
	.globl main
main:	addiu $sp,$sp,4
	sw $ra,0($sp)
do:	li $v0,readInt # val = read_int();
	syscall
	move $s0,$v0
	
	move $a0,$s0
	li $a1,2
	la $a2,str
	jal itoa
	
	move $a0,$v0
	li $v0,printString
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	move $a0,$s0
	li $a1,8
	la $a2,str
	jal itoa 
	
	move $a0,$v0
	li $v0,printString
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	move $a0,$s0
	li $a1,16
	la $a2,str
	jal itoa
	
	move $a0,$v0
	li $v0,printString
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
while: bnez $s0,do
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
