	.text
sqrt:	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)
	
	li $s0,0 # i = 0
	l.d $f8,d3 # 0.5
	l.d $f0,d1 # xn = 1.0
	l.d $f2,d2 # 0.0
	if: c.le.d $f12,$f2 # f(val > 0.0)
	bc1t else
		do:
			mov.d $f4,$f0 # aux = xn
			
			div.d $f6,$f12,$f0 # val/xn
			add.d $f10,$f0,$f6 # xn + val/xn);
			mul.d $f0,$f8,$f10 # xn = 0.5 * (xn + val/xn);
			
			addiu $s0,$s0,1 # i++
			
			c.eq.d $f4,$f0
			bc1t endIf
		while:	blt $s0,25,do # while((aux != xn) && (++i < 25)
		j endIf
	else:
		l.d $f0,d2
	endIf:
	
	lw $s0,4($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra
	
	.data
	.eqv printString,4
	.eqv printDouble,3
	.eqv readDouble,7
d3:	.double 0.5
d2:	.double 0.0
d1:	.double 1.0
print1:	.asciiz "Valor: "
print2:	.asciiz "Resultado: "
	.text
	.globl main
main: 	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,print1 # "Valor: "
	li $v0,printString
	syscall

	li $v0,readDouble
	syscall	
	mov.d $f12,$f0

	jal sqrt
	
	la $a0,print2 # print "Resultado: "
	li $v0,printString
	syscall
	
	mov.d $f12,$f0
	li $v0,printDouble
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
