 unsigned int count;
 void interrupt()
 {
  if(TMR0IF_BIT==1)
  {
    count+=1;
    TMR0IF_BIT=0;
}
}

void main()
{
TRISC=0;    // PORTC IS OUTPUT
PORTC=0;    // PORTC INITIAL VALUE IS 0
GIE_BIT=1;  // TURNING ON GLOBAL INTERRUPT
PEIE_BIT=1; // TURNING ON PERIPHERL INTERRUPT BIT
count=0;
OPTION_REG=0X84;
 TMR0IE_BIT=1; // TURNING ON TIMER INTERRUPT
 TMR0=100;
 while(1)
 {
    switch(count )
    {
        case 1:

        RC1_BIT=1;

        delay_us(1500);
        RC1_BIT=0;
        TMR0=100;
        break;
        case 2:

        RC2_BIT=1;

        delay_us(1324);
        RC2_BIT=0;

        TMR0=100;
        break;
        case 3:
        RC3_BIT=1;
        delay_us(1233);
        RC3_BIT=0;
        TMR0=100;
        break;
        case 4:
        RC4_BIT=1;
        delay_us(1432);
        RC4_BIT=0;
        TMR0=100;
        break;
        case 5:
        RC5_BIT=1;
        delay_us(1222);
        RC5_BIT=0;
        count=0 ;
        TMR0=100;
        break;
    }
}
}
