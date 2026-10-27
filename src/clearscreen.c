#include "print.h"

void clear_screen() {
    volatile unsigned short* vga = (unsigned short*)0xB8000;
    unsigned short blank_char = 0x0F << 8; // Blanc sur fond noir
    
    // Efface tout l'écran (25 lignes de 80 caractères)
    for (int i = 0; i < 80 * 25; i++) {
        vga[i] = blank_char;
    }
    
    // Réinitialise le curseur
    cursor_x = 0;
    cursor_y = 0;
}