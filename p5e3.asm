# i = $t0
# lista = $t1
# lista + i = $t2
# houve troca = $t3
# lista [i] = $t4
# lista[i + 1] = $t5
# p = $t6
# *p = $t7

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
	la $t1,lista # $t1 = &lista[0]
doWhile:	 
	li $t3,FALSE # house troca = False
	li $t0,0 # i = 0
for2:	bge $t0,SIZEMENOS1,endFor2 # while i < 9
	sll $t2,$t0,2 # lista + i = i * 4
	addu $t2,$t2,$t1 # lista + i = &lista[i] + i * 4
	lw $t4,0($t2) # $t4 = lista[i]
	lw $t5,4($t2) # $tt5 = lista[i + 1)
	ble $t4,$t5,endIf # if(lista[i] < lista[i + 1])
	sw $t4,4($t2) # $t4 = lista[i + 1]
	sw $t5,0($t2) # $t3 = lista[i]
	li $t3,TRUE # houve troca = True 
endIf:	
	addi $t0,$t0,1 # i++
	j for2
endFor2:	
	beq $t3,TRUE,doWhile #doWhile(houve troca == TRUE)
		
	la $t6, lista # $t6 = &lista[0]
	li $t3,SIZE # $t3 = 10
	sll $t3,$t3,2 # $t3 = 10 * 40
	addu $t3,$t3,$t6 # $t3 = &lista[0] + 40
while:	
	bge $t6,$t3,endWhile # while (p < lista + SIZE)
	lw $t7,0($t6) # $t7 = *p
	
	move $a0,$t7 # move conteudo de *p para $a0
	li $v0,printInt # print_int
	syscall
	
	la $a0,str2
	li $v0,printString
	syscall
	
	addiu $t6,$t6,4 # p++
	j while
endWhile:
	jr $ra

