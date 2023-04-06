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
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm 
;   Link: gcc gcc -m64 -no-pie -o main.out manager.o main.o getradicand.o get_clock_freq.o -std=c17
;   Purpose:  This is the central module that will direct calls to different functions including get_freq, getradicand main file to benchmark the 
;              square root instruction 

;===== Begin code area ==========================================================================================================================================================
global manager
extern printf
extern scanf
extern atof
extern getradicand
extern get_freq

segment .data
msg_greetings db "Welcome to Square Root Benchmarks by Raul Jarquin Valdez",10,0
msg_cpu db 10,"Your CPU is %s",10,0
msg_maxClock db 10,"Your max clock speed is %d MHz",10,0
msg_squareRoot db 10,"The square root of %lf is %lf.",10,0
msg_numOftimes db 10,"Next enter the number of times iteration should be performed: ",0
int_format db "%ld",0
msg_tics_before db 10,"The time on the clock is %d tics.",10,0
msg_benchBegin db 10,"The bench mark of the sqrtsd instruction is in progress.",10,0
msg_tics_after db 10,"The time on the clock is %d tics and the benchmark is completed.",10,0
msg_elapsed db 10,"The elapsed time was %d tics",10,0
msg_time db 10,"The time for one square root computation is %f tics which equals %f ns.",10,0

segment .bss
cpu_name resb 100



segment .text 


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


    push qword 0       ;""Welcome to Square Root..."
    mov rax, 0
    mov rdi, msg_greetings
    call printf
    pop rax



    ;=============================CPU Name====================================================================================================================================
    mov r15, 0x80000002 ; this value is passed to cpuid to get information about the processor
    mov rax, r15  ; get processor brand and information
	cpuid         ; cpu identification
    
    mov [cpu_name], rax     ;gets first 4 char
    mov[cpu_name +4], rbx
    mov [cpu_name +8], rcx
    mov [cpu_name +12], rdx
    
    mov r15, 0x80000003 
    mov rax, r15 
	cpuid        
    
    mov [cpu_name +16], rax     ;gets next 4 char
    mov[cpu_name +20], rbx
    mov [cpu_name +24], rcx
    mov [cpu_name +28], rdx

    mov r15, 0x80000004 ; this value is passed to cpuid to get information about the processor
    mov rax, r15  ; get processor brand and information
	cpuid         ; cpu identification
    
    mov [cpu_name +32], rax     ;gets last 4 char
    mov[cpu_name +36], rbx
    mov [cpu_name +40], rcx
    mov [cpu_name +44], rdx

    push qword 0     ;"Your CPU...."
    mov rax, 0
    mov rdi, msg_cpu
    mov rsi, cpu_name
    call printf
    pop rax


   ;===== Obtain and display the CPU max and min frequencies ================================================================================================================
    ;so clock speed is number of times a tic tic's
  
    mov rax,0x0000000000000016
    cpuid
    mov rdx, rbx      ;copy max frequency to rdx                       
  
    push qword 0      ;"Your max clock speed is...""
    mov rax, 0
    mov rdi, msg_maxClock
    mov rsi, rdx
    call printf
    pop rax


    ;===== Obtain float num and compute square root ===========================================================================================================================
    push qword 0      
    mov rax, 0 
    call getradicand
    movsd xmm15, xmm0
    pop rax

    movsd xmm14, xmm15      ;xmm14 holds float num from user
    sqrtsd xmm15, xmm15     ;computing sq-rt

    push qword 0            ;"The square root of ..."
    mov rax, 2
    mov rdi, msg_squareRoot
    movsd xmm0, xmm14 
    movsd xmm1, xmm15       ;xmm15 holds computed sqrt num 
    call printf
    pop rax 

    
    ;===== display the sqrtsd instruction ======================================================================================================================================
    
    push qword 0       ;"Next enter the number..."
    mov rax, 0 
    mov rdi, msg_numOftimes
    call printf
    pop rax

    push qword 0
    mov rax, 0 
    mov rdi, int_format
    mov rsi, rsp
    call scanf
    mov r15, rsi
    pop rax
  

    ;===== DETERMINE CPU TICS BEFORE ================================================================================================================================================
	xor rdx, rdx
    xor rax, rax
    cpuid			;Identify your CPU	
	rdtsc			;Gets number of tics. This combines one half of 	 ;
	;				;rdx and one half of rax into 1 register.			 ;   
	;				;rdtsc = "Read Time Stamp Counter"					 ;
	;																	 ;
	;																	 ;
	shl rdx, 32		;Shifts the 32 bits of rdx to the the.
	add rdx, rax
    mov r14, rdx    ;r14 holds tics before

    push qword 0
    mov rax, 0
    mov rdi, msg_tics_before
    mov rsi, r14
    call printf
    pop rax 


;===== Benchmark begin ========================================================================================================================================================

    push qword 0        ;"the benchmark is in progress..."
    mov rax, 0
    mov rdi, msg_benchBegin
    call printf
    pop rax 
 
    mov r13, 0     ;r13 holds loop counter start at 1 since user asked for n cycles not n+1 cycles 
    beginLoop:
        cmp r15, r13
        je endLoop

        movsd xmm13, xmm14      ;holds copy of input num
        sqrtsd xmm13, xmm13     ;computing sq-rt
 
        
       
        inc r13
        jmp beginLoop

    endLoop:
    

 ;===== DETERMINE CPU TICS AFTER ================================================================================================================================================
    
    xor rdx, rdx
    xor rax, rax
    cpuid			;Identify your CPU	
	rdtsc			;Gets number of tics. This combines one half of 	 ;
	;				;rdx and one half of rax into 1 register.			 ;   
	;				;rdtsc = "Read Time Stamp Counter"					 ;
	;																	 ;
	;																	 ;
	shl rdx, 32		;Shifts the 32 bits of rdx to the the.
	add rdx, rax
    mov r13, rdx    ;r13 holds tics after 

    push qword 0    ;"The time on the clock is..."
    mov rax, 0
    mov rdi, msg_tics_after
    mov rsi, r13
    call printf
    pop rax 


    ;=====CALCULATE ELAPSED TIME==================================================================================================================================================

   
    ;Getting computer speed in GHz
    push qword 0 
    mov rax, 0
    call get_freq
    movsd xmm13, xmm0           ;GHz frequency
    pop rax


    ;Elapsed time in tics
    sub r13, r14     ;Tics After - Tics Before
   

    push qword 0        ;"The elapsed time was..."
    mov rax, 0
    mov rdi, msg_elapsed
    mov rsi, r13
    call printf
    pop rax 


    cvtsi2sd xmm15, r13  ; elapsed time 
    divsd xmm15, xmm13   ; elapsed / GHz frequency , tics divide out and youre left with nano secs

    
   cvtsi2sd xmm12, r15   ;users n loop converted into IEE
   divsd xmm15, xmm12    ; xmm15 = elapsed / n 

   
  

    push qword 0        ;"The time for one square comput..."
    mov rax, 1
    mov rdi, msg_time
    movsd xmm0, xmm15   ;time for one square root computation in tics
    movsd xmm1, xmm13   ;converted into nano sec 
    call printf
    pop rax 


    movsd xmm0, xmm13

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