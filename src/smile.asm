section .data
  msg:     db "[^0^] u!!",10
  msgLen:  equ $-msg

section .text
global _start 

_start:
; Print ----------------------------------------------------------------
  mov al, 1       ; RAX holds syscall 1 (write). We are using the lower
                  ; 8 bits of RAX with AL. This takes up less bytes.
  mov rdi, rax    ; RDI holds the file descriptor - STDOUT. We copy the
                  ; value in RAX and move it there to save space.
  mov rsi, msg    ; RSI contains the address of our buffer.
  mov dl, msgLen  ; RDX holds the length of the buffer. We are the lower 
                  ; 8 bits, DL, again for this.
  syscall         ; Now we call the kernel.

; Exit -----------------------------------------------------------------
  mov al, 60      ; We are now executing syscall 60 - Exit
  xor rdi, rdi    ; RDI contains the return value, here it will be 0!
  syscall         ; Call the kernel one last time.

;--- Build 
; $ nasm -f elf64 smile.asm -o smile.o
; $ ld smile.o -o smile
; $ ./smile
