; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; Today's date:  03/22/23
; Section ID: Section 7, MW 12-2pm


global reverse
extern printf
extern scanf


;Data(Array with data)
segment .data

segment .bss

;=====================================================================================================
;Main code 
segment .text
reverse:

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


mov r15, rdi    ;array_a
mov r14, rsi    ;array_b
mov r13, rdx    ;array_a len
mov r12, 0      ;counter

sub r13,1
beginLoop:
    cmp r13,0
    jl endLoop

    movsd xmm15, [r15+8*r13]
    movsd[r14+8*r12], xmm15

    dec r13
    inc r12
    jmp beginLoop

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



ret

