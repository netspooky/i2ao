section .data
  msg:     db "[^0^] u!!",10
  msgLen:  equ $-msg

section .text
global _start 

_start:
; Print ----------------------------------------------------------------
  mov rax, 1      ; Syscall 1
  mov rdi, 1      ; The File Descriptor - STDOUT
  mov rsi, msg    ; Pointer to the message
  mov rdx, msgLen ; Length of the Message
  syscall         

; Exit -----------------------------------------------------------------
  mov rax, 60     ; Syscall 60
  mov rdi, 0      ; Error code - eg return 0;
  syscall      

;--- Build 
; $ nasm -f elf64 bigsmile.asm -o bigsmile.o
; $ ld bigsmile.o -o bigsmile
; $ ./bigsmile
