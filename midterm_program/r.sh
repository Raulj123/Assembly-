#!/bin/bash

rm *.o
rm *.out

echo "Compile the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c

echo "Compile the C module display_array.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o display_array.o display_array.c

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module reverse.asm"
nasm -f elf64 -l reverse.lis -o reverse.o reverse.asm

echo "Link two files already created"
g++ -m64 -no-pie -o output.out manager.o main.o display_array.o input_array.o reverse.o -std=c17

echo "Run the program output"
./output.out

echo "The bash script file is now closing"

rm *.o
rm *.out
