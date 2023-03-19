#!/bin/bash

rm *.o
rm *.out

echo "Compile the C module main.c"
gcc -g -c -Wall -no-pie -m64 -std=c17 -o main.o main.c 

echo "Compile the C module compar.c"
gcc -g -c -Wall -no-pie -m64 -std=c17 -o compar.o compar.c 

echo "Assemble executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm -g -gdwarf

echo "Assemble fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm -g -gdwarf

echo "Assemble show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm -g -gdwarf

echo "Link files created"
gcc -m64 -no-pie -o main.out executive.o main.o fill_random_array.o show_array.o compar.o -std=c17

echo "Run the program"
gdb ./main.out

rm *.0
rm *.out 
