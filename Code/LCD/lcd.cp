#line 1 "C:/Users/ayush/Desktop/New folder/New folder/lcd.c"
void interrupt()
 {
 unsigned char output;
 if (INTCON.TMR0IF) {
 TMR0IE_BIT=0;
 PORTD=~PORTD;
 TMR0IE_BIT=1;
 INTCON.TMR0IF = 0;
 }
 if(PIR1.RCIF)
 {
 PIE1.RCIE=0;
 output=UART1_Read();


 PORTD=0XFF;


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
PEIE_BIT=1;
PIE1.RCIE=1;
UART1_Init(9600);
TMR0=246;
reset=0;
max_value=5000;
cw=4888;
set=0;

while(1)


 {

if (TMR0IF_BIT==1)
{
reset+=1;
set+=1;
if(reset>=max_value )
{

RC1_BIT=0;
RESET=0;
SET=0;
}
if (set==cw)
{

RC1_BIT=1;


 }
TMR0IF_BIT=0;
TMR0=246;
}
 }

 }
