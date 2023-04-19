#
# for loop emulation, display #s and show sum
#

#
# area for variables and constants
#
        .data
        prompt:     .asciiz     "Hi! Welcome to the MIPS basic arithmetic calculator."
        prompt2:    .asciiz     "Insert your first number here: "
        prompt3:    .asciiz     "Insert your second number here: "
        prompt4:    .asciiz     "Now pick your operation of choice: [1]Addition [2]Subtraction [3]Multiplication [4]Division: "
        NL:         .asciiz     "\n"
        result:     .asciiz     "Here's you result: "
        wrongKey:   .asciiz     "Bro, what weed are ya smokin? Can I have some cuuu???"
# promptInput:   .asciiz   "Enter value to display, 1 to value: "

#
# code text section
#
        .text
        .globl  main
main:

    li $v0, 4       #4 prints the string, and li is load immediate (const value)
    la $a0, prompt
    syscall

    li $v0, 4
    la $a0, NL
    syscall

    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0, 6
    syscall
    mov.s $f1, $f0

    li $v0, 4
    la $a0, prompt3
    syscall

    li $v0, 6
    syscall
    mov.s $f2, $f0 # mov.s is single precision floating point, not integer, so use move

    li $v0, 4
    la $a0, prompt4
    syscall

    li $v0, 5    #picks which operation you want
    syscall
    move $t2, $v0

    beq $t2, 1, addition
    beq $t2, 2, subtract
    beq $t2, 3, multiply
    beq $t2, 4, divide
    j wrong

addition:

    add.s $f3 $f1, $f2
    j print

subtract:

    sub.s $f3 $f1, $f2
    j print

multiply:

    mul.s $f3 $f1, $f2
    j print

divide:

    div.s $f3 $f1, $f2
    j print


print:

    li $v0, 4
    la $a0, result
    syscall

    li $v0, 2
    mov.s $f12, $f3
    syscall

    #exit
    li $v0, 10
    syscall

wrong:

    li $v0, 4
    la $a0, wrongKey
    syscall

    #exit
    li $v0, 10
    syscall
#
# codes START here
#


#
# codes END here
#

