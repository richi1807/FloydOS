/*We will load our C bootloader at 0x600 */
ENTRY(main);
SECTIONS
{
    . = 0x600;
    .text : AT(0x600)
    {
        _text = .;
        *(.text);
        _text_end = .;
    }
    .data :
    {
        _data = .;
        *(.bss);
        *(.bss*);
        *(.data);
        *(.rodata*);
        *(COMMON)
        _data_end = .;
    }
/*    .sig : AT(0x201FE)
    {
        SHORT(0xaa55);
    }
*/
    /DISCARD/ :
    {
        *(.note*);
        *(.iplt*);
        *(.igot*);
        *(.rel*);
        *(.comment);
/* add any unwanted sections spewed out by your version of gcc and flags here */
    }
}
