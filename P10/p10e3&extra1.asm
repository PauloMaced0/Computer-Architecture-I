	.text
######## MEDIAN ######## double *array, int nval)	
median:	
do: 	li $t0,0 # houveTroca = False
	li $t1,0 # i = 0
	move $t2,$a1
	addiu $t2,$t2,-1
	for: bge $t1,$t2,endFor
		sll $t3,$t1,3
		addu $t4,$t3,$a0 # array[i]
		l.d $f0,0($t4) # array[i]
		l.d $f2,8($t4) # array[i + 1]
		
		if:  	c.le.d $f0,$f2
			bc1t endIf
			s.d $f2,0($t4) 
			s.d $f0,8($t4) # array[i] = array[i+1]
			li $t0,1 # houveTroca = TRUE
		endIf:
	
		addiu $t1,$t1,1
		j for
	endFor:
while: beq $t0,1,do
	rem $t0,$a1,2
	la $t3,d8 # 2.0
	l.d $f8,0($t3)
	# cvt.d.w $f8,$f8
	if_2: bnez $t0,else_2
		srl $t2,$a1,1
		sll $t1,$t2,3
		addu $t2,$t1,$a0
		l.d $f0,0($t2)
		l.d $f2,8($t2)
		add.d $f4,$f0,$f2
		div.d $f0,$f4,$f8
		j endIf_2
	else_2:	
		srl $t2,$a1,1
		sll $t1,$t2,3
		addu $t2,$t1,$a0
		l.d $f0,0($t2)
	endIf_2:
	jr $ra
	
	
######## MAX ######## (double *p, unsigned int n)
max:	move $t0,$a0 # *p
	move $t1,$a1 # n
	
	sll $t2,$t1,3
	addu $t3,$t0,$t2 # *u = p + n
	addiu $t2,$t2,-8 # *u = p+ n - 1
	
	l.d $f0,0($t0)
	addiu $t0,$t0,8
whileMax:	bgt $t0,$t3,endWhileMax
	
	l.d $f2,0($t0)
	ifMax:	c.le.d $f2,$f0
		bc1t endIfMax
		mov.d $f0,$f2
	endIfMax:
	addiu $t0,$t0,8
	j whileMax
endWhileMax:
	jr $ra
	

######## AVERAGE ######## (double *array, int n)
average:
	move $t0,$a0
	move $t1,$a1 # n
	l.d $f0,d1 # double sum = 0.0
	
	move $t3,$a1 # i = n 
forAverage:	blez $t3,endForAverage
	
	addiu $t3,$t3,-1
	sll $t4,$t3,3
	addu $t2,$t0,$t4
	
	l.d $f2,0($t2)
	add.d $f0,$f0,$f2
	
	j forAverage
endForAverage: 
	mtc1 $t1,$f4
	cvt.d.w $f4,$f4
	div.d $f0,$f0,$f4
	
	jr $ra
	

######## F2C ######## f2c(double ft)
f2c:	la $t0,d4 # 5.0
	la $t1,d5 # 9.0
	la $t2,d6 # 32.0
	l.d $f2,0($t0)
	l.d $f4,0($t1)
	l.d $f6,0($t2)

	div.d $f2,$f2,$f4
	sub.d $f8,$f12,$f6
	mul.d $f0,$f2,$f8
	
	jr $ra

######## XTOY ######## (float x, int y)
xtoy:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s2,$a0
	li $s0,0
	l.s $f0,d7 # result = 1.0
	
	jal abs
	move $s1,$v0
forXtoy:	bge $s0,$s1,endForXtoy	
ifXtoy:	blez $s2,elseXtoy
	mul.s $f0,$f0,$f12
	j endIfXtoy
	elseXtoy: 
	div.s $f0,$f0,$f12
endIfXtoy:
	addiu $s0,$s0,1
	j forXtoy
endForXtoy:
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	jr $ra		


######## ABS ######## (int val)
abs: 	
	li $t0,0xFFFFFFFF
if2:	bgez $a0,endIf2
	xor $a0,$a0,$t0
	addiu $a0,$a0,1
endIf2:
	move $v0,$a0
	jr $ra
	
	
######## VAR ######## (double *array, int nval)
var: 	addiu $sp,$sp,-28
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	s.s $f20,16($sp)
	s.s $f22,20($sp)
	sw $s3,24($sp)
	# average(*array, nval)
	jal average
	cvt.s.d $f20,$f0
	
	li $s0,0
	l.d $f22,d1
	move $s1,$a0 # &array[0]
	move $s2,$a1 #  $s2 = nval
	forVar:	bge $s0,$s2,endForVar
		
		sll $s3,$s0,3
		addu $s3,$s3,$s1 
		l.d $f12,0($s3) # array[i]
		cvt.s.d $f12,$f12 # (float)array[i]
		sub.s $f12,$f12,$f20 # (float)array[i] - media
		li $a0,2
		jal xtoy
		add.s $f22,$f22,$f0 # soma += xtoy((float)array[i] - media, 2);
	
		addiu $s0,$s0,1 # i++
		j forVar
	endForVar:
	mtc1 $s2,$f4
	cvt.d.s $f4,$f4
	cvt.d.s $f22,$f22
	
	mov.d $f0,$f22 # return (double)soma / (double)nval
	lw $ra,0($sp)
	lw $s0,0($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	l.s $f20,16($sp)
	l.s $f22,20($sp)
	lw $s3,24($sp)
	addiu $sp,$sp,28
	jr $ra

				
######## SQRT ######## (double val)												
sqrt:	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)
	
	li $s0,0 # i = 0
	l.d $f8,d2 # 0.5
	l.d $f0,d3 # xn = 1.0
	l.d $f2,d1 # 0.0 
	ifSqrt: c.le.d $f12,$f2 # f(val > 0.0)
	bc1t elseSqrt
		doSqrt: 
			mov.d $f4,$f0 # aux = xn
			
			div.d $f6,$f12,$f0 # val/xn
			add.d $f10,$f0,$f6 # xn + val/xn);
			mul.d $f0,$f8,$f10 # xn = 0.5 * (xn + val/xn);
			
			addiu $s0,$s0,1 # i++
			
			c.eq.d $f4,$f0
			bc1t endIfSqrt
		whileSqrt:	blt $s0,25,doSqrt # while((aux != xn) && (++i < 25)
		j endIfSqrt
	elseSqrt:
		l.d $f0,d2
	endIfSqrt:
	
	lw $s0,4($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra
	
	
######## STDEV ######## (double *array, int nval)
stdev:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	jal var
	mov.d $f12,$f0
	jal sqrt

	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
							
######## MAIN ########
	.data
	.eqv printDouble,3
	.eqv readInt,5
	.eqv printString,4
	.eqv SIZE,11 
	.eqv SIZEMENOSUM,10
d1:	.double 0.0
d2:	.double 0.5
d3:	.double 1.0
d4:	.double 5.0
d5:	.double 9.0
d6:	.double 32.0
d7:	.float 1.0
d8:	.double 2.0
print1:	.asciiz "["
print2:	.asciiz "]"
print3:	.asciiz ", "
print4:	.asciiz "Temperatura máxima: "
print5:	.asciiz "Média:	"
print6:	.asciiz "Mediana: "
print7:	.asciiz "Desvio padrão:	"
print8:	.asciiz "Variância: "
print9:	.asciiz "Array inicial -> "
print10:.asciiz "Array ordenado -> "
print11:.asciiz "\n"
separator:.asciiz "#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#"
	.align 3
array: 	.space 88 # change to 88
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	li $s0,0 # i = 0
	
forMain:bge $s0,SIZE,endForMain
	la $s1,array # &array[0]
	sll $s2,$s0,3
	addu $s1,$s1,$s2
	
	li $v0,readInt
	syscall
	
	# converter as temperaturas do array em graus
	mtc1 $v0,$f12
	cvt.d.w $f12,$f12
	jal f2c
	# armaxenar num array de reais de precisão dupla
	s.d $f0,0($s1)
	
	addiu $s0,$s0,1
	j forMain
endForMain:
	la $a0,separator
	li $v0,printString # "#-#...."
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
		
	# Mostrar conteúdo do array(desordenado)
	la $a0,print9
	li $v0,printString # "array inicial"
	syscall
	
	la $a0,print1 
	li $v0,printString # "["
	syscall
	
	li $s0,0 # i = 0
for2:	bge $s0,SIZE,endFor2
	la $s1,array # &array[0]
	sll $s2,$s0,3
	addu $s1,$s1,$s2
	
	l.d $f12,0($s1)
	li $v0,printDouble
	syscall
	
	if_print: beq $s0,SIZEMENOSUM,endIf_print
		la $a0,print3 # ", "
		li $v0,printString 
		syscall
	endIf_print:
	addiu $s0,$s0,1
	j for2
endFor2:
	
	la $a0,print2 # "]"
	li $v0,printString
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	# Mostrar temperatura máxima
	la $a0,print4 # "temperatura maxima"
	li $v0,printString
	syscall
	
	la $a0,array
	li $a1,SIZE
	jal max
	
	mov.d $f12,$f0 # print max
	li $v0,printDouble
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	# Mosrar temperatura média e mediana
	la $a0,print5 # "Media"
	li $v0,printString
	syscall
	
	la $a0,array
	li $a1,SIZE
	jal average
	
	mov.d $f12,$f0 # print average
	li $v0,printDouble
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	la $a0,print6 # "Mediana"
	li $v0,printString
	syscall
	
	la $a0,array
	li $a1,SIZE
	jal median
	
	mov.d $f12,$f0 # print median
	li $v0,printDouble
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	# Variância da amostra
	la $a0,print8 # "Variancia"
	li $v0,printString
	syscall
	
	la $a0,array
	li $a1,SIZE
	jal var
	
	mov.d $f12,$f0 # print var
	li $v0,printDouble
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	# Desvio padrão da amostra
	la $a0,print7 # "desvio padrao"
	li $v0,printString
	syscall
	
	la $a0,array
	li $a1,SIZE
	jal stdev
	
	mov.d $f12,$f0 # print desvio padrao
	li $v0,printDouble
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	# Mostrar conteúdo do array (ordenado\)
	li $s0,0
	
	la $a0,print10 # "array ordenado"
	li $v0,printString
	syscall
	
	la $a0,print1 
	li $v0,printString # "["
	syscall
for2Main:	bge $s0,SIZE,endFor2Main
	la $s1,array # &array[0]
	sll $s2,$s0,3
	addu $s1,$s1,$s2

	l.d $f12,0($s1)
	li $v0,printDouble
	syscall
	
	if_print2: beq $s0,SIZEMENOSUM,endIf_print2
		la $a0,print3
		li $v0,printString # ", "
		syscall
	endIf_print2:
	addiu $s0,$s0,1
	j for2Main
endFor2Main:
	
	la $a0,print2 # "]"
	li $v0,printString
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	la $a0,separator
	li $v0,printString # "#-#...."
	syscall
	
	la $a0,print11 # "\n"
	li $v0,printString
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	li $v0,0
	jr $ra
	
