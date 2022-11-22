	.data
str1: 	.asciiz "Introduza um numero\n"
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos e: "
	.eqv printString,4
	.eqv readInt,5
	.eqv printInt,1
	.text
	.globl main
main: 	li $t0,0 # variavel soma
	li $t1,0 # variavel i do for
for: 	bge $t1,5,endfor # for(i = 0, i<5,i++)
	
	la $a0,str1 #load str1
	li $v0,printString # print str1
	syscall
	
	li $v0,readInt # lê valor do teclado
	syscall
	move $t2,$v0 # passa o valor lido do teclado para $t2
	#$t2 é a variavel value
	
	ble $t2,0,else #if(value > 0)
	add $t0,$t0,$t2 #soma = soma + value
	j endif
	
else: 	la $a0,str2 #load str2
	li $v0,printString #print da str2
	syscall
endif:	
	addi $t1,$t1,1 # i++
	j for # jump incondicional para o ciclo for
endfor: 
	la $a0,str3 #load str3
	li $v0,printString # print str3
	syscall
	
	move $a0,$t0 #passa valor da soma para $a0(para imprimir)
	li $v0,printInt # print soma
	syscall
	
	jr $ra # fim do programa
