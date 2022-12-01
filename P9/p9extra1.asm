	.text
median:	
do: 	li $t0,0 # houveTroca = False
	li $t1,0 # i = 0
	move $t2,$a1
	addiu $t2,$t2,-1
	for: bge $t1,$t2,endFor
		sll $t3,$t1,3
		addu $t4,$t3,$a0 # array[i]
		l.d $f0,0($t4) # array[i]
		l.d $f2,8($t4) # array[i + 1]
		
		if:  	c.le.d $f0,$f2
			bc1t endIf
			s.d $f2,0($t4) 
			s.d $f0,8($t4) # array[i] = array[i+1]
			li $t0,1 # houveTroca = TRUE
		endIf:
	
		addiu $t1,$t1,1
		j for
	endFor:
while: beq $t0,1,do
	rem $t0,$a1,2
	la $t3,d1
	l.d $f8,0($t3)
	# cvt.d.w $f8,$f8
	if_2: bnez $t0,else_2
		srl $t2,$a1,1
		sll $t1,$t2,3
		addu $t2,$t1,$a0
		l.d $f0,0($t2)
		l.d $f2,8($t2)
		add.d $f4,$f0,$f2
		div.d $f0,$f4,$f8
		j endIf_2
	else_2:	
		srl $t2,$a1,1
		sll $t1,$t2,3
		addu $t2,$t1,$a0
		l.d $f0,0($t2)
	endIf_2:
	jr $ra
	
	### MAIN
	.data
	.eqv printDouble,3
	.eqv readDouble,7
	.eqv printString,4
	.eqv SIZE,10
d1:	.double 2.0
print1:	.asciiz ", "
print2:	.asciiz "Mediana: "
print3:	.asciiz "\n"
	.align 3
array: 	.space 80
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	li $s0,0 # i = 0
	
forMain:bge $s0,SIZE,endForMain # for(i = 0; i < SIZE; i++)
	la $s1,array # &array[0]
	sll $s2,$s0,3
	addu $s1,$s1,$s2
	
	li $v0,readDouble
	syscall
	
	s.d $f0,0($s1) # a[i] = (double)read_int()
	
	addiu $s0,$s0,1
	j forMain
endForMain:	
	li $s0,0 # k = 0
	
	la $a0,array
	li $a1,SIZE
	jal median # median(a, SIZE)
	
	la $a0,print2
	li $v0,printString # print("Mediana: ")
	syscall 
	
	mov.d $f12,$f0
	li $v0,printDouble # print_double( median(a, SIZE) );
	syscall
	
	la $a0,print3
	li $v0,printString # print("\n")
	syscall 
	
	for_2: bge $s0,SIZE,endFor_2
		la $s1,array
		sll $s2,$s0,3
		addu $s1,$s1,$s2
		l.d $f12,0($s1)
		li $v0,printDouble
		syscall
		
		la $a0,print1 # print ", "
		li $v0,printString
		syscall
		addiu $s0,$s0,1
		j for_2
	endFor_2:
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
	
