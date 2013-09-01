
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0
;robo.c,5 :: 		void interrupt()          // Interrupt service routine
;robo.c,7 :: 		if(TMR0IF_BIT==1)
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;robo.c,9 :: 		count+=1;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;robo.c,10 :: 		TMR0IF_BIT=0;
	BCF        TMR0IF_bit+0, 2
;robo.c,11 :: 		}
L_interrupt0:
;robo.c,13 :: 		}
L__interrupt19:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_delayus:
;robo.c,14 :: 		void delayus(unsigned char  x)
;robo.c,16 :: 		delayus_variable=(unsigned char)x;
	MOVF       FARG_delayus_x+0, 0
	MOVWF      _delayus_variable+0
;robo.c,18 :: 		asm  NOP
	NOP
;robo.c,19 :: 		asm NOP
	NOP
;robo.c,20 :: 		asm decfsz _delayus_variable,f
	DECFSZ     _delayus_variable+0, 1
;robo.c,21 :: 		asm goto $-3
	GOTO       $-3
;robo.c,22 :: 		}
	RETURN
; end of _delayus

_uart:
;robo.c,24 :: 		void uart()
;robo.c,27 :: 		if(UART1_Data_Ready()==1)
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_uart1
;robo.c,31 :: 		output[j]=UART1_Read();
	MOVF       _j+0, 0
	ADDLW      _output+0
	MOVWF      FLOC__uart+0
	CALL       _UART1_Read+0
	MOVF       FLOC__uart+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;robo.c,32 :: 		j+=1;
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;robo.c,41 :: 		if (output[5]==43)
	MOVF       _output+5, 0
	XORLW      43
	BTFSS      STATUS+0, 2
	GOTO       L_uart2
;robo.c,43 :: 		j=0;
	CLRF       _j+0
	CLRF       _j+1
;robo.c,44 :: 		countt[0]=(unsigned int) output[1];
	MOVF       _output+1, 0
	MOVWF      _countt+0
	CLRF       _countt+1
;robo.c,45 :: 		countt[1]=(unsigned int) output[2];
	MOVF       _output+2, 0
	MOVWF      _countt+2
	CLRF       _countt+3
;robo.c,46 :: 		countt[2]=(unsigned int) output[3];
	MOVF       _output+3, 0
	MOVWF      _countt+4
	CLRF       _countt+5
;robo.c,47 :: 		countt[3]=(unsigned int) output[4];// typecasting the received string to int
	MOVF       _output+4, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      _countt+6
	MOVF       R0+1, 0
	MOVWF      _countt+7
;robo.c,48 :: 		countt[0]=countt[0]-48;
	MOVLW      48
	SUBWF      _countt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+1, 1
;robo.c,49 :: 		countt[1]=countt[1]-48;
	MOVLW      48
	SUBWF      _countt+2, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+3, 1
;robo.c,50 :: 		countt[2]=countt[2]-48;
	MOVLW      48
	SUBWF      _countt+4, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+5, 1
;robo.c,51 :: 		countt[3]=countt[3]-48;
	MOVLW      48
	SUBWF      R0+0, 1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _countt+6
	MOVF       R0+1, 0
	MOVWF      _countt+7
;robo.c,52 :: 		PORTD=countt[3];
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;robo.c,53 :: 		sdelay=(countt[0] * 1000)+(countt[1] * 100)+(countt[2] * 10)+(countt[3]);
	MOVF       _countt+0, 0
	MOVWF      R0+0
	MOVF       _countt+1, 0
	MOVWF      R0+1
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__uart+0
	MOVF       R0+1, 0
	MOVWF      FLOC__uart+1
	MOVF       _countt+2, 0
	MOVWF      R0+0
	MOVF       _countt+3, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDWF      FLOC__uart+0, 0
	MOVWF      _sdelay+0
	MOVF       FLOC__uart+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      _sdelay+1
	MOVF       _countt+4, 0
	MOVWF      R0+0
	MOVF       _countt+5, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDWF      _sdelay+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _sdelay+1, 1
	MOVF       _countt+6, 0
	ADDWF      _sdelay+0, 1
	MOVF       _countt+7, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _sdelay+1, 1
;robo.c,55 :: 		output[5]=49;
	MOVLW      49
	MOVWF      _output+5
;robo.c,60 :: 		switch(output[0])          // output[0] is motor no.
	GOTO       L_uart3
;robo.c,62 :: 		case 49:                   // case for motor 1,49 ascii for 1
L_uart5:
;robo.c,63 :: 		del=sdelay;
	MOVF       _sdelay+0, 0
	MOVWF      _del+0
	MOVF       _sdelay+1, 0
	MOVWF      _del+1
;robo.c,64 :: 		break;
	GOTO       L_uart4
;robo.c,65 :: 		case 50:              //motor2
L_uart6:
;robo.c,66 :: 		d1=sdelay;
	MOVF       _sdelay+0, 0
	MOVWF      _d1+0
	MOVF       _sdelay+1, 0
	MOVWF      _d1+1
;robo.c,67 :: 		break;
	GOTO       L_uart4
;robo.c,68 :: 		case 51:           //motor 3
L_uart7:
;robo.c,69 :: 		d2=sdelay;
	MOVF       _sdelay+0, 0
	MOVWF      _d2+0
	MOVF       _sdelay+1, 0
	MOVWF      _d2+1
;robo.c,70 :: 		break;
	GOTO       L_uart4
;robo.c,71 :: 		case 52:         //motor 4
L_uart8:
;robo.c,72 :: 		d3=sdelay;
	MOVF       _sdelay+0, 0
	MOVWF      _d3+0
	MOVF       _sdelay+1, 0
	MOVWF      _d3+1
;robo.c,73 :: 		break;
	GOTO       L_uart4
;robo.c,76 :: 		}
L_uart3:
	MOVF       _output+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_uart5
	MOVF       _output+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_uart6
	MOVF       _output+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_uart7
	MOVF       _output+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_uart8
L_uart4:
;robo.c,78 :: 		}
L_uart2:
;robo.c,80 :: 		}
L_uart1:
;robo.c,81 :: 		}
	RETURN
; end of _uart

_Delay:
;robo.c,83 :: 		void Delay(unsigned int cnt)
;robo.c,87 :: 		i = (unsigned char)(cnt>>8);
	MOVF       FARG_Delay_cnt+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      Delay_i_L0+0
;robo.c,88 :: 		while(i>=1)
L_Delay9:
	MOVLW      1
	SUBWF      Delay_i_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Delay10
;robo.c,90 :: 		i--;
	DECF       Delay_i_L0+0, 1
;robo.c,91 :: 		delayus(253);
	MOVLW      253
	MOVWF      FARG_delayus_x+0
	CALL       _delayus+0
;robo.c,92 :: 		}
	GOTO       L_Delay9
L_Delay10:
;robo.c,93 :: 		delayus((unsigned char)(cnt & 0xFF));
	MOVLW      255
	ANDWF      FARG_Delay_cnt+0, 0
	MOVWF      FARG_delayus_x+0
	CALL       _delayus+0
;robo.c,94 :: 		}
	RETURN
; end of _Delay

_main:
;robo.c,95 :: 		void main()
;robo.c,98 :: 		del=d1=d2=d3=d4=1481;       // initial delay value
	MOVLW      201
	MOVWF      _d4+0
	MOVLW      5
	MOVWF      _d4+1
	MOVLW      201
	MOVWF      _d3+0
	MOVLW      5
	MOVWF      _d3+1
	MOVLW      201
	MOVWF      _d2+0
	MOVLW      5
	MOVWF      _d2+1
	MOVLW      201
	MOVWF      _d1+0
	MOVLW      5
	MOVWF      _d1+1
	MOVLW      201
	MOVWF      _del+0
	MOVLW      5
	MOVWF      _del+1
;robo.c,99 :: 		j=0;
	CLRF       _j+0
	CLRF       _j+1
;robo.c,100 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;robo.c,102 :: 		TRISC=0xC0;   //bits 7 and 6 have to be set to use the USART
	MOVLW      192
	MOVWF      TRISC+0
;robo.c,103 :: 		SPEN_BIT=1;   //SPEN has to be set (Serial Port ENable)
	BSF        SPEN_bit+0, 7
;robo.c,104 :: 		CREN_BIT=1;   //set the Continuous Receive ENable bit
	BSF        CREN_bit+0, 4
;robo.c,105 :: 		PORTC=0;
	CLRF       PORTC+0
;robo.c,106 :: 		OPTION_REG=0x84;    //Used for prescaling
	MOVLW      132
	MOVWF      OPTION_REG+0
;robo.c,107 :: 		GIE_BIT=1;          // turning on the global interrupt
	BSF        GIE_bit+0, 7
;robo.c,108 :: 		PEIE_BIT=1;         // turning on the peripheral interrupt
	BSF        PEIE_bit+0, 6
;robo.c,109 :: 		UART1_Init(9600);   // initialising the UART
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;robo.c,110 :: 		TMR0IE_BIT=1;        // turning on timer interrupt
	BSF        TMR0IE_bit+0, 5
;robo.c,111 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;robo.c,112 :: 		while(1)
L_main11:
;robo.c,114 :: 		switch(count )    //  PWM case for different motor
	GOTO       L_main13
;robo.c,116 :: 		case 1:           // motor1
L_main15:
;robo.c,117 :: 		RC1_BIT=1;
	BSF        RC1_bit+0, 1
;robo.c,118 :: 		uart();        // calling UART function
	CALL       _uart+0
;robo.c,119 :: 		Delay(del);
	MOVF       _del+0, 0
	MOVWF      FARG_Delay_cnt+0
	MOVF       _del+1, 0
	MOVWF      FARG_Delay_cnt+1
	CALL       _Delay+0
;robo.c,120 :: 		RC1_BIT=0;
	BCF        RC1_bit+0, 1
;robo.c,122 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;robo.c,123 :: 		break;
	GOTO       L_main14
;robo.c,124 :: 		case 2:            //motor2
L_main16:
;robo.c,125 :: 		RC2_BIT=1;
	BSF        RC2_bit+0, 2
;robo.c,126 :: 		uart();
	CALL       _uart+0
;robo.c,127 :: 		Delay(d1);
	MOVF       _d1+0, 0
	MOVWF      FARG_Delay_cnt+0
	MOVF       _d1+1, 0
	MOVWF      FARG_Delay_cnt+1
	CALL       _Delay+0
;robo.c,128 :: 		RC2_BIT=0;
	BCF        RC2_bit+0, 2
;robo.c,129 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;robo.c,130 :: 		break;
	GOTO       L_main14
;robo.c,131 :: 		case 3:
L_main17:
;robo.c,133 :: 		RC3_BIT=1;
	BSF        RC3_bit+0, 3
;robo.c,134 :: 		uart();
	CALL       _uart+0
;robo.c,135 :: 		Delay(d2);
	MOVF       _d2+0, 0
	MOVWF      FARG_Delay_cnt+0
	MOVF       _d2+1, 0
	MOVWF      FARG_Delay_cnt+1
	CALL       _Delay+0
;robo.c,136 :: 		RC3_BIT=0;
	BCF        RC3_bit+0, 3
;robo.c,137 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;robo.c,138 :: 		break;
	GOTO       L_main14
;robo.c,139 :: 		case 4:        //motor4
L_main18:
;robo.c,140 :: 		RC4_BIT=1;
	BSF        RC4_bit+0, 4
;robo.c,141 :: 		uart();
	CALL       _uart+0
;robo.c,142 :: 		Delay(d3);
	MOVF       _d3+0, 0
	MOVWF      FARG_Delay_cnt+0
	MOVF       _d3+1, 0
	MOVWF      FARG_Delay_cnt+1
	CALL       _Delay+0
;robo.c,144 :: 		RC4_BIT=0;
	BCF        RC4_bit+0, 4
;robo.c,148 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;robo.c,149 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;robo.c,150 :: 		break;
	GOTO       L_main14
;robo.c,151 :: 		}
L_main13:
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVLW      1
	XORWF      _count+0, 0
L__main20:
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVLW      2
	XORWF      _count+0, 0
L__main21:
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVLW      3
	XORWF      _count+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      4
	XORWF      _count+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L_main18
L_main14:
;robo.c,152 :: 		}
	GOTO       L_main11
;robo.c,153 :: 		}
	GOTO       $+0
; end of _main
