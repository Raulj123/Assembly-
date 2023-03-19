// **
// Program name:  Non-deterministic Random Numbers.This program will generate up to 100 random number using the non-deterministic 
// random number generator found inside of modern X86 microprocessors.Later the random numbers are restricted to the interval 1.0 <= Number < 2.0 
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
//  File name: compar.c
//  Language: C language
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -no-pie -m64 -std=c17 -o compar.o compar.c normal.asm
//  Link: gcc -m64 -no-pie -o main.out executive.o main.o fill_random_array.o show_array.o compar.o normal.o -std=c17
//  Purpose:  This file is a part of qsort parameter in order to show qsort how to compare each element 
// ;===== Begin code area ================================================================================================
#include <stdbool.h>
extern int compar(const void * a, const void * b);
int compar(const void *a, const void *b){
    if(*(double*)a > *(double*)b){
        return 1;
    }
    if(*(double*)a < *(double*)b){
        return -1;
    }
    return 0;
}
