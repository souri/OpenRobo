
_main:
;servo.c,2 :: 		void main() {
;servo.c,4 :: 		TRISB =0x00;
	CLRF       TRISB+0
;servo.c,5 :: 		PORTB=0x00;
	CLRF       PORTB+0
;servo.c,6 :: 		OPTION_REG=0x00;
	CLRF       OPTION_REG+0
;servo.c,7 :: 		GIE_BIT=1;
	BSF        GIE_bit+0, 7
;servo.c,8 :: 		TMR0IE_BIT=0;
	BCF        TMR0IE_bit+0, 5
;servo.c,10 :: 		reset=0;
	CLRF       R1+0
	CLRF       R1+1
;servo.c,11 :: 		max_value=5000;
	MOVLW      136
	MOVWF      R5+0
	MOVLW      19
	MOVWF      R5+1
;servo.c,12 :: 		cw=4850;
	MOVLW      242
	MOVWF      R7+0
	MOVLW      18
	MOVWF      R7+1
;servo.c,13 :: 		set=0;
	CLRF       R3+0
	CLRF       R3+1
;servo.c,14 :: 		TMR0=246;
	MOVLW      246
	MOVWF      TMR0+0
;servo.c,15 :: 		while(1)
L_main0:
;servo.c,20 :: 		if (TMR0IF_BIT==1)
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_main2
;servo.c,22 :: 		reset+=1;
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;servo.c,23 :: 		set+=1;
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;servo.c,24 :: 		if(reset>=max_value )
	MOVF       R5+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main5
	MOVF       R5+0, 0
	SUBWF      R1+0, 0
L__main5:
	BTFSS      STATUS+0, 0
	GOTO       L_main3
;servo.c,26 :: 		RB0_BIT=~RB0_BIT;
	MOVLW      1
	XORWF      RB0_bit+0, 1
;servo.c,27 :: 		RB1_BIT=0;
	BCF        RB1_bit+0, 1
;servo.c,28 :: 		RESET=0;
	CLRF       R1+0
	CLRF       R1+1
;servo.c,29 :: 		SET=0;
	CLRF       R3+0
	CLRF       R3+1
;servo.c,30 :: 		}
L_main3:
;servo.c,31 :: 		if (set==cw)
	MOVF       R3+1, 0
	XORWF      R7+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main6
	MOVF       R7+0, 0
	XORWF      R3+0, 0
L__main6:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;servo.c,33 :: 		RB2_BIT=~RB2_BIT;
	MOVLW      4
	XORWF      RB2_bit+0, 1
;servo.c,34 :: 		RB1_BIT=1;
	BSF        RB1_bit+0, 1
;servo.c,37 :: 		}
L_main4:
;servo.c,38 :: 		TMR0IF_BIT=0;
	BCF        TMR0IF_bit+0, 2
;servo.c,39 :: 		TMR0=246;
	MOVLW      246
	MOVWF      TMR0+0
;servo.c,40 :: 		}
L_main2:
;servo.c,41 :: 		}
	GOTO       L_main0
;servo.c,42 :: 		}
	GOTO       $+0
; end of _main
