	.text
	.eqv printInt,1
	.eqv printString,4
insert:
if:	ble $a2,$a3,else
	li $v0,1
	jr $ra
else:
	addiu $a3,$a3,-1 # i = size - 1
	sll $a3,$a3,2 # i * 4
	sll $a2,$a2,2 # pos * 4
for:	blt $a3,$a2,endFor # for(i = size-1; i >= pos; i--)
	addu $t0,$a0,$a3 #  $t0 = &array + size
	lw $t1,0($t0)
	addiu $t0,$t0,4 # $t0 + 1(4 int)
	sw $t1,0($t0)
	addiu $a3,$a3,-4
	j for
	
endFor: addu $a0,$a0,$a2
	sb $a1,0($a0)
	
	li $v0,0
	jr $ra


print_array:
	move $t2,$a0
	move $t3,$a1
	
	sll $t0,$t3,2
	addu $t0,$t0,$t2
For:	bge $t2,$t0,endFOR
	lw $t1,0($t2)
	move $a0,$t1
	li $v0,printInt
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	addiu $t2,$t2,4
	j For
endFOR:	jr $ra
	
	.data
array:	.space 50
str1:	.asciiz ", "
str2:	.asciiz "Size of array: "
str3:	.asciiz "array["
str4:	.asciiz "] = "
str5:	.asciiz "Enter the value to be inserted: "
str6:	.asciiz "Enter the position: "
str7:	.asciiz "\nOriginal array: "
str8:	.asciiz "\nModified array: "
	.eqv readInt,5
	.text
	.globl main
main:	
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str2
	li $v0,printString
	syscall
		
	li $v0,readInt
	syscall
	
	move $s1,$v0 # array_size = read_int();
	li $s0,0
for1:	bge $s0,$s1,endFor1
	la $a0,str3
	li $v0,printString
	syscall
	
	move $a0,$s0
	li $v0,printInt
	syscall
	
	la $a0,str4
	li $v0,printString
	syscall
	
	la $s3,array
	sll $s2,$s0,2
	addu $s2,$s3,$s2
	li $v0,readInt
	syscall
	move $s4,$v0
	sw $s4,0($s2)

	addiu $s0,$s0,1
	j for1
endFor1:
	la $a0,str5
	li $v0,printString
	syscall
	
	li $v0,readInt
	syscall
	move $s5,$v0
	
	la $a0,str6
	li $v0,printString
	syscall
	
	li $v0,readInt
	syscall
	move $s6,$v0
	
	la $a0,str7
	li $v0,printString
	syscall
	
	la $a0,array
	move $a1,$s1
	jal print_array
	
	la $a0,array
	move $a1,$s5
	move $a2,$s6
	move $a3,$s1
	jal insert
	
	la $a0,str8
	li $v0,printString
	syscall
	
	la $a0,array
	move $a1,$s1
	addiu $a1,$a1,1
	jal print_array
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
	
	
