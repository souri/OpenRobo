unsigned int count,countt[4],i,del,d1,d2,d3,d4,sdelay,j;
unsigned char output[6];
unsigned char delayus_variable;

void interrupt()          // Interrupt service routine
{
  if(TMR0IF_BIT==1)
  {
   count+=1;
   TMR0IF_BIT=0;
 }

}
void delayus(unsigned char  x)
{
  delayus_variable=(unsigned char)x;
  asm NOP
  asm NOP
  asm decfsz _delayus_variable,f
  asm goto $-3
}

void uart()
{
  if(UART1_Data_Ready()==1)
  {
   output[j]=UART1_Read();
   j+=1;
    // storing the three different character received in an array

   if (output[5]==43)
   {
     j=0;
     countt[0]=(unsigned int) output[1];
     countt[1]=(unsigned int) output[2];
     countt[2]=(unsigned int) output[3];
    countt[3]=(unsigned int) output[4];// typecasting the received string to int
    countt[0]=countt[0]-48;
    countt[1]=countt[1]-48;
    countt[2]=countt[2]-48;
    countt[3]=countt[3]-48;
    PORTD=countt[3];
    sdelay=(countt[0] * 1000)+(countt[1] * 100)+(countt[2] * 10)+(countt[3]);

    output[5]=49;
     switch(output[0])          // output[0] is motor no.
     {
     case 49:                   // case for motor 1,49 ascii for 1
     del=sdelay;
     break;
           case 50:              //motor2
           d1=sdelay;
           break;
           case 51:           //motor 3
           d2=sdelay;
           break;
           case 52:         //motor 4
           d3=sdelay;
           break;


         }

       }

     }
   }

   void Delay(unsigned int cnt)
   {
    unsigned char        i;

    i = (unsigned char)(cnt>>8);
    while(i>=1)
    {
      i--;
      delayus(253);
    }
    delayus((unsigned char)(cnt & 0xFF));
  }
  void main()
  {

   del=d1=d2=d3=d4=1481;       // initial delay value
   j=0;
   count=0;

  TRISC=0xC0;   //bits 7 and 6 have to be set to use the USART
  SPEN_BIT=1;   //SPEN has to be set (Serial Port ENable)
  CREN_BIT=1;   //set the Continuous Receive ENable bit
  PORTC=0;
  OPTION_REG=0x84;    //Used for prescaling
  GIE_BIT=1;          // turning on the global interrupt
  PEIE_BIT=1;         // turning on the peripheral interrupt
  UART1_Init(9600);   // initialising the UART
 TMR0IE_BIT=1;        // turning on timer interrupt
 TMR0=60;
 while(1)
 {
    switch(count )    //  PWM case for different motor
    {
    case 1:           // motor1
    RC1_BIT=1;
        uart();        // calling UART function
        Delay(del);
        RC1_BIT=0;

        TMR0=60;
        break;
    case 2:            //motor2
    RC2_BIT=1;
    uart();
    Delay(d1);
    RC2_BIT=0;
    TMR0=60;
    break;
    case 3:
             //motor3
    RC3_BIT=1;
    uart();
    Delay(d2);
    RC3_BIT=0;
    TMR0=60;
    break;
      case 4:        //motor4
      RC4_BIT=1;
      uart();
      Delay(d3);
      RC4_BIT=0;
      count=0;
      TMR0=60;
      break;
    }
  }
}
