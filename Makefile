ASM=nasm
CC=gcc
LD=ld

all: NyxOS.iso

src/boot.o: src/boot.asm
	$(ASM) -f elf32 src/boot.asm -o src/boot.o

src/print.o: lib/print.c
	$(CC) -m32 -ffreestanding -fno-pie -fno-stack-protector -c src/print.c -o src/print.o

src/kernel.o: src/kernel.c
	$(CC) -m32 -ffreestanding -fno-pie -fno-stack-protector -c src/kernel.c -o src/kernel.o

kernel.elf: src/boot.o src/kernel.o linker.ld
	$(LD) -m elf_i386 -T linker.ld -o kernel.elf src/boot.o src/kernel.o src/print.o

NyxOS.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	grub-mkrescue -o NyxOS.iso iso/