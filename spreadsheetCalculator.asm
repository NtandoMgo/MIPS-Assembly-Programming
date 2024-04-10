.data
	aray: .space 4000
	input: .space 4000
	instruction1: .asciiz "Enter n and formulae: \n"
	instruction2: .asciiz "The values are: \n"
	newline: .asciiz "\n"
	

		
.text
	main:
		la $s1,input
	
		li $v0, 4
		la $a0, instruction1
		syscall

		li, $v0, 5
		syscall
		
		move $s0, $v0
		mul $s0, $s0, 4
		
		addi $t0, $zero, 0
		addi $t3, $zero, 0
		
		while:  
			beq $s0, $t0, exit
			
			li, $v0, 8
			move $a0, $s1
			li $a1, 20
			syscall
			
			move $t1, $a0
			sw $t1, aray($t0)
			addi $t0,$t0,4
			addi $s1,$s1,20
			j while 
		exit:
			
		li $v0, 4
		la $a0, instruction2
		syscall
		
		addi $t4, $zero, 0
		
		addi $t7, $zero, 0
		
		loop_Through_Inputs:
			beq $t4, $t0, leave
			lw $t2, aray($t4)
			move $t6, $t2
			jal cleanNumber
			li $v0, 1
			move $a0, $t3
			syscall
				
			li $v0, 4
			la $a0, newline
			syscall
			
			add $t7,$t7,$t3
			addi $t4, $t4, 4

			j loop_Through_Inputs			
	
		leave:	
			li $v0, 1
			move $a0, $t7
			syscall
				
			li $v0, 4
			la $a0, newline
			syscall	
				
			li $v0, 10
			syscall
			
	li $v0,10
	syscall
	
	
	cleanNumber:
			add $t3, $zero,$zero 			 
			sumCalculatorLoop:
				lb $t5, 0($t6)
				beq $t5, 10,end
				beq $t5, 61,Index
		
				bne $t5, 10,CombineTerms
			
				j sumCalculatorLoop
			
			CombineTerms:
				mul $t3, $t3, 10
				andi $t5,$t5,0x0F
				add $t3, $t3, $t5
				addi $t6, $t6, 1
				j sumCalculatorLoop
				
				
			CombineIndex:
				mul $t3, $t3, 10
				andi $t5,$t5,0x0F
				add $t3, $t3, $t5
				addi $t6, $t6, 1
				j whileLoop
				
			end:
				jr $ra
				
			Index:
				addi $t6, $t6, 1
				
				whileLoop:
					lb $t5, 0($t6)
					
					beq $t5, 10,endIndex
					
					bne $t5, 10,CombineIndex
					j whileLoop
			
				jr $ra
				
			endIndex:
				mul $t3, $t3, 4
				
				lw $t6, aray($t3)
				
				addi $sp,$sp, -4
				sw $ra, 0($sp)
				
				jal cleanNumber
				
				lw $ra, 0($sp)
				addi $sp,$sp, 4
				
				
		jr $ra
