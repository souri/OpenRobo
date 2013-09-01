#line 1 "C:/Users/ayush/Desktop/New folder/pwm/pwm_servo.c"
unsigned int a[5],reset,set,max_value,cw,tmrcounter,tmrcmp;
 unsigned char output;




 void interrupt() {
 TMR0IE_BIT=0;

 if (INTCON.TMR0IF) {
 RB0_BIT=~RB0_BIT;
 tmrcounter+=1;

if(tmrcounter==39)
{
RB1_BIT=1;
}
if (tmrcounter==5)
{
RB1_BIT=0;
}

 INTCON.TMR0IF=0;
 TMR0=0;
 TMR0IE_BIT=1;
 }




void main() {
 TRISB=0;
 PORTB=0;
reset=0;
max_value=200;
cw=192;
tmrcounter=0;
tmrcmp=0;


OPTION_REG=0x00;
GIE_BIT=1
 PEIE_BIT=1;
TMR0=0;;

TMR0IE_BIT=1;
 while(1)
 {
 }


}
