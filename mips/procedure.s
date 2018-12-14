# Assembly Assignment #2
# procedure.s
# Jeron Lau
# Calculate 5×7 by using additon inside a loop and function calls.

.data
	text_multiply: .asciiz " times "
	text_equals: .asciiz " is "
	text_period: .asciiz "."

.text
main: # Start of program
	# Delegate storage needed for running main function.
	addi $sp, $sp, -16 # Reserve 4*4 bytes in stack for $ra (Return Address), $s0, $s1 and $s2
	sw $ra, 0 ($sp) # Put $ra (Return Address) on the stack.
	sw $s0, 4 ($sp) # Put $s0 on the stack
	sw $s1, 8 ($sp) # Put $s1 on the stack
	sw $s2, 12 ($sp) # Put $s2 on the stack

	# Call multiply with arguments 7 and 5.
	addi $s0, $zero, 5 # Input 1
	addi $s1, $zero, 7 # Input 2
	addi $a0, $s0, 0 # Input 1 as Argument 0
	addi $a1, $s1, 0 # Input 2 as Argument 1
	jal multiply # Transfer control to multiply function
	addi $s2, $v0, 0 # Save $v0 (Return value) into $s2

	# Print out some text
	addi $v0, $zero, 1 # Print integer
	addi $a0, $s0, 0 # Print first input
	syscall

	addi $v0, $zero, 4 # Print string
	la $a0, text_multiply # Print " multiply "
	syscall

	addi $v0, $zero, 1 # Print integer
	addi $a0, $s1, 0 # Print second input
	syscall

	addi $v0, $zero, 4 # Print string
	la $a0, text_equals # Print " equals "
	syscall

	addi $v0, $zero, 1 # Print integer
	addi $a0, $s2, 0 # Print answer
	syscall

	addi $v0, $zero, 4 # Pring string
	la $a0, text_period # Print a period
	syscall

	# Pop $ra (Return Address) off the stack & Return control to the kernel
	lw $ra, 0 ($sp) # Pop $ra (Return Address) off the stack.
	lw $s0, 4 ($sp) # Pop $s0 off the stack.
	lw $s1, 8 ($sp) # Pop $s1 off the stack.
	lw $s2, 12 ($sp) # Pop $s2 off the stack.
	addi $sp, $sp, 16 # Move back up the 16 bytes.
	jr $ra # Return control to the kernel.

multiply: # The multiply function
	# Delegate storage needed for running this function.
	addi $sp, $sp, -8 # Reserve 4*2 bytes in stack for $ra (Return Address), $s0
	sw $ra, 0 ($sp) # Put $ra (Return Address) on the stack.
	sw $s0, 4 ($sp) # Put $s0 on the stack.

	# Load arguments in s registers
	addi $t0, $a0, 0 # Copy a0 into t0
	addi $t1, $a1, 0 # Copy a1 into t1

	# Actually do something (Do multiplication).
	addi $s0, $zero, 0 # Initialize answer
	loop: # Begin loop
		add $s0, $s0, $t0 # Add $t0 to answer
		addi $t1, $t1, -1 # Decrease temporary
		bne $t1, $zero, loop # When temporary is 0, exit loop.

	# Return
	addi $v0, $s0, 0

	# Pop $ra (Return Address) off the stack & Return control to the kernel
	lw $ra, 0 ($sp) # Pop $ra (Return Address) off the stack.
	lw $s0, 4 ($sp) # Pop $s0 off the stack.
	addi $sp, $sp, 8 # Move back up the 4 bytes.
	jr $ra # Return control to main

