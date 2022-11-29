	.text
average:
	move $t0,$a0
	move $t1,$a1 # n
	l.d $f0,d1 # double sum = 0.0
	
	move $t3,$a1 # i = n 
for:	blez $t3,endFor
	
	addiu $t3,$t3,-1
	sll $t4,$t3,3
	addu $t2,$t0,$t4
	
	l.d $f2,0($t2)
	add.d $f0,$f0,$f2
	
	j for
endFor: 
	mtc1 $t1,$f4
	cvt.d.w $f4,$f4
	div.d $f0,$f0,$f4
	
	jr $ra
	
	### MAIN
	.data
	.eqv printDouble,3
	.eqv readDouble,7
	.eqv SIZE,10
d1:	.double 0.0
str1:	.asciiz "Valor: "
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
	jal average
	
	mov.d $f12,$f0
	li $v0,printDouble
	syscall

	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
	