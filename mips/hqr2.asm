# Hoare's Quicksort (Recursive)
# Jeron Lau
# Quicksort algorithm on an array of integers.
# Assembly Assignment Six.

# Data
.data
	array_a: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
	array_b: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
	array_c: .word 5, 4, 6, 3, 7, 2, 8, 1, 0, 9
	array_d: .word 9, 1, 7, 7, 6, 5, 4, 4, 2, 0
	array_e: .word 1, 4, 3, 2, 1, 1, 3, 2, 4, 5

#	array_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
#	array_b: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
#	array_c: .word 1, 1, 2, 3, 6, 5, 6, 0, 9, 9
#	array_d: .word 10, 40, 3, 3, 40, 10, 0, 0, 9, 10
#	array_e: .word 5, 5, 5, 5, 5, 5, 5, 5, 5, 5

	print_a: .asciiz "array_a: "
	print_b: .asciiz "array_b: "
	print_c: .asciiz "array_c: "
	print_d: .asciiz "array_d: "
	print_e: .asciiz "array_e: "

	newline: .asciiz "\n"
	comma: .asciiz ", "
.text

# Entry point for program
main:
	# Add a words to the stack.
	addi $sp, $sp, -4
	sw $ra, 0 ($sp)
	
	# println!("array_a: {:?}", array_a);
	la $a0, print_a
	la $a1, array_a
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_b: {:?}", array_b);
	la $a0, print_b
	la $a1, array_b
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_c: {:?}", array_c);
	la $a0, print_c
	la $a1, array_c
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_d: {:?}", array_d);
	la $a0, print_d
	la $a1, array_d
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_e: {:?}", array_e);
	la $a0, print_e
	la $a1, array_e
	addi $a2, $zero, 10
	jal print_array

	# quicksort(&array_a, array_a.len());
	la $a0, array_a
	addi $a1, $zero, 10
	jal quicksort
	
	# quicksort(&array_b, array_b.len());
	la $a0, array_b
	addi $a1, $zero, 10
	jal quicksort
	
	# quicksort(&array_c, array_c.len());
	la $a0, array_c
	addi $a1, $zero, 10
	jal quicksort
	
	# quicksort(&array_d, array_d.len());
	la $a0, array_d
	addi $a1, $zero, 10
	jal quicksort
	
	# quicksort(&array_e, array_e.len());
	la $a0, array_e
	addi $a1, $zero, 10
	jal quicksort

	# Print Newline
	addi $v0, $zero, 4
	la $a0, newline
	syscall

	# println!("array_a: {:?}", array_a);
	la $a0, print_a
	la $a1, array_a
	addi $a2, $zero, 10
	jal print_array

	# println!("array_b: {:?}", array_b);
	la $a0, print_b
	la $a1, array_b
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_c: {:?}", array_c);
	la $a0, print_c
	la $a1, array_c
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_d: {:?}", array_d);
	la $a0, print_d
	la $a1, array_d
	addi $a2, $zero, 10
	jal print_array
	
	# println!("array_e: {:?}", array_e);
	la $a0, print_e
	la $a1, array_e
	addi $a2, $zero, 10
	jal print_array

	# Take words off the stack and return.
	lw $ra, 0 ($sp)
	addi $sp, $sp, 4
	jr $ra

quicksort:
	# Add a words to the stack.
	addi $sp, $sp, -28
	sw $ra, 0 ($sp)
	sw $s0, 4 ($sp) # Array
	sw $s1, 8 ($sp) # Length
	sw $s2, 12 ($sp) # If statement itermediate value
	sw $s3, 16 ($sp) # First
	sw $s4, 20 ($sp) # Last
	sw $s5, 24 ($sp) # Pivot
	
	# Put arguments into s registers.
	move $s0, $a0
	move $s1, $a1
	
	# Check for the base case: Size of array is 0 or 1.
	srl $s2, $s1, 1
	beq $s2, $zero, quicksort_return
	
	# Set first=-1 and last=length
	addi $s3, $zero, -1
	move $s4, $s1
	
	# Get the floor of the midpoint for the pivot.
	addi $s5, $s4, -1 # Get midpoint.
	srl $s5, $s5, 1
	sll $s5, $s5, 2 # Use midpoint as index.
	add $s5, $s5, $s0
	lw $s5, 0 ($s5) # Dereference &array[index]

	# Continuously loop (bringing ends closer together) to calculate new pivot index.
	gpi_loop:
		up_loop:
			addi $s3, $s3, 1 # increment
			sll $s2, $s3, 2 # index
			add $s2, $s2, $s0
			lw $s2, 0 ($s2) # Dereference &array[index]
			slt $s2, $s2, $s5 # if
			beq $s2, $zero, dn_loop
			j up_loop
		
		dn_loop:
			addi $s4, $s4, -1 # decrement
			sll $s2, $s4, 2 # index
			add $s2, $s2, $s0
			lw $s2, 0 ($s2) # Dereference &array[index]
			slt $s2, $s5, $s2 # if
			beq $s2, $zero, dn_end
			j dn_loop
		dn_end:
		
		# Break if first is last or last + 1
		sub $s2, $s3, $s4
		srl $s2, $s2, 1
		beq $s2, $zero, gpi_end
		
		# Swap first and last
		move $a0, $s0
		move $a1, $s3
		move $a2, $s4
		jal swap
		
		j gpi_loop
	gpi_end:
	
	# Calculate the new pivot index.
	addi $s5, $s4, 1
	
	# quicksort(array, pivot index);
	move $a0, $s0
	move $a1, $s5
	jal quicksort
	
	# quicksort(array + (pivot index * 4), length - pivot index]);
	sll $s2, $s5, 2
	add $a0, $s0, $s2
	sub $a1, $s1, $s5
	jal quicksort
	
	# Take words off the stack and return.
	quicksort_return:
	lw $ra, 0 ($sp)
	lw $s0, 4 ($sp)
	lw $s1, 8 ($sp)
	lw $s2, 12 ($sp)
	lw $s3, 16 ($sp)
	lw $s4, 20 ($sp)
	lw $s5, 24 ($sp)
	addi $sp, $sp, 28
	jr $ra

# Print out an array of integers.
# print(text, array, len)
print_array:
	# Add a words to the stack.
	addi $sp, $sp, -24
	sw $ra, 0 ($sp)
	sw $s0, 4 ($sp)
	sw $s1, 8 ($sp)
	sw $s2, 12 ($sp)
	sw $s3, 16 ($sp)
	sw $s4, 20 ($sp)

	# Set s registers
	move $s0, $a1 # i (pointer begin)
	sll $s1, $a2, 2 # len (pointer end)
	add $s1, $s1, $s0 # len (pointer end)
	move $s2, $a1 # array
	move $s3, $a0 # text

	# Print Text.
	addi $v0, $zero, 4
	move $a0, $s3
	syscall

	# Loop through
	print_loop:
		# Load int
		lw $s4, 0 ($s0)

		# Print int
		addi $v0, $zero, 1 
		move $a0, $s4
		syscall

		# i += 4
		addi $s0, $s0, 4

		# if i == len { break }
		beq $s0, $s1, print_exit

		# Print comma
		addi $v0, $zero, 4
		la $a0, comma
		syscall

		j print_loop

	print_exit:
	# Print Newline
	addi $v0, $zero, 4
	la $a0, newline
	syscall

	# Take words off the stack and return.
	lw $ra, 0 ($sp)
	lw $s0, 4 ($sp)
	lw $s1, 8 ($sp)
	lw $s2, 12 ($sp)
	lw $s3, 16 ($sp)
	lw $s4, 20 ($sp)
	addi $sp, $sp, 24 # Move back up registers
	jr $ra
	
## Swap data at indices `i` and `j` in `array`.
# void swap(int[] array, int i, int j)
swap:
	# Add a words to the stack.
	addi $sp, $sp, -20
	sw $ra, 0 ($sp)
	sw $s0, 4 ($sp) # One swap value.
	sw $s1, 8 ($sp) # Value from array[i].
	sw $s2, 12 ($sp) # Value array[j].
	sw $s3, 16 ($sp) # Another swap value.

	# Load arguments into s registers.
	sll $s1, $a1, 2 # s1 is (i >> 4)
	add $s1, $a0, $s1 # s1 is (array + (i * 4)) or &array[i]

	sll $s2, $a2, 2 # s2 is (i >> 4)
	add $s2, $a0, $s2 # s2 is (array + (i * 4)) or &array[n]

	# Swap
	lw $s0, 0 ($s1)
	lw $s3, 0 ($s2)
	sw $s3, 0 ($s1)
	sw $s0, 0 ($s2)

	# Take words off the stack and return.
	lw $ra, 0 ($sp)
	lw $s0, 4 ($sp)
	lw $s1, 8 ($sp)
	lw $s2, 12 ($sp)
	lw $s3, 16 ($sp)
	addi $sp, $sp, 20 # Move back up registers
	jr $ra
