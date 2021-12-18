.data
	#header
	progDes: .asciiz "Program Description:\tWrite a program that prompt the user for a temperature in Celsius and then display the result in Fahrenheit.\n"
	author: .asciiz "Author:\t\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t\t10/11/2021\n"
	sep: .asciiz "==============================================================================================================================================================================================\n"
	#program
	cin: .asciiz "Please input a number in Celsius: "
	cout: .asciiz "The temperature in Fahrenheit is: "
	#the measurement from celsius to farenheit
	num: .float 1.8 #multiply by 1.8
	num2: .float 32.0 #add 32 
.text
main:
	li $v0, 4			#the load immediate to access the outputs
	la $a0, progDes			#the output statement from the header to show the program description
	syscall
	la $a0, author			#the output statement from the header to output my name
	syscall
	la $a0, date			#the output statement from the header to display the date it was created
	syscall
	la $a0, sep			#the output statement from the header to separate the header statements with the program itself
	syscall
########################## -- PROGRAM -- Celsius to Farenheit -- ######################################
	la $a0, cin			#cin statement from the .data
	syscall

	li $v0, 5			#the load immediate to enter the user's input
	syscall
	
	add $t0, $v0, $0		#storing in the user input of register $v0 to register $t0
	
	mtc1 $t0, $f0			#transfer the integer into a float register
	cvt.s.w $f0, $f0		#convert an integer to a float
	#multiply float input by 1.8 ($f3)
	l.s $f2, num			#storing in the constant number of 1.8 to the register $f2
	mul.s $f3, $f2, $f0		#multiply the single float number with the inputted value
	#f0 is the user input stored from $t0 to convert the integer into a decimal. $f2 is the constant in the .data
	
	l.s $f4, num2			#set 32 with the register f4
	add.s $f3, $f3, $f4		#add the elements of the constant number and the value that has been multiplied
	
	li $v0, 4			#to display the output
	la $a0, cout			#output the statement that has the conversion from celsius to farenheit
	syscall
	
	li $v0, 2			#used to output the value of the float value
	mov.s $f12, $f3			#move the value that has been calculated onto $f12
	syscall
	
	li $v0, 10			#used to terminate the program once everything has run.
	syscall
