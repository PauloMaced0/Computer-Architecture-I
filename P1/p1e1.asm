#Pretende-se escrever um programa, em linguagem assembly, que implemente a expressão
#aritmética y = 2x + 8
	
	.data
	
	.text
	.globl main
main:	ori $t0, $0,13		# registo t0 = 3
	ori $t2, $0, 8 		# $t0 = 8
	add $t1, $t0, $t0 	# y = x + x \ $t1 = $t0 + $t0 
	add $t1, $t1, $t2 	# y = y + 8 \ $t1 = $t1 + $t2
	jr $ra			#fim do programa
	