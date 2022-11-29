	.data
	.eqv readInt,5 
	.eqv printFloat,2
f1:	.float 2.59375
f2:	.float 0.0
	.text
	.globl main
main:	
do:	li $v0,readInt
	syscall
	move $t0,$v0
	la $t1,f1 # load f1 to $t1
	l.s $f2,0($t1)
	mtc1 $t0,$f0 # move to coprocessor1
	cvt.s.w $f0,$f0 # convert word to single precision
	mul.s $f2,$f2,$f0 # res = (float)val * 2.59375
	
	mov.s $f12,$f2
	li $v0,printFloat
	syscall
	
	l.s $f4,f2
	c.eq.s $f2,$f4
	bc1f do
while:	
	li $v0,0
	jr $ra
