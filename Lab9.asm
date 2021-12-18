.data
	#header
	progDes: .asciiz "Program Description:\tSubroutine And Stack – Decimal To Binary\n"
	author: .asciiz "Author:\tElaeth Lilagan\n"
	sep: .asciiz "==========================================================================================================================\n"
	#program
	cin: .asciiz "Input an integer in decimal form:\t"
	cout: .asciiz "The number "
	cout2: .asciiz " in binary is:\t"
.text
	#outputs for the header inside of the program
	li $v0, 4
	la $a0, progDes		#output statement for the program
	syscall
	la $a0, author		#output statement for my name
	syscall
	la $a0, sep		#output statement to separate different areas of the program
	syscall
	la $a0, cin		#outputs statement to enter in a integer
	syscall

	li $v0, 5
	syscall
	add $a0, $v0, $0	#passing argument to be passed in the BaseChange function
	add $s0, $v0, $0	#stores in the user input
	
	jal BaseChange		#used to do the binary conversion
	
	li $v0, 10		#terminate the program
	syscall
	
BaseChange:	#used to convert decimal to binary
	
	li $s1, 32		#for 32 digits
	li $s2, 2		#to divide the decimal by 2 to get the remainder and integer
	li $s3, 0		#initialize the counter
	
	add $t0, $a0, $0 	#used to store the address $a0 from the main to $t0
#The output statements_____________________________________________________________________________________________________________
	li $v0, 4
	la $a0, cout		#first part of the output
	syscall
	
	add $a0, $0, $s0	#used to set the base number (10) inside of the output statement
	li $v0, 1		#to set the integer output
	syscall
	
	li $v0, 4
	la $a0, cout2		#output the second half of the cout statement
	syscall
#Binary conversion__________________________________________________________________________________________________________________
Loop1:	#will be used recursively to divide until the quotient is zero
	beq $t0, $0, Loop2	#until the quotient is zero
	
	div $t0, $s2		#divide the base with two to get the quotient and remainder
	mfhi $t1		#remainder
	mflo $t0		#quotient -- setting it the new base
	#push $t1 to the stack
	addi $sp, $sp, -4	#to add in new space within the stack
	sw $t1, 0($sp)		#setting the remainders to the stack
	
	addi $s3, $s3, 1	#starting the counter	
	addi $s4, $s4, 1
	
	j Loop1
	
Loop2:	#will be used to output the zeroes within 32 bits
	beq $s1, $s3, Loop3	#until there are no more spots left
	
	li $a0, 0		#print zero
	li $v0, 1
	syscall
	
	addi $s3, $s3, 1	#increment the counter by 1
	
	j Loop2
	
Loop3:	#will be used to pop and print out the numbers
	beq $s4, $0, exit	#until everything is popped
	
	lw $a0, 0($sp)		#load the updated version of the stack
	li $v0, 1		#store it into an integer
	syscall
	
	addi $sp, $sp, 4	#pop and moves to the next part of the stack
	sub $s4, $s4, 1		#subtract the counter
	j Loop3

exit:	jr $ra
