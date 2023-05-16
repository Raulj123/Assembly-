#!/bin/bash

rm *.o
rm *.out

echo "Compile the C module driver.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o driver.o driver.c

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm


echo "Assemble the module isfloatr.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm


echo "Link two files already created"
g++ -m64 -no-pie -o output.out driver.o manager.o isfloat.o -std=c17

echo "Run the program output"
./output.out

echo "The bash script file is now closing"

rm *.o
rm *.out