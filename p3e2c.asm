# $t0 - value 
# $t1 - bit 
# $t2 - i
	.data
str1: 	.asciiz "Introduza um numero: \n"
str2: 	.asciiz "O valor em binario e: "
	.eqv printString,4
	.eqv readInt,5
	.eqv printChar,11
	.text
	.globl main
main:	li $t2,0 # i = 0
	
	la $a0,str1 # load str1
	li $v0,printString # print str1
	syscall
	
	li $v0,readInt # le valor int do teclado
	syscall 
	
	move $t0,$v0 # $t0 = valor do teclado
	
	la $a0,str2 # load str2
	li $v0,printString # print str2
	syscall
	
for:	bge $t2,32,endfor # for(;i<32;)
	rem $t3,$t2,4 # $t3 = i % 4
	bne $t3,0,else # if($t3 == 0)
	li $a0,' ' # load $a0 = ' '
	li $v0,printChar # print ' '
	syscall

else:	andi $t1,$t0,0x80000000 # $t4 = $t0 & 0x80000000
	srl $t1,$t1,31	# $t1 = $t4 >> 31
	
	addi $a0,$t1,0x30
	li $v0,printChar #printChar
	syscall
	sll $t0,$t0,1
	addi $t2,$t2,1 # i++
	j for
	
endfor:	jr $ra
	
