# fibonacci.asm
# Jeron Lau
# Assembly Programming Assignment Three:
#     Recursive Calls in Assembly
# Add numbers less than 10

.data
    # The Newline Character (after each number).
    newline: .asciiz "\n"

    # Initial values for the three variables in main()
    initial_answer: .word 0
    initial_max: .word 10
    initial_i: .word 1

.text
    # BEGIN fn main()
    # Print out the first ten fibonacci numbers.
    main:
        # Put values on stack
        addi $sp, $sp, -16 # 4 * -4
        sw $ra, 0 ($sp) # Return Address (ra)
        sw $s0, 4 ($sp) # Answer for fibonacci(n) (answer)
        sw $s1, 8 ($sp) # Range Maximum (max)
        sw $s2, 12 ($sp) # For Loop Index (i)

        # Load Initialize Values
        lw $s0, initial_answer # answer = 0; // addi $s0, $zero, 0
        lw $s1, initial_max  # max = 10; // addi $s1, $zero, 10
        lw $s2, initial_i  # i = 1; // addi $s2, $zero, 1

        # BEGIN loop
        loop:
            # answer = fibonacci(i)
            addi $a0, $s2, 0 # Move i into a0 register
            jal fibonacci # Jump and Link, Call the Function
            addi $s0, $v0, 0 # Move return value into answer

            # print answer
        	addi $v0, $zero, 1 # Print Integer
	        addi $a0, $s0, 0 # Print the answer
	        syscall

            # print newline
	        addi $v0, $zero, 4 # Print String
	        la $a0, newline # Print the newline
	        syscall

            # if i == max { break }
            beq $s2, $s1, loop_end # Stop after 10 have been calculated and printed

            # i += 1;
            addi $s2, $s2, 1

            # continue;
            j loop # Back to top of loop.
        # END loop
        loop_end:

        # Pop values off stack, and return.
        lw $ra, 0 ($sp) # Return Address (ra)
        lw $s0, 4 ($sp) # Answer for fibonacci(n) (answer)
        lw $s1, 8 ($sp) # Range Maximum (max)
        lw $s2, 12 ($sp) # For Loop Index (i)
        addi $sp, $sp, 16 # 4 * 4
        jr $ra # Return from main()
    # END fn main()

    # BEGIN fn fibonacci(i32 which_one) -> i32
    # Calulate a fibonnacci number.  which_one is a number 1 or greater.
    # fibonacci(1) evaluates to 1
    # fibonacci(2) evaluates to 1
    # fibonacci(3) evaluates to 2
    # ... and so on
    # When which_one is less than 1 this function returns 0 as an error.
    fibonacci:
        # Put values on stack
        addi $sp, $sp, -16 # 4 * -4
        sw $ra, 0 ($sp) # Return Address (ra)
        sw $s0, 4 ($sp) # minus_one
        sw $s1, 8 ($sp) # minus_two
        sw $s2, 12 ($sp) # which_one

        # Set which_one from first argument
        addi $s2, $a0, 0 # move argument into $s2 (which_one)

        # if which_one < 1 { return 0 }
        slti $t0, $s2, 1 # $t0 = which_one < 1
        beq $t0, $zero, branch_elif # if $t0 is false, goto "else if"
        addi $v0, $zero, 0 # set return value to 0
        j branch_end # return

        # else if which_one < 3 { return 1 }
        branch_elif: # "else if"
        slti $t0, $s2, 3 # $t0 = which_one < 3
        beq $t0, $zero, branch_else # if $t0 is false, goto "else"
        addi $v0, $zero, 1 # set return value to 1
        j branch_end # return
            
        # else
        branch_else:
            # minus_one = fibonacci(which_one - 1)
            addi $a0, $s2, -1 # set argument to which_one - 1
            jal fibonacci # recursive call to fibonacci
            addi $s0, $v0, 0 # move return value into minus_one

            # minus_two = fibonacci(which_one - 2)
            addi $a0, $s2, -2 # set argument to which_one - 2
            jal fibonacci # recursive call to fibonacci
            addi $s1, $v0, 0 # move return value into minus_two

            # return minus_one + minus_two
            add $v0, $s0, $s1

        # return
        branch_end:

        # Pop values off stack, and return.
        lw $ra, 0 ($sp) # Return Address (ra)
        lw $s0, 4 ($sp) # minus_one
        lw $s1, 8 ($sp) # minus_two
        lw $s2, 12 ($sp) # which_one
        addi $sp, $sp, 16 # 4 * 4
        jr $ra # Return from fibonacci()
    # END fn fibonacci(i32 which_one) -> i32
