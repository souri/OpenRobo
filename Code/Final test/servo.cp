#line 1 "C:/Users/ayush/Desktop/New folder/servo.c"

void main() {
unsigned int a[5],reset,set,max_value,cw;
TRISB =0x00;
PORTB=0x00;
OPTION_REG=0x00;
GIE_BIT=1;
TMR0IE_BIT=0;

reset=0;
max_value=5000;
cw=4850;
set=0;
TMR0=246;
while(1)


 {

if (TMR0IF_BIT==1)
{
reset+=1;
set+=1;
if(reset>=max_value )
{
RB0_BIT=~RB0_BIT;
RB1_BIT=0;
RESET=0;
SET=0;
}
if (set==cw)
{
RB2_BIT=~RB2_BIT;
RB1_BIT=1;


 }
TMR0IF_BIT=0;
TMR0=246;
}
 }
 }
