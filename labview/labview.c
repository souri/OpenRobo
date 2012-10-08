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



void main()
{
unsigned char output;
int result;
UART1_Init(2400);
//Lcd_Init();
TRISB=0;
TRISD=0;
PORTD=0;
//  Lcd_Out_Cp("output");
Delay_ms(100);
while(1)
{

Delay_ms(100);

   if (UART1_Data_Ready() == 1) {          // if data is received
     output=UART1_Read(); // reads text until 'OK' is found
     //result=(int)output - 1;
     PORTD=output;
     Delay_ms(100 );           // sends back text
     if(output==49)
     {
     RB7_bit=1;
     }
// Lcd_Out_Cp(output);
 Delay_ms(100);

 
 
 }
  }
  }
