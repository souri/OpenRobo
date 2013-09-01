#line 1 "C:/Users/ayush/Desktop/finalproject/New folder/motor/servo.c"
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
TRISC=0;
PORTC=0;
GIE_BIT=1;
PEIE_BIT=1;
count=0;
OPTION_REG=0X84;
 TMR0IE_BIT=1;
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
