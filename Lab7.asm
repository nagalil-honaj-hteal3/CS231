.data
	#header
	progDes: .asciiz "Program Description:\tLoops and Array: To output the contents of the array in reverse order\n"
	author: .asciiz "Author:\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t09/22/2021\n"
	sep: .asciiz "========================================================================================================================================\n"

	#program
	numElem: .asciiz "\nEnter the number of elements:\n"
	enterNum: .asciiz "Enter number "
	reverse: .asciiz "The content of array in reverse order is:\n"
	colon: .asciiz ":\t" #used for the loop when entering numbers
	output: .asciiz "The content of array in reverse order is:\n"
	newLine: .asciiz "\n"#used to make a new line for outputting the array
	
	#errors
	#arrow: .asciiz "==>"
	errorMsg1: .asciiz "\nError array cannot have more than 10 elements, try again!!\n"
	errorMsg2: .asciiz "\nError the number that has been entered must be a positive that is less than or equal to 10. Enter another number: "

	arr: .word 0,0,0,0,0,0,0,0,0,0
	#this is to set an array of integers by the size of 10

.text
	li $v0, 4			#cout
	la $a0, progDes			#outputs the progDes statement that is shown on the .data
	syscall
	la $a0, author			#outputs the author statement that is shown on the .data
	syscall
	la $a0, date			#outputs the date statement that is shown on the .data
	syscall
	la $a0, sep			#outputs the sep statement that is shown on the .data
	syscall

	la $a0, numElem			#asks the user to enter the number of elements inside of the array
	syscall
	
readX:	#this label is used when the user did not enter the correct number of elements	
	li $v0, 5			#cin, gets the user's input and stores it inside of register $v0
	syscall
	
	add $t0, $v0, $0		#adds the user's input for the amount of elements to be entered inside the array
	
	li $s0, 0			#used to initialize if the number entered was a negative to asking the user's number of elements
	li $s1, 10			#used to set the end boundary for the user to enter within the range of the array
	la $s2, arr			#initialize the array from 0 to 10
	li $s3, 1			#used for counter in the loop
	
	ble $t0, $s0, reset1		#be less than or equal to: input was a negative or equal to zero
	bgt $t0, $s1, reset2		#be greater than: user input was greater than zero
	
	li $v0, 4
	la $a0, sep			#insert a seperation header after getting the number of indexes within the array
	syscall
	
inLoop:	#for asking the user to enter the amount of numbers within the array
	beq $s0, $t0, complete		#used to set how large the loop should be with the input of the user when asked the number of elements

	li $v0, 4			#cout
	la $a0, enterNum		#ask the user to enter any number
	syscall
	
	li $v0, 1			#used for storing the counter's value within the loop
	add $a0, $s3, $s0		#increments the counter and outputs what the integer of the loop is in
	syscall
	
	li $v0, 4			#cout
	la $a0, colon			#put a colon next to the 
	syscall
	
	li $v0, 5			#now asked to insert the number
	syscall
	
	sw $v0, 0($s2)			#stores the number that user entered into memory location arr, which is the array
	addi $s2, $s2, 4		#shift to the next index of the array once the element has been stored 
	addi $s0, $s0, 1		#increment the loop until it reaches to the user's input of choice of the amount of elements inside the array
	
	j inLoop			#continues to cycle
	
reset1:	#used to catch an integer that cannot be used for the array
	li $v0, 4
	la $a0, errorMsg2		#that the number entered is not in the correct range
	syscall
	j readX				#proceeds to ask the user to enter another integer
	
reset2: #used to catch tbe integer greater than the range
	li $v0, 4
	la $a0, errorMsg1		#that the number entered is not in the correct range
	syscall
	j readX				#goes back to ask the user to enter another integer
	
complete:#once the user finishes entering the numbers
	li $v0, 4
	la $a0, sep			#used to seperate the other loop
	syscall
	la $a0, output			#outputs a message to inform the user it will be in reverse order
	syscall
	la $a0, sep
	syscall

outLoop: #to output the array in reverse order
	beq $t0, $0, exit		#once there is no more elements remaining
	addi $s2, $s2, -4		#since the array is int, then it must decrement by 4
	lw $a0, 0($s2)			#loads the integers onto register $a0 once it is removed out of the memory
	li $v0, 1			#outputs an integer
	syscall
	
	li $v0, 4
	la $a0, newLine			#used to create a new line to output the numbers in ordinary fashion
	syscall
	
	addi $t0, $t0, -1		#decrement the loop by one once the integer has been viewed
	j outLoop

exit: 	#terminates the program 
	li $v0, 10
	syscall
