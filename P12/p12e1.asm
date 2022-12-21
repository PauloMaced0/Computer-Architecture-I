	# OFFSETS
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	# SYSCALLS
	.eqv printString, 4
	.eqv printInt, 1
	.eqv printFloat, 2
	.eqv readInt,5
	.eqv readString,8
	.eqv readFloat,6	
	
	.data
print1:	.asciiz "N. Mec: "
print2:	.asciiz "Primeiro Nome: "
print4:	.asciiz "Nota: "
print5:	.asciiz "Ultimo nome: "
print6:	.asciiz "\n"
print7:	.asciiz "\nMedia: "
	.eqv MAX_STUDENTS,4
	.align 2 
st_array:.space 176
	.align 2
media:	.float
f1:	.float -20.0
f2:	.float 0.0
	.text
read_data: # FUNCTION READ_DATA()
	li $t0,0 # i = 0
	move $t1,$a1 # ns = 4
	move $t3,$a0 # *student
	for: bge $t0,$t1,endFor
		mul $t2,$t0,44
		addu $t2,$t3,$t2
		
		la $a0,print1
		li $v0,printString # print_string("N. Mec: ");
		syscall
		
		li $v0,readInt
		syscall 
		sw $v0,0($t2) # st[i].id_number = read_int();
		
		la $a0,print2
		li $v0,printString # print_string("Primero Nome: ");
		syscall
		
		addiu $t4,$t2,4
		move $a0,$t4
		li $a1,17
		li $v0,readString
		syscall
		
		la $a0,print5
		li $v0,printString # print_string("Ultimo nome: ");
		syscall
		
		addiu $t4,$t2,22
		move $a0,$t4
		li $a1,14
		li $v0,readString
		syscall
		
		la $a0,print4
		li $v0,printString # print_string("Nota: ");
		syscall
		
		addiu $t4,$t2,40
		li $v0,readFloat
		syscall
		s.s $f0,0($t4)
		
		addiu $t0,$t0,1 
		j for
	endFor:
	
	jr $ra
	
max: # FUNCTION MAX()
	l.s $f0,f1 # float max_grade = -20.0;
	l.s $f2,f2 # float sum = 0.0;
	move $t0,$a0 # student *p;
	mul $t2,$a1,44
	add $t1,$t2,$a0 # (st + ns)
	formax:	bge $t0,$t1,endFormax
		
		l.s $f4,40($t0)
		add.s $f2,$f2,$f4
	if:	c.le.s $f4,$f0
		bc1t endIf
			mov.s $f0,$f4
			move $v0,$t0
		endIf:	
		addiu $t0,$t0,44
		j formax
	endFormax:
	mtc1 $a1,$f6
	cvt.s.w $f6,$f6
	div.s $f8,$f2,$f6
	s.s $f8,0($a2)
	
	jr $ra
	
print_student: # FUNCTION PRINT_STUDENT()
	move $t0,$a0
	
	la $a0,print6
	li $v0,printString
	syscall
	
	lw $a0,id_number($t0)
	li $v0,printInt
	syscall
	
	la $a0,print6
	li $v0,printString
	syscall
	
	li $t1,first_name
	add $a0,$t0,$t1
	li $v0,printString
	syscall
	
	la $a0,print6
	li $v0,printString
	syscall
	
	li $t1,last_name
	add $a0,$t0,$t1
	li $v0,printString
	syscall
	
	la $a0,print6
	li $v0,printString
	syscall
	
	l.s $f12,grade($t0)
	li $v0,printFloat
	syscall
	
	jr $ra

	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,st_array
	li $a1,MAX_STUDENTS
	jal read_data
	
	la $a0,st_array
	li $a1,MAX_STUDENTS
	la $a2,media
	jal max	
	move $s0,$v0 # pmax
	
	la $a0,print7
	li $v0,printString # print_string("\nMedia: ");
	syscall
	
	la $a0,media
	l.s $f12,0($a0)
	li $v0,printFloat # print_float( media );
	syscall
	
	move $a0,$s0
	jal print_student
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra # return 0
