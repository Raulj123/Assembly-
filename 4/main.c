// **
// Program name: Benchmark
//Program displays CPU as well as Max GHZ in asm. Takes in float num from user to square root it and repeats this loop as many time as the user likes.
// Number of tics is taken before and after the execution. Program the finds average time for the sqaure root func in tics and nano seconds 
//  Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
//                                                                                                                            *
// This file is part of the software program Benchmark.                                                                   *
// Benchmark is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// Benchmark is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//  Program name: Benchmark
//  Programming languages: Two modules in C and three module in X86
//  Date program began:  04/01/23
//  Date of last update: 04/05/23
// 
//  Files in this program: manager.asm, get_clock_freq.asm, getradicand.asm, main.c
// 
// This file
//  File name: main.c
//  Language: C language
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -no-pie -m64 -std=c17 -o main.o main.c
//  Link: gcc -m64 -no-pie -o main.out manager.o main.o getradicand.o get_clock_freq.o -std=c17
//  Purpose:  This file calls manager.asm to begin the program and get return value from manager and displays it  
// ;===== Begin code area ================================================================================================

#include <stdio.h>
#include <string.h>

extern double manager();
int main(){
    double computation = manager();
    printf("\nThe main function has received this number %f and will keep it for future reference. The main function will return a zero to the operating system.", computation);
    return 0;
}