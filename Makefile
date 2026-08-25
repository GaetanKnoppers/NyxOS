ASM=nasm
LD=ld

SRC_DIR=src
ISO_DIR=iso

BOOT_OBJ=$(SRC_DIR)/boot.o
KERNEL=kernel.elf
ISO=NyxOS.iso

all: $(ISO)

$(BOOT_OBJ): $(SRC_DIR)/boot.asm
	$(ASM) -f elf32 $(SRC_DIR)/boot.asm -o $(BOOT_OBJ)

$(KERNEL): $(BOOT_OBJ) linker.ld
	$(LD) -m elf_i386 -T linker.ld -o $(KERNEL) $(BOOT_OBJ)

$(ISO): $(KERNEL)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	grub-mkrescue -o $(ISO) $(ISO_DIR)


rebuild: clean all