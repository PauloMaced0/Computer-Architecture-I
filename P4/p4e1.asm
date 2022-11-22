#Mapa de registos 
# num :	$t0
# i : $t1
# str : $t2
# str + i : $t3
# str[i] : $t4
	.data
	.eqv SIZE,21
	.eqv readString,8
	.eqv printInt,1
str: 	.space  SIZE	
	.text
	.globl main
main : 	la $a0,str # copiar a string para o endereço de string
	li $a1,SIZE # ler string com o tamanho size
	li $v0,readString
	syscall
	
	li $t0, 0 # num = 0
	li $t1, 0 # i = 0
while :
	la $t2,str # $t2 = endereço de str
	addu $t3,$t2,$t1 # $t3 = endereço inical($t2) + i(depende do tipo de variavel)
	lb $t4, 0($t3) # load byte do endereço $t3
	beq $t4,'\0',endWhile #while str[i] != 0
if:	blt $t4,'0',endif #if str[i] >= 0
	bgt $t4, '9', endif # if str[i] <= 9
	addi $t0,$t0,1 # num ++
endif:
	addi $t1,$t1,1 # i++ 
	j while
endWhile:
	la $a0,str #print num
	li $v0,printInt
	syscall 
	
	jr $ra 
