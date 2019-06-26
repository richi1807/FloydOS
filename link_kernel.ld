/*We will load our C kernel at 0xA00 */
ENTRY(main);
SECTIONS
{
    . = 0xC00;
    .text : AT(0xC00)
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
