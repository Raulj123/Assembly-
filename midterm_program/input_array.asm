; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; Today's date:  03/22/23
; Section ID: Section 7, MW 12-2pm



global input_array
extern printf
extern scanf
extern stdin
extern clearerr


;Data(Array with data)
segment .data
float_format db "%lf",0
msg2 db "Inavlid num not entered in array",0

segment .bss

;=====================================================================================================
;Main code 
segment .text
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


mov r15, rdi    ;array_a
mov r14, rsi    ;len
mov r13, 0      ;counter

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
    pop r12
    je endLoop



    mov [r15 + 8*r13], r12 ;array[counter](memory address), place input(r12). Multipled by 8 to scale index
    inc r13         ;increment r13(counter)
    jmp Loop


    
    

    jmp endLoop
endLoop:
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

