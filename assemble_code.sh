gcc -S -g -Os -march=i686 -ffreestanding -Wall -Werror -fno-toplevel-reorder -I. -o $1.s $1.c

