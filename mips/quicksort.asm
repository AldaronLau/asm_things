# quicksort.asm
# Jeron Lau
# Quicksort algorithm on an array of integers.
# Assembly Assignment Six.


.data

list_a: .word 1, 4, 3, 2, 1, 1, 3, 2, 4, 5
list_b: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
list_c: .word 5, 4, 6, 3, 7, 2, 8, 1, 0, 9
list_d: .word 9, 1, 7, 7, 6, 5, 4, 4, 2, 0

print_a: .asciiz "sort(list_a): "
print_b: .asciiz "sort(list_b): "
print_c: .asciiz "sort(list_c): "
print_d: .asciiz "sort(list_d): "

newline: .asciiz "\n"


.text

# Entry point for program
main:
	# Put values on the stack.
	addi $sp, $sp, -8 # (2 registers * -4).
	sw $ra, 0 ($sp) # Return Address (ra).
	sw $s0, 4 ($sp) # Variable to store return value from strlen.

	# Call function on multiple input and print results.
	la $a0, string_a # First string as parameter.
	jal strlen # strlen(string_a);
	move $s0, $v0 # s0 = strlen(string_a);
	addi $v0, $zero, 4 # Print String
	la $a0, print_a # "string_a length: "
	syscall # printf("string_a length: ");
	addi $v0, $zero, 1 # Print int
	move $a0, $s0 # s0
	syscall # printf("string_a length: %d", strlen(string_a));
	addi $v0, $zero, 4 # Print String
	la $a0, newline # "\n"
	syscall # printf("string_a length: %d\n", strlen(string_a));

	la $a0, string_b # First string as parameter.
	jal strlen # strlen(string_b);
	move $s0, $v0 # s0 = strlen(string_b);
	addi $v0, $zero, 4 # Print String
	la $a0, print_b # "string_b length: "
	syscall # printf("string_b length: ");
	addi $v0, $zero, 1 # Print int
	move $a0, $s0 # s0
	syscall # printf("string_b length: %d", strlen(string_b));
	addi $v0, $zero, 4 # Print String
	la $a0, newline # "\n"
	syscall # printf("string_b length: %d\n", strlen(string_b));

	la $a0, string_c # First string as parameter.
	jal strlen # strlen(string_c);
	move $s0, $v0 # s0 = strlen(string_c);
	addi $v0, $zero, 4 # Print String
	la $a0, print_c # "string_c length: "
	syscall # printf("string_c length: ");
	addi $v0, $zero, 1 # Print int
	move $a0, $s0 # s0
	syscall # printf("string_c length: %d", strlen(string_c));
	addi $v0, $zero, 4 # Print String
	la $a0, newline # "\n"
	syscall # printf("string_c length: %d\n", strlen(string_c));

	la $a0, string_d # First string as parameter.
	jal strlen # strlen(string_d);
	move $s0, $v0 # s0 = strlen(string_d);
	addi $v0, $zero, 4 # Print String
	la $a0, print_d # "string_d length: "
	syscall # printf("string_d length: ");
	addi $v0, $zero, 1 # Print int
	move $a0, $s0 # s0
	syscall # printf("string_d length: %d", strlen(string_d));
	addi $v0, $zero, 4 # Print String
	la $a0, newline # "\n"
	syscall # printf("string_d length: %d\n", strlen(string_d));

	# Pop values from the stack.
	lw $ra, 0 ($sp)
	lw $s0, 4 ($sp)
	addi $sp, $sp, 8 # Move back up registers
	jr $ra

# The strlen() function from the C standard libary, implemented in MIPS assembly.
strlen:
	# Put values on the stack.
	addi $sp, $sp, -20 # (5 registers * -4).
	sw $ra, 0 ($sp) # Return address.
	sw $s0, 4 ($sp) # s0 is Character count.
	sw $s1, 8 ($sp) # s1 is The pointer to the C String.
	sw $s2, 12 ($sp) # s2 is The current character.
	sw $s3, 16 ($sp) # s3 is Memory location of current character.

	# Load argument into $s1 register
	move $s1, $a0
	# Initialize character count to -1
	addi $s0, $zero, -1
	
	# Loop though the C string.
	strlen_loop:
		addi $s0, $s0, 1 # Add 1 to the character count.
		add $s3, $s0, $s1 # count + string
		lb $s2, 0 ($s3) # current = *(count + string)
		bne $s2, $zero, strlen_loop # if current == '\0' { goto strlen_loop; }

	# Set return value.
	move $v0, $s0

	# Pop values from the stack.
	lw $ra, 0 ($sp) # Return address.
	lw $s0, 4 ($sp) # s0 is Character count.
	lw $s1, 8 ($sp) # s1 is The pointer to the C String.
	lw $s2, 12 ($sp) # s2 is The current character.
	lw $s3, 16 ($sp) # s3 is Memory location of current character.
	addi $sp, $sp, 20 # Move stack pointer back to where it was.

	# Return Function
	jr $ra
