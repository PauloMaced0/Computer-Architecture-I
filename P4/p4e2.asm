#Mapa de registos 
#num: $t0
#p: $t1
# *p : $t2
	.data
	.eqv SIZE, 20
	.eqv SIZEmaisUM, 21
	.eqv readString, 8
	.eqv printInt, 1
str:	.space SIZEmaisUM
	.text
	.globl main
	
main:	
	la $a0,str # load address de str
	li $a1, SIZE # definir o numero de char que deve ler
	li $v0, readString # lê input
	syscall 
	
	la $t1,str #load address de str...p = str
while: 	
	lb $t2,0($t1) # load byte de str[i]
	beqz $t2,endWhile # while(*p != 0)
	blt $t2,'0',endIf # if(str[i] >= 0)
	bgt $t2,'9',endIf # if(str[i] <= 0)
	addi $t0,$t0,1 # num++
endIf:	
	addiu $t1,$t1,1 #p++
	j while
endWhile:
	move $a0,$t0
	li $v0,printInt
	syscall
	jr $ra