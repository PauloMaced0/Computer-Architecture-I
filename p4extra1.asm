#Acesso com ponteiros
# p : $t0
# *p : $t2
	.data
	.eqv printString,4
	.eqv readString,8 
	.eqv SIZE, 20
	.eqv SIZE1, 21
str: 	.space SIZE1
	.text
	.globl main
main: 	
	la $a0,str # copiar a string para o endereço de string
	li $a1,SIZE # ler string com o tamanho size
	li $v0,readString
	syscall
	
	la $t0,str # p = str
while:	
	lb $t2,0($t0) # $t2 = str[i]
	beqz $t2,endWhile # while(*p != '\0')
	blt $t2,'a',endIf
	bgt $t2,'z',endIf
	sub $t2,$t2,0x20 # *p = *p - 'a' + 'A'
	sb $t2,0($t0)
endIf:
	addiu $t0,$t0,1 # p++
	j while
endWhile:
	la $a0, str
	li $v0, printString
	syscall
	jr $ra	
