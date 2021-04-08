#include <targets/AT91SAM7.h>
#include "lcd.h"
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD


int main(){
	
	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B oraz zegara dla tego portu
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20

	initLCD(); //inicjalizacja wyświetlacza LCD
	LCDSettings();
	LCDClearScreen(); //wyczyść ekran
	
	int counter=0; //zmienna pomocnicza sprawdzająca czy wyświetlacz w danej chwili jest włączony czy wyłączony
	
	PIT_MR|=PIT_MR_PITEN; //aktywowanie Timera
	PIT_MR=(PIT_MR_PIV_MASK & 0x1000); //ustawienie bitu PIV w rejestrze PIV_MR wartość po której następi przepełnienie licznika
	
	while(1){
	
		if((PIT_SR&0x00000001) &(counter%2==0) ){		//jeśli counter parzysty włącz wyświetlacz	
			PIT_PIVR; //odczytanie PIVR powoduje wyzerowania licznika
			PIOB_SODR|=LCD_BACKLIGHT; //zmiana stanu na wyświetlaczu LCD		
			PIT_MR=(PIT_MR_PITEN)|(PIT_MR_PIV_MASK & 0x1000); //ponowne ustawienie zliczania w Timerze
			counter++; //zwiększenie licznika
		}
		else if((PIT_SR&0x00000001) &(counter%2!=0)){ //jeśli counter nieparzysty wyłącz wyświetlacz
			PIT_PIVR; //odczytanie PIVR powoduje wyzerowania licznika
			PIOB_CODR|=LCD_BACKLIGHT; //zmiana stanu na wyświetlaczu LCD		
			PIT_MR=(PIT_MR_PITEN)|(PIT_MR_PIV_MASK & 0x1000); //ponowne ustawienie zliczania w Timerze
			counter++; //zwiększenie licznika
		}
		
		
	}
}