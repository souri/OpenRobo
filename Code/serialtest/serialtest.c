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
 unsigned char output[6],send;
 unsigned int sdelay,i,j,countt[5];


  void uart()

  {
        if(UART1_Data_Ready()==1)
     {


       output[i]=UART1_Read();


        UART1_Write(output[i]);
            // storing the three different character received in an array


           

     if (output[5]==48)
      {
       i=0;
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
     send = (unsigned char) sdelay;
      output[5]=49;
      UART1_Write(output[5]);
      }
     i+=1;
       }}
       
 void main()
 {   i=0;
 TRISD=0;
 PORTD=0;
 TRISC=0xC0;
 GIE_BIT=1;          // turning on the global interrupt
  PEIE_BIT=1;
  //RCIE_BIT=1;       // turning on the peripheral interrupt
  UART1_Init(9600);
  Lcd_Init();
   SPEN_BIT=1;   //SPEN has to be set (Serial Port ENable)
  CREN_BIT=1;   //set the Continuous Receive ENable bit
while(1)
{
   uart();
   }
   }
