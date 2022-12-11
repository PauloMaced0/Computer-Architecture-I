	# $f12 = x
	# $a0 = y
	# stoy(float x, int y)
	.text
xtoy:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s2,$a0
	li $s0,0
	l.s $f0,d1 # result = 1.0
	
	jal abs
	move $s1,$v0
for:	bge $s0,$s1,endFor	
if:	blez $s2,else
	mul.s $f0,$f0,$f12
	j endIf
	else: 
	div.s $f0,$f0,$f12
endIf:
	addiu $s0,$s0,1
	j for
endFor:
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	addiu $sp,$sp,16
	jr $ra	

abs: 	
	li $t0,0xFFFFFFFF
if2:	bgez $a0,endIf2
	xor $a0,$a0,$t0
	addiu $a0,$a0,1
endIf2:
	move $v0,$a0
	jr $ra

	.data
	.eqv printString,4
	.eqv printFloat,2
	.eqv readInt,5
	.eqv readFloat,6
d1:	.float 1.0
print:	.asciiz "Base: "
print1:	.asciiz "Expoente: "
print2:	.asciiz "Resultado: "
print3:	.asciiz "\n"
	.text
	.globl main
main: 	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)

	la $a0,print
	li $v0,printString
	syscall

	li $v0,readFloat
	syscall	
	mov.s $f12,$f0
	
	la $a0,print3
	li $v0,printString
	syscall

	la $a0,print1
	li $v0,printString
	syscall

	li $v0,readInt
	syscall
	move $s0,$v0
	
	la $a0,print3
	li $v0,printString
	syscall

	la $a0,print2
	li $v0,printString
	syscall

	move $a0,$s0
	jal xtoy
	
	mov.s $f12,$f0
	li $v0,printFloat
	syscall
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	addiu $sp,$sp,8
	li $v0,0
	jr $ra
