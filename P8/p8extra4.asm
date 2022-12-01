	.text
find_duplicates: addiu $sp,$sp,-8
		sw $s0,0($sp)
		sw $s1,4($sp)
	li $t0,0 # i = 0
	li $s1,0 # dup_counter = 0
for_:	bge $t0,$a2,endFor_
	li $t3,0 # $t3 = 0
	sll $t1,$t0,2
	addu $t1,$t1,$a1
	sw $t3,0($t1) # dup_array[i] = 0;
	
	li $t4,0 # j = 0
	li $t6,1 # token = 1
	for_2: bge $t4,$a2,endFor_2
		
		sll $s0,$t0,2
		addu $t5,$s0,$a0
		lw $t7,0($t5) # array[i]
		
		sll $t8,$t4,2
		addu $t8,$a0,$t8
		lw $t9,0($t8) # array[j]
		if: bne $t7,$t9,endIf # if(array[i] == array[j])
			sll $s1,$t4,2
			addu $t2,$a1,$s1 # dup_array[j]
			sw $t6,0($t2) # dup_array[j] = token
			addiu $t6,$t6,1 # token++
		endIf:
		addiu $t4,$t4,1
		j for_2
	endFor_2:
	
	addiu $t0,$t0,1
	j for_
endFor_:
	lw $s0,0($sp)
	lw $s1,4($sp)
	addiu $sp,$sp,8
	jr $ra
		
	.data
	.eqv printString, 4
	.eqv readInt, 5
	.eqv printInt, 1
	.eqv SIZE,10
print1:	.asciiz "array["
print2:	.asciiz "]="
print3:	.asciiz "*, "
print4:	.asciiz "\n# repetidos: "
print5:	.asciiz ", "
	.align 2
array:	.space 40
aux_array: .space 40
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	li $s0,0 # i = 0
for:	bge $s0,SIZE,endFor

	la $a0,print1
	li $v0,printString
	syscall
	
	move $a0,$s0
	li $v0,printInt
	syscall
	
	la $a0,print2
	li $v0,printString
	syscall
	
	move $a0,$s0
	li $v0,readInt
	syscall 
	
	move $s4,$v0
	
	la $s2,array
	sll $s3,$s0,2
	addu $s3,$s3,$s2
	sw $s4,0($s3)
	
	addiu $s0,$s0,1
	j for
endFor:
	la $a0 array
	la $a1, aux_array
	li $a2,SIZE
	jal find_duplicates # find_duplicates(array, aux_array, SIZE);
	
	li $s0,0 # i = 0
for2: bge $s0,SIZE,endFor2
	la $s2,aux_array
	sll $s7,$s0,2
	addu $s3,$s7,$s2 # aux_array[i]
	lw $s4,0($s3) # aux_array[i]
	ifmain: blt $s4,2,else # if(aux_array[i] >= 2)
		
		la $a0,print3
		li $v0,printString # print_string("*, ");
		syscall
		
		addiu $s1,$s1,1 # dup_counter++;
		j endIfmain
	else:
		la $s5,array
		addu $s6,$s5,$s7 # array[i]
		lw $a0,0($s6)
		li $v0,printInt # print_int10(array[i]);
		syscall 		
		
		la $a0,print5
		li $v0,printString # print_string(", ");
		syscall
		
	endIfmain:
	
	addiu $s0,$s0,1
	j for2
endFor2:				
	la $a0,print4 # print_string("\n# repetidos: ");
	li $v0,printString
	syscall
	
	move $a0,$s1 # print_int10(dup_counter)
	li $v0,printInt
	syscall
		
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra	
