.data
	#header
	progDes: .asciiz "Program Description:\tSoubroutine & Array\n"
	author: .asciiz "Author:\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t10/04/2021\n"
	sep: .asciiz "============================================================================================================\n"
	#program
	cin: .asciiz "Enter a number of elements to enter inside of the array:\t"
	cin2: .asciiz "Enter an integer: "
	cout: .asciiz "The sum of the following integers entered are: "
	#use pointer as number of elements
	#errors
	errorMsg1: .asciiz "ERROR: The number inserted is less than or equal to 2. Enter again:\t"
	errorMsg2: .asciiz "ERROR: The number inserted is greater than or equal to 11. Enter again:\t"
	
	arr: .word 0,0,0,0,0,0,0,0,0,0
.text
#GIVEN VARIABLES/CONSTANTS____________________________________________________________________________________________________________________
	li $s0, 2			#minimum range for user to not enter
	li $s1, 11			#maximum range for user to not enter
	
#HEADER_______________________________________________________________________________________________________________________________________
	li $v0, 4			#cout
	la $a0, progDes			#output the program description statement
	syscall
	la $a0, author			#output my name
	syscall
	la $a0, date			#output the date it's created
	syscall
	la $a0, sep			#spacing format
	syscall
#INPUT_________________________________________________________________________________________________________________________________________
	la $a0, cin			#input for the amount of elements to enter in the array
	syscall

readIN:
	li $v0, 5			#gets the input of the user
	syscall
	
	ble $v0, $s0, error1		#if the input is less than 2
	bge $v0, $s1, error2		#if the input is greater than 11
	
	add $a0, $v0, $0		#passing argument
	jal FillArray
#FillingArray___________________________________________________________________________________________________________________________________
FillArray:
	add $s3, $a0, $0		#stores in the passed in argument with $t0
	#loop counter
	li $t0, 1
	#declare the array and memory register with the first element
	la $s2, arr
	
	
loop1:
	beq $s3, $0, jump		#until the counter is set to zero
	
	li $v0, 4
	la $a0, cin2			#input statement for entering values for the sum
	syscall
	
	li $v0, 5			#input for integer to enter
	syscall
	#set the integer into an array
	add $t1, $v0, $0		#move the integer into $t1
	sw $t1, 0($s2)			#sets the following integers into $s2, which is the array
	
	add $s2, $s2, 4			#increment the array
	add $t0, $t0, 1			#increment the counter
	addi $s3, $s3, -1		#decrement the counter that was initialized
	
	j loop1	
	
jump:	jr $ra
#AddingElement__________________________________________________________________________________________________________________________________
AddElement:
	#la $s2, arr			#load the array
	
#loop2:	
	beq $t2, $0, output
	lw $t0, 0($s2)
	
	add $s4, $t0, $s4		#sum
	#increments
	addi $t2, $t2, -1
	addi $s2, $s2, 4
	
	j AddElement

output:	#output the sum of the elements inside of the array
	li $v0, 4
	la $a0, cout
	syscall
	
	add $a0, $s4, $0
	li $v0, 1
	syscall
	
	j end

end:
	li $v0, 10
	syscall

#output:	#the sum of the inserted integers
#ERRORS_________________________________________________________________________________________________________________________________________
error1:
	li $v0, 4
	la $a0, errorMsg1
	syscall
	
	j readIN		
error2:
	li $v0, 4
	la $a0, errorMsg2
	syscall
	
	j readIN
