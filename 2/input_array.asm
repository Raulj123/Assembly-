;**
;Program name:  Arrays .  Users inputs float numbers then program calculates magnitude and displays arrays and magnitude, program also appends both arrays. Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
;                                                                                                                           *
;This file is part of the software program Arrays.                                                                   *
;Arrays is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Arrays is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: Arrays
;  Programming languages: Two modules in C and four module in X86
;  Date program began:  02/02/23
;  Date of last update: 02/17/23
;
;  Files in this program: manager.asm, input_array.asm, magnitude.asm, append.asm, main.c, display_array.c
;  Status: Finished.
;
;This file
;   File name: input_array.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l  input_array.lis  -o   input_array.o  input_array.asm

;===== Begin code area ================================================================================================

global input_array
extern printf
extern scanf
extern stdin
extern clearerr


segment .data
float_format db "%lf",0

segment .bss    ;Reserved for uninitialized data

segment .text   ;Reserved for executing instructions.

input_array:
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

   
mov r15, rdi    ;Holds the first parameter(array_A)
mov r14, rsi    ;Holds the second parameter (array size 20 bytes)
mov r13, 0      ;For loop counter
push qword 0

Loop:
    cmp r14,r13     ;comparing array size and loop counter 
    je endLoop      ;If equal will jump to endLoop
    push qword 0    ;push 64 bits of zeros onto stack, After je Endloop 
    mov rax, 0
    mov rdi, float_format   ;First paramter float_format
    mov rsi, rsp            ;Second paramter rsp(top of stack)
    call scanf
    cdqe                    ;so rax can have -1 all across
    cmp rax, -1             ;loop termination condition: user enters cntrl + d
    pop r12         ;value entered stored in r12
    je endLoop
    mov [r15 + 8*r13], r12 ;array[counter](memory address), place input(r12). Multipled by 8 to scale index
    inc r13         ;increment r13(counter)
    jmp Loop
    endLoop:

;Turn fail bit off 
mov rax, 0 
mov rdi, [stdin]
call clearerr

pop rax
mov rax, r13 ;store counter in rax and send back to manager.asm

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



ret