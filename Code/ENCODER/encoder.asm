
_main:
;encoder.c,1 :: 		void main() {
;encoder.c,2 :: 		TRISB=0;
	CLRF       TRISB+0
;encoder.c,3 :: 		PORTB=0;
	CLRF       PORTB+0
;encoder.c,4 :: 		while(1)
L_main0:
;encoder.c,6 :: 		RB1_BIT=1;
	BSF        RB1_bit+0, 1
;encoder.c,7 :: 		RB0_BIT=0;
	BCF        RB0_bit+0, 0
;encoder.c,8 :: 		delay_ms(1500);
	MOVLW      39
	MOVWF      R11+0
	MOVLW      13
	MOVWF      R12+0
	MOVLW      38
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;encoder.c,9 :: 		RB1_BIT=0;
	BCF        RB1_bit+0, 1
;encoder.c,10 :: 		RB0_BIT=1;
	BSF        RB0_bit+0, 0
;encoder.c,11 :: 		}
	GOTO       L_main0
;encoder.c,13 :: 		}
	GOTO       $+0
; end of _main
