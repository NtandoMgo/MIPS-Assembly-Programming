.data       #declare memory and constants
    str: .space 1024 
    question: .asciiz "Enter n, followed by n lines of text:\n"
    message: .asciiz "The values are:\n"
.text       #
.globl      main
main:
	li $v0, 4
	la $a0, question
	syscall
	
	li $v0, 5
	syscall 
	
	move $s0, $v0
	la $s1, str
	la $t0, str
get_word:
	li $v0, 8
	la $a0, ($s1)
	li $a1, 20
	syscall

	sub $s0, $s0, 1
	add $s1, $s1, 20
	bne $s0, 0, get_word
	
    	la $a0, message	
	li $v0, 4
	syscall
output:
	sub $s1, $s1, 20

	li $v0, 4
	move $a0, $s1
	syscall
	
	bne $s1, $t0, output
	
	li $v0, 10
	syscall 
	
	
	
	
	
	
	
	