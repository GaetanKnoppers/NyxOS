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

section .rodata
logo:
    db " __   __     __  __     __  __     ______     ______", 0    
    db "/\ "-.\ \   /\ \_\ \   /\_\_\_\   /\  __ \   /\  ___\", 0   
    db "\ \ \-.  \  \ \____ \  \/_/\_\/_  \ \ \/\ \  \ \___  \", 0  
    db " \ \_\\"\_\  \/\_____\   /\_\/\_\  \ \_____\  \/\_____\", 0 
    db "  \/_/ \/_/   \/_____/   \/_/\/_/   \/_____/   \/_____/ ", 0
                                                        
section .bss
align 16

stack_bottom:
    resb 16384
stack_top:

section .text
bits 32

global _start


_start:
    cli

    mov esp, stack_top

    mov word [0xb8000 + 160 + 0], 0x0F48
    mov word [0xb8000 + 160 + 2], 0x0F65
    mov word [0xb8000 + 160 + 4], 0x0F6C
    mov word [0xb8000 + 160 + 6], 0x0F6C
    mov word [0xb8000 + 160 + 8], 0x0F6F
    mov word [0xb8000 + 160 + 10], 0x0F2C
    mov word [0xb8000 + 160 + 12], 0x0F20
    mov word [0xb8000 + 160 + 14], 0x0F57
    mov word [0xb8000 + 160 + 16], 0x0F6F
    mov word [0xb8000 + 160 + 18], 0x0F72
    mov word [0xb8000 + 160 + 20], 0x0F6C
    mov word [0xb8000 + 160 + 22], 0x0F64

.loop:
    hlt
    jmp .loop