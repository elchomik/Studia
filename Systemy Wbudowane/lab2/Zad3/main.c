#include <targets/AT91SAM7.h>
#include <lcd.h>
#include "lcd.c" //dołaczenie nagłówka zawierającego definicję funkcji Delay
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD


int main(){
       
        PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście

      InitLCD(); //ustawienie wyświetlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){
        LCDWrite130x130bmp(); //wywołanie funkcji odpowiedzialnej za wyświetlenie pliku bmp
		Delay(4000); //opóźnienie 4 sekundy
		LCDWrite130x130bmp2(); //wywołanie funkcji odpowiedzialnej za wyświetlenie pliku bmp2
		Delay(4000); //opóźnienie 4 sekundy
} 


}