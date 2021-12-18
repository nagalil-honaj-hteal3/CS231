.data
	progDes: .asciiz "Program Description:\tUse assemble language to write power function.\n"
	author: .asciiz "Author:\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t09/20/2021\n"
	sep: .asciiz "==============================================================================================================================================\n"
	
	#loop
	answer: .asciiz "Your answer is: "
	
	#user inputs
	base: .asciiz "Enter a base number: "
	power: .asciiz "Enter a power for the base: "
	
	#errors
	arrow: .asciiz "==>"
	errorMsg: .asciiz "**** ERROR: "
	errorMsg1: .asciiz " is not a valid number. Enter another base number: "
	errorMsg2: .asciiz " is not a valid exponent number. Enter another power number: "
	case0:	.asciiz "Any integer that's power is equal to zero will have a result of 1."
.text 
	li $v0, 4		#cout
	la $a0, progDes		#outputs the progDes statement at .data
	syscall
	la $a0, author		#outputs the author statement at .data
	syscall			
	la $a0, date		#outputs the date statement at .data
	syscall
	la $a0, sep		#outputs the sep statement at .data
	syscall
	
	#li $s3, 0		#for counter increment
	li $s0, 0		#sets the s0 register to the value of 0
	li $s1, 12		#sets the s1 register to the value of 12
	li $s2, 1		#used to multiply the base number itself 
#user inputs__________________________________________________________________________________________________________________________________
readX:	#used to read the base number 
	li $v0, 4		#cout
	la $a0, base		#outputs the base statement at .data
	syscall
	li $v0, 5		#reads in the integer that the user will enter for the base
	syscall
	
	addi $t0, $v0, 0	#set the input register to a t0 register to store the value of the base
	bltz $t0, error1	#if the base is less than 0, or is a negative number, then it will go to error1
	bge $t0, $s1, error1	#if the base is greater than 12, then it will go to error1
	beqz $t0, error1	#if the base is zero

readY:	#used to read the power number  
	li $v0, 4
	la $a0, power		#outputs the power statement at .data 
	syscall
	li $v0, 5		#reads in the integer that the user will enter for the power
	syscall

	add $t1, $v0, $0	#set the input register to a t1 register to store the value of the power
	bltz $t1, error2	#if the power entered is less than 0, so meaning if it is a negative number or not an integer
	bge $t1, $s1, error2	#if the power entered is greater than 12, then it will be report that there is an error
	beqz $t1, error3	#if the power is equal to zero 

	li $t3, 0
#________________________________________________________________________________________________________________________________________________________
Loop:	#beq $t1, $s0, exit	#loops as long as the user's desired input for the power
	mul $s2, $s2, $t0	#used to multiply the base over and over again	
	addi $s0, $s0, 1	#increment register $s0 by 1
	beq $s0, $t1, exit	#if the loop counter is equal to the power/exponent
	j Loop			#jumps back to the loop until it matches the power
#errors__________________________________________________________________________________________________________________________________________________
error1: li $v0, 4
	la $a0, arrow		#outputs the arrow statement from the .data
	syscall
	la $a0, errorMsg	#outputs the errorMsg statement from the .data
	syscall
	
	li $v0, 1
	add $a0, $0, $t0	#gets the user input from the base value ($t0) and stores into the value onto register $a0
	syscall
	
	li $v0, 4
	la $a0, errorMsg1	#outputs the number the user enters with the errorMsg1 from the .data and asks the user to enter another number
	syscall
	
	j readX			#once the error has been caught, then it will jump back to the readX

error2:	li $v0, 4		#this error2 block will be used if the number (power) is either a negative/not an integer or greater than 12
	la $a0, arrow
	syscall
	la $a0, errorMsg	#this errorMsg is print out the statement from the .data
	syscall
	
	li $v0, 1
	add $a0, $0, $t1	#gets the user input from the power value ($t1) and stores it into register $a0
	syscall
	
	li $v0, 4
	la $a0, errorMsg2	#outputs the number the user enters with the errorMsg2 from the .data and asks the user to enter another number
	syscall

	j readY
	
error3: #if the exponent was zero
	li $v0, 4		#this error3 block will be used if the number (power) entered is zero
	la $a0, arrow		#from the .data
	syscall
	la $a0, errorMsg	#from the .data
	syscall
	
	#li $v0, 1
	#add $a0, $0, $t1
	#syscall
	
	li $v0, 4
	la $a0, case0		#prints out the case0 from the .data
	syscall

	li $v0, 10		#terminates the program
	syscall
		
exit:
	li $v0, 4
	la $a0, answer		#to output the value of the number that has been multiplied
	syscall
	
	li $v0, 1
	add $a0, $0, $s2	#gets the result of the value that has been evalued when it is being multiplied
	syscall
	
	li $v0, 10		#used to end the program
	syscall
