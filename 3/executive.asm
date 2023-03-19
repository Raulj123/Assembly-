;**
;Program name:  Non-deterministic Random Numbers.This program will generate up to 100 random number(numbers above 100 or below 0 will be rejected) using the non-deterministic 
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
;  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.c, compar.c
;  Status: Finished.
;
;This file
;   File name: executive.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l executive.lis -o executive.o executive.asm normal.asm
;   Link: gcc -m64 -no-pie -o main.out executive.o main.o fill_random_array.o show_array.o compar.o normal.o -std=c17
;   Purpose:  This is the central module that will direct calls to different functions including fill_random_array, show_array,compar.
;             Using those functions, user will choose how many elements they want(will reject sizes over 100 and below 0) and display them in IEEE & scientific notation and later sort them 

;===== Begin code area ================================================================================================
global executive
extern fill_random_array
extern show_array
extern normal
extern compar
extern qsort
extern stdin
extern fgets 
extern strlen
extern printf
extern scanf

input_length equ 100
array_size equ 100


segment .data
msg_name db "Please enter your name: ",0
msg_title db "Please enter your title(Mr,Ms,Sargent,Chief,Project Leader,etc.): ",0
msg_greetings db "Nice to meet you %s %s",10,0
msg_program_rules db 10,"This program will generate 64-bit IEEE float numbers.",10, "How many numbers do you want.Today’s limit is 100 per customer: ",0
format_decimal db "%ld",0
msg_error_below db "The number you entered is below 0. Try again.  ",0
msg_error_greater db "The number you entered is greater than 100. Try again.  ",0
msg_sorted db 10,"The array is now being sorted.",10,0
msg_goodbye db 10,"Goodbye %s.You are welcome anytime.",10,0
msg_normal db 10, "The random numbers will be normalized.  Here is the normalized array",10,0

segment .bss 
name resb input_length     ;reserves a block of 200 bytes of memory for name 
title resb input_length    ;reserves a block of 200 bytes of memory for title
array resb array_size      ;reserves 100 qwords 


segment .text 
executive:
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

push qword 0                ;"Please enter your name:"
mov rax, 0 
mov rdi, msg_name
call printf
pop rax


push qword 0               ;Block to store users name in buffer 
mov rax, 0 
mov rdi, name              ;First parameter name(reserves 200 bytes of memory)
mov rsi, input_length      ;Second parameter size of name
mov rdx,[stdin]            ;Memory address of stdin is stored in rdx
call fgets                 ;Reads a line from stdin and stores it in name
pop rax


mov rax, 0
mov rdi, name
call strlen                ;Returns length of string including'\n' & excluding '\0' and stores it in rax 


sub rax, 1                 ;subtract 1 from rax to get the position of '\n'  string representation ex/ hi = [0],[1],[\n],[\0]
mov byte[name + rax], 0    ;copy value '0' at memory location of '\n\


push qword 0               ;"Please enter your title(Mr,Ms,Sargent,Chief,Project Leader,etc.): "
mov rax, 0 
mov rdi, msg_title
call printf
pop rax


push qword 0               ;Block to store users title in buffer 
mov rax, 0 
mov rdi, title             ;First parameter title(reserves 200 bytes of memory)
mov rsi, input_length      ;Second parameter size of title
mov rdx,[stdin]            ;Memory address of stdin is stored in rdx
call fgets                 ;Reads a line from stdin and stores it in title
pop rax


mov rax, 0
mov rdi, title
call strlen                ;Returns length of string including'\n' & excluding '\0' and stores it in rax 


sub rax, 1                 ;subtract 1 from rax to get the position of '\n' 
mov byte[title + rax], 0   ;copy value '0' at memory location of '\n\


push qword 0               ;"Nice to meet you..."
mov rax, 0 
mov rdi, msg_greetings     
mov rsi, title
mov rdx, name 
call printf
pop rax 


push qword 0               ;"This program will generate 64-bit...."
mov rax, 0 
mov rdi, msg_program_rules   
call printf
pop rax 


Loop:                      ;Block for value check, if below 0 or above 100 get a new value
    push qword 0
    mov rax, 0
    mov rdi, format_decimal
    mov rsi, rsp
    call scanf             ;Places decimal format on top of stack 
    pop rax
    mov r13, rax           ;Stores value popped from the stack into r13 

    cmp r13, 0                
    jl lessThan_zero       ;If less than 0 jump to below_zero
    cmp r13, 100
    jg greater_than        ;If greater than 100 jump to greater_than
    jmp endLoop            ;If user entered a number between 0-100 continue with the program 

    lessThan_zero:
        push qword 0
        mov rax, 0 
        mov rdi, msg_error_below    ;"The number you entered is below..."
        call printf
        pop rax
        jmp Loop

    greater_than:
        push qword 0 
        mov rax, 0 
        mov rdi, msg_error_greater   ;"The number you entered is greater..."
        call printf
        pop rax
        jmp Loop

endLoop:


push qword 0 
mov rax, 0
mov rdi, array              ;First parameter array
mov rsi, r13                ;Second parameter array size
call fill_random_array
pop rax 


push qword 0                ;Displaying IEEE and sceintific notation 
mov rax, 0
mov rdi, array              ;First parameter array
mov rsi, r13                ;Second parameter array size 
call show_array
pop rax 


push qword 0                ;"The array is now being.."
mov rax, 0
mov rdi, msg_sorted
call printf
pop rax

mov rdi, array      ;First parameter array 
mov rsi, r13        ;Second parameter array size
mov rdx, 8          ;Third parameter size in bytes in each element 
mov rcx, compar     ;Fourth parameter comparison fucntion to show qsort how to compare each element in array 
call qsort 


push qword 0                ;Displaying IEEE and sceintific notation (sorted)
mov rax, 0
mov rdi, array              ;First parameter array
mov rsi, r13                ;Second parameter array size 
call show_array
pop rax 


push qword 0                ;"normalized..."
mov rax, 0
mov rdi, msg_normal
call printf
pop rax


push qword 0                ;calling normalized function
mov rax, 0 
mov rdi, array
mov rsi, r13
call normal
pop rax 


push qword 0                ;Displaying IEEE and sceintific notation (sorted)
mov rax, 0
mov rdi, array              ;First parameter array
mov rsi, r13                ;Second parameter array size 
call show_array
pop rax 


push qword 0                ;"Goodbye..."
mov rax, 0 
mov rdi, msg_goodbye
mov rsi, title
call printf
pop rax

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

mov rax, name              ;sending back name to main.c

ret