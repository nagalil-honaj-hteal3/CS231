.data
	progDes: .asciiz "Program Description:\t\tPrint Output"
	author: .asciiz "\nAuthor:\t\tElaeth Lilagan"
	date: .asciiz "\nCreation Date:\t\t09/13/2021"
	separate: .asciiz "\n============================================================="
	userInput: .asciiz "\nHow many numbers do you like to add together? "
	sum: .asciiz "\nThe sum of the numbers are "
.text
main:
	li $v0, 4		#cout
	la $a0, progDes		#the program description statement from .data
	syscall
	
	li $v0, 4		#cout
	la $a0, author		#the author statement from .data
	syscall
	
	li $v0, 4		#cout 
	la $a0, date		#the date statement from .data
	syscall
	
	li $v0, 4		#cout
	la $a0, separate	#the ====== to border the program
	syscall
#_________________________________________________________________________________________________________
	#for loop
	li $s0, 0		#the counter set to 0
	
	li $v0, 4		#cout
	la $a0, userInput	#getting the user input to be set as the max counter for the for loop
	syscall

	li $v0, 5		#reads the integer for counter
	syscall
	
	add $s1, $v0, $0	#stores in the max counter from the input the user has entered
	
	li $t4, 2	#address for 2
	
	begin: beq $s0, $s1, done 
		li $v0, 5	#cin
		syscall
				
		add $t0, $v0, $0 #the number that has been inserted
	
		div $t0, $t4	#divide number inserted with two
		mfhi $t2	#remainder
		mflo $t3	#quotient
		
		bne $t2, $0, else #compare the remainder to zero
		addi $s0, $s0, 1  #iterate counter
		add $t1, $t1, $t0 #the sum (sum = sum + num) oh is it my register here 
		j begin
	else:
		
		addi $s0, $s0, 1 #updates the counter and increments by 1 (i++)
		j begin
		
	done: 
		li $v0, 4
		la $a0, sum
		syscall 
		
		li $v0, 1
		add $a0, $t1, $0 #the added sum
		syscall
		
	li $v0, 10 #terminates the program
	syscall
	
