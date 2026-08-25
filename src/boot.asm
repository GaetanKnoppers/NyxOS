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
    db ' __   __     __  __     __  __     ______     ______', 10    
    db '/\ "-.\ \   /\ \_\ \   /\_\_\_\   /\  __ \   /\  ___\', 10   
    db '\ \ \-.  \  \ \____ \  \/_/\_\/_  \ \ \/\ \  \ \___  \', 10  
    db ' \ \_\\"\_\  \/\_____\   /\_\/\_\  \ \_____\  \/\_____\', 10 
    db '  \/_/ \/_/   \/_____/   \/_/\/_/   \/_____/   \/_____/ ', 0
                                                        
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

    mov esi, logo
    mov edi, 0xB8000
    call print_string

.loop:
    hlt
    jmp .loop

print_string:
    ; ESI = texte
    ; EDI = position VGA de départ

    mov ebp, edi            ; position de début de la ligne

.next:
    lodsb

    cmp al, 0
    je .done

    cmp al, 10
    je .newline

    mov ah, 0x0F
    mov word [edi], ax
    add edi, 2

    jmp .next

.newline:
    add ebp, 160            ; ligne suivante
    mov edi, ebp            ; retour à la colonne de départ
    jmp .next

.done:
    ret
clear_screen:
    mov edi, 0xB8000
    mov ecx, 80 * 25
    mov ax, 0x0F20
    rep stosw
    ret