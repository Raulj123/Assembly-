#!/bin/bash

rm *.o
rm *.out

echo "Compile the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble getfrequency.asm"
nasm -f elf64 -l getfrequency.lis -o getfr.o getfrequency.asm

echo "Link two files already created"
g++ -m64 -no-pie -o output.out manager.o main.o getfr.o -std=c17


echo "Run the program output"
./output.out

echo "The bash script file is now closing"

rm *.o
rm *.out
