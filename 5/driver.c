// **
// Program name: Data Validation 
// validation of incoming numbers and performance comparison of two versions of the sine function.
//  Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
//                                                                                                                            *
// This file is part of the software program Data Validation.                                                                   *
// Data Validation is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
// version 3 as published by the Free Software Foundation.                                                                    *
// Data Validation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//  Program name: Data Validation
//  Programming languages: One modules in C and two module in X86
//  Date program began:  04/11/23
//  Date of last update: 04/19/23
// 
//  Files in this program: manager.asm, isfloat.asm, driver.c
// 
// This file
//  File name: driver.c
//  Language: C language
//  Max page width: 132 columns
//  Compile: gcc -c -Wall -no-pie -m64 -std=c17 -o driver.o driver.c
//  Link: g++ -m64 -no-pie -o output.out driver.o manager.o isfloat.o -std=c17
//  Purpose:  This file calls manager.asm to begin the program and get return value from manager and displays it  
// ;===== Begin code area ================================================================================================


#include <stdio.h>
extern double manager();
int main(){
     
    printf("Welcome to Asterix Software Development Corporation\n\n");
    printf("Thank you for using this program.  Have a great day.\n\n");
    double tics = manager();
    printf("The driver program received this number %.0f. A zero will be returned to the OS.Bye.", tics);
    return 0;
}
