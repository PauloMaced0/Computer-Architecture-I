# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1	
	.text
atoi:	li $v0,0
while: lb $t0,0($a0)
	blt $t0,0x30,endWhile 
	bgt $t0,0x39,endWhile
	
	sub $t1,$t0,0x30
	addiu $a0,$a0,1
	mul $v0,$v0,10
	add $v0,$v0,$t1
	j while 
endWhile: jr $ra

atoibin: li $v0,0
while2:  lb $t0,0($a0)
	blt $t0,0x30,endWhile2 
	bgt $t0,0x31,endWhile2
	
	sub $t1,$t0,0x30
	addiu $a0,$a0,1
	sll $v0,$v0,1
	add $v0,$v0,$t1
	j while2
endWhile2: jr $ra

	.data
str: 	.asciiz"2020 e 2024 sao anos bissextos"
str2:	.asciiz "1011"
str3:	.asciiz"\n"
	.eqv printString,4
	.eqv printInt,1
	.text
	.globl main1 # main changed to main1 to permit p8e2 execution
main1:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str
	jal atoi
	
	move $a0,$v0
	li $v0,printInt
	syscall
	
	la $a0,str3
	li $v0,printString
	syscall
	
	la $a0,str2
	jal atoibin
	
	move $a0,$v0
	li $v0,printInt
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
