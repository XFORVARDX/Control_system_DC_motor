
;CodeVisionAVR C Compiler V1.25.8 Standard
;(C) Copyright 1998-2007 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 7,372800 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "codedetect.vec"
	.INCLUDE "codedetect.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x1000)
	LDI  R25,HIGH(0x1000)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

	OUT  RAMPZ,R24

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x10FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x10FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x500)
	LDI  R29,HIGH(0x500)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.25.8 Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2007 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 
;       8 Project :
;       9 Version :
;      10 Date    : 20.02.2024
;      11 Author  : F4CG
;      12 Company : F4CG
;      13 Comments:
;      14 
;      15 
;      16 Chip type           : ATmega128
;      17 Program type        : Application
;      18 Clock frequency     : 7,372800 MHz
;      19 Memory model        : Small
;      20 External SRAM size  : 0
;      21 Data Stack size     : 1024
;      22 *****************************************************/
;      23 
;      24 #include <mega128.h>
;      25 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      26 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      27 	.EQU __se_bit=0x20
	.EQU __se_bit=0x20
;      28 	.EQU __sm_mask=0x1C
	.EQU __sm_mask=0x1C
;      29 	.EQU __sm_powerdown=0x10
	.EQU __sm_powerdown=0x10
;      30 	.EQU __sm_powersave=0x18
	.EQU __sm_powersave=0x18
;      31 	.EQU __sm_standby=0x14
	.EQU __sm_standby=0x14
;      32 	.EQU __sm_ext_standby=0x1C
	.EQU __sm_ext_standby=0x1C
;      33 	.EQU __sm_adc_noise_red=0x08
	.EQU __sm_adc_noise_red=0x08
;      34 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;      35 	#endif
	#endif
;      36 #include <lcd.h>
;      37 #include <delay.h>
;      38 #include <stdio.h>
;      39 
;      40 
;      41 
;      42 #asm
;      43 {
{
;      44    .equ __lcd_port=0x1B ;PORTA
   .equ __lcd_port=0x1B ;PORTA
;      45         }
        }
;      46 #endasm
;      47 #define BAUD 9600
;      48 
;      49 unsigned int ugol1,ugol2 =0;
;      50 int flag = 1;
;      51 
;      52 // External Interrupt 0 service routine
;      53 interrupt [EXT_INT0] void ext_int3_isr(void)
;      54 {

	.CSEG
_ext_int3_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      55 
;      56 
;      57 
;      58 
;      59 if (PIND.1 == 1)
	SBIS 0x10,1
	RJMP _0x4
;      60 {
;      61 
;      62         if (flag == -1)
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x5
;      63         {
;      64         //lcd_clear();
;      65         //lcd_putsf("<-");
;      66         //printf(buffer, "%d", ugol);
;      67         //lcd_puts(buffer);
;      68         ugol2=0;
	CLR  R6
	CLR  R7
;      69         TCNT1=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
;      70         flag = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R8,R30
;      71 
;      72         }
;      73                ugol1=TCNT1;
_0x5:
	__INWR 4,5,44
;      74         }
;      75 
;      76 else
	RJMP _0x6
_0x4:
;      77 {
;      78 
;      79 
;      80         if (flag == 1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x7
;      81         {
;      82 
;      83 
;      84         //lcd_clear();
;      85         //lcd_putsf("->");
;      86 
;      87         //sprintf(buffer, "%d", ugol);
;      88         //lcd_puts(buffer);
;      89 
;      90         TCNT1=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
;      91         flag = -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	MOVW R8,R30
;      92         }
;      93         ugol2=TCNT1;
_0x7:
	__INWR 6,7,44
;      94 }
_0x6:
;      95 
;      96 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      97 
;      98 
;      99 // Timer 3 overflow interrupt service routine
;     100 interrupt [TIM3_OVF] void timer3_ovf_isr(void)
;     101 {
_timer3_ovf_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     102 
;     103 
;     104                 putchar(ugol1);
	ST   -Y,R4
	CALL _putchar
;     105                 putchar(ugol2);
	ST   -Y,R6
	CALL _putchar
;     106                 TCNT3L=0;
	LDI  R30,LOW(0)
	STS  136,R30
;     107                  TCNT3H=0;
	STS  137,R30
;     108 
;     109 
;     110 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;     111 void main(void)
;     112 {
_main:
;     113 
;     114 // Declare your local variables here
;     115 
;     116 // Input/Output Ports initialization
;     117 // Port A initialization
;     118 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     119 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     120 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     121 DDRA=0x00;
	OUT  0x1A,R30
;     122 
;     123 // Port B initialization
;     124 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     125 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     126 PORTB=0x00;
	OUT  0x18,R30
;     127 DDRB=0x10;
	LDI  R30,LOW(16)
	OUT  0x17,R30
;     128 
;     129 // Port C initialization
;     130 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     131 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     132 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     133 DDRC=0x00;
	OUT  0x14,R30
;     134 
;     135 // Port D initialization
;     136 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     137 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     138 PORTD=0x00;
	OUT  0x12,R30
;     139 DDRD=0x00;
	OUT  0x11,R30
;     140 
;     141 // Port E initialization
;     142 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     143 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     144 PORTE=0x02;
	LDI  R30,LOW(2)
	OUT  0x3,R30
;     145 DDRE=0x00;
	LDI  R30,LOW(0)
	OUT  0x2,R30
;     146 
;     147 // Port F initialization
;     148 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     149 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     150 PORTF=0x00;
	STS  98,R30
;     151 DDRF=0x00;
	STS  97,R30
;     152 
;     153 // Port G initialization
;     154 // Func4=In Func3=In Func2=In Func1=In Func0=In
;     155 // State4=T State3=T State2=T State1=T State0=T
;     156 PORTG=0x00;
	STS  101,R30
;     157 DDRG=0x00;
	STS  100,R30
;     158 
;     159 
;     160 // Timer/Counter 0 initialization
;     161 // Clock source: System Clock
;     162 // Clock value: 115,200 kHz
;     163 // Mode: CTC top=OCR0
;     164 // OC0 output: Disconnected
;     165 ASSR=0x00;
	OUT  0x30,R30
;     166 TCCR0=0x00;
	OUT  0x33,R30
;     167 TCNT0=0x00;
	OUT  0x32,R30
;     168 OCR0=0xFF;
	LDI  R30,LOW(255)
	OUT  0x31,R30
;     169 
;     170 // Timer/Counter 1 initialization
;     171 // Clock source: System Clock
;     172 // Clock value: Timer 1 Stopped
;     173 // Mode: Normal top=FFFFh
;     174 // OC1A output: Discon.
;     175 // OC1B output: Discon.
;     176 // OC1C output: Discon.
;     177 // Noise Canceler: Off
;     178 // Input Capture on Falling Edge
;     179 // Timer 1 Overflow Interrupt: Off
;     180 // Input Capture Interrupt: Off
;     181 // Compare A Match Interrupt: Off
;     182 // Compare B Match Interrupt: Off
;     183 // Compare C Match Interrupt: Off
;     184 TCCR1A=0x0;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
;     185 TCCR1B=0b00000111;//таймер в режиме счечика по нарастающему фронту со входа T1
	LDI  R30,LOW(7)
	OUT  0x2E,R30
;     186 TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;     187 TCNT1L=0x00;
	OUT  0x2C,R30
;     188 ICR1H=0x00;
	OUT  0x27,R30
;     189 ICR1L=0x00;
	OUT  0x26,R30
;     190 OCR1AH=0x00;
	OUT  0x2B,R30
;     191 OCR1AL=0x00;
	OUT  0x2A,R30
;     192 OCR1BH=0x00;
	OUT  0x29,R30
;     193 OCR1BL=0x00;
	OUT  0x28,R30
;     194 OCR1CH=0x00;
	STS  121,R30
;     195 OCR1CL=0x00;
	STS  120,R30
;     196 
;     197 
;     198 // Timer/Counter 2 initialization
;     199 // Clock source: System Clock
;     200 // Clock value: 7372,800 kHz
;     201 // Mode: CTC top=OCR2
;     202 // OC2 output: Disconnected
;     203 TCCR2=0x00;
	OUT  0x25,R30
;     204 TCNT2=0x00;
	OUT  0x24,R30
;     205 OCR2=0x00;
	OUT  0x23,R30
;     206 
;     207 // Timer/Counter 3 initialization
;     208 // Clock source: System Clock
;     209 // Clock value: 921,600 kHz
;     210 // Mode: Normal top=FFFFh
;     211 // Noise Canceler: Off
;     212 // Input Capture on Falling Edge
;     213 // OC3A output: Discon.
;     214 // OC3B output: Discon.
;     215 // OC3C output: Discon.
;     216 // Timer 3 Overflow Interrupt: On
;     217 // Input Capture Interrupt: Off
;     218 // Compare A Match Interrupt: Off
;     219 // Compare B Match Interrupt: Off
;     220 // Compare C Match Interrupt: Off
;     221 TCCR3A=0x00;
	STS  139,R30
;     222 TCCR3B=0x01;
	LDI  R30,LOW(1)
	STS  138,R30
;     223 TCNT3H=0x00;
	LDI  R30,LOW(0)
	STS  137,R30
;     224 TCNT3L=0x00;
	STS  136,R30
;     225 ICR3H=0x00;
	STS  129,R30
;     226 ICR3L=0x00;
	STS  128,R30
;     227 OCR3AH=0x00;
	STS  135,R30
;     228 OCR3AL=0x00;
	STS  134,R30
;     229 OCR3BH=0x00;
	STS  133,R30
;     230 OCR3BL=0x00;
	STS  132,R30
;     231 OCR3CH=0x00;
	STS  131,R30
;     232 OCR3CL=0x00;
	STS  130,R30
;     233 
;     234 // External Interrupt(s) initialization
;     235 // INT0: On
;     236 // INT0 Mode: Rising Edge
;     237 // INT1: Off
;     238 // INT2: Off
;     239 // INT3: Off
;     240 // INT4: Off
;     241 // INT5: Off
;     242 // INT6: Off
;     243 // INT7: Off
;     244 EICRA=0x03;
	LDI  R30,LOW(3)
	STS  106,R30
;     245 EICRB=0x00;
	LDI  R30,LOW(0)
	OUT  0x3A,R30
;     246 EIMSK=0x01;
	LDI  R30,LOW(1)
	OUT  0x39,R30
;     247 EIFR=0x01;
	OUT  0x38,R30
;     248 
;     249 // Timer(s)/Counter(s) Interrupt(s) initialization
;     250 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x37,R30
;     251 ETIMSK=0x04;
	LDI  R30,LOW(4)
	STS  125,R30
;     252 
;     253 // Analog Comparator initialization
;     254 // Analog Comparator: Off
;     255 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     256 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     257 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     258 
;     259 
;     260 // USART0 initialization
;     261 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     262 // USART0 Receiver: Off
;     263 // USART0 Transmitter: On
;     264 // USART0 Mode: Asynchronous
;     265 // USART0 Baud Rate: 57600
;     266 UCSR0A=0x00;
	OUT  0xB,R30
;     267 UCSR0B=0x08;
	LDI  R30,LOW(8)
	OUT  0xA,R30
;     268 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  149,R30
;     269 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  144,R30
;     270 UBRR0L=0x07;
	LDI  R30,LOW(7)
	OUT  0x9,R30
;     271 
;     272 
;     273 
;     274 //LCD initialization
;     275 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _lcd_init
;     276 
;     277 
;     278 // Global enable interrupts
;     279 #asm("sei")
	sei
;     280 
;     281 while (1)
_0x8:
;     282       {
;     283 
;     284 
;     285 
;     286       // Place your code here
;     287 
;     288       };
	RJMP _0x8
;     289 }
_0xB:
	RJMP _0xB

    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG
__base_y_G2:
	.BYTE 0x4

	.CSEG
__lcd_delay_G2:
    ldi   r31,15
__lcd_delay0:
    dec   r31
    brne  __lcd_delay0
	RET
__lcd_ready:
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
    cbi   __lcd_port,__lcd_rs     ;RS=0
__lcd_busy:
	CALL __lcd_delay_G2
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G2
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G2
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G2
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
__lcd_write_nibble_G2:
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G2
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G2
	RET
__lcd_write_data:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output    
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	CALL __lcd_write_nibble_G2
    ld    r26,y
    swap  r26
	CALL __lcd_write_nibble_G2
    sbi   __lcd_port,__lcd_rd     ;RD=1
	ADIW R28,1
	RET
__lcd_read_nibble_G2:
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G2
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G2
    andi  r30,0xf0
	RET
_lcd_read_byte0_G2:
	CALL __lcd_delay_G2
	CALL __lcd_read_nibble_G2
    mov   r26,r30
	CALL __lcd_read_nibble_G2
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
_lcd_clear:
	CALL __lcd_ready
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(12)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(0)
	MOV  R10,R30
	MOV  R11,R30
	RET
__long_delay_G2:
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
__lcd_init_write_G2:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	CALL __lcd_write_nibble_G2
    sbi   __lcd_port,__lcd_rd     ;RD=1
	ADIW R28,1
	RET
_lcd_init:
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R13,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G2,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G2,3
	CALL SUBOPT_0x0
	CALL SUBOPT_0x0
	CALL SUBOPT_0x0
	CALL __long_delay_G2
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL __lcd_init_write_G2
	CALL __long_delay_G2
	LDI  R30,LOW(40)
	CALL SUBOPT_0x1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x1
	LDI  R30,LOW(133)
	CALL SUBOPT_0x1
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	CALL _lcd_read_byte0_G2
	CPI  R30,LOW(0x5)
	BREQ _0x14
	LDI  R30,LOW(0)
	RJMP _0xD3
_0x14:
	CALL __lcd_ready
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL _lcd_clear
	LDI  R30,LOW(1)
_0xD3:
	ADIW R28,1
	RET
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
_getchar:
     sbis usr,rxc
     rjmp _getchar
     in   r30,udr
	RET
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET

	.DSEG
_p_S56:
	.BYTE 0x2

	.CSEG

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	CALL __long_delay_G2
	LDI  R30,LOW(48)
	ST   -Y,R30
	JMP  __lcd_init_write_G2

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	CALL __lcd_write_data
	JMP  __long_delay_G2

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
