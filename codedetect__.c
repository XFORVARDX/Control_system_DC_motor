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

#include <mega128.h>
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
#include <lcd.h>
#include <delay.h>
#include <stdio.h>



#asm
{
   .equ __lcd_port=0x1B ;PORTA
        }
#endasm
#define BAUD 9600

unsigned int ugol1,ugol2 =0;
int flag = 1;

// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int3_isr(void)
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
interrupt [TIM3_OVF] void timer3_ovf_isr(void)
{


                putchar(ugol1);
                putchar(ugol2);
                TCNT3L=0;
                 TCNT3H=0;


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
PORTF=0x00;
DDRF=0x00;

// Port G initialization
// Func4=In Func3=In Func2=In Func1=In Func0=In
// State4=T State3=T State2=T State1=T State0=T
PORTG=0x00;
DDRG=0x00;


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
OCR1CH=0x00;
OCR1CL=0x00;


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
TCCR3A=0x00;
TCCR3B=0x01;
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

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
EICRA=0x03;
EICRB=0x00;
EIMSK=0x01;
EIFR=0x01;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;
ETIMSK=0x04;

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
UCSR0C=0x06;
UBRR0H=0x00;
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
