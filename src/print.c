#include "print.h"

static int cursor_x = 0;
static int cursor_y = 0;

void print(const char* text) {
    volatile unsigned short* vga = (unsigned short*)0xB8000;
    unsigned short color_attribute = 0x0F << 8;

    for (int i = 0; text[i] != '\0'; i++) {
        // Si retour à la ligne '\n'
        if (text[i] == '\n') {
            cursor_x = 0;    // On revient tout à gauche
            cursor_y++;      // On descend d'une ligne
        } 
        // Sinon, affiche le caractère normalement
        else {
            //calcule de la case mémoire exacte sur l'écran (Y * Largeur + X)
            int index = (cursor_y * 80) + cursor_x;
            vga[index] = color_attribute | text[i];
            
            cursor_x++; //avance vers la droite
        }

        // Si le bord droit de l'écran est depassé (plus de 80 caractères)
        if (cursor_x >= 80) {
            cursor_x = 0;
            cursor_y++;
        }
    }
}