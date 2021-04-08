#include <targets/AT91SAM7.h>
#include <LCD.h> //do��czenie biblioteki do obs�ugi wy�wietlacza LCD
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja pod�wietlania wy�wietlacza LCD


int main(){

		PMC_PCER=PMC_PCER_PIOB; //w�aczenie portu B
		PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyj�cia
		PIOB_PER=LCD_BACKLIGHT; //w��czenie pinu 20
		PIOB_PER|=LCD_BACKLIGHT; //ustawienie 1 na wyj�ciu
	
	initLCD(); //inicjalizacja LCD
	LCDSettings();
	LCDClearScreen();
	while(1){
		LCDPutStr("Mateusz",8,10,MEDIUM,WHITE,BLACK); //wy�wietlenie imienia
                LCDPutStr("Markowski",16,10,MEDIUM,WHITE,BLACK); //wy�wietlenie nazwiska
                LCDPutStr("GL07",24,10,MEDIUM,WHITE,BLACK); //wy�wietlenie grupy
		
	}
}