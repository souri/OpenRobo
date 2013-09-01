void interrupt()
{
  unsigned char output;
  if(PIR1.RCIF)
  {
    PIE1.RCIE=0;
      output=UART1_Read(); // reads text until 'OK' is found
     //result=(int)output - 1;
      UART1_Write(output);
      PORTD=0XFF;

      //Lcd_Chr_Cp(output);
      PIE1.RCIE=1;
  }
}


void main() {
  unsigned int a[5],reset,set,max_value,cw;
  TRISB =0x00;
  PORTB=0x00;
  TRISC=0;
  PORTC=0;
  OPTION_REG=0x00;
  INTCON=0;
  GIE_BIT=1;
  TMR0IE_BIT=1;
  INTCON.PEIE=1;
  PIE1.RCIE=1;
  UART1_Init(9600);
  TMR0=246;
  reset=0;
  max_value=5000;
  cw=4888;
  set=0;

  if (TMR0IF_BIT==1)
  {
    reset+=1;
    set+=1;
    if(reset>=max_value )
    {
    //RC0_BIT=~RB0_BIT;
      RC1_BIT=0;
      RESET=0;
      SET=0;
    }
    if (set==cw)
    {
      //RB2_BIT=~RB2_BIT;
      RC1_BIT=1;
    }
    TMR0IF_BIT=0;
    TMR0=246;
  }
}
