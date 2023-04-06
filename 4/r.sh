#!/bin/bash

rm *.o
rm *.out

echo "Compile the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c


echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm 


echo "Assemble getradicand.asm"
nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm 


echo "Assemble get_clock_freq.asm"
nasm -f elf64 -l get_clock_freq.lis -o get_clock_freq.o get_clock_freq.asm 


echo "Link files created"
gcc -m64 -no-pie -o main.out manager.o main.o getradicand.o get_clock_freq.o -std=c17

echo "Run the program"
./main.out

rm *.o
rm *.out 