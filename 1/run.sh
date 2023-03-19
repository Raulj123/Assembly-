#!/bin/bash

rm *.o
rm *.out

echo "Compile the C++ module driver.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Assemble the module pythagoras.asm"
nasm -f elf64 -l pythagoras.lis -o pythagoras.o pythagoras.asm

echo "Link two files already created"
g++ -m64 -no-pie -o driver.out pythagoras.o driver.o -std=c++17

echo "Run the program driver"
./driver.out

echo "The bash script file is now closing"

rm *.o
rm *.out

