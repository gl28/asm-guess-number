section .data
    prompt db "I just picked a number from 0-9. Enter your guess here: "
    prompt_len equ $ - prompt
    correctMessage db "Correct!"
    correctMessage_len equ $ - correctMessage
    incorrectMessage db "Incorrect!"
    incorrectMessage_len equ $ - incorrectMessage

section .bss
    intNumber resb 1
    ; reserving 3 bytes for digit + newline + null terminator
    strNumber resb 3
    ; reserving 1 byte for user input
    input resb 1

section .text
    global _start

_start:
random:
    ; generate pseudo-random number
    rdtsc ; read TSC into EDX:EAX

    and eax, 0x0F ; keep lower 4 bits to get number in range 0-15
    cmp al, 10 ; check if number is in range 10-15
    jge random ; if num >=10, try again

    ; store integer value
    mov [intNumber], al

    ; also convert integer to string
    add al, '0' ; add char '0' to int to get ASCII value of the number
    mov [strNumber], al
    mov byte [strNumber+1], 10 ; 10 is ASCII for newline
    mov byte [strNumber+2], 0 ; 0 is ACII for null terminator


    ; print the prompt
    mov eax, 4   ; sys_write
    mov ebx, 1   ; file descriptor for stdout
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80     ; make syscall

    ; read user input
    mov eax, 3   ; sys_read
    mov ebx, 0   ; file descriptor for stdin
    mov ecx, input
    mov edx, 1   ; maximum number of bytes to read (including newline and null terminator)
    int 0x80     ; make syscall

    ; compare input with random number
    mov al, [input]
    cmp al, [intNumber]
    je correct
    jmp incorrect

correct:
    ; tell user they got it right :)
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, correctMessage
    mov edx, correctMessage_len
    int 0x80 ; make syscall

incorrect:
    ; tell user they got it wrong :(
    mov eax, 4 ; sys_write
    mov ebx, 1 ; stdout
    mov ecx, incorrectMessage
    mov edx, incorrectMessage_len
    int 0x80 ; make syscall

exit:
    ; sys_exit
    mov eax, 1 ; 1 is the number for sys_exit system call
    xor ebx, ebx ; clear the ebx register
    int 0x80
