section .multiboot
align 8

header_start:

    dd 0xe85250d6                ; magic number (multiboot 2)
    dd 0                         ; architecture 0 (Mode x86 proteger)
    dd header_end - header_start ; Longeur du header
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start)) ; checksum

    ;Tag pour GRUB
    dw 0
    dw 0
    dd 8

header_end:
                                                        
section .bss
align 16

stack_bottom:
    resb 16384
stack_top:


section .text
bits 32

global _start
extern kernel_main

_start:
    cli

    mov esp, stack_top

    call kernel_main

.hang:
    hlt
    jmp .hang