.data 0x0
  
  nPrompt:	.asciiz "Enter the size (N) of the array:\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  


.text 0x3000
main:
	# Print the prompt for reading N
	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, nPrompt 		# address of nPrompt is in $a0
	syscall           			# print the string
	
	# read in the N (number of elements)
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
	
##################################################################################
##   Insert code here for reading N array elements into memory                  ##
initread:
	li $t0, 0
	li $t1, 4
	
	
read:
	beq	$t0, $s0, initreverse
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$t2, $0, $v0			# copy integer into $t2
 	mult	$t0, $t1
 	mflo	$t3
 	sw	$t2, ($t3)
 	addi	$t0, $t0, 1
 	j	read
 	
	
##################################################################################
	
	
##################################################################################
##   Insert code here for reversing the elements in memory                      ##
initreverse:
	subi $t5, $s0, 1
	li $t4, 0
reverse:
	
	bge $t4, $t5, initprint
	mult $t4, $t1
	mflo $t6
	mult $t5, $t1
	mflo $t7
	lw $t0, ($t6)
	lw $t2, ($t7)
	sw $t2, ($t6)
	sw $t0, ($t7)
	addi $t4, $t4, 1
	subi $t5, $t5, 1
	j reverse

##################################################################################	


##################################################################################
##   Insert code here for printing the reversed array                           ##
initprint:
	li $t0, 0
	
print:
	beq	$t0, $s0, exit
	
	
 	mult	$t0, $t1
 	mflo	$t3
 	lw	$t2, ($t3)
 	addi	$t0, $t0, 1
	
	addi 	$v0, $0, 1  			# system call 1 is for printing an integer
	add 	$a0, $0, $t2 			# bring the area value from $10 into $a0
  	syscall           			# print the integer
  	
  	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, newline			# address of nPrompt is in $a0
	syscall           			# print the string
	
	j print
##################################################################################


# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
