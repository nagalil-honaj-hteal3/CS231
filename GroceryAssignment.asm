.data
	#header
	progDes: .asciiz "Program Description:\tSubroutine And Parameter Passing - Groceries\n"
	author: .asciiz "Name:\t\t\tElaeth Lilagan\n"
	date: .asciiz "Creation Date:\t\t10/08/2021\n"
	sep: .asciiz "=====================================================================================================================\n"
	#program -- items
	cin1: .asciiz "Please enter the number of item(s) you are purchasing:\n"
	cin2: .asciiz "Please enter the price of item "
	colon: .asciiz ":\t"
	#program -- coupons
	cin3: .asciiz "Please enter the number of coupons that you want to use.\n"
	cin4: .asciiz "Please enter the amount of coupon "
	#program -- extra
	cout1: .asciiz "Your total charge is:\t$"
	cout2: .asciiz "\nThank you for shopping with us."
	#errors
	out1: .asciiz "Sorry, too many items to purchase!!\n"
#	out2: .asciiz "You cannot enter negative numbers silly goose!!"
	out2: .asciiz "Too many Coupons!! "
	out3: .asciiz "This coupon is not acceptable\n"
	#arrays
	ItemArr: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	CouponArr: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.text
#Header_______________________________________________________________________________________________________________________________________________
	li $v0, 4
	la $a0, progDes
	syscall
	la $a0, author
	syscall
	la $a0, date
	syscall
	la $a0, sep
	syscall
#######################################################################______________MAIN_FUNCTION_______________################################################################
main:
	li $s0, 0		#set for the counter to zero
	li $s1, 20		#the max number for the counter to reach/the number of items the user can enter
	
	la $a0, cin1		#ouputs the item amount of things the user enters for grocery
	syscall
	#user's input after the cin1 statement
	li $v0, 5
	syscall
	
	bge $v0, $s1, error1	#if the user's input is greater than register s1 which is 20, then it will jump to the error1 function that will ask the user to enter another integer
	
	add $a0, $0, $v0	#pass the register $v0 to the passing argument
	add $t9, $0, $v0	#stores the integer inputted to $t1

	jal FillPriceArray
	li $v0, 4
	la $a0, sep
	syscall
	#add $t0, $v1, $0	#stores the returned element from the FillPriceArray function
##############################################################################_______________FILL_COUPONS________________###################################################################################	
main2:
	li $v0, 4
	la $a0, cin3		#asks the user to enter a number amount of coupons
	syscall
	
	li $v0, 5		#user input
	syscall
	
	bgt $v0, $t9, error2	#if the user's input is greater than 20
	#add into a passing argument
	add $a0, $0, $v0	#store the user's input into a passing argument
	
	jal FillCouponArray
	#add $			#store return element
	
	j sum
	#add $t3, $v4, $0	#returns the number from the sum
	
printSum:
	li $v0, 4
	la $a0, sep
	syscall
	la $a0, cout1		#outputs the total number amount of money
	syscall

	add $a0, $s6, $0	#the integer that was added up in the sum loop
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, cout2		#notifying the user that the purchase has been complete
	syscall

	li $v0, 10
	syscall
#######################################################################________________FILL_PRICE_ARRAY_SUBROUTINE_FUNCTION________________################################################################
FillPriceArray:
	add $t2, $a0, $0	#used for the user's input that was passed from the main -- the counter the user entered
	li $t0, 1		#for the counter
	la $s2, ItemArr		#declaring the Item Array 	

	li $v0, 4
	la $a0, sep
	syscall 
priceLoop:			#loop to get all the items prices			
	beq $t2, $0, jump1	#cycle the loop once it reaches the user's input of items
	#get user's inputs and prices from the following
	li $v0, 4
	la $a0, cin2	
	syscall
	
	add $a0, $t0, $0	#setting the counter with the address $a0 to count the counter of items within the loop and to label the integer for the user to see what item number they are on 
	li $v0, 1		#to store the integer/item number
	syscall
	
	#display a colon after the integer
	li $v0, 4
	la $a0, colon
	syscall
	
	#user input for price
	li $v0, 5
	syscall
	
	#storing the price into the array
	add $t1, $v0, $0	#setting a temporary value for the user input for price
	sw $t1, 0($s2)		#set the array $s2 with the elements the user entered with from $t1
	
	#increase the counter
	add $s2, $s2, 4		#increment the array once the price has been filled in
	add $t0, $t0, 1		#increment the counter by one in the loop
	addi $t2, $t2, -1	#decrement the amount of items from the user's entry
	
	j priceLoop		#jump back to the loop once all the items have been collected
	
jump1:				#jump the register back to the main
	#add $v1, $t1, $0	#return result back to the main
	jr $ra
	
#################################################################################___________________________FillPriceCoupon_Function___________________________###########################################################################
FillCouponArray:
	add $t4, $a0, $0	#store the user input 
	#loop counter
	li $t0, 1
	li $t3, 10		#the range for the coupon
	
	la $s5, CouponArr	#array of the coupon
	la $s2, ItemArr		#array of the item
	
CouponLoop:			#used to gather all the coupons for items entered
	beq $t4, $0, jump2
	
	li $v0, 4
	la $a0, cin4		#output the statement for the user's coupon to be entered
	syscall

	add $a0, $t0, $0	#passed in value of the user's input used as counter
	li $v0, 1		#outputs as in integer 
	syscall
	
	li $v0, 4
	la $a0, colon		#the colon after the counter
	syscall
	#user input for coupon
	li $v0, 5
	syscall
	#comparing arrays
	add $t1, $v0, $0	#setting the input to register $t1
	lw $t2, 0($s2)		#array of items
	
	bge $t1, $t2, error3	
	bge $t1, $t3, error3	#user's input to be greater than or equal to 10
	
	sw $t1, 0($s5)		#used to store the coupons into an array
	#counters
	addi $s5, $s5, 4	#increment the CouponArray
	addi $s2, $s2, 4	#increment the ItemArray
	add $t0, $t0, 1		#used to increment the counter
	addi $t4, $t4, -1	#decrement once that coupon is checked
	
	j CouponLoop
	
addZero:#used to set the CouponArray if the user does not enter a valid number

	sw $0, 0($s5)		#set register 0 as the value inside of the CouponArray if the user enters a number greater or equal to 10
	addi $s5, $s5, 4	#increment the CouponArray
	addi $s2, $s2, 4	#increment the ItemArray
	addi $t0, $t0, 1	#used to increment the counter
	addi $t4, $t4, -1	#decrement once that coupon is checked
	
	j CouponLoop
			
jump2:	
	jr $ra
###################################################################################################______________________SUM_FUNCTION________________________________##########################################################################################

sum:	
	la $s2, ItemArr
	la $s5, CouponArr
	
sumLoop:
	beq $t9, $0, printSum#jump3
	lw $t0, 0($s2)		#load the array for the items
	lw $t1, 0($s5)		#load the array for the coupons
	
	sub $t2, $t0, $t1	#subtracts coupons to the price of items
	add $s6, $t2, $s6	#get the sum of the items
	
	addi $t9, $t9, -1	#decrement the items from user's input
	add $s2, $s2, 4		#increment the item array
	add $s5, $s5, 4		#increment the coupon array
	
	j sumLoop

#jump3: 
	#add $v4, $t6, $0	#returning the result to main
	#jr $ra
################################################################################################___________________ERRORS____________________#############################################################################################
error1:	#if the user enters an integer greater than 20 items
	li $v0, 4
	la $a0, out1
	syscall
	
	j main
	
#error0:	#if the user enters a negative integer
#	li $v0, 4
#	la $a0, out2
#	syscall
	
#	j main			#jump back to the main to ask the user to enter another integer

error2: #if the user enters a lot of coupons, greater than 20
	li $v0, 4
	la $a0, out2		#outputs the user's entry for to much coupons
	syscall
	la $a0, cin3
	
	j main2

error3: #if the user enters a coupon that is not within the range of integers less than 10
	li $v0, 4
	la $a0, out3
	syscall
	
	j addZero
