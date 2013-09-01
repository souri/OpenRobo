
unsigned int a[5],reset,set,max_value,cw,tmrcounter,tmrcmp;
 unsigned char output;




 void interrupt() {
   TMR0IE_BIT=0;
    PIE1.RCIE=0;

  if (INTCON.TMR0IF) {
  RB0_BIT=~RB0_BIT;
  tmrcounter+=1;
  tmrcmp+=1;
if(tmrcounter==200)
{

RC1_BIT=1;
tmrcounter=0;

}
if (tmrcounter==15)
{
RC1_BIT=0;
}
if(tmrcmp==10000)
      {
       //PORTD=~PORTD;
      tmrcmp=0;
           // PIE1.RCIE=0;
            
            if(RCIF_BIT==1)
            {
      output=UART1_Read();

       // reads text until 'OK' is found
     //result=(int)output - 1;
     UART1_Write(output);
     PORTD=~PORTD;
           }
       // Lcd_Chr_Cp(output);

     }

   INTCON.TMR0IF=0;
   TMR0=156;

    }

     TMR0IE_BIT=1;
     PIE1.RCIE=1;
 }


void main()
{
  TRISB=0;
  PORTB=0;
    TRISC=0;
    PORTC=0;
    TRISD=0;
    PORTD=0;
reset=0;
max_value=200;
cw=192;
tmrcounter=0;
tmrcmp=0;
  UART1_Init(9600);

OPTION_REG=0x00;
GIE_BIT=1  ;
  PEIE_BIT=1;
TMR0=156;
 PIE1.RCIE=1;
TMR0IE_BIT=1;
  while(1)
  {
  }


}
