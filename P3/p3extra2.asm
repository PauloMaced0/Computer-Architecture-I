# $t0 = res
# $t1 = i
# $t2 = mdor
# $t3 = mdo	
	.data 
str1:	.asciiz "Introduza dois numeros: \n"
str2: 	.asciiz "\n Resultado: "
	.eqv printString,4
	.eqv readInt,5 
	.eqv printInt,1
	.text
	.globl main
main:	la $a0,str1
	li $v0, printString
	syscall
	
	li $t0,0 # res = 0
	li $t1,0 # i = 0
	
	li $v0, readInt # le valor do teclado 
	syscall 
	move $t2, $v0 # mdor = readint()
	 
	li $v0, readInt  # le valor do teclado
	syscall 
	move $t3, $v0 # mdo = readint()
	
	andi $t2,$t2,0x0F # mdor and 0x0f !!!Para valores de 16 bits mudar para 0xFFFF
	andi $t3,$t3,0x0F # mdo and 0x0f  !!!Para valores de 16 bits mudar para 0xFFFF
	
while: 	beqz $t2,endwhile #mdor != 0
	bge $t1,4,endwhile # i++ < 4  !!!Para valores de 16 bits mudar para i++ < 16
	
	andi $t4,$t2,0x00000001 # $t4 = mdor and 0x00000001
	beqz $t4,endif # $t4 == 0
	add $t0,$t0,$t3	# res = res + mdo
	
endif: 	sll $t3,$t3,1 # mdo = mdo << 1
	srl $t2,$t2,1 # mdor = mdor >> 1
	
	addi $t1,$t1,1 # i++
	j while
endwhile:
	la $a0,str2 # loads str1 
	li $v0,printString # prints str1
	syscall
	
	move $a0,$t0 # copies res to $a0
	li $v0,printInt # prints res
	syscall
	
	jr $ra
	
	
	
	
