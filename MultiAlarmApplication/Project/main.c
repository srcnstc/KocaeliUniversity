/*SERCAN SATICI*/
/*110207011*/


#include "msp430.h"
#include "ds1302.h"
#include "lcd_msp.h"
#include "degisken.h"

#define   SEGMENT0   BIT0       // P2.0
#define   SEGMENT1   BIT1       // P2.1
#define   SEGMENT2   BIT2       // P2.2
#define   SEGMENT3   BIT3       // P2.3

const unsigned char segment[]={0x77,0x38,0xD0,0x06,0x5B,0x4F};  //A,L,r,1,2,3
unsigned int x=0;

void segment_yaz(unsigned char, char);


void lcd_saat_goster(void);
void lcd_tarih_goster(void);


unsigned char saat[8]; 
unsigned char tarih[10]; 



void main(void)
{  
  
  WDTCTL = WDTPW + WDTHOLD;  
  BCSCTL1= CALBC1_1MHZ;
  DCOCTL = CALDCO_1MHZ;
  __delay_cycles(100000);               //DCO 1MHZ


  P1DIR = 0xFF;                      // P1 Tum Pinler Çikis
  P2DIR = BIT0 + BIT1 + BIT2 + BIT3; // Segment Seçme Pinleri
  
  P1OUT = 0x00;
  P2OUT = 0x00;
  
  Reset_DS1302();
  init_DS1302();
  lcd_init();
  
  TA0CCR0  = 65535-1;                   
  TA0CCTL0 = CCIE;                      //Timer üzerinden kesme üret
  TA0CTL   = MC_2 + TASSEL_2 + TACLR;   //Continuos mode+SMCLK+Timer ilk deger 0

  TA1CTL   = MC_1 + TASSEL_2;
  TA1CCR0  = 5000 - 1;
  TA1CCTL0 = CCIE;

  
  __bis_SR_register(LPM0_bits + GIE);   //CPU and MCLK are disabled, SMCLK and ACLK remain active
}

void segment_yaz(unsigned char sayi_f,char seg)
{
  P2OUT = 0;
  P1OUT = sayi_f;
  P2OUT = seg;  
}


#pragma vector=TIMER0_A0_VECTOR
__interrupt void ta0_isr(void)
{
  BurstRead1302(rdata);                 //veri okudugu yer
  
  lcd_saat_goster();
  lcd_tarih_goster();
  
} 

void lcd_saat_goster(void)
{  
  char i;
  
  saat[6] = rakam[(rdata[0]&0xF0) >> 4];                //saniye
  saat[7] = rakam[ rdata[0]&0x0F];
  saat[3] = rakam[(rdata[1]&0xF0) >> 4];                //dakika
  saat[4] = rakam[ rdata[1]&0x0F];                      
  saat[0] = rakam[(rdata[2]&0xF0) >> 4];                //saat
  saat[1] = rakam[ rdata[2]&0x0F];                      
  
  saat[2]=':'; 
  saat[5]=':'; 
  
  lcd_goto(1,1);
  
  for(i=0;i<8;i++)
    lcd_putch(saat[i]);
}

void lcd_tarih_goster(void)
{
  char i;
  
  tarih[0] = rakam[(rdata[3]&0xF0) >> 4];
  tarih[1] = rakam[ rdata[3]&0x0F];
  tarih[3] = rakam[(rdata[4]&0xF0) >> 4];
  tarih[4] = rakam[ rdata[4]&0x0F];
  tarih[6] = rakam[(rdata[6]&0xF0) >> 4];
  tarih[7] = rakam[ rdata[6]&0x0F];
  tarih[8] = rakam[(rdata[5]&0xF0) >> 4];
  tarih[9] = rakam[ rdata[5]&0x0F];  
  
  tarih[2]='/'; 
  tarih[5]='/';
  
  lcd_goto(1,12);
  for(i=0;i<5;i++)
    lcd_putch(tarih[i]);
  
  lcd_goto(2,13);
  lcd_puts("20");
  for(i=6;i<8;i++)
    lcd_putch(tarih[i]);
  
  lcd_goto(2,1);
  switch(rdata[5])
  {
  case 1 :lcd_puts("Pazartesi"); break;
  case 2 :lcd_puts("Sali     "); break;
  case 3 :lcd_puts("Carsamba "); break;
  case 4 :lcd_puts("Persembe "); break;
  case 5 :lcd_puts("Cuma     "); break;
  case 6 :lcd_puts("Cumartesi"); break;
  case 7 :lcd_puts("Pazar    "); break;
  }
}  

#pragma vector=TIMER1_A0_VECTOR
__interrupt void TA1_A0_ISR(void)
{

  if(saat[0]==rakam[1] & saat[1]==rakam[1] & saat[3]==rakam[2] & saat[4]==rakam[0])//Alarm1=11:20
 {
   
  x++;
  
  switch(x)
  {
  case 1 : segment_yaz( segment[0],               SEGMENT0);      break;
  case 2 : segment_yaz( segment[1],               SEGMENT1);      break;
  case 3 : segment_yaz( segment[2],               SEGMENT2);      break;
  case 4 : segment_yaz( segment[3],               SEGMENT3); x=0; break;
  }
 }
 
 if(saat[0]==rakam[1] & saat[1]==rakam[1] & saat[3]==rakam[2] & saat[4]==rakam[2])//Alarm2=11:22
 {	
  x++;
  
  switch(x)
  {
  case 1 : segment_yaz( segment[0],               SEGMENT0);      break;
  case 2 : segment_yaz( segment[1],               SEGMENT1);      break;
  case 3 : segment_yaz( segment[2],               SEGMENT2);      break;
  case 4 : segment_yaz( segment[4],               SEGMENT3); x=0; break;
  }
 }
 
 if(saat[0]==rakam[1] & saat[1]==rakam[1] & saat[3]==rakam[2] & saat[4]==rakam[4])//Alarm3=11:24
 {	
  x++;
  
  switch(x)
  {
  case 1 : segment_yaz( segment[0],               SEGMENT0);      break;
  case 2 : segment_yaz( segment[1],               SEGMENT1);      break;
  case 3 : segment_yaz( segment[2],               SEGMENT2);      break;
  case 4 : segment_yaz( segment[5],               SEGMENT3); x=0; break;
  }
 }
 
}