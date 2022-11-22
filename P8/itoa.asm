# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
	.text
	.globl itoa
itoa:	addiu $sp,$sp,-20
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a2
do:
	rem $t0,$s0,$s1
	div $s0,$s0,$s1
	
	move $a0,$t0
	jal toascii
	
	sb $v0,0($s3)
	addiu $s3,$s3,1	
dowhile: bgtz $s0,do
	li $s3,'\0'
	
	move $a0,$s2
	jal strrev
		
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	addiu $sp,$sp,20
	jr $ra
