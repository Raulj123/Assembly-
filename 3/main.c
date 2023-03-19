// **
// Program name:  Non-deterministic Random Numbers.This program will generate up to 100 random numbers(will reject any above 100 or below 0) using 
//the non-deterministic random number generator found inside of modern X86 microprocessors.Later the random numbers are restricted to the interval 
//1.0 <= Number < 2.0 
// or even intervals such as 1.0 <= number < M, where is a predetermined fixed upper limit..
//  Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
//                                                                                                                            *
// This file is part of the software program Non-deterministic Random Numbers.                                                                   *
// Non-deterministic Random Numbers is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// Non-deterministic Random Numbers is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
// **


// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// 
// Author information
//   Author name: Raul Jarquin Valdez
//   Author email: jarquinr121@csu.fullerton.edu
// 
// Program information
//  Program name: Non-deterministic Random Numbers
//  Programming languages: Two modules in C and three module in X86
//  Date program began:  02/25/23
//  Date of last update: 03/05/23
// 
//  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.c, compar.c
//  Status: Finished.
// 
// This file
//  File name: main.c
//  Language: C language
//  Max page width: 132 columns
//  Complie: gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c normal.asm
//  Link: -m64 -no-pie -o main.out executive.o main.o fill_random_array.o show_array.o compar.o normal.o -std=c17
//  Purpose:  This is the driver module that will call executive() to initialize the array operations.
// ;===== Begin code area ================================================================================================



#include <stdio.h>
#include <string.h>
const int SIZE = 100;
extern char* executive();
int main(){

printf("Welcome to Random Products, LLC.\nThis software is maintained by Raul jarquin Valdez\n");
char* name = executive();

printf("\nOh,%s.We hope you enjoyed your arrays.Do come again.A zero will be returned to the operating system.\n\n",name);
}
