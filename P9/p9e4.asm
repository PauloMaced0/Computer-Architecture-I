	.text
max:	move $t0,$a0 # *p
	move $t1,$a1 # n
	
	sll $t2,$t1,3
	addu $t3,$t0,$t2 # *u = p + n
	addiu $t2,$t2,-8 # *u = p+ n - 1
	
	l.d $f0,0($t0)
	addiu $t0,$t0,8
while:	bgt $t0,$t3,endWhile
	
	l.d $f2,0($t0)
	if:	c.le.d $f2,$f0
		bc1t endIf
		mov.d $f0,$f2
	endIf:
	addiu $t0,$t0,8
	j while
endWhile:
	jr $ra
	
	### MAIN
	.data
	.eqv printDouble,3
	.eqv readDouble,7
	.eqv SIZE,10
d1:	.double 0.0
	.align 3
array: 	.space 80
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	li $s0,0 # i = 0
	
forMain:bge $s0,SIZE,endForMain
	la $s1,array # &array[0]
	sll $s2,$s0,3
	addu $s1,$s1,$s2
	
	li $v0,readDouble
	syscall
	
	s.d $f0,0($s1)
	
	addiu $s0,$s0,1
	j forMain
endForMain:	
	la $a0,array
	li $a1,SIZE
	jal max
	
	mov.d $f12,$f0
	li $v0,printDouble
	syscall

	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
	