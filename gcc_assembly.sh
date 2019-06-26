gcc -S -g -Os -march=i686 -ffreestanding -Wall  -fno-toplevel-reorder -I. -o $1.s $1.c 
