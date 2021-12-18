.data
	progDes: .asciiz "Program Description:\t\tA program that sums up multiples of 6 entered by a user.\n"
	author: .asciiz "Name:\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t\t09/15/2021\n"
	sep: .asciiz "====================================================================================================================\n"
	question: .asciiz "How many positive numbers that are devisable by 6 do you want to add?\n"
	enterNum: .asciiz "Enter a number: "
	sum: .asciiz "The sum of the positive numbers between 1 and 100 that are devisable by 6 is: "
	
	arrow: .asciiz "==> "
	divis: .asciiz " is divisible by 6\n"
	notDiv: .asciiz " is not divisible by 6. Enter another number.\n"
	errorMsg: .asciiz "**** ERROR: "
	posError: .asciiz " is not a positive number. Enter another number.\n"
	rangeError: .asciiz " is not in the range of 1 to 100. Enter another number.\n"
.text
main:
	li $v0, 4		#cout
	la $a0, progDes		#gets the .data statement from the progDes and outputs the following statement
	syscall		
	la $a0, author		#gets the author variable and prints out the statement
	syscall
	la $a0, date		#gets the date variable and outputs the statement
	syscall
	la $a0, sep		#this is used to separate the header with the code
	syscall
	la $a0, question	#used to ask the question to the user and set that number for the counter to 
	syscall
#_____________________________________________________________________________________________________________________________________________________
#for loop
	li $v0, 5		#cin to read the integer the user entered 
	syscall
	
	add $t0, $v0, $0	#stores in the integer the user has entered to set the max number for counter

	li $s0, 0		#sets the value $s0 to zero for the counter
	li $s2, 100		#used for the max range 
	li $s3, 6		#used for the division
	li $s4, 0		
	
begin: 
	beq $t0, $s0, done 	#this line sets the for loop for how many times the user wants to enter integers	
		
	li $v0, 4
	la $a0, enterNum
	syscall
			
	li $v0, 5
	syscall
	
	add $t1, $0, $v0	#stores in the number that the user inputted
	bgt $t1, $s2, error1	#if the number inserted is greater than 100
	beq $t1, $s4, error1	#if the number is greater than 100 or equal to 0
	blt $t1, $s4, error2 	#if the number inserted was not a positive number

	div $t1, $s3		#divide the number that is inserted by 6
	mfhi $t2		#to prove that it is the remainder
	#mflo $t3		#quotient
	
	bne $t2, $s4, error3	#if the number has a remainder and not divisible by six
	
	li $v0, 4
	la $a0, arrow
	syscall		
	li $v0, 1
	add $a0, $0, $t1	#used to get the number that is the dividened of six 
	syscall
	li $v0, 4
	la $a0, divis		#outputs the statement if the number is a dividend
	syscall
	
	add $t3, $t3, $t1	#the total sum of the numbers inserted
	
	addi $s0, $s0, 1	#used for the counter
	j begin
	
error1:				#if the number is not in the range so if it is greater than 100 or equal to 0
	li $v0, 4
	la $a0, arrow		#from .data
	syscall
	la $a0, errorMsg	#from .data
	syscall
	li $v0, 1
	add $a0, $0, $t1
	syscall
	la $v0, 4
	la $a0, rangeError	#from .data
	syscall
	j begin

error2:				#if the number is negative
	li $v0, 4
	la $a0, arrow
	syscall
	la $a0, errorMsg
	syscall
	li $v0, 1
	add $a0, $0, $t1
	syscall
	li $v0, 4
	la $a0, posError	#from .data
	syscall
	j begin
	
error3:				#if the number is not divisible by 6
	li $v0, 4
	la $a0, arrow
	syscall
	li $v0, 1
	add $a0, $0, $t1
	syscall
	li $v0, 4
	la $a0, notDiv		#from .data
	syscall
	j begin
	
done: 
	li $v0, 4
	la $a0, sum		#outputs the sum statement in the .data
	syscall
	
	li $v0, 1
	add $a0, $0, $t3	#outputs the sum
	syscall
	
	li $v0, 10
	syscall
