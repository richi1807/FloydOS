/*The header file for the keyboard device controller and the keyboard encoder.
 * There are two devices we need to program if we need to get the hardware
 * keyboard thing working. One is the onboard keyboard and the other is the
 * ususal keyboard controller which is present on the Motherboard itself
 * Some lessons learnt :
 * 
 * 1.Keyboards are slow devices , far slower than the usual CPUs. Hence , we
 * should wait for the keyboard to finish the previous operation. This can be
 * done by reading the value in the status register.
 *
 * 2.Whatever we write to the keyboard encoder will go to the keyboard
 * controller first. So make sure to for the keyboard controller as well
 * */
#include "common.h"

#ifndef __KBD__
#define __KBD__
//Define the macros
#define KBD_ENCODER_PORT 0x60
#define KBD_CONTROLLER_PORT 0x64
#define true 1 
#define false 0
/*Sending the command to the keyboard cntroller*/
uint16_t kbd_get_code() ;
uint8_t get_key_pressed() ;
void init_kbd() ;
#endif 
