#line 1 "C:/Users/ayush/Desktop/finalproject/New folder/ENCODER/robo.c"
 unsigned int count,countt[4],i,del,d1,d2,d3,d4,sdelay,j;

unsigned char output[6];
 unsigned char delayus_variable;
void interrupt()
{
 if(TMR0IF_BIT==1)
 {
 count+=1;
 TMR0IF_BIT=0;
 }

 }
 void delayus(unsigned char x)
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








 if (output[5]==43)
 {
 j=0;
 countt[0]=(unsigned int) output[1];
 countt[1]=(unsigned int) output[2];
 countt[2]=(unsigned int) output[3];
 countt[3]=(unsigned int) output[4];
 countt[0]=countt[0]-48;
 countt[1]=countt[1]-48;
 countt[2]=countt[2]-48;
 countt[3]=countt[3]-48;
 PORTD=countt[3];
 sdelay=(countt[0] * 1000)+(countt[1] * 100)+(countt[2] * 10)+(countt[3]);

 output[5]=49;




 switch(output[0])
 {
 case 49:
 del=sdelay;
 break;
 case 50:
 d1=sdelay;
 break;
 case 51:
 d2=sdelay;
 break;
 case 52:
 d3=sdelay;
 break;


 }

 }

 }
 }

 void Delay(unsigned int cnt)
{
 unsigned char i;

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

 del=d1=d2=d3=d4=1481;
 j=0;
 count=0;

 TRISC=0xC0;
 SPEN_BIT=1;
 CREN_BIT=1;
 PORTC=0;
 OPTION_REG=0x84;
 GIE_BIT=1;
 PEIE_BIT=1;
 UART1_Init(9600);
 TMR0IE_BIT=1;
 TMR0=60;
 while(1)
 {
 switch(count )
 {
 case 1:
 RC1_BIT=1;
 uart();
 Delay(del);
 RC1_BIT=0;

 TMR0=60;
 break;
 case 2:
 RC2_BIT=1;
 uart();
 Delay(d1);
RC2_BIT=0;
 TMR0=60;
 break;
 case 3:

 RC3_BIT=1;
 uart();
 Delay(d2);
 RC3_BIT=0;
 TMR0=60;
 break;
 case 4:
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
