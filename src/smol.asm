BITS 64
        org 0x100000000  ; Where to load this into memory
;----------------------+------+-------------+----------+------------------------
; ELF Header struct    | OFFS | ELFHDR      | PHDR     | ASSEMBLY OUTPUT
;----------------------+------+-------------+----------+------------------------
        db 0x7F, "ELF" ; 0x00 | e_ident     |          | 7f 45 4c 46
msg:    dd 0x5e305e5b  ; 0x04 |             |          | 5b 5e 30 5e "^0^["
        dd 0x2175205d  ; 0x08 |             |          | 5d 20 75 21 "!u ]"
        dw 0x0a21      ; 0x0C |             |          | 21 0a       "\n!"
        dw 0x0         ; 0x0E |             |          | 00 00
;----------------------+------+-------------+----------+------------------------
; ELF Header struct ct.| OFFS | ELFHDR      | PHDR     | ASSEMBLY OUTPUT
;----------------------+------+-------------+----------+------------------------
        dw 2           ; 0x10 | e_type      |          | 02 00
        dw 0x3e        ; 0x12 | e_machine   |          | 3e 00
        dd 1           ; 0x14 | e_version   |          | 01 00 00 00
        dd _start - $$ ; 0x18 | e_entry     |          | 04 00 00 00 
;----------------------+------+-------------+----------+------------------------
; Program Header Begin | OFFS | ELFHDR      | PHDR     | ASSEMBLY OUTPUT
;----------------------+------+-------------+----------+------------------------
phdr:   dd 1           ; 0x1C |   ...       | p_type   | 01 00 00 00 
        dd phdr - $$   ; 0x20 | e_phoff     | p_flags  | 1c 00 00 00
        dd 0           ; 0x24 |   ...       | p_offset | 00 00 00 00
        dd 0           ; 0x28 | e_shoff     |   ...    | 00 00 00 00
        dq $$          ; 0x2C |   ...       | p_vaddr  | 00 00 00 00 
                       ; 0x30 | e_flags     |   ...    | 01 00 00 00 
        dw 0x40        ; 0x34 | e_shsize    | p_addr   | 40 00
        dw 0x38        ; 0x36 | e_phentsize |   ...    | 38 00
        dw 1           ; 0x38 | e_phnum     |   ...    | 01 00
        dw 2           ; 0x3A | e_shentsize |   ...    | 02 00
        dq 2           ; 0x3C | e_shnum     | p_filesz | 02 00 00 00 00 00 00 00
        dq 2           ; 0x44 |             | p_memsz  | 02 00 00 00 00 00 00 00
        dq 2           ; 0x4C |             | p_align  | 02 00 00 00 00 00 00 00
;--- END OF HEADER -------------------------------------------------------------
_start: 
;--- Write -----------------------------------------------------------------//--
  mov al, 1
  ; mov rdi, rax
  mov edi, eax
  ; mov rsi, msg 
  mov esi, eax
  shl rsi, 0x20
  mov sil, 4
  mov dl, 10
  syscall
;--- Exit ------------------------------------------------------------------//--
  mov al, 60     
  xor rdi, rdi   
  syscall        

; Build
; nasm -f bin -o smol smol.asm
