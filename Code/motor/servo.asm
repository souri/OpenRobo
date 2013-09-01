
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0
;servo.c,2 :: 		void interrupt()
;servo.c,4 :: 		if(TMR0IF_BIT==1)
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;servo.c,6 :: 		count+=1;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;servo.c,7 :: 		TMR0IF_BIT=0;
	BCF        TMR0IF_bit+0, 2
;servo.c,8 :: 		}
L_interrupt0:
;servo.c,9 :: 		}
L__interrupt15:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:
;servo.c,11 :: 		void main()
;servo.c,13 :: 		TRISC=0; // PORTC IS OUTPUT
	CLRF       TRISC+0
;servo.c,14 :: 		PORTC=0;// PORTC INITIAL VALUE IS 0
	CLRF       PORTC+0
;servo.c,15 :: 		GIE_BIT=1;  // TURNING ON GLOBAL INTERRUPT
	BSF        GIE_bit+0, 7
;servo.c,16 :: 		PEIE_BIT=1;// TURNING ON PERIPHERL INTERRUPT BIT
	BSF        PEIE_bit+0, 6
;servo.c,17 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
;servo.c,18 :: 		OPTION_REG=0X84;
	MOVLW      132
	MOVWF      OPTION_REG+0
;servo.c,19 :: 		TMR0IE_BIT=1; // TURNING ON TIMER INTERRUPT
	BSF        TMR0IE_bit+0, 5
;servo.c,20 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,21 :: 		while(1)
L_main1:
;servo.c,23 :: 		switch(count )
	GOTO       L_main3
;servo.c,25 :: 		case 1:
L_main5:
;servo.c,27 :: 		RC1_BIT=1;
	BSF        RC1_bit+0, 1
;servo.c,29 :: 		delay_us(1500);
	MOVLW      10
	MOVWF      R12+0
	MOVLW      188
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
;servo.c,30 :: 		RC1_BIT=0;
	BCF        RC1_bit+0, 1
;servo.c,31 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,32 :: 		break;
	GOTO       L_main4
;servo.c,33 :: 		case 2:
L_main7:
;servo.c,35 :: 		RC2_BIT=1;
	BSF        RC2_bit+0, 2
;servo.c,37 :: 		delay_us(1324);
	MOVLW      9
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
	NOP
;servo.c,38 :: 		RC2_BIT=0;
	BCF        RC2_bit+0, 2
;servo.c,40 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,41 :: 		break;
	GOTO       L_main4
;servo.c,42 :: 		case 3:
L_main9:
;servo.c,43 :: 		RC3_BIT=1;
	BSF        RC3_bit+0, 3
;servo.c,44 :: 		delay_us(1233);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      0
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
	NOP
;servo.c,45 :: 		RC3_BIT=0;
	BCF        RC3_bit+0, 3
;servo.c,46 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,47 :: 		break;
	GOTO       L_main4
;servo.c,48 :: 		case 4:
L_main11:
;servo.c,49 :: 		RC4_BIT=1;
	BSF        RC4_bit+0, 4
;servo.c,50 :: 		delay_us(1432);
	MOVLW      10
	MOVWF      R12+0
	MOVLW      75
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
;servo.c,51 :: 		RC4_BIT=0;
	BCF        RC4_bit+0, 4
;servo.c,52 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,53 :: 		break;
	GOTO       L_main4
;servo.c,54 :: 		case 5:
L_main13:
;servo.c,55 :: 		RC5_BIT=1;
	BSF        RC5_bit+0, 5
;servo.c,56 :: 		delay_us(1222);
	MOVLW      8
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	NOP
;servo.c,57 :: 		RC5_BIT=0;
	BCF        RC5_bit+0, 5
;servo.c,58 :: 		count=0 ;
	CLRF       _count+0
	CLRF       _count+1
;servo.c,59 :: 		TMR0=100;
	MOVLW      100
	MOVWF      TMR0+0
;servo.c,60 :: 		break;
	GOTO       L_main4
;servo.c,61 :: 		}
L_main3:
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      1
	XORWF      _count+0, 0
L__main16:
	BTFSC      STATUS+0, 2
	GOTO       L_main5
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      2
	XORWF      _count+0, 0
L__main17:
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      3
	XORWF      _count+0, 0
L__main18:
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      4
	XORWF      _count+0, 0
L__main19:
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVLW      0
	XORWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVLW      5
	XORWF      _count+0, 0
L__main20:
	BTFSC      STATUS+0, 2
	GOTO       L_main13
L_main4:
;servo.c,62 :: 		}
	GOTO       L_main1
;servo.c,63 :: 		}
	GOTO       $+0
; end of _main
