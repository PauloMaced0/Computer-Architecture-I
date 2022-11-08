EXERCICIO 1
#Mapa de registos 
# val : $t0
# n: $t1
# min: $t2
# max: $t3
.data
str1: "Maximo/minimo sao:\n"
str2: ':'
str3: "Digite ate 20 inteiros (zero para terminar):"
.eqv printInt,1
.eqv printString, 4
.eqv readInt,5
.text
.globl main

main:
li $t1 = 0
li $t2 = 0x7FFFFFFF
li $t3 = 0x80000000 

li $a0,str3
li $v0,printString
syscall

do:
li $v0,readInt
syscall

move $t0, $v0

if: 
beqz $t0,endif
if2:
ble $t0,$t3,if3
move $t3,$t0
if3:
bge $t0,$t2,endif
move $t2, $t0
endif:
addiu $t1,$t1,1

blt $t1,20,while
while : bnez $t0,do	

la $a0,str1
li $v0,printString
syscall

move $a0,$t3
li $v0,printInt
syscall

la $a0,str2
li $v0,printString
syscall

move $a0,$t2
li $v0,printInt
syscall

jr $ra






#EXERCICIO 2
#Mapa de registos
# i = $t0
# v = $t1
# &(val[0]) = $t3
# val[i] = $t5
.data
.eqv SIZE,8
.eqv halfSIZE, 4
.eqv printChar,11
.eqv printString, 4
.eqv printInt,1
str1 : "Result is: \n"
.align 2
arr: .word 8, 4, 15, -1987, 327, -9, 27, 16
.text
.globl main

main:
li $t0, 0
la $t3, arr
do:
sll $t4,$t0,2 # $t4 = i * 4
addu $t1, $t4, $t3 # $t1 = (i * 4) + &arr[0]
lw $t6,0($t1) 

li $t5,halfSize
addu $t5,$t5,$t0
sll $t5,$t5,2
addu $t5, $t5, $t3 # $t5 = (i * 4) + &arr[0]
lw $t9,0($t5)

sw $t6,0($t5) # val[i] = val[i + size/2]
sw $t9,0($t1) # val[i + size/2] = val[i]

addiu $t0,$t0,1
doWhile: blt $t0,halfSIZE,do

la $a0,str1
li $v0,printString
syscall

li $t0,0
la $t1,arr
do2:
sll $t2,$t0,2
addu $t1, $t2,$t1
lw $a0,0($t1)

li $v0,priintInt
syscall

li $a0,','
li $v0,printChar
syscall

addiu $t0,$t0,1
doWhile2: blt $t0,SIZE,do2

jr $ra






# EXERCICIO 3
# Mapa de registos
# n_even: $t0 
# n_odd: $t1
# p1: $t2
# p2: $t3
.data
.eqv N, 140
.eqv readInt,5
.eqv printInt,1
a : .space 140
b : .space 140
.text
.globl main
main:
li $t0,0
li $t1,0

la $t2,a
addiu $t4,$t2,N
for: bge $t2,$t4,endFor
move $a0,$t2
li $v0,readInt
syscall
addiu $t2,$t2,4
j for
endFor:

la $t2,a
la $t3,b
for2: bge $t2,$t4,endFor2

rem $t5,$t2,2
if: beqz $t5,else
lw $t6,0($t2)
addiu $t3,$t3,4
sw $t6,0($t3)
addi $t1,$t1,1
else:
addi $t0,$t0,1
addiu $t2,$t2,4
j for2
endFor2:

la $t3,b
for3:
li $t5,b
addiu $t5,$t5,$t1
bge $t3,$t5,endFor3
lw $t6,0($t3)
move $a0,$t6
li $v0,printInt
syscall
addiu $t3,$t3,4
j for3
endFor3:
jr $ra













































