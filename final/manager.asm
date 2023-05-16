; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; Today's date:  05/15/23
; Section ID: Section 07, MW 12-2pm

;Constants
global manager
extern printf
extern scanf
extern getfreq

segment .data
hello db " %.2f",0
format0 db "%lf",0
format1 db "%lf",0
format2 db "%lf",0
format3 db "%lf",0
msg1 db "Please enter the current: ", 0
msg2 db "Please enter the resistance on circuit 1: ", 0
msg3 db "Please enter the resistance on circuit 2: ", 0
msg4 db "Please enter the resistance on circuit 3: ", 0
msg_res db "The total resistance is R = %lf",10,0
msg_vol db "The voltage is V = %lf", 10,0
msg_freq db "The frequency of this processor is %lf GHz",10,0
msg_last db "The computations were performed in  %d tics, which equals %lf seconds.",0



segment .bss



segment .text
manager:

push qword 0                                         ;pushes value 0 onto stack, stored as a 64-bit value
                                                           
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


push qword 0        ;"Please enter the current 
mov rax, 0 
mov rdi, msg1
call printf
pop rax 

push qword 0      ; current stored in xmm15 
mov rax, 0 
mov rdi, format0
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax 

push qword 0        ;"Please enter the r1
mov rax, 0 
mov rdi, msg2
call printf
pop rax 

push qword 0      ; r1 stored in xmm14
mov rax, 0 
mov rdi, format1
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax 

push qword 0        ;"Please enter the r2
mov rax, 0 
mov rdi, msg3
call printf
pop rax 

push qword 0      ; r2 stored in xmm13
mov rax, 0 
mov rdi, format2
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax 

push qword 0        ;"Please enter the r3 
mov rax, 0 
mov rdi, msg4
call printf
pop rax 

push qword 0      ; r3 stored in xmm12
mov rax, 0 
mov rdi, format3
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
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

; ===== CALULATING TOTAL RESISTANCE & VOLTAGE =======================================================================================================================================

mov rax, 1
cvtsi2sd xmm11,rax
movsd xmm10, xmm11
movsd xmm9, xmm11
divsd xmm11, xmm14
divsd xmm10, xmm13
divsd xmm9, xmm12
addsd xmm11, xmm10
addsd xmm11, xmm9
; total r is in xmm11
mulsd xmm15, xmm11
; push qword 0
; mov rax, 1
; mov rdi, hello 
; movsd xmm0, xmm15
; call printf
; pop rax 
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

    sub r13, r14 ;tics after - bfore
    cvtsi2sd xmm3, r13
push qword 0
mov rax, 1
mov rdi, msg_res 
movsd xmm0, xmm11
call printf
pop rax 

push qword 0
mov rax, 1
mov rdi, msg_vol
movsd xmm0, xmm15
call printf
pop rax 

;==call freq

 ;Getting computer speed in GHz
    push qword 0 
    mov rax, 0
    call getfreq
    movsd xmm13, xmm0           ;GHz frequency
    pop rax


push qword 0
mov rax, 1
mov rdi, msg_freq 
movsd xmm0, xmm13
call printf
pop rax 

divsd xmm13, xmm3

push qword 0
mov rax, 1
mov rdi, msg_last
mov rsi, r13
movsd xmm0, xmm3
call printf
pop rax 


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

