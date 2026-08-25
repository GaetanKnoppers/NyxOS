#include "print.h"

void kernel_main(void)
{
    print("Hello, World");

    while (1) {
        __asm__ volatile ("hlt");
    }
}