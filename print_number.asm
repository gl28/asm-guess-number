section .data
    intNumber db 7 ; db means define bytes

section .bss
    ; reserving 3 bytes for digit + newline + null terminator
    strNumber resb 3

section .text
    global _start

_start:
    ; Convert integer to string
    mov al, [intNumber] ; al register has 8 bits
    add al, '0' ; add char '0' to int to get ASCII value of the number
    mov [strNumber], al
    mov byte [strNumber+1], 10 ; 10 is ASCII for newline
    mov byte [strNumber+2], 0 ; 0 is ACII for null terminator

    ; sys_write
    mov eax, 4 ; 4 is the number for the sys_write system call
    mov ebx, 1 ; 1 is the file descriptor for stdout
    mov ecx, strNumber ; ecx stores a pointer to the data to write
    mov edx, 2 ; 2 is the number of bytes to write
    int 0x80 ; triggers interrupt

    ; sys_exit
    mov eax, 1 ; 1 is the number for sys_exit system call
    xor ebx, ebx ; clear the ebx register
    int 0x80
