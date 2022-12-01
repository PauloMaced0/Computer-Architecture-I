	.text
	## strlen function
strlen: li $v0,0
while:	lb $t7,0($a0)
	addiu $a0,$a0,1
	beq $t7,'\0',endWhile
	addiu $v0,$v0,1
	j while 
endWhile: jr $ra
	## insert function
insert:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	move $t0,$a0 # *p = dst
	move $t4,$a0 # &dst[0]
	
	jal strlen
	move $t3,$v0 # i = strlen(dst);

	move $a0,$a1
	jal strlen
	move $t2,$v0 #len_src = strlen(src);
	
if:	bgt $a2,$t3,endIf # if(pos <= len_dst)
	
	for1:	blt $t3,$a2,endFor1
		
		addu $t6,$t4,$t3
		lb $t5,0($t6) # dst[i]
		addu $t1,$t6,$t2 # dst[i + len_src]
		sb $t5,0($t1) # dst[i + len_src] = dst[i]
		
		addiu $t3,$t3,-1	
		j for1
	endFor1:
	li $t3,0
	for2:	bge $t3,$t2,endFor2
	
		addu $t6,$a1,$t3 # &src[0] + i
		lb $t5,0($t6) # src[i]
		addu $t1,$t3,$a2 # i + pos
		addu $t1,$t1,$t4 # &dst[0] + i + pos
		sb $t5,0($t1) # dst[i + pos] = src[i];
		
		addiu $t3,$t3,1
		j for2
	endFor2:
endIf:
	lw $ra,0($sp)
	addiu $sp,$sp,4
	move $v0,$t0
	jr $ra
	
	.data
print1:	.asciiz "Enter a string: "
print2:	.asciiz "Enter a string to insert: "
print3:	.asciiz "Enter the position: "
print4:	.asciiz "Original string: "
print5:	.asciiz "\nModified string: "
print6:	.asciiz "\n"
	.eqv printString,4
	.eqv readString,8
	.eqv readInt,5
str1:	.space 101
str2:	.space 51
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,print1 # print_string("Enter a string: ")
	li $v0,printString
	syscall 
	
	la $a0,str1 # read_string(str1, 50);
	li $a1,50
	li $v0,readString
	syscall
	
	la $a0,print2  # print_string("Enter a string to insert: ");
	li $v0,printString
	syscall 
	
	la $a0,str2 # read_string(str2, 50);
	li $a1,50
	li $v0,readString
	syscall
	
	la $a0,print3 # print_string("Enter the position: ")
	li $v0,printString
	syscall
	
	# insert_pos = read_int();
	li $v0,readInt
	syscall
	move $s0,$v0
	
	la $a0,print4 # print_string("Original string: ");
	li $v0,printString
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	la $a0,str1
	la $a1,str2
	move $a2,$s0
	jal insert # insert(str1, str2, insert_pos);
	
	la $a0,print5
	li $v0,printString
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	la $a0,print6
	li $v0,printString
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
