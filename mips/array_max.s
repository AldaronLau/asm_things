# Assembly Assignment #4
# array_max.s
# Jeron Lau
# Find the largest number in an array.

.data
	array_a: .word -20, 23, -59, 39, 6 # MAX 39
	array_a_len: .word 5

	array_b: .word 70, 23, -59, 39, 6 # MAX 70
	array_b_len: .word 5

	array_c: .word 0, 23, -59, -39, 6 # MAX 23
	array_c_len: .word 5

	array_d: .word 0, 23, -59, -39, 6, 2, -2, 100 # MAX 100
	array_d_len: .word 8

	newline: .asciiz "\n"

.text
	main:
		# Delegate Storage
		addi $sp, $sp, -4 # Reserve 4 bytes in stack for $ra
		sw $ra, 0 ($sp) # Put $ra (Return Address) on the stack.

		# print(largest(array_a, array_a_len) + "\n")
		la $a0, array_a # Load array_a address into a0
		lw $a1, array_a_len # Load array_a_len into a1
		jal largest # Call largest(array_a, array_a_len)
		move $a0, $v0 # With Return Value from largest()
		li $v0, 1 # Print Integer
		syscall
		la $a0, newline # "\n"
		li $v0, 4 # Print Newline
		syscall

		# print(largest(array_b, array_b_len) + "\n")
		la $a0, array_b # Load array_b address into a0
		lw $a1, array_b_len # Load array_b_len into a1
		jal largest # Call largest(array_b, array_b_len)
		move $a0, $v0 # With Return Value from largest()
		li $v0, 1 # Print Integer
		syscall
		la $a0, newline # "\n"
		li $v0, 4 # Print Newline
		syscall

		# print(largest(array_c, array_c_len) + "\n")
		la $a0, array_c # Load array_c address into a0
		lw $a1, array_c_len # Load array_c_len into a1
		jal largest # Call largest(array_c, array_c_len)
		move $a0, $v0 # With Return Value from largest()
		li $v0, 1 # Print Integer
		syscall
		la $a0, newline # "\n"
		li $v0, 4 # Print Newline
		syscall

		# print(largest(array_d, array_d_len) + "\n")
		la $a0, array_d # Load array_d address into a0
		lw $a1, array_d_len # Load array_d_len into a1
		jal largest # Call largest(array_d, array_d_len)
		move $a0, $v0 # With Return Value from largest()
		li $v0, 1 # Print Integer
		syscall
		la $a0, newline # "\n"
		li $v0, 4 # Print Newline
		syscall

		# Pop $ra (Return Address) off the stack & Return control to the kernel
		lw $ra, 0 ($sp) # Pop $ra (Return Address) off the stack.
		addi $sp, $sp, 4 # Move back up the 4 bytes.
		jr $ra # Return control to the kernel.

	largest:
		# Delegate Storage
		addi $sp, $sp, -4 # Reserve 4 bytes in stack for $ra
		sw $ra, 0 ($sp) # Put $ra (Return Address) on the stack.

		# Copy Arguments into temp registers, and initialize others.
		move $t0, $a0 # array_adress
		sll $t1, $a1, 2 # Array Length (bytes) = Array Length (elements) * 4
		li $t2, 4 # Index Counter Point To Second element
		lw $t3, 0 ($t0) # Load max from array_adress [0]

		# Go through the loop
		largest_loop:
			add $t4, $t2, $t0 # t4 (new_pointer) = offset + array_address
			lw $t4, 0 ($t4) # now t4 (new) is value pointed to by old t4 (new_pointer)
			slt $t5, $t4, $t3 # t5 (temp) = new < max
			mul $t6, $t5, $t3 # t6 (temp) = max * (new < max)
			slt $t5, $t3, $t4 # t5 (temp) = new > max
			mul $t7, $t5, $t4 # t7 (temp) = new * (new > max)
			add $t3, $t6, $t7 # max = (max * (new < max)) + (new * (new > max))
			addi $t2, $t2, 4 # Increment Offset by size of an element.
			bne $t2, $t1, largest_loop # Continue while counter isn't length yet.

		# Set Return Value to max
		move $v0, $t3

		# Pop $ra (Return Address) off the stack & Return control to main()
		lw $ra, 0 ($sp) # Pop $ra (Return Address) off the stack.
		addi $sp, $sp, 4 # Move back up the 4 bytes.
		jr $ra # Return control to main().
