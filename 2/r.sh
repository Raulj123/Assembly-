rm *.o
rm *.out

echo "Complie the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Compile the C module display_array"
gcc -c -Wall -no-pie -m64 -std=c17 -o display_array.o display_array.c

echo "Assemble magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "Assemble append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "Link files created"
gcc -m64 -no-pie -o main.out manager.o input_array.o display_array.o main.o magnitude.o append.o  -std=c17


echo "Run the program main"
./main.out

echo "The bash script file is now closing"

rm *.o
rm *.out