sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;

unsigned int a[5],reset,set,max_value,cw,tmrcounter,tmrcmp;
unsigned char output;
void isr()
{
  if(tmrcounter>=max_value )
  {
    RB2_BIT=~RB2_BIT;
    RB1_BIT=0;
    tmrcounter=0;
    tmrcmp=0;
  }
  if (tmrcmp==cw)
  {

    RB1_BIT=1;
  }
}

void interrupt()
{
  // INTCON.GIE=0;
  if (INTCON.TMR0IF) {
    RB0_BIT=~RB0_BIT;
    tmrcounter+=1;
    tmrcmp+=1;
    isr();

    INTCON.TMR0IF=0;
    TMR0=156;
    TMR0IE_BIT=1;
    }
    /*
      if(PIR1.RCIF)
      {
            PIE1.RCIE=0;
      output=UART1_Read(); // reads text until 'OK' is found
     //result=(int)output - 1;
     UART1_Write(output);
     PORTD=0XFF;

       // Lcd_Chr_Cp(output);
        PIE1.RCIE=1;
     }
     */
    // INTCON.GIE=1;
}

void main()
{
unsigned char output;
int result;
max_value=200;
cw=192;
tmrcounter=0;
tmrcmp=0;
//UART1_Init(9600);
//Lcd_Init();
TRISB=0;
TRISD=0;
PORTD=0;
TMR0=156;
INTCON.GIE=1;
INTCON.PEIE=1;
PIE1.RCIE=1;
TMR0IE_BIT=1;
}
