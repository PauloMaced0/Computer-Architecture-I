# i = $t0
# lista = $t1
# lista +i = $t2
	.data
	.eqv SIZE, 5
str: 	.asciiz "\n Introduza um numero:"
	.align 2
lista: 	.space 20 # Espaço necessario para 5 interiros
	.eqv readInt, 5
	.eqv printString, 4
	.text
	.globl main
main:
	li $t0,0 # i = 0
for:	bge $t0,SIZE,endFor # while i < 5

	la $a0,str # la da string 
	li $v0,printString #print string
	syscall
	
	li $v0,readInt # ler valor do reclado
	syscall
	
	la $t1,lista # $t1 = lista(&lista[0])
	sll $t2,$t0,2 # lista + i = lista[i * 4]
	addu $t2,$t2,$t1 # lista[i] = &lista[i]
	sw $v0,0($t2) # store int
	
	addi $t0,$t0,1 # i++
	j for
endFor:
	jr $ra
