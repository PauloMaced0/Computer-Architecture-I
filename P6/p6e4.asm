# Mapa de resgistos
# i = $t0
	.data
	.eqv printString, 4
	.eqv printInt, 1
str1:	.asciiz "Nr. de parametros: "
str2: 	.asciiz "\nP"
str3: 	.asciiz ": "
	.text
	.globl main
main:	
	move $t1,$a0 # argc
	move $t2,$a1 # *argv[]
	
	la $a0,str1
	li $v0,printString
	syscall 
	
	move $a0,$t1
	li $v0,printInt
	syscall
	
	li $t0,0
for: 
	bge $t0,$t1,endFor
	sll $t3,$t0,2
	addu $t4,$t2,$t3
	
	la $a0,str2
	li $v0,printString
	syscall 
	
	move $a0,$t0
	li $v0,printInt
	syscall
	
	la $a0, str3
	li $v0, printString
	syscall
	
	lw $a0,0($t4)
	li $v0,printString
	syscall
	
	addiu $t0,$t0,1
	j for
endFor:
	jr $ra