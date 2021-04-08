#include <targets/AT91SAM7.h> //dodanie biblioteki
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD

int main(){
	
	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście
}



