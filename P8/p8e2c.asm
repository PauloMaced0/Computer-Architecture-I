	.eqv printString,4
	.text
print_int_ac1:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a2,buf
	jal itoa
	
	move $a0,$v0
	li $v0,printString
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	.data
	.eqv readInt,5
	.eqv printString, 4
buf:	.space 33
str: 	.asciiz "Valor: "
str2: 	.asciiz "Base: "
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str
	li $v0,printString
	syscall
	
	li $v0,readInt
	syscall
	move $t0,$v0
	
	la $a0,str2
	li $v0,printString
	syscall
	
	li $v0,readInt
	syscall 
	move $t1,$v0
	
	move $a0,$t0
	move $a1,$t1
	jal print_int_ac1
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
