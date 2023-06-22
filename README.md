# asm-guess-number

A very exciting game where you can guess a random number. Written all in x86 assembly, as a learning exercise.

To run (depending on your hardware):

`nasm -f elf64 print_number.asm`

`ld -o print_number print_number.o`

`./print_number`