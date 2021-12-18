.data
	progDes: .asciiz "Program Description:\t\tThis program is written to mimic a very basic calculator\n"
	author: .asciiz "Author:\t\t\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t\t\t09/12/2021\n"
	separate: .asciiz "==========================================================================================\n"
	int: .asciiz "Please input the two numbers:\n"
	int2: .asciiz ""
	sum: .asciiz "\nSum is:\t\t\t"
	diff: .asciiz "\nDifference is:\t\t"
	prod: .asciiz "\nProduct is:\t\t"
	quo: .asciiz "\nQuotient is:\t\t"
	remainder: .asciiz "\nRemainder is:\t\t"
.text					#used for inputs and outputs for the user
main: 					#main function
	li $v0, 4 			#cout
	la $a0, progDes 		#The program description statement from .data
	syscall
	
	li $v0, 4			#cout
	la $a0, author			#The author statement from .data
	syscall
	
	li $v0, 4			#cout
	la $a0, date			#The date statement from .data
	syscall
	
	li $v0, 4			#cout
	la $a0, separate		#The seperate statement with lots of '=' from .data
	syscall
#_______________________________________________________________________________________________________________________	
	li $v0, 4			#cout
	la $a0, int			#The first integer to be used from the user input
	syscall
	
	li $v0, 5			#read the first integer from the user
	syscall
	
	#move $t0, $v0			#Used to reuse the first integer from the user input for other operations
	add $t0, $0, $v0		#stores $v0 to $t0 which is int
	
	li $v0, 4			#cout
	la $a0, int2			#The second integer to be used from the user input 
	syscall
	
	li $v0, 5			#read the second integer from the user
	syscall
	#move $t1, $v0			#Used to reuse the second integer for the other operations
	add $t1, $0, $v0		#stores $v0 to $t1 which is int2
	
	add $t2, $t0, $t1		#Adds both integers the user has inputted
	
	li $v0, 4			#cout
	la $a0, sum			#Outputs the sum statement 
	syscall
	
	li $v0, 1			#print the contents ofthe sum which is an integer
	#move $a0, $t2			#Outputs the sum that was calculated
	add $a0, $zero, $t2 		#Outputs the sum that was calculated
	syscall	
	
	sub $t3, $t0, $t1		#Subtracts the numbers used from the user inputs
	
	li $v0, 4			#cout
	la $a0, diff			#Outputs the diff statement at data
	syscall
	
	li $v0, 1			#cout
	add $a0, $zero, $t3		#Outputs what the difference of the two numbers are based on the inputs
	#move $a0, $t3			
	syscall
	
	mult $t0, $t1			#Gets both the numbers that the user inputs and multiplies both
	mfhi $t4			#Move the value of hi register into $t4
	mflo $t5			#Move the value of lo register into $t5
	
	li $v0, 4			#cout
	la $a0, prod			#Outputs the product varaiable from .data
	syscall
	
	li $v0, 1			#cout
	add $a0, $t5, $0		#Outputs the lo value from the product
	#move $a0, $t5			
	syscall
	
	div $t0, $t1			#Gets both numbers and divide the integers from user input
	mfhi $t6			#Used to get the remainder from the division
	mflo $t7			#Used to get the quotient from the division
	
	li $v0, 4			#cout
	la $a0, quo			#Outputs the quo variable from .data
	syscall
	
	li $v0, 1			#reads integer
	add $a0, $t7, $0		#Gets the quotient
	#move $a0, $t7			
	syscall
	
	li $v0, 4			#cout
	la $a0, remainder		#Outputs the remainder from the .data
	syscall
	
	li $v0, 1			#reads integer
	add $a0, $t6, $0		#Gets the remainder
	#move $a0, $t6			
	syscall
	
	li $v0, 10			#Used to terminate the program
	syscall
