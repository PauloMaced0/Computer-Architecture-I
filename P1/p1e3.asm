	.data	# Data segment
str:	.asciiz "bla"
	.text	# Code segment
	.globl main
main : 	ori $v0, $0, 5		# Lê valor int do teclado ($vo = 5)
	syscall			#chamada ao syscall "read_int() 
	or $t0, $0, $v0		#$t0 = $v0 ($t0 = x)
	
	la $a0,str
	li $v0,4
	syscall
	
	ori $t2, $0, 8		#$t2 = 8
	add $t1, $t0, $t0	#$t1 = $t0 + $t0 = x + x = 2 * x
	sub $t1, $t1, $t2	#$t1 = $t1 + $t2 = y = 2 * x - 8
	
	or $a0, $0, $t1 	#$a0 = y
	ori $v0, $0, 1		#imprime em decimal, complemento para 2
	syscall
	ori $v0, $0, 34		#imprime em hexadecimal
	syscall
	ori $v0, $0, 35		#imprime em binario
	syscall
	
	jr $ra
	
	
	
	
	
