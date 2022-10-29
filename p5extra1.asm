#Mapa de registos		
#$t0 = i
#$t1 = &array[0] .... $t1 = *p
#$t2 = &array[i]
#$t3 = j 
#$t4 = array[j]
#$t5 = array[i]
#$t6 = &array[j]
#$t7 = *pUltimo

	.data
	.eqv SIZE,10
	.eqv SIZEMENOS1,9
str:	.asciiz "\nIntroduza um numero:"
str1:	.asciiz ";"
	.align 2
array:	.space 40
	.eqv readInt,5
	.eqv printString,4
	.eqv printInt,1
	.text
	.globl main
main:	
	la $t1, array
	li $t0,0
for:	
	bge $t0,SIZE,endFor
	
	la $a0,str
	li $v0,printString
	syscall
	
	li $v0,readInt
	syscall
	
	sll $t2,$t0,2
	addu $t2,$t2,$t1
	sw $v0,0($t2)
	
	addi $t0,$t0,1
	j for
endFor:
	li $t0,0 #i = 0
for2:	
	bge $t0,SIZEMENOS1,endFor2 #while i < 9
	sll $t2,$t0,2 # $t2 = i*4
	addu $t2,$t2,$t1 # $t2 = &array[i]
	
	li $t3,1 # j = 1
	add $t3,$t3,$t0 # j = 1 + i
	innerFor: 
		bge $t3,SIZE,endInnerFor # while j < 10
		sll $t6,$t3,2
		addu $t6,$t6,$t1 # $t6 = &array[j] 
		lw $t5,0($t2) # $t5 = array[i]
		lw $t4,0($t6) # $t4 = array[j]
	if:	ble $t5,$t4,endIf # if(array[i] > array[j])
		sw $t5,0($t6) # $t5 = array[j] 
		sw $t4,0($t2) # $t4 = array[i]
	endIf:
		addi $t3,$t3,1 # j++
		j innerFor
	endInnerFor:
		addi $t0,$t0,1 # i++
		j for2
endFor2:
	la $t1,array
	li $t0,SIZE
	sll $t0,$t0,2
	addu $t7,$t1,$t0
while: 
	bge $t1,$t7,endWhile
	lw $a0,0($t1)
	
	li $v0,printInt
	syscall
	
	la $a0,str1
	li $v0,printString
	syscall
	
	addi $t1,$t1,4#p++
	j while
endWhile:
	jr $ra
