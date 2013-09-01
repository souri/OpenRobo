
_main:
;labview.c,18 :: 		void main()
;labview.c,22 :: 		UART1_Init(2400);
	MOVLW      64
	MOVWF      SPBRG+0
	BCF        TXSTA+0, 2
	CALL       _UART1_Init+0
;labview.c,24 :: 		TRISB=0;
	CLRF       TRISB+0
;labview.c,25 :: 		TRISD=0;
	CLRF       TRISD+0
;labview.c,26 :: 		PORTD=0;
	CLRF       PORTD+0
;labview.c,28 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;labview.c,29 :: 		while(1)
L_main1:
;labview.c,32 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;labview.c,34 :: 		if (UART1_Data_Ready() == 1) {          // if data is received
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;labview.c,35 :: 		output=UART1_Read(); // reads text until 'OK' is found
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      main_output_L0+0
;labview.c,37 :: 		PORTD=output;
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;labview.c,38 :: 		Delay_ms(100 );           // sends back text
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;labview.c,39 :: 		if(output==49)
	MOVF       main_output_L0+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;labview.c,41 :: 		RB7_bit=1;
	BSF        RB7_bit+0, 7
;labview.c,42 :: 		}
L_main6:
;labview.c,44 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;labview.c,48 :: 		}
L_main4:
;labview.c,49 :: 		}
	GOTO       L_main1
;labview.c,50 :: 		}
	GOTO       $+0
; end of _main
