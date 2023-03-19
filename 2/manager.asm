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
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l  manager.lis  -o   manager.o  manager.asm

;===== Begin code area ================================================================================================


global magnitudeArray
extern printf
extern scanf
extern input_array
extern display_array
extern magnitude
extern append 
max equ 2

segment .data   

program_rulesA db "This program will manage your arrays of 64-bit floats.",10, "For array A enter a sequence of 64 bit floats separated by white space.",10, "After the last input press enter followed by Control+D:",10,0
displayA db "These number were received and placed into array A :",10,0
display_magA db "The magnitude of array A is: %.5lf",10,0
program_rulesB db 10,"For array B enter a sequence of 64-bit floats separated by white space.After the last input press enter followed by Control+D: ",10,0
displayB db "These number were received and placed into array B :",10,0
display_magB db "The magnitude of array B is: %.5lf",10,0
appended_msg db 10,"Arrays A and B have been appended and given the name A ⊕  B.",10, "A B contains:",10,0
display_magAB db "The magnitude of  A ⊕  B is  %.5lf",10,0

segment .bss    ;Reserved for uninitialized data
array_A resq max   ;arrayA of 20 bytes 
array_B resq max   ;arrayB of 20 bytes 
append_array resq max   ;For final array


segment .text   ;Reserved for executing instructions.

magnitudeArray:
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
push qword 0

;"This program will manage your arrays of 64-bit floats....""
push qword 0            
mov rax, 0
mov rdi, program_rulesA
call printf
pop rax 

;fill array_A using the input_array module
push qword 0 
mov rax, 0
mov rdi, array_A    ;first parameter array_A
mov rsi, max        ;Second parameter array size(20 bytes)
call input_array    ;Calling input_array module 
mov r15, rax        ;Store rax(counter,number of items in array) in r15 
pop rax


;"These number were received and placed into the array A:"
push qword 0 
mov rax, 0 
mov rdi, displayA
call printf
pop rax 

;displaying numbers with display_array
push qword 0
mov rax, 0 
mov rdi, array_A;  first parameter array_A
mov rsi, r15        ;Second parameter elements in array 
call display_array
pop rax

;computing magnitude 
push qword 0 
mov rax, 0
mov rdi, array_A    ;first parameter array_A
mov rsi, r15        ;Second parameter elements in array_A
call magnitude
movsd xmm15, xmm0
pop rax 


;"The magnitude of array A is: "
push qword 0 
mov rax, 1
mov rdi, display_magA
movsd xmm0, xmm15
call printf
pop rax

;"For array B enter a sequence of 64-bit floats.....""
push qword 0 
mov rax, 0
mov rdi, program_rulesB
call printf
pop rax

;fill array_B using the input_array module
push qword 0 
mov rax, 0
mov rdi, array_B  ;first parameter array_B
mov rsi, max      ;Second parameter array size(20 bytes)
call input_array    ;Calling input_array module 
mov r14, rax        ;Store rax(counter,number of items in array) in r14
pop rax

;"These number were received and placed into the array B:"
push qword 0 
mov rax, 0 
mov rdi, displayB
call printf
pop rax 


;displaying numbers with display_array
push qword 0
mov rax, 0 
mov rdi, array_B;  first parameter array_B
mov rsi, r14        ;Second parameter elements in array 
call display_array
pop rax


;computing magnitude 
push qword 0 
mov rax, 0
mov rdi, array_B   ;first parameter array_A
mov rsi, r14       ;Second parameter elements in array_A
call magnitude
movsd xmm14, xmm0
pop rax 

;"The magnitude of array B is: "
push qword 0 
mov rax, 1
mov rdi, display_magB
movsd xmm0, xmm14
call printf
pop rax

;"Arrays A and B have been appended and given the...."
push qword 0
mov rax, 0
mov rdi, appended_msg
call printf
pop rax 

push qword 0 
mov rax, 0 
mov rdi, array_A    ;first parameter array_A
mov rsi, r15        ;second parameter elements in array_A
mov rdx, array_B    ;third parameter array_B
mov rcx, r14        ;fourth parameter elements in array_B
mov r8, append_array
call append
mov r13, rax        ;store total elements in both arrays in r13 
pop rax

;displaying both arrays
push qword 0
mov rax, 0 
mov rdi, append_array;  first parameter array_A
mov rsi, r13        ;Second parameter elements in array_A
call display_array
pop rax

;compute magnitde of A & B
push qword 0 
mov rax, 0
mov rdi, append_array      ;first parameter array_A (both arrays)
mov rsi, r13           ;number of elemnts in both arrays 
call magnitude
movsd xmm13, xmm0 
pop rax

;"The magnitude of A & B...."
push qword  0
mov rax, 1
mov rdi, display_magAB
movsd xmm0, xmm13
call printf
pop rax

pop rax
movsd xmm0,xmm13     ;contents of xmm15 are copied to the xmm0 register 


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
