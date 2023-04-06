;**
;Program name: Benchmark
;Program displays CPU as well as Max GHZ in asm. Takes in float num from user to square root it and repeats this loop as many time as the user likes.
;Number of tics is taken before and after the execution. Program the finds average time for the sqaure root func in tics and nano seconds 
; Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
;                                                                                                                           *
;This file is part of the software program Benchmark.                                                                   *
;Benchmark is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Benchmark is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: Benchmark
;  Programming languages: One module in C and three module in X86
;  Date program began:  04/01/23
;  Date of last update: 04/05/23
;
;  Files in this program: manager.asm, get_clock_freq.asm, getradicand.asm, main.c
;  Status: Finished.
;
;This file
;   File name: getradicand.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm 
;   Link: gcc gcc -m64 -no-pie -o main.out manager.o main.o getradicand.o get_clock_freq.o -std=c17
;   Purpose:  File takes in a float number from the user and sends it back to manager.asm

;===== Begin code area ==========================================================================================================================================================
global getradicand
extern printf
extern scanf



segment .data
msg_askForNum db "Please enter a floating radicand for square root bench marking: ",0
float_format db "%lf",0

segment .bss




segment .text 
getradicand:
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



    push qword 0        ;"Please enter a floating radicand..."
    mov rax, 0
    mov rdi, msg_askForNum
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, float_format
    mov rsi,rsp
    call scanf
    movsd xmm15, [rsp]   
    pop rax

    movsd xmm0, xmm15   ;sending back float num 

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