# mul_by_add.s
# Jeron Lau
# Calculate 7×5 by using additon inside a loop.

.data
x: .word 7 # input 1
y: .word 5 # input 2
answer: .word 0 # output value `x * y`

.text
main: # start of program
lw $t0, x # t0 from x
lw $t1, y # t1 from y
add $s0, $s0, $s0 # Initialize answer
loop: # begin loop
add $s0, $s0, $t0 # add x to answer
addi $t1, $t1, -1 # y--
bne $t1, $zero, loop # only loop when not zero yet
# end loop
sw $s0, answer # answer from s0
# end of program
nop
nop
