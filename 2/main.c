// ;**
// ;Program name:  Arrays .  Users inputs float numbers then program calculates magnitude and displays arrays and magnitude, program also appends both arrays. Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
// ;                                                                                                                           *
// ;This file is part of the software program Arrays.                                                                   *
// ;Arrays is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// ;version 3 as published by the Free Software Foundation.                                                                    *
// ;Arrays is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
// ;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// ;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
// ;**




// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// ;
// ;Author information
// ;  Author name: Raul Jarquin Valdez
// ;  Author email: jarquinr121@csu.fullerton.edu
// ;
// ;Program information
// ;  Program name: Arrays
// ;  Programming languages: Two modules in C and four module in X86
// ;  Date program began:  02/02/23
// ;  Date of last update: 02/17/23
// ;
// ;  Files in this program: manager.asm, input_array.asm, magnitude.asm, append.asm, main.c, display_array.c
// ;  Status: Finished.
// ;
// ;This file
// ;   File name: main.c
// ;   Language: X86 with Intel syntax.
// ;   Max page width: 132 columns
// ;    Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//      Link: g++ -m64 -no-pie -o manager.out append.o magnitude.o main.o input_array.o display.o -std=c++17

// ;===== Begin code area ================================================================================================




#include<stdio.h>

extern double magnitudeArray();
int main(){
    double magnitude = 0;
    printf("\nWelcome to Arrays of Integers Bought to you by Raul Jarquin Valdez\n\n");
    magnitude = magnitudeArray();
    printf("\nMain received %.10lf., and will keep it for future use. Main will return 0 to the operating system.Bye.\n",magnitude);
    return 0;
}