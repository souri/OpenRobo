
_main:
;lcd.c,18 :: 		void main()
;lcd.c,22 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;lcd.c,23 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;lcd.c,24 :: 		TRISB=0;
	CLRF       TRISB+0
;lcd.c,25 :: 		TRISD=0;
	CLRF       TRISD+0
;lcd.c,26 :: 		PORTD=0;
	CLRF       PORTD+0
;lcd.c,27 :: 		PORTB=0;
	CLRF       PORTB+0
;lcd.c,38 :: 		Lcd_Out_Cp("Fuck Dit");
	MOVLW      ?lstr1_lcd+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;lcd.c,39 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;lcd.c,43 :: 		}
	GOTO       $+0
; end of _main
