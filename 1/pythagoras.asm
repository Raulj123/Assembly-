; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; CWID: 887033116
; COURSE: CPSC 240-07, Assignment 1

;Constants
global asmFile
extern printf
extern scanf

;Data(Array with data)
segment .data
msg1 db "Enter the length of the first side of the triangle: ", 0
side1 db "%lf", 0
msg2 db "Enter the length of the second side of the triangle: ", 0
side2 db "%lf", 0
msg3 db 10, "Thank you.  You entered two sides: %.8lf and %.8lf ",0
msg4 db 10, "The length of the hypotenuse is %.8lf ",0
errormsg db "Negative values not allowed. Try again: ",0
zero dq 0.0

;Empty for Assignment1
segment .bss

;=====================================================================================================
;Main code 
segment .text
asmFile:

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

;Asking user for first side
push qword 0                                         ;pushes value 0 onto stack, stored as a 64-bit value
mov rax, 0                                           ;stores value 0 into rax
mov rdi, msg1                                        ;First argument in function call. Holds memory address of the string stored at msg1
call printf                                          ;Argument pushed onto stack and prints msg1 
pop rax                                              ;value stored on top of stack(msg1) is copied into rax

Loop:
    ;input of first side
    push qword 0                                    ;pushes value 0 onto stack, stored as a 64-bit value
    mov rax, 0                                      ;stores value 0 into rax
    mov rdi, side1                                  ;First argument in function call. Holds memory address of the double float stored at side1
    mov rsi, rsp                                    ;pointer that holds address of the top of the stack is stored in rsi
    call scanf                                      ;reads input stores it in rdi & rsi. Values and address are stored on stack 
    movsd xmm15, [rsp]                              ; moves value stored at rsp into xmm15
    movsd xmm14, xmm15                              ; stores value we entered in xmm14(used for scratch work later)
    pop rax                                         ; retrieves value from top of the stack and stores it in rax(Evens out the stack) 
    
    movsd xmm11, [zero]                             ; moves a 0 in xmm11 
    ucomisd xmm15,xmm11                             ; performs comparison of the two double-precision float numbers. Result is stored in flag registers
    jb below_zero                                   ; jump to Below_zero if below condition is met
    jmp end_loop                                    ; if not met will skip over jb belo_zero line and will jump to the end of loop

    below_zero:                                     
    push qword 0                                    ;pushes value 0 onto stack, stored as a 64-bit value
    mov rax, 0                                      ;stores value 0 into rax
    mov rdi, errormsg                               ;First argument in function call. Holds memory address of the string stored at errormsg
    call printf                                     ;Argument pushed onto stack and prints msg1
    pop rax                                         ;value stored on top of stack(errormsg) is copied into rax
    jmp Loop                                        ; jump to start of loop again 
end_loop:

push qword 0                                        ; Asking user for second side no other comments needed on this block of code
mov rax, 0
mov rdi, msg2
call printf
pop rax

Loop2:                                              ;Restore original values ;Start of second loop2
    push qword 0                                    ;no further comments to reduce duplicative annotations
    mov rax, 0
    mov rdi, side2
    mov rsi, rsp
    call scanf
    movsd xmm13, [rsp]
    movsd xmm12, xmm13
    pop rax
    ucomisd xmm13,xmm11
    jb below_zero2
    jmp end_loop2
    below_zero2:
    push qword 0 
    mov rax, 0
    mov rdi, errormsg
    call printf
    pop rax
    jmp Loop2
end_loop2:


push qword 0                                      ;displaying both numbers 
mov rax, 2                                        ;values in xmm0, xmmm1 will be outputted
mov rdi, msg3                                     ;First argument in function call. Holds memory address of the string stored at msg3
movsd xmm0, xmm15
movsd xmm1, xmm13
call printf
pop rax

push qword 0
mov rax, 1                                        ;Values in xmm0 will be outputted
mov rdi, msg4
mulsd xmm14, xmm14                                ;multiply xmm14 by itself and store in xmm14
mulsd xmm12,xmm12                                 ;multiply xmm14 by itself and store in xmm14
addsd xmm14,xmm12                                 ;Add xmm12 with xmm14 and store in xmm14
sqrtsd xmm14,xmm14                                ;Take square root of xmm14 and store in xmm14
movsd xmm0, xmm14                                 ; mov value in xmm14 and store it in xmm0
call printf                                       
pop rax
 
movsd xmm0,xmm14                                  ;send back the result 

                                                    
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


