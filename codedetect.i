/*****************************************************
This program was produced by the
CodeWizardAVR V1.25.8 Standard
Automatic Program Generator
� Copyright 1998-2007 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 20.02.2024
Author  : F4CG                            
Company : F4CG                            
Comments: 


Chip type           : ATmega128
Program type        : Application
Clock frequency     : 7,372800 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 1024
*****************************************************/
// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega128
#pragma used+
#pragma used+
sfrb PINF=0;
sfrb PINE=1;
sfrb DDRE=2;
sfrb PORTE=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      // 16 bit access
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   // 16 bit access
sfrb SFIOR=0x20;
sfrb WDTCR=0x21;
sfrb OCDR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   // 16 bit access
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  // 16 bit access
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  // 16 bit access
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  // 16 bit access
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb ASSR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TIFR=0x36;
sfrb TIMSK=0x37;
sfrb EIFR=0x38;
sfrb EIMSK=0x39;
sfrb EICRB=0x3a;
sfrb RAMPZ=0x3b;
sfrb XDIV=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// Needed by the power management functions (sleep.h)
#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
#endasm
/* LCD driver routines

  CodeVisionAVR C Compiler
  (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE LCD IS CONNECTED!

  EXAMPLE FOR PORTB:

    #asm
        .equ __lcd_port=0x18
    #endasm
    #include <lcd.h>

*/
#pragma used+
#pragma used+
void _lcd_ready(void);
void _lcd_write_data(unsigned char data);
// write a byte to the LCD character generator or display RAM
void lcd_write_byte(unsigned char addr, unsigned char data);
// read a byte from the LCD character generator or display RAM
unsigned char lcd_read_byte(unsigned char addr);
// set the LCD display position  x=0..39 y=0..3
void lcd_gotoxy(unsigned char x, unsigned char y);
// clear the LCD
void lcd_clear(void);
void lcd_putchar(char c);
// write the string str located in SRAM to the LCD
void lcd_puts(char *str);
// write the string str located in FLASH to the LCD
void lcd_putsf(char flash *str);
// initialize the LCD controller
unsigned char lcd_init(unsigned char lcd_columns);
#pragma used-
#pragma library lcd.lib
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
typedef char *va_list;
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
#asm
{
   .equ __lcd_port=0x1B ;PORTA
        }
#endasm
unsigned int ugol1,ugol2 =0;
int flag = 1;
// External Interrupt 0 service routine
interrupt [2] void ext_int3_isr(void)
{
                       if (PIND.1 == 1)
{               
         if (flag == -1) 
        {             
        //lcd_clear();
        //lcd_putsf("<-");
        //printf(buffer, "%d", ugol);
        //lcd_puts(buffer);
        ugol2=0;
        TCNT1=0; 
        flag = 1;
        }
               ugol1=TCNT1; 
        }
 else 
{       
                if (flag == 1) 
        {                   
                   //lcd_clear();
        //lcd_putsf("->");  
                //sprintf(buffer, "%d", ugol);
        //lcd_puts(buffer); 
                TCNT1=0; 
        flag = -1;
        }
        ugol2=TCNT1; 
}
}
// Timer 3 overflow interrupt service routine
interrupt [30] void timer3_ovf_isr(void)
{       
                               putchar(ugol1);
                putchar(ugol2);
                (*(unsigned char *) 0x88)=0;
                 (*(unsigned char *) 0x89)=0;
}
void main(void)
{
// Declare your local variables here
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;
// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x10;
// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;
// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x00;
// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTE=0x02;
DDRE=0x00;
// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
(*(unsigned char *) 0x62)=0x00;
(*(unsigned char *) 0x61)=0x00;
// Port G initialization
// Func4=In Func3=In Func2=In Func1=In Func0=In 
// State4=T State3=T State2=T State1=T State0=T 
(*(unsigned char *) 0x65)=0x00;
(*(unsigned char *) 0x64)=0x00;
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 115,200 kHz
// Mode: CTC top=OCR0
// OC0 output: Disconnected
ASSR=0x00;
TCCR0=0x00;
TCNT0=0x00;
OCR0=0xFF;
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0x0;
TCCR1B=0b00000111;//������ � ������ ������� �� ������������ ������ �� ����� T1
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
(*(unsigned char *) 0x79)=0x00;
(*(unsigned char *) 0x78)=0x00;
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 7372,800 kHz
// Mode: CTC top=OCR2
// OC2 output: Disconnected
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;
// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: 921,600 kHz
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Timer 3 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
(*(unsigned char *) 0x8b)=0x00;
(*(unsigned char *) 0x8a)=0x01;
(*(unsigned char *) 0x89)=0x00;
(*(unsigned char *) 0x88)=0x00;
(*(unsigned char *) 0x81)=0x00;
(*(unsigned char *) 0x80)=0x00;
(*(unsigned char *) 0x87)=0x00;
(*(unsigned char *) 0x86)=0x00;
(*(unsigned char *) 0x85)=0x00;
(*(unsigned char *) 0x84)=0x00;
(*(unsigned char *) 0x83)=0x00;
(*(unsigned char *) 0x82)=0x00;
// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Rising Edge
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
(*(unsigned char *) 0x6a)=0x03;
EICRB=0x00;
EIMSK=0x01;
EIFR=0x01;
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;
(*(unsigned char *) 0x7d)=0x04;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: Off
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 57600
UCSR0A=0x00;
UCSR0B=0x08;
(*(unsigned char *) 0x95)=0x06;
(*(unsigned char *) 0x90)=0x00;
UBRR0L=0x07;
//LCD initialization
lcd_init(16);
// Global enable interrupts
#asm("sei")
while (1)
      {
                        // Place your code here
      };
}
