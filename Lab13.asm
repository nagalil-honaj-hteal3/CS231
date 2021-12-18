.data
	#header
	progDes: .asciiz "Program Description:\t\tWrite a program that prompts the user for a 9 character line of text by decrypting the message and outputting it.\n"
	author: .asciiz "Author:\t\t\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t\t\t10/23/2021\n"
	sep: .asciiz "========================================================================================================================================================================================================================================================\n"
	#program
	cin: .asciiz "Please enter the message to be sent:\n"
	encrypt: .asciiz "Your encrypted message is:\n" 
	decrypt: .asciiz "Your decrypted message is:\n"
	nL: .asciiz "\n"
	#character arrays
	enter: .byte '-','-','-','-','-','-','-','-','-','-'	#for the inputted message
	ncrypt:	.byte '-','-','-','-','-','-','-','-','-','-'	#when encrypting the message
	out: .byte '-','-','-','-','-','-','-','-','-','-'	#only for decrypting
.text
main:	
######################################______________HEADER_____________########################################################################
	li $v0, 4		#used to output the statements from the .data segment
	la $a0, progDes		#Lab Description
	syscall
	la $a0, author		#My Name
	syscall
	la $a0, date		#Creation Date
	syscall
	la $a0, sep		#Separation Header
	syscall
#_____________________________________________________________________________________________________________________________________________#	
	li $s7, 10		#used for the encryption key
	
	la $a0, cin		#asks the user to input the following to be encrypted/decrypted
	syscall
	
	li $v0, 8		#used for accessing string by input
	la $a0, enter		#store the array 'enter'
	li $a1, 10		#the user has a requirement by only entering in 10 elements inside of the enter array
	syscall
	
	#li $v0, 4
	#la $a0, nL		#adding a new line during the execution
	#syscall
	
	la $s2, enter		#store in the enter array as register $s2
	la $s1, ncrypt		#store in the ncrypt array as register $s1
	li $t0, 10		#set 10 to the max counter
	
LoopOne:#used to loop through the all of 10 characters in the arrays
	beq $t0, $0, cout1	#go through the loop to getting the elements needed inside of the array
	lb $t1, 0($s2)		#load the byte from the enter array 
	
	xor $t2, $t1, $s7	#xor encrypts the string from the encryption key $s7
	sb $t2, 0($s1)		#store byte to store the encrypted keys into the ncrypt array $s1

	li $t2, 0		#cleans the memory of $t2
	li $t1, 0		#cleans the memory of $t1
	
	addi $s2, $s2, 1	#increments the array by 1 since it is a byte	
	addi $s1, $s1, 1	#increments the array by 1 since it is a byte
	addi $t0, $t0, -1	#decrements the counter by one to match zero to move onto the next loop
	
	j LoopOne
	
cout1:	#outputs the encrypted message once all of the elements have been checked
	li $v0, 4
	la $a0, encrypt		#output for the encrypt statement from .data
	syscall
	la $a0, ncrypt		#output for the ncrypt array from .data
	syscall 
	
	la $s2, ncrypt		#load the ncrypt array
	la $s1, out		#load the out array
	
	li $t0, 10		#used to reset the counter
	
Loop2:	#runs the loop for all elements in the 10 char array for decryption
	beq $t0, $0, cout2	#goes through the loop until the counter hits zero
	lb $t1, 0($s2)		#loads the elements inside of the ncrypt array
	
	xor $t2, $t1, $s7	#xor decrypts the string from the key
	sb $t2, 0($s1)		#stores the elements into the encrypt array
	
	li $t2, 0		#clean the encrypt array
	li $t1, 0		#clean the ncrypt array
	
	addi $s2, $s2, 1	#increment the enter array by one byte
	addi $s1, $s1, 1	#increment the ncrypt array by one byte
	addi $t0, $t0, -1	#decrement the counter by one

	j Loop2
	
cout2:	#outputs the decryption
	li $v0, 4
	la $a0, nL		#adds in a new line
	syscall
	la $a0, decrypt		#outputs the decrypt statement from .data
	syscall
	la $a0,	out		#output the following elements in the out array 
	syscall
	
end:	li $v0, 10		#terminates the program
	syscall
