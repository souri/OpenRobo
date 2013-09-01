
_isr:
;pwm_servo.c,3 :: 		void isr()
;pwm_servo.c,8 :: 		if(tmrcounter>=max_value )
	MOVF       _max_value+1, 0
	SUBWF      _tmrcounter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isr3
	MOVF       _max_value+0, 0
	SUBWF      _tmrcounter+0, 0
L__isr3:
	BTFSS      STATUS+0, 0
	GOTO       L_isr0
;pwm_servo.c,10 :: 		RB2_BIT=~RB2_BIT;
	MOVLW      4
	XORWF      RB2_bit+0, 1
;pwm_servo.c,11 :: 		RB1_BIT=0;
	BCF        RB1_bit+0, 1
;pwm_servo.c,12 :: 		tmrcounter=0;
	CLRF       _tmrcounter+0
	CLRF       _tmrcounter+1
;pwm_servo.c,13 :: 		tmrcmp=0;
	CLRF       _tmrcmp+0
	CLRF       _tmrcmp+1
;pwm_servo.c,14 :: 		}
L_isr0:
;pwm_servo.c,15 :: 		if (tmrcmp==cw)
	MOVF       _tmrcmp+1, 0
	XORWF      _cw+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isr4
	MOVF       _cw+0, 0
	XORWF      _tmrcmp+0, 0
L__isr4:
	BTFSS      STATUS+0, 2
	GOTO       L_isr1
;pwm_servo.c,18 :: 		RB1_BIT=1;
	BSF        RB1_bit+0, 1
;pwm_servo.c,21 :: 		}
L_isr1:
;pwm_servo.c,24 :: 		}
	RETURN
; end of _isr

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0
;pwm_servo.c,28 :: 		void interrupt() {
;pwm_servo.c,29 :: 		TMR0IE_BIT=0;
	BCF        TMR0IE_bit+0, 5
;pwm_servo.c,30 :: 		if (INTCON.TMR0IF) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt2
;pwm_servo.c,31 :: 		RB0_BIT=~RB0_BIT;
	MOVLW      1
	XORWF      RB0_bit+0, 1
;pwm_servo.c,32 :: 		tmrcounter+=1;
	INCF       _tmrcounter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmrcounter+1, 1
;pwm_servo.c,33 :: 		tmrcmp+=1;
	INCF       _tmrcmp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tmrcmp+1, 1
;pwm_servo.c,34 :: 		isr();
	CALL       _isr+0
;pwm_servo.c,36 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;pwm_servo.c,37 :: 		TMR0=156;
	MOVLW      156
	MOVWF      TMR0+0
;pwm_servo.c,38 :: 		TMR0IE_BIT=1;
	BSF        TMR0IE_bit+0, 5
;pwm_servo.c,39 :: 		}
L_interrupt2:
;pwm_servo.c,42 :: 		}
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:
;pwm_servo.c,45 :: 		void main() {
;pwm_servo.c,46 :: 		TRISB=0;
	CLRF       TRISB+0
;pwm_servo.c,47 :: 		PORTB=0;
	CLRF       PORTB+0
;pwm_servo.c,48 :: 		reset=0;
	CLRF       _reset+0
	CLRF       _reset+1
;pwm_servo.c,49 :: 		max_value=200;
	MOVLW      200
	MOVWF      _max_value+0
	CLRF       _max_value+1
;pwm_servo.c,50 :: 		cw=192;
	MOVLW      192
	MOVWF      _cw+0
	CLRF       _cw+1
;pwm_servo.c,51 :: 		tmrcounter=0;
	CLRF       _tmrcounter+0
	CLRF       _tmrcounter+1
;pwm_servo.c,52 :: 		tmrcmp=0;
	CLRF       _tmrcmp+0
	CLRF       _tmrcmp+1
;pwm_servo.c,55 :: 		OPTION_REG=0x00;
	CLRF       OPTION_REG+0
;pwm_servo.c,56 :: 		TMR0=156;
	MOVLW      156
	MOVWF      TMR0+0
;pwm_servo.c,57 :: 		GIE_BIT=1;
	BSF        GIE_bit+0, 7
;pwm_servo.c,58 :: 		TMR0IE_BIT=1;
	BSF        TMR0IE_bit+0, 5
;pwm_servo.c,59 :: 		PEIE_BIT=1;
	BSF        PEIE_bit+0, 6
;pwm_servo.c,62 :: 		}
	GOTO       $+0
; end of _main
