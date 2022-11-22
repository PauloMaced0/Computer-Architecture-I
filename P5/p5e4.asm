#Compara valores unsigned
# i = $t0
# lista = $t1
# lista + i = $t2
# houve troca = $t3
# p = $t4
# *p = $t5
# *(p+1) = $t6
# pUltimo = $t7
	.data
	.eqv SIZE, 10
	.eqv SIZEMENOS1,9
	.eqv TRUE, 1
	.eqv FALSE, 0
str: 	.asciiz "\n Introduza um numero:"
str2:	.asciiz ";"
	.align 2
lista: 	.space 40 # Espaço necessario para 10 interiros
	.eqv readInt, 5
	.eqv printString, 4
	.eqv printInt,1
	.text
	.globl main
main:
	li $t0,0 # i = 0
for:	
	bge $t0,SIZE,endFor # while i < 5
	la $a0,str # la da string 
	li $v0,printString #print string
	syscall
	li $v0,readInt # ler valor do reclado
	syscall
	la $t1,lista # $t1 = lista(&lista[0])
	sll $t2,$t0,2 # lista + i = i * 4
	addu $t2,$t2,$t1 # lista[i] = &lista[i] + i * 4
	sw $v0,0($t2) # store int
	addi $t0,$t0,1 # i++
	j for
endFor:
	la $t4,lista
	li $t7,SIZEMENOS1 # pUltimo = 9
	sll $t7,$t7,2 # pUltimo = 36
	addu $t7,$t7,$t4 # pUltimo = &lista[0] + 36
doWhile:
	la $t4,lista # p = lista
	li $t3,FALSE # houve troca = FALSE
for2:	bge $t4,$t7,endFor2
	lw $t5, 0($t4) #*p = lista[i]
	lw $t6, 4($t4) # *(p+1) = lista[i]
	ble $t5,$t6, endif
	sw $t5,4($t4)#*p = *(p+1);
	sw $t6,0($t4)#*(p+1) = aux;
	li $t3,TRUE
endif:
	addiu $t4,$t4,4 #p++
	j for2
endFor2:
	sub $t7,$t7,4
	beq $t3,TRUE,doWhile
	
	la $t1, lista # $t1 = &lista[0]
	li $t7,SIZE # $t3 = 10
	sll $t7,$t7,2 # $t3 = 10 * 40
	addu $t7,$t7,$t1 # $t3 = &lista[0] + 40
while:	
	bge $t1,$t7,endWhile # while (p < lista + SIZE)
	lw $t5,0($t1) # *p = lista[i]
	
	move $a0,$t5 # move conteudo de *p para $a0
	li $v0,printInt # print_int
	syscall
	
	la $a0,str2
	li $v0,printString
	syscall
	
	addiu $t1,$t1,4 # p++
	j while
endWhile:
	jr $ra

	
