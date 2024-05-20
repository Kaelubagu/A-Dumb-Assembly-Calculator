#
# template assembly file
#
        .text
        .globl  main
main:
#
# opening linkage (save return address)
#
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)
#
# codes START here
#
    
     # Read the input numbers
    li $v0, 4
    la $a0, Beginning
    syscall

    li $v0, 4
    la $a0, prompt1
    syscall
    
    li $v0, 5
    syscall
    sw $v0, input_num1

    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 5
    syscall
    sw $v0, input_num2

    lw $t0, input_num1
    lw $t1, input_num2

    # Display operation selection message and read the user's choice
    li $v0, 4
    la $a0, msg_operation
    syscall

    li $v0, 5
    syscall
    move $t7, $v0

    # Perform the chosen operation
    beq $t7, 1, adding
    beq $t7, 2, subtracting
    beq $t7, 3, multiplication
    beq $t7, 4, division

exit:
    li $v0, 10
    syscall

adding:
    add $t2, $t0, $t1
    j check_multiples

subtracting:
    sub $t2, $t0, $t1
    j check_multiples

multiplication:
    mul $t2, $t0, $t1
    j check_multiples

division:
    div $t0, $t1
    mflo $t2
    j check_multiples

check_multiples:
    # Check if the result is a multiple of 2, 3, or 5
    li $t6, 2
    li $t7, 3
    li $t8, 5

    # Check if multiple of 2
    div $t2, $t6
    mfhi $t9
    beq $t9, $zero, print_multiple_2

    # Check if multiple of 3
    div $t2, $t7
    mfhi $t9
    beq $t9, $zero, print_multiple_3

    # Check if multiple of 5
    div $t2, $t8
    mfhi $t9
    beq $t9, $zero, print_multiple_5

    j exit

print_multiple_2:

    li $v0, 4
    la $a0, results
    syscall

    li $v0, 1       #prompt answer
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, joke_prompt
    syscall

    li $v0, 4
    la $a0, msg_multiple_2
    syscall
    j exit

print_multiple_3:

    li $v0, 4
    la $a0, results
    syscall

    li $v0, 1       #prompt answer
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, joke_prompt
    syscall

    li $v0, 4
    la $a0, msg_multiple_3
    syscall
    j exit

print_multiple_5:

    li $v0, 4
    la $a0, results
    syscall

    li $v0, 1       #prompt answer
    move $a0, $t3
    syscall
    
    li $v0, 4
    la $a0, joke_prompt
    syscall

    li $v0, 4
    la $a0, msg_multiple_5
    syscall
    j exit

#
# codes END here
#

#
# closing linkage (get return address and restore stack pointer)
#
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra
        .end    main
#
# area for variables and constants
#
        .data
input_num1: .word 0
input_num2: .word 0


    Beginning:      .asciiz "Hi, welcome to the Joke Calculator."
    prompt1:        .asciiz "Choose an integer: "
    prompt2:        .asciiz "Choose another integer:" 
    results:         .asciiz "Result: "
    joke_prompt:    .asciiz "Here's your joke... "

    msg_operation:  .asciiz "Choose an operation: 1) Add, 2) Subtract, 3) Multiply, 4) Divide\n"
    msg_multiple_2: .asciiz "Why was six afraid of seven? Because seven eight nine (7 8 9)."
    msg_multiple_3: .asciiz "Why did the scarecrow win an award? Because he was outstanding in his field!"
    msg_multiple_5: .asciiz "Why don't scientists trust atoms? Because they make up everything."


        
