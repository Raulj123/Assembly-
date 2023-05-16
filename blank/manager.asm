; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; Today's date:  05/15/23
; Section ID: Section 07, MW 12-2pm

;Constants
global manager
extern printf
extern scanf
age equ 44
segment .data
msg1 db "Happy Birthday Chris for year %d", 10,0

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

mov r15, 44     ; age we want to stop at 
mov r14, 1      ; current age 

Loop:
    cmp r14,r15
    jg endLoop

    push qword 0 
    mov rax, 0 
    mov rdi, msg1
    mov rsi, r14
    call printf
    pop rax

    inc r14
    jmp Loop

endLoop:


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
mov rax, age

ret

