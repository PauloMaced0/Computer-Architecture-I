	.data
str1:	.asciiz "Uma string qualquer"
str2:	.asciiz "AC1 - P"
str3: 	.asciiz "So para chatear\n"
	.eqv print_string,4
	.text
	.globl main
main: 	la $a0,str3
	
	ori $v0,$0,print_string
	syscall
	jr $ra
	
