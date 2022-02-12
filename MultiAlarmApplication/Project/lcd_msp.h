#define delay_us(x)     __delay_cycles(x)
#define delay_ms(x)     __delay_cycles((x * 1000L))

#define LCD_DATA        P1OUT
#define LCD_CONTROL     P2OUT
#define	EN_ACKAPA()     LCD_EN(1),LCD_EN(0)

#define	LCD_RS(x)       ( (x) ? (LCD_CONTROL |= BIT7) : (LCD_CONTROL &= ~BIT7) )
#define LCD_EN(x)       ( (x) ? (LCD_CONTROL |= BIT6) : (LCD_CONTROL &= ~BIT6) )


void lcd_komut(unsigned char); // LCD ye komut göndermeye yarar
void lcd_temizle(void);        // LCD ekrany temizler
void lcd_puts(const char*);    // LCD ye string ifade yazar
void lcd_goto(char,char);      // LCD de satyr ve stün olarak istenilen yere gider
void lcd_init(void);           // LCD ba?langyç ayarlary yapylyr
void lcd_putch(char);          // LCD ye tek karakter yazmak için kullanylyr.