
#include "io430.h"

int main( void )
{
  // Stop watchdog timer to prevent time out reset
  WDTCTL = WDTPW + WDTHOLD;

  int harf_B[5]={0x7F,0x49,0x49,0x49,0x36};
  int harf_J[5]={0x02,0x01,0x41,0x7E,0x40};
  int harf_K[5]={0x7F,0x08,0x14,0x22,0x41};
  
  int harf_E[5]={0x7F,0x49,0x49,0x41,0x00};
  int harf_L[5]={0x7F,0x01,0x01,0x01,0x01};
  int harf_U[5]={0x7F,0x01,0x01,0x01,0X7F};

  
  int harf_1[5]={0x00,0x21,0x7F,0x01,0x00};
  int harf_9[5]={0x30,0x49,0x49,0x4A,0x3C};
  int harf_0[5]={0x3E,0x45,0x49,0x51,0x3e};
  int harf_3[5]={0x42,0x41,0x51,0x69,0x46};
  
 
  P2SEL = 0X00;
  P1DIR = 0XFF;
  P1OUT = 0XFF;
  P2DIR = 0XFF;
  
//  P2SEL = P2SEL & 0X3F;
//  P2SEL2 = P2SEL2 & 0X3F;

  while(1)
  {
      for(int i=0;i<5;i++)
     {
       for(int k=0;k<40;k++)
       {
          P1OUT = harf_B[i];
          P2OUT = harf_B[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
     
     for(int i=0;i<400;i++);
     for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
          P1OUT = harf_J[i];
          P2OUT = harf_J[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
     
     for(int i=0;i<400;i++);
  
          for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
          P1OUT = harf_K[i];
          P2OUT = harf_K[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
          for(int i=0;i<400;i++);
  
          for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
          P1OUT = harf_1[i];
          P2OUT = harf_1[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
     
     for(int i=0;i<400;i++);
     for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
          P1OUT = harf_9[i];
          P2OUT = harf_9[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
  
          for(int i=0;i<400;i++);
     for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
         P2OUT = harf_0[i]; 
         P1OUT = harf_0[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
     
     for(int i=0;i<800;i++);
     
     for(int i=0;i<5;i++)
     {
       for(int k=0;k<20;k++)
       {
         P2OUT = harf_3[i]; 
         P1OUT = harf_3[i];
       }
     
     }
     P1OUT = 0X00;
     P2OUT = 0X00;
     for(int i=0;i<14000;i++);
  
  }

}
