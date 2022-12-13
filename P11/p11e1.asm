	# OFFSETS
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	# SYSCALLS
	.eqv printString, 4
	.eqv printInt, 1
	.eqv printFloat, 2
	.eqv readInt,5
	.eqv readString,8
	.data	
	.align 2
	# STRUCT 
student:.word 72343
	.asciiz "Napoleao"
	.space 9
	.asciiz "Bonaparte"
	.space 5 
	.float 5.1

print1:	.asciiz "\nN. Mec: "
print2:	.asciiz "\nNome: "
print3:	.asciiz","
print4:	.asciiz "\nNota: "
print5:	.asciiz "Primero nome: "
print6:	.asciiz "\n"
	.text
	.globl main
main:	la $a0,print1
	li $v0,printString #print_string("\nN. Mec: ")
	syscall
	
	la $t0,student # &student
	
	lw $a0,id_number($t0)
	li $v0,printInt # print_intu10(stg.id_number)
	syscall
	
	la $a0,print2
	li $v0,printString # print_string("\nNome: ")
	syscall
	
	addiu $a0,$t0,last_name 
	li $v0,printString # print_string(stg.last_name)
	syscall
	
	la $a0,print3
	li $v0,printString # print_char(',');
	syscall
	
	addiu $a0,$t0,first_name
	li $v0,printString # print_string(stg.first_name)
	syscall
	
	la $a0,print4
	li $v0,printString # print_string("\nNota: ");
	syscall
	
	l.s $f12,grade($t0)
	li $v0,printFloat # print_float(stg.grade)
	syscall
	
	la $a0,print1
	li $v0,printString # print_str("N. Mec: ")
	syscall
	
	li $v0,readInt
	syscall 
	
	sw $v0,id_number($t0) # stg.id_number = read_int();
	
	la $a0,print5
	li $v0,printString # print_string("Primeiro Nome: ");
	syscall
	
	addiu $a0,$t0,first_name
	li $a1,17
	li $v0,readString # read_string(stg.first_name, 17);
	syscall
	
	la $a0,print1
	li $v0,printString # print_str("N. Mec: ")
	syscall
	
	la $t0,student
	
	lw $a0,id_number($t0)
	li $v0,printInt # print_intu10(stg.id_number)
	syscall
	
	la $a0,print2
	li $v0,printString # print_string("\nNome: ")
	syscall
	
	addiu $a0,$t0,last_name
	li $v0,printString # # print_string(stg.last_name)
	syscall
	
	la $a0,print3
	li $v0,printString # ","
	syscall
	
	addiu $a0,$t0,first_name
	li $v0,printString # print_string(stg.first_name)
	syscall
	
	la $a0,print4
	li $v0,printString # # print_string("\nNota: ");
	syscall
	
	l.s $f12,grade($t0)
	li $v0,printFloat # # print_float(stg.grade)
	syscall

	li $v0,0
	jr $ra # return 0