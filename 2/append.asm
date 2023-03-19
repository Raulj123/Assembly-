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
;   File name: append.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l  append.lis  -o   append.o  append.asm

;===== Begin code area ================================================================================================




global append
extern printf
extern scanf
max equ 20 

segment .data
segment .bss
append_array resq max


segment .text
append:
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

mov r15, rdi        ;array_A
mov r14, rsi        ;elements in array_A
mov r13, rdx        ;array_B
mov r12, rcx        ;elements in array_B
mov r10, r8         ;append_array
mov r11, 0          ;for counter for first loop


addToLoop:
    cmp r11, r14               ;compare counter to elements in array_A
    je endLoop                 ;If equal jump to end of loop
    mov r8, [r15 + 8*r11]      ;value of array_A[0] stored in r8
    mov [r10 + 8*r11], r8      ;value of array_A[0] stored in append_array[0]
    inc r11                    ;increment counter
    jmp addToLoop              ;jump to start of loop 
endLoop:

mov rax, 0                     ;counter for loop2 
addToLoop2:
    cmp rax, r12               ;compare counter to elements in array_B
    je endLoop2                ;If equal jump to end loop 
    mov r8, [r13 +8*rax]       ;value of array_B[0] stored in r8
    mov [r10 +8*r11], r8       ;value of array_B[0] stored in append_array[counter]
    inc r11                    ;increment counter(index of append_array)
    inc rax                    ;increment counter for loop2
    jmp addToLoop2
endLoop2:
;add r12,r14                   ;Total elements in both array
mov rax, r11                ;return number of total elements 

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