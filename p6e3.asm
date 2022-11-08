# Mapa de registos
# i = $t0
# j = $t1
# array[i] [j] = $t2
	.data
	.eqv printString, 4
	.eqv printChar, 11
	.eqv SIZE, 3
array: 	.word str1, str2, str3 
srt1:	.asciiz "Array"
str2:	.asciiz "de"
str3: 	.asciiz "ponteiros"
	.text 
	.globl main
main:	