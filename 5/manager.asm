; // **
; // Program name: Data Validation 
; // validation of incoming numbers and performance comparison of two versions of the sine function.
; //  Copyright (C) 2021 Raul Jarquin Valdez.                                                                           *
; //                                                                                                                            *
; This file is part of the software program Data Validation.                                                                   *
; Data Validation is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
; version 3 as published by the Free Software Foundation.                                                                    *
; Data Validation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;  **


;  ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
 
;  Author information
;    Author name: Raul Jarquin Valdez
;    Author email: jarquinr121@csu.fullerton.edu
 
;  Program information
;   Program name: Data Validation
;   Programming languages: One modules in C and two module in X86
;   Date program began:  04/11/23
;   Date of last update: 04/19/23
 
;   Files in this program: manager.asm, isfloat.asm, driver.c
 
;  This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Compile: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link: g++ -m64 -no-pie -o output.out driver.o manager.o isfloat.o -std=c17
;   Purpose:  This file retrieves a valid float num (otherwise rejects it) and computes the taylor series to find the sin value. later using the math.h sin function to compare the performace of those two.
 ;===== Begin code area ================================================================================================

global manager
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern isfloat
extern atof
extern sin
input_len equ 100




section .data
degree dq 180,0
pi dq 3.14,0
msg_programInfo db "This program Sine Function Benchmark is maintained by Raul Jarquin Valdez",10,0
msg_name db "Please enter your name: ",0
msg_greetings db "It is nice to meet you %s. Please enter an angle number in degrees: ",0
msg_taylorNum db "Thank you.  Please enter the number of terms in a Taylor series to be computed: ",0
msg_ready db "Thank you.  The Taylor series will be used to compute the sine of your angle.",10,0
msg_comp db "The computation completed in %d tics and the computed value is %.9f",10,0
string_format db "%s",0
msg_invalid db "Invalid. Please try again: ",0
int_format db "%d",0
test1 db "The computed %lf",10,0
msg_next db "Next the sine of %.9lf will be computed by the function “sin” in the library <math.h>",10,0
msg_sinvalue db "The computation completed in %d tics and gave the value %.8f",10,0 

section .bss
name resb input_len

section .text
manager:

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

push qword 0        ;"This program Sine Function Benchmark..."
mov rax, 0 
mov rdi, msg_programInfo
call printf
pop rax 

push qword 0        ;"Please enter your name: .."
mov rax, 0 
mov rdi, msg_name
call printf
pop rax 


push qword 0    ;block to store name in buffer
mov rax, 0
mov rdi, name
mov rsi, input_len
mov rdx, [stdin]
call fgets
pop rax


mov rax, 0       ;returns len of string excluding '\0' stores in rax
mov rdi, name
call strlen         

sub rax, 1       ;copy value 0 at mem location of \n
mov byte[name + rax], 0


push qword 0     ;"Its nice to meet you.."
mov rax, 0
mov rdi, msg_greetings
mov rsi, name
call printf
pop rax

Loop:

    push qword 0
    mov rax, 0
    mov rdi, string_format
    mov rsi, rsp
    call scanf
    

   
    mov rax,0
    mov rdi,rsp
    call isfloat
    cmp rax,0
    je invalid
  
    
    ;converts the user's input from a string to float
    mov rax, 0
    mov rdi, rsp            ;passing the user input stored at the top of the stack into the first parameter
    call atof               ;atof convers a string float into a double float value
    movsd xmm15, xmm0    ;backup the elements in xmm0 and copies into xmm15
    pop rax            ;reverse the push qword in the loop if it jumps through this block
    jmp endLoop

invalid:
    pop r11         ;counter the push at start of loop
    push qword 0    ;"Invalid. Please try again: "
    mov rax, 0
    mov rdi, msg_invalid
    call printf
    pop rax 
    jmp Loop
endLoop:

push qword 0        ;"Thank you please enter the num of taylor" 
mov rax, 0
mov rdi, msg_taylorNum
call printf
pop rax 

push qword 0 
mov rax, 0 
mov rdi, int_format
mov rsi, rsp
call scanf             ;Places int format on top of stack 
pop rax
mov r15, rax           ;Stores value popped from the stack into r15, r15 holds number of terms in a Taylor series to be computed


push qword 0        ;"Thank you.The Taylor..."
mov rax, 0
mov rdi, msg_ready
call printf
pop rax 

;==============================CONVERT TO RAD======================
mov rax, 0x400921FB54442D18
push rax
movsd xmm14, [rsp]       ;xmm0 contains pi 
pop rax

mov r14,  180
cvtsi2sd xmm13, r14 

movsd xmm3, xmm15       ; xmm3 holds degrees for later use 

divsd xmm14, xmm13        ; pi / 180.0 
mulsd xmm15, xmm14        ; Degrees * (pi/180.0)


;=========================TAYLOR-SERIES============================
;    The relation between every term k, k+1 is:                                               
;   -1 * x^2
;   -------------
;   (2k+2)(2k+1)

;   Start the term from 1.0 and multiply the recurrance relation against it until terminal

;   k is what iteration we are on
;   x is the user inputted number
;==================================================================
; we need 2.0, -1.0 and 1.0 to multiply floats

mov rax, 2
cvtsi2sd xmm13, rax     ;xmm13 stores 2.0 

mov rax, 1
cvtsi2sd xmm12, rax    ;xmm12 stores 1.0

mov rax, -1
cvtsi2sd xmm11, rax     ;xmm1 stores -1.0

mov rax, 0 
cvtsi2sd xmm10, rax     ;start at k = 0 


mov r13, 0          ;counter for loop
cvtsi2sd xmm9, r13    ;xmm9 stores sum, intially at 0 

; mov rax, 0 
; cvtsi2sd xmm4, rax 
movsd xmm4, xmm15   ; xmm4 stores the current term (rad num)

;==============================BEGIN BENCHMARK FOR TAYLOR SERIES========================================================
xor rdx, rdx
xor rax, rax 
cpuid                      
rdtsc
shl rdx, 32
add rdx, rax
mov r8, rdx    ;r8 holds tics before 


Loop2:
    cmp r15, r13    ;compare number of terms(r15) and counter(r13)
    je endLoop2

    addsd xmm9, xmm4        ;add current term of the sequence     ===================

    movsd xmm8, xmm13       ; xmm8 stores 2.0
    mulsd xmm8, xmm10       ; xmm8 stores 2.0 * 0(k)        xmm10 is the k 
    addsd xmm8, xmm12       ; xmm8 stores result from above + 1

    movsd xmm7, xmm13       ; 2k + 2 stored in xmm7 
    mulsd xmm7, xmm10 
    addsd xmm7, xmm13 

    mulsd xmm8, xmm7        ; (2k+1) * (2k+2)

    movsd xmm6, xmm15       ; xmm6 stores user input (originally was a degree but converted into rads)
    mulsd xmm6,xmm6         ; x^2 stored in xmm6 

    divsd xmm6, xmm8        ; x^2 / (2k+1) * (2k+2)    stored in xmm6 

    mulsd xmm6, xmm11       ; result frm above *  -1   stored in xmm6 

 
    mulsd xmm4, xmm6       ; current term * factor                    =========================

    inc r13
    cvtsi2sd xmm10, r13   ; inc k 
    jmp Loop2
endLoop2:

xor rdx, rdx
xor rax, rax 
cpuid                   
rdtsc
shl rdx, 32
add rdx, rax
mov r12, rdx             ;r9  holds tics after


sub r12, r8             ;Tics After - Tics Before 

;==============================END BENCHMARK FOR TAYLOR SERIES========================================================

push qword 0 
mov rax, 1
mov rdi, msg_comp
mov rsi, r12 
movsd xmm0, xmm9
call printf
pop rax 

;roundps xmm3,xmm3,1

push qword 0            ;"Next the sine of 22.499999995 will be computed by the.."
mov rax, 1 
mov rdi, msg_next
movsd xmm0, xmm3
call printf
pop rax

;==============================BEGIN BENCHMARK FOR SIN==============================================================

xor rdx, rdx
xor rax, rax 
cpuid                   
rdtsc
shl rdx, 32
add rdx, rax
mov r15, rdx             ;r15  holds tics before

push qword 0 
mov rax, 0 
movsd xmm0, xmm15
call sin
movsd xmm15,xmm0
pop rax 


xor rdx, rdx
xor rax, rax 
cpuid                   
rdtsc
shl rdx, 32
add rdx, rax
mov r14, rdx             ;r14  holds tics after

sub r14, r15             ;Tics After - Tics Before


;==============================END BENCHMARK FOR SIN==================================================================

push qword 0 
mov rax, 1
mov rdi, msg_sinvalue
mov rsi, r14
movsd xmm0, xmm15
call printf
pop rax 

mov rax, r12
cvtsi2sd xmm15, r12
movsd xmm0, xmm15 

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