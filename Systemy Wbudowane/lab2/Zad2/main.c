#include <targets/AT91SAM7.h>
#include <lcd.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podœwietlenia LCD


int main(){
       
        PMC_PCER=PMC_PCER_PIOB; //w³¹czenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjœcia
	PIOB_PER=LCD_BACKLIGHT ;//w³¹czenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjœcie

      InitLCD(); //ustawienie wyœwietlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){

        LCDWrite130x130bmp(); //wywo³anie funkcji odpowiedzialnej za wyœwietlenie pliku bmp

} 


}