#include <targets/AT91SAM7.h>
#include <lcd.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja pod�wietlenia LCD


int main(){
       
        PMC_PCER=PMC_PCER_PIOB; //w��czenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyj�cia
	PIOB_PER=LCD_BACKLIGHT ;//w��czenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyj�cie

      InitLCD(); //ustawienie wy�wietlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){

        LCDWrite130x130bmp(); //wywo�anie funkcji odpowiedzialnej za wy�wietlenie pliku bmp

} 


}