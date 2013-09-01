#line 1 "C:/Users/ayush/Desktop/finalproject/New folder/ENCODER/encoder.c"
void main() {
TRISB=0;
PORTB=0;
while(1)
{
RB1_BIT=1;
RB0_BIT=0;
delay_ms(1500);
RB1_BIT=0;
RB0_BIT=1;
}

}
