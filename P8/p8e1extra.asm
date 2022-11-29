	.text
int_div: move $t0,$a0 # dividendo
	move $t1,$a1 # divisor
	
	sll $t1,$t1,16
	andi $t0,$t0,0xFFFF
	sll $t0,$t0,1
	
	li $t2,0 # i = 0
	for: 	bge $t2,16,endFor
		li $t3,0 # bit = 0
		if: blt $t0,$t1,endIf
			sub $t0,$t0,$t1
			li $t3,1
		endIf:
			sll $t0,$t0,1 # dividendo = dividendo << 1
			or $t0,$t0,$t3 # dividendo OR bit
		addiu $t2,$t2,1
		j for
	endFor:
	srl $t2,$t0,1
	andi $t2,$t2,0xFFFF0000
	andi $t4,$t0,0xFFFF
	
	or $v0,$t2,$t4
	jr $ra

	.data
	.eqv readInt,5
	.eqv printInt,1
	.eqv printString,4
str1: 	.asciiz "Dividendo: "
str2:	.asciiz "Divisor: "
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str1
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
	jal int_div
	
	move $a0,$v0
	li $v0,printInt
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra