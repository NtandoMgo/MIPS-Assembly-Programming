.data
spaceofstring: .space 1000
instruction : .asciiz "Enter a sum:\n"
output: .asciiz "The value is:\n"
newline: .asciiz "\n"
.text
 main:
    li $v0,4
    la $a0,instruction
    syscall

    la $a0,spaceofstring
    li $a1,1000
    li $v0,8
    syscall

    li $t4,10
    la $t0,spaceofstring
    li $t2,0
     li $t6,0
     li $t7,0
     b sum_loop
getsign:
    li $t3,1
    lb $t1,($t0)
    beq $t1,'+',addition
    j sum_loop
addition:
	add $t7,$t7,$t2
    	addu $t0,$t0,1
    	li $t2,0
    	j getsign
 sum_loop:
	lb $t1,($t0)
    	addu $t0,$t0,1
    	beq $t1,10, _sum_loop
    	blt $t1,'0', _sum_loop
    	bgt $t1,'9', _sum_loop
    	mult $t2,$t4
    	mfhi $t5
    	mflo $t2
    	sub $t1,$t1,'0'
    	add $t2,$t2,$t1
 	b getsign
 _sum_loop:
	add $t7,$t7,$t2
    	mul $t2,$t2,$t3
	li $v0,4
	la $a0,output
	syscall
	move $a0,$t7
    	li $v0,1
    	syscall

    	la $a0,newline
    	li $v0,4
    	syscall

    	b exit
 exit:
    li $v0,10
    syscall

