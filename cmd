rm *.o
rm *.bin
rm floppy.img
nasm -f bin -o boot.bin boot.asm 
nasm -f bin -o gdt.bin gdt.asm
nasm -f elf -o desc_flush.o desc_flush.asm 
nasm -f elf -o intr.o intr.asm
nasm -f elf -o paging_helper.o paging.asm  
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o pic.o pic.c 
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o vbr.o vbr.c
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o descriptors.o descriptors.c 
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o kernel_main.o kernel_main.c
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o monitor.o monitor.c
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o pmm.o pmm.c
gcc -c -g -Os -march=i686 -ffreestanding -Wall -Werror -I. -fno-toplevel-reorder -o paging.o paging.c
ld -static -Tlink.ld -nostdlib --nmagic -o vbr.elf vbr.o
ld -static -Tlink_kernel.ld -nostdlib --nmagic -o kernel_main.elf kernel_main.o monitor.o  desc_flush.o descriptors.o intr.o pic.o pmm.o paging.o paging_helper.o
objcopy -O binary vbr.elf vbr.bin
objcopy -O binary kernel_main.elf kernel_main.bin
dd if=/dev/zero of=floppy.img bs=512 count=2880 
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc 
dd if=vbr.bin of=floppy.img bs=512 count=1 conv=notrunc seek=1 
dd if=gdt.bin of=floppy.img bs=512 count=2 conv=notrunc seek=2
dd if=kernel_main.bin of=floppy.img conv=notrunc bs=512 seek=4
