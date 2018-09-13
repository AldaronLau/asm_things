# example0.s
# Jeron Lau
# Example #0
# Add numbers less than 10

.data # Mutable Globals
start: .word 10

.rodata # Read-Only Constants

.bss # Uninitialized Data
answer: .word

.text # Code

main:
add $t0, $zero, $zero # $t0 is sum register
lw $t1, start # $t1 is counter register

top:
beq $t1, $zero, exit # if counter equals zero exit loop
add $t0, $t0, $t1 # sum = sum + counter
addi $t1, $t1, -1 # counter = counter - 1
j top

exit:
sw $t0, answer
nop
nop
