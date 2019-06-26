#include "kernel_main.h"
/*Defines the various macros and initialization functions for the 8259A
 * programmable interrupt controller*/

// The following devices use PIC 1 to generate interrupts
#define		I86_PIC_IRQ_TIMER		0
#define		I86_PIC_IRQ_KEYBOARD		1
#define		I86_PIC_IRQ_SERIAL2		3
#define		I86_PIC_IRQ_SERIAL1		4
#define		I86_PIC_IRQ_PARALLEL2		5
#define		I86_PIC_IRQ_DISKETTE		6
#define		I86_PIC_IRQ_PARALLEL1		7
 
//! The following devices use PIC 2 to generate interrupts
#define		I86_PIC_IRQ_CMOSTIMER		0
#define		I86_PIC_IRQ_CGARETRACE		1
#define		I86_PIC_IRQ_AUXILIARY		4
#define		I86_PIC_IRQ_FPU			5
#define	I86_PIC_IRQ_HDC			6

/*These macros define the second operation control word bits*/
#define OCR_2_B1  0x01
#define OCR_2_B2  0x02
#define OCR_2_B3  0x04
#define OCR_2_EOI 0x20
#define OCR_2_SL  0x40
#define OCR_2_R   0x80

/*same port is used for two different function.The sepecific operation
 * desired is determined by the read or the write operation*/
#define PIC1_COMMAND 0x20 //read-only operation
#define PIC1_STATUS  0x20 //write-only operation
#define PIC1_DATA    0x21 //read-only operation
#define PIC1_IMR     0x21 //write-only operation

#define PIC2_COMMAND 0xA0
#define PIC2_STATUS  0xA0
#define PIC2_DATA    0xA1
#define PIC2_IMR     0xA2 

/*Details for the ICW 1. Remember this is the initialization control word
 * which is followed by two or three more ICWs depending on whether a bit is
 * set or not.We only need to worry about 4 bits.Rest everything is
 * either ignored or must be zero*/

#define ICW1_ICW4     0x01        // Whether ICW4 is coming or not 
#define ICW1_PIC_NO 0x00        // 0=Only one PIC in the system
#define ICW1_EDGE_TRIGGERED 0x08 //1 = operation in edge triggered mode
#define ICW1_PIC_INIT 0x10 //Set if the PIC is to be initialized.Which is what we wanna do basically.So this is always 1

/*For ICW2. This control word is used to map the base address of the IVT of which the  PIC are to use.We need to give the hexadecimal address in here.So we not keep any macros for this purpose*/

/*For ICW3.It is used to tell the PICs how they communicate with each
 * other.It is utmost necessary to map them properly if we are using
 * cascading */

/*ICW3_PIC1. Specifies what IRQ of the master PIC is connected to the
 * slave PIC.The macros are self explainatory.In the master PIC, it is
 * specified bitwise*/
#define ICW3_PIC1_B0 0x01
#define ICW3_PIC1_B1 0x02
#define ICW3_PIC1_B2 0x04
#define ICW3_PIC1_B3 0x08
#define ICW3_PIC1_B4 0x10
#define ICW3_PIC1_B5 0x20
#define ICW3_PIC1_B6 0x40
#define ICW3_PIC1_B7 0x80

/*ICW3_PIC2. Specifies what IRQ the master PIC uses to connect to the INT
 * pin of the slave PIC. Here, we only get three bits to specify and
 * nothing more than that.Just the decimal conversion of what we have done
 * above. Nothing more*/
#define ICW3_PIC2_IRQ0 0x00
#define ICW3_PIC2_IRQ1 0x01
#define ICW3_PIC2_IRQ2 0x02
#define ICW3_PIC2_IRQ3 0x03
#define ICW3_PIC2_IRQ4 0x04
#define ICW3_PIC2_IRQ5 0x05
#define ICW3_PIC2_IRQ6 0x06
#define ICW3_PIC2_IRQ7 0x07 

/*ICW4_PIC. We only need to worry about bit 1 as the rest of the bits are
 * useless for us.They talk about buffered mode and shit, which we don't need*/
#define ICW4_PIC_x86 0x01 //1 = We are running in protected mode 

/*Initialization of the PIC with the help of all the macros defined above*/
void init_pic() ;
