; Name: Raul Jarquin Valdez
; Email: jarquinr121@csu.fullerton.edu
; Today's date:  03/22/23
; Section ID: Section 7, MW 12-2pm

;Constants
global manager
extern isfloat
extern printf
extern scanf
extern stdin
extern clearerr
extern atof
extern fgets
extern strlen
extern input_array
extern display_array
extern reverse 
max equ 10
input_len equ 100

;Data(Array with data)
segment .data
msg1 db "Please enter your name: ", 0
msg2 db "What is your title: ",0
msg3 db "Welcome %s %s",10,0
msg4 db "This is our reversible program.",10,0
msg5 db "Please enter float numbers separated by ws and press <enter><control+d> to terminate inputs.",10,0
string_format db "%s",0
msg6 db 10,"You entered",10,0
msg7 db "The array has %d doubles",10,0
msg8 db 10,"The function reverse was called",0
msg9 db 10,"The second array holds these values",10,0

segment .bss
array_a resq max   ;array_a reserves 10, 64 bit nums
array_b resq max ;array_b
name resb input_len
title resb input_len
;=====================================================================================================
;Main code 
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



push qword 0        ;"Enter your name"
mov rax, 0 
mov rdi, msg1
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


push qword 0
mov rax, 0
mov rdi, msg2
call printf
pop rax


push qword 0    ;block to store name in buffer
mov rax, 0
mov rdi, title
mov rsi, input_len
mov rdx, [stdin]
call fgets
pop rax


mov rax, 0       ;returns len of string excluding '\0' stores in rax
mov rdi, title
call strlen         

sub rax, 1       ;copy value 0 at mem location of \n
mov byte[title + rax], 0



push qword 0       ;"Welcome..."
mov rax, 0 
mov rdi, msg3
mov rsi, title
mov rdx, name
call printf
pop rax


push qword 0    ;"This is our..."
mov rax, 0
mov rdi, msg4
call printf
pop rax


push qword 0    ;"Please enter.."
mov rax, 0
mov rdi, msg5
call printf
pop rax


push qword 0 
mov rax, 0 
mov rdi, array_a
mov rsi, max
call input_array
mov r13, rax
pop rax 


push qword 0    ;"You enterd"
mov rax, 0
mov rdi, msg6
call printf
pop rax


push qword 0 
mov rax, 0
mov rdi, array_a
mov rsi, r13
call display_array
pop rax 

push qword 0    ;"The array has n doubles"
mov rax, 0
mov rdi, msg7
mov rsi, r13
call printf
pop rax


push qword 0    ;"The function reverse..."
mov rax, 0
mov rdi, msg8
call printf
pop rax

push qword 0    ;call reverse fucntion 
mov rax, 0
mov rdi, array_a
mov rsi, array_b
mov rdx, r13        ;size of array_a
call reverse
pop rax


push qword 0    ;"The second array holds..."
mov rax, 0
mov rdi, msg9
call printf
pop rax


push qword 0        ;Display reverse array
mov rax, 0
mov rdi, array_b
mov rsi, r13
call display_array
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

mov rax, name

ret

