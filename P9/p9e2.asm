	.data
d1: 	.double 5.0
d2:	.double 9.0
d3:	.double 32.0
str1:	.asciiz "Celsius: "
	.text
	
f2c:	la $t0,d1
	la $t1,d2
	la $t2,d3
	l.d $f2,0($t0)
	l.d $f4,0($t1)
	l.d $f6,0($t2)

	div.d $f2,$f2,$f4
	sub.d $f8,$f12,$f6
	mul.d $f0,$f2,$f8
	
	jr $ra

	.eqv readInt,5
	.eqv printDouble,3
	.eqv printString,4
	.globl main
main:	
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	li $v0,readInt
	syscall 
	move $t0,$v0
	
	la $a0,str1
	li $v0,printString
	syscall
	
	mtc1 $t0,$f12
	cvt.d.w $f12,$f12
	jal f2c
	
	mov.d $f12,$f0
	li $v0,printDouble
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra