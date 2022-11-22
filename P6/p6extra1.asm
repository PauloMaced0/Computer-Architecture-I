#Mapa de registos 
# i = $t0
# j = $t1
# argv [i][j] = $t2
# count_maiusculas = $t8
# count_minusculas = $t7
# count_caracter = $t6
# maior argumento = $s0
	.data
	.eqv printString, 4
	.eqv printInt, 1
	.eqv printChar,11
str1:	.asciiz "\nArgv["
str2:	.asciiz "]: "
str3:	.asciiz "\nNr. de caracteres: "
str4:	.asciiz "\nNr. de maiúsculas: "
str5:	.asciiz "\nNr. de minúsculas: "
str6:	.asciiz "\nArgumento com mais caracteres: "
	.text
	.globl main
main:
	move $t3,$a0 # $t3 = argc
	move $t9,$a1 # $t9 = *argv[]
	li $t0,0 # i = 0
	li $s0,0 # max = 0
	
for:	
	bge $t0,$t3,endFor
	li $t1,0 # j = 0
	li $t6,0 # count_caracter
	li $t7,0 # count_minusculas
	li $t8,0 # count_maiusculas
	
	la $a0,str1
	li $v0,printString # print string1
	syscall
	
	move $a0,$t0
	li $v0,printInt # print index of string
	syscall
	
	la $a0,str2
	li $v0,printString # print string2
	syscall
	
	move $t4,$t9 # $t4 = &argv[0]
	sll $t5,$t0,2 # $t5 = i * 4
	addu $t4,$t4,$t5 # $t4 = &argv[0] + i * 4
	lw $a0,0($t4) # $a0 = argv[i]
	li $v0,printString # print argv[i]
	syscall
	
	while: 
		move $t4,$t9 # $t4 = &argv[0]
		sll $t5,$t0,2 # $t5 = i * 4
		addu $t4,$t4,$t5 # $t4 = &argv[0] + i * 4
		lw $t4,0($t4) # $a0 = argv[i]
		addu $t4,$t4,$t1
		lb $t2,0($t4)
	
		beq $t2,'\0',endWhile
		if:
			blt $t2,0x41,if2
			bgt $t2,0x5A,if2
			addiu $t8,$t8,1 # count_maiusculas++ 
		if2:
			blt $t2,0x61,endIf
			bgt $t2,0x7A,endIf
			addiu $t7,$t7,1 # count_minusculas++
		endIf:
		addiu $t6,$t6,1 # count_caracter++
		addiu $t1,$t1,1 # j++
		j while
	endWhile:
	if3:
		blt $t6,$s0,endIf3
		move $s0,$t5 # index do maior argumento
	endIf3:
	
	la $a0,str3
	li $v0,printString
	syscall
	
	move $a0,$t6
	li $v0,printInt
	syscall
	
	la $a0,str4
	li $v0,printString
	syscall
	
	move $a0,$t8
	li $v0,printInt
	syscall
	la $a0,str5
	li $v0,printString
	syscall
	
	move $a0,$t7
	li $v0,printInt
	syscall
	
	li $a0,'\n'
	li $v0,printChar
	syscall
		
	addiu $t0,$t0,1 # i++
	j for
endFor:
	la $a0,str6
	li $v0,printString
	syscall
	
	addu $t1,$t9,$s0
	lw $a0,0($t1)
	li $v0,printString
	syscall
	
	li $a0,'\n'
	li $v0,printChar
	syscall
	
	jr $ra