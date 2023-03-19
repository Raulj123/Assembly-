;**
;Program name:  Non-deterministic Random Numbers.This program will generate up to 100 random number using the non-deterministic 
;random number generator found inside of modern X86 microprocessors.Later the random numbers are restricted to the interval 1.0 <= Number < 2.0 
;or even intervals such as 1.0 <= number < M, where is a predetermined fixed upper limit..
; Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
;                                                                                                                           *
;This file is part of the software program Non-deterministic Random Numbers.                                                                   *
;Non-deterministic Random Numbers is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Non-deterministic Random Numbers is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;**


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Raul Jarquin Valdez
;  Author email: jarquinr121@csu.fullerton.edu
;
;Program information
;  Program name: Non-deterministic Random Numbers
;  Programming languages: Two modules in C and three module in X86
;  Date program began:  02/25/23
;  Date of last update: 03/05/23
;
;  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.c, compar.c normal.asm
;  Status: Finished.
;
;This file
;   File name: normal.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l normal.lis -o normal.o normal.asm 
;   Link: gcc -m64 -no-pie -o main.out executive.o main.o fill_random_array.o show_array.o compar.o normal.o -std=c17
;   Purpose:  normalizing numbers in array 
;===== Begin code area ================================================================================================


global normal
extern printf
extern scanf

segment .data


segment .bss


segment .text
normal:
push qword 0 

push rbp                                             ;Backing up registers
mov  rbp,rsp
push rdi                                             ;Backup rdi
push rsi                                             ;Backup rsi
push rdx                                             ;Backup rdx
push rcx                                             ;Backup rcx
push r8                                              ;Backup r8
push r9                                              ;Backup r9
push r10                                             ;Backup r10
push r11                                             ;Backup r11
push r12                                             ;Backup r12
push r13                                             ;Backup r13
push r14                                             ;Backup r14
push r15                                             ;Backup r15
push rbx                                             ;Backup rbx
pushf                                                ;Backup rflags


mov r15, rdi       ;First parameter array
mov r14, rsi       ;Second parameter array size 
mov r13, 0         ;For loop counter 

loop_normal:
    cmp r13,r14
    je endloop_normal

    mov rbx,[r15+8*r13]
    shl rbx, 12
    shr rbx, 12
    mov r8, 1023
    shl r8, 52
    or rbx, r8
    mov[r15 +8*r13], rbx
    inc r13
    jmp loop_normal

endloop_normal:

popf                                              ;Restore rflags
pop rbx                                           ;Restore rbx
pop r15                                           ;Restore r15
pop r14                                           ;Restore r14
pop r13                                           ;Restore r13
pop r12                                           ;Restore r12
pop r11                                           ;Restore r11
pop r10                                           ;Restore r10
pop r9                                            ;Restore r9
pop r8                                            ;Restore r8
pop rcx                                           ;Restore rcx
pop rdx                                           ;Restore rdx
pop rsi                                           ;Restore rsi
pop rdi                                           ;Restore rdi
pop rbp                                           ;Restore rbp

pop rax

ret











