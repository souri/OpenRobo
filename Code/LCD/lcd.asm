
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0
;lcd.c,1 :: 		void interrupt()
;lcd.c,4 :: 		if (INTCON.TMR0IF) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;lcd.c,5 :: 		TMR0IE_BIT=0;
	BCF        TMR0IE_bit+0, 5
;lcd.c,6 :: 		PORTD=~PORTD;
	COMF       PORTD+0, 1
;lcd.c,7 :: 		TMR0IE_BIT=1;
	BSF        TMR0IE_bit+0, 5
;lcd.c,8 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;lcd.c,9 :: 		}
L_interrupt0:
;lcd.c,10 :: 		if(PIR1.RCIF)
	BTFSS      PIR1+0, 5
	GOTO       L_interrupt1
;lcd.c,12 :: 		PIE1.RCIE=0;
	BCF        PIE1+0, 5
;lcd.c,13 :: 		output=UART1_Read(); // reads text until 'OK' is found
	CALL       _UART1_Read+0
;lcd.c,16 :: 		PORTD=0XFF;
	MOVLW      255
	MOVWF      PORTD+0
;lcd.c,19 :: 		PIE1.RCIE=1;
	BSF        PIE1+0, 5
;lcd.c,20 :: 		}
L_interrupt1:
;lcd.c,21 :: 		}
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:
;lcd.c,24 :: 		void main() {
;lcd.c,26 :: 		TRISB =0x00;
	CLRF       TRISB+0
;lcd.c,27 :: 		PORTB=0x00;
	CLRF       PORTB+0
;lcd.c,28 :: 		TRISC=0;
	CLRF       TRISC+0
;lcd.c,29 :: 		PORTC=0;
	CLRF       PORTC+0
;lcd.c,30 :: 		OPTION_REG=0x00;
	CLRF       OPTION_REG+0
;lcd.c,31 :: 		INTCON=0;
	CLRF       INTCON+0
;lcd.c,32 :: 		GIE_BIT=1;
	BSF        GIE_bit+0, 7
;lcd.c,33 :: 		TMR0IE_BIT=1;
	BSF        TMR0IE_bit+0, 5
;lcd.c,34 :: 		PEIE_BIT=1;
	BSF        PEIE_bit+0, 6
;lcd.c,35 :: 		PIE1.RCIE=1;
	BSF        PIE1+0, 5
;lcd.c,36 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;lcd.c,37 :: 		TMR0=246;
	MOVLW      246
	MOVWF      TMR0+0
;lcd.c,38 :: 		reset=0;
	CLRF       main_reset_L0+0
	CLRF       main_reset_L0+1
;lcd.c,39 :: 		max_value=5000;
	MOVLW      136
	MOVWF      main_max_value_L0+0
	MOVLW      19
	MOVWF      main_max_value_L0+1
;lcd.c,40 :: 		cw=4888;
	MOVLW      24
	MOVWF      main_cw_L0+0
	MOVLW      19
	MOVWF      main_cw_L0+1
;lcd.c,41 :: 		set=0;
	CLRF       main_set_L0+0
	CLRF       main_set_L0+1
;lcd.c,43 :: 		while(1)
L_main2:
;lcd.c,48 :: 		if (TMR0IF_BIT==1)
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_main4
;lcd.c,50 :: 		reset+=1;
	INCF       main_reset_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_reset_L0+1, 1
;lcd.c,51 :: 		set+=1;
	INCF       main_set_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_set_L0+1, 1
;lcd.c,52 :: 		if(reset>=max_value )
	MOVF       main_max_value_L0+1, 0
	SUBWF      main_reset_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main8
	MOVF       main_max_value_L0+0, 0
	SUBWF      main_reset_L0+0, 0
L__main8:
	BTFSS      STATUS+0, 0
	GOTO       L_main5
;lcd.c,55 :: 		RC1_BIT=0;
	BCF        RC1_bit+0, 1
;lcd.c,56 :: 		RESET=0;
	CLRF       main_reset_L0+0
	CLRF       main_reset_L0+1
;lcd.c,57 :: 		SET=0;
	CLRF       main_set_L0+0
	CLRF       main_set_L0+1
;lcd.c,58 :: 		}
L_main5:
;lcd.c,59 :: 		if (set==cw)
	MOVF       main_set_L0+1, 0
	XORWF      main_cw_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       main_cw_L0+0, 0
	XORWF      main_set_L0+0, 0
L__main9:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;lcd.c,62 :: 		RC1_BIT=1;
	BSF        RC1_bit+0, 1
;lcd.c,65 :: 		}
L_main6:
;lcd.c,66 :: 		TMR0IF_BIT=0;
	BCF        TMR0IF_bit+0, 2
;lcd.c,67 :: 		TMR0=246;
	MOVLW      246
	MOVWF      TMR0+0
;lcd.c,68 :: 		}
L_main4:
;lcd.c,69 :: 		}
	GOTO       L_main2
;lcd.c,71 :: 		}
	GOTO       $+0
; end of _main
