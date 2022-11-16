	.text
#strcpy:	li $t0,0
#do:	
#	move $s0,$a0 # dst
#	move $s1,$a1 # src
#	
#	addu $s1,$s1,$t0
#	addu $s0,$s0,$t0
#	
#	lb $t1,0($s1)
#	sb $t1,0($s0)
#	
#	addiu $t0,$t0,1
#doWhile: bne $t1,'\0',do
#	
#	move $v0,$a0
#	jr $ra
strcpy:
	move $t0,$a0 # $t0 = *p(dst)
	move $t1,$a1 # $t1 = *src 
do:
	lb $t2,0($t1) # $2 = *p
	sb $t2,0($t0) # *p = *src
	addiu $t0,$t0,1 # dst++
	addiu $t1,$t1,1 # src++
doWhile: bne $t2,'\0',do # while (src[i] != 0)
	move $v0,$a0 # valor de return da funçao
	jr $ra
	
strlen: li $v0,0 # len = 0
while:	lb $t0,0($a0) # $t0 = s[i]
	addiu $a0,$a0,1 # s++
	beq $t0,'\0',endWhile # while (*s != 0)
	addiu $v0,$v0,1 # len
	j while 
endWhile: jr $ra

exchange: lb $t0,0($a0) 
	lb $t1,0($a1) 
	sb $t1,0($a0) # $t1 = $t0
	sb $t0,0($a1) # $t0 = $t1
	jr $ra
	
strrev:	addiu $sp,$sp,-16 # alocar espço na stack 
	sw $ra,0($sp) # salvaguarda das variaveis
	sw $s0,4($sp) 
	sw $s1,8($sp)
	sw $s2,12($sp)

	move $s0,$a0 # Valor a devolver na funçao
	move $s1,$a0 # *p1 = $s1
	move $s2,$a0 # *p2 = $s2
while1:	lb $t0,0($s2)
	beq $t0,'\0',endWhile1 # while(p2 != 0)
	addiu $s2,$s2,1 # p2++
	j while1
endWhile1: 
	addiu $s2,$s2,-1  # p1--
while2: bge $s1,$s2,endWhile2 # while (p1 < p2)
	move $a0,$s1 # 1 argumento de entrada
	move $a1,$s2 # 2 argumento de entrada
	jal exchange # chamada a funçao
	addiu $s1,$s1,1 #p1++ 
	addiu $s2,$s2,-1 #p2--
	j while2
endWhile2:
	move $v0,$s0 # valor a devolver da funçao 
	lw $ra,0($sp) # retoma dos valores guardados
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,16($sp)
	addiu $sp,$sp,16 # estabelecer valor inicial da stack
	jr $ra
	
	.data
str1: 	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "
	.eqv STR_MAX_SIZE,30
	.eqv printString,4
	.eqv printInt,1
	.text
	.globl main
main: 	addiu $sp,$sp,-4 # definir espaço na stack para guardar $ra
	sw $ra,0($sp) # store $ra na stack
	
	la $a0,str1 # argumneto de entrada da funçao 
	jal strlen # chamda da funçao 
if:	bgt $v0,STR_MAX_SIZE,else # if(strlen(str1) <= STR_MAX_SIZE)
	
	la $a0,str2 # argumento 1 de entrada da funçao
	la $a1,str1 # argumneto 2 de entrda da fuhnçao 
	jal strcpy # chamada da funçao 
	
	move $t1,$v0 # guardar valor em $t1 do return de strcpy
	move $a0,$v0 # print strcpy(str)
	li $v0,printString 
	syscall
	
	la $a0,str3 # print \n
	li $v0,printString
	syscall
	
	move $a0,$t1 #argumento de entrada da funçao
	jal strrev # chamda da funçao
	 
	move $a0,$v0 # print return da funçao strrev
	li $v0,printString
	syscall
	
	li $t0,0 # exit_value = 0
	j endif
else:	
	la $a0,str4 # print str4: String too long
	li $v0,printString
	syscall
	
	la $a0,str1 # argumento de entrada da funçao
	jal strlen
	
	move $a0,$v0 # print do return da funçao strlen
	li $v0,printInt
	syscall
	
	li $t0,-1 # exit_value = -1
endif:
	lw $ra,0($sp) # retoma do valor de $ra
	addiu $sp,$sp,4 # estabelcer valor inicial da stack
	move $v0,$t0 # return exit_value
	jr $ra
	
 