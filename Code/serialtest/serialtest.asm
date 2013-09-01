
_uart:
;serialtest.c,19 :: 		void uart()
;serialtest.c,22 :: 		if(UART1_Data_Ready()==1)
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_uart0
;serialtest.c,26 :: 		output[i]=UART1_Read();
	MOVF       _i+0, 0
	ADDLW      _output+0
	MOVWF      FLOC__uart+0
	CALL       _UART1_Read+0
	MOVF       FLOC__uart+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;serialtest.c,29 :: 		UART1_Write(output[i]);
	MOVF       _i+0, 0
	ADDLW      _output+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;serialtest.c,35 :: 		if (output[5]==48)
	MOVF       _output+5, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_uart1
;serialtest.c,37 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;serialtest.c,38 :: 		countt[0]=(unsigned int) output[1];
	MOVF       _output+1, 0
	MOVWF      _countt+0
	CLRF       _countt+1
;serialtest.c,39 :: 		countt[1]=(unsigned int) output[2];
	MOVF       _output+2, 0
	MOVWF      _countt+2
	CLRF       _countt+3
;serialtest.c,40 :: 		countt[2]=(unsigned int) output[3];
	MOVF       _output+3, 0
	MOVWF      _countt+4
	CLRF       _countt+5
;serialtest.c,41 :: 		countt[3]=(unsigned int) output[4];// typecasting the received string to int
	MOVF       _output+4, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      _countt+6
	MOVF       R0+1, 0
	MOVWF      _countt+7
;serialtest.c,42 :: 		countt[0]=countt[0]-48;
	MOVLW      48
	SUBWF      _countt+0, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+1, 1
;serialtest.c,43 :: 		countt[1]=countt[1]-48;
	MOVLW      48
	SUBWF      _countt+2, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+3, 1
;serialtest.c,44 :: 		countt[2]=countt[2]-48;
	MOVLW      48
	SUBWF      _countt+4, 1
	BTFSS      STATUS+0, 0
	DECF       _countt+5, 1
;serialtest.c,45 :: 		countt[3]=countt[3]-48;
	MOVLW      48
	SUBWF      R0+0, 1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _countt+6
	MOVF       R0+1, 0
	MOVWF      _countt+7
;serialtest.c,46 :: 		PORTD=countt[3];
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;serialtest.c,47 :: 		sdelay=(countt[0] * 1000)+(countt[1] * 100)+(countt[2] * 10)+(countt[3]);
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
	ADDWF      FLOC__uart+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FLOC__uart+1, 1
	MOVF       _countt+4, 0
	MOVWF      R0+0
	MOVF       _countt+5, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       FLOC__uart+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__uart+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       _countt+6, 0
	ADDWF      R0+0, 1
	MOVF       _countt+7, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _sdelay+0
	MOVF       R0+1, 0
	MOVWF      _sdelay+1
;serialtest.c,48 :: 		send = (unsigned char) sdelay;
	MOVF       R0+0, 0
	MOVWF      _send+0
;serialtest.c,49 :: 		output[5]=49;
	MOVLW      49
	MOVWF      _output+5
;serialtest.c,50 :: 		UART1_Write(output[5]);
	MOVLW      49
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;serialtest.c,51 :: 		}
L_uart1:
;serialtest.c,52 :: 		i+=1;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;serialtest.c,53 :: 		}}
L_uart0:
	RETURN
; end of _uart

_main:
;serialtest.c,55 :: 		void main()
;serialtest.c,56 :: 		{   i=0;
	CLRF       _i+0
	CLRF       _i+1
;serialtest.c,57 :: 		TRISD=0;
	CLRF       TRISD+0
;serialtest.c,58 :: 		PORTD=0;
	CLRF       PORTD+0
;serialtest.c,59 :: 		TRISC=0xC0;
	MOVLW      192
	MOVWF      TRISC+0
;serialtest.c,60 :: 		GIE_BIT=1;          // turning on the global interrupt
	BSF        GIE_bit+0, 7
;serialtest.c,61 :: 		PEIE_BIT=1;
	BSF        PEIE_bit+0, 6
;serialtest.c,63 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;serialtest.c,64 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;serialtest.c,65 :: 		SPEN_BIT=1;   //SPEN has to be set (Serial Port ENable)
	BSF        SPEN_bit+0, 7
;serialtest.c,66 :: 		CREN_BIT=1;   //set the Continuous Receive ENable bit
	BSF        CREN_bit+0, 4
;serialtest.c,67 :: 		while(1)
L_main2:
;serialtest.c,69 :: 		uart();
	CALL       _uart+0
;serialtest.c,70 :: 		}
	GOTO       L_main2
;serialtest.c,71 :: 		}
	GOTO       $+0
; end of _main
