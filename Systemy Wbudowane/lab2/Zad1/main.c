#include <targets/AT91SAM7.h>
#include <LCD.h> //do³¹czenie biblioteki do obs³ugi wyœwietlacza LCD
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podœwietlania wyœwietlacza LCD


int main(){

		PMC_PCER=PMC_PCER_PIOB; //w³aczenie portu B
		PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjœcia
		PIOB_PER=LCD_BACKLIGHT; //w³¹czenie pinu 20
		PIOB_PER|=LCD_BACKLIGHT; //ustawienie 1 na wyjœciu
	
	initLCD(); //inicjalizacja LCD
	LCDSettings();
	LCDClearScreen();
	while(1){
		LCDPutStr("Mateusz",8,10,MEDIUM,WHITE,BLACK); //wyœwietlenie imienia
                LCDPutStr("Markowski",16,10,MEDIUM,WHITE,BLACK); //wyœwietlenie nazwiska
                LCDPutStr("GL07",24,10,MEDIUM,WHITE,BLACK); //wyœwietlenie grupy
		
	}
}