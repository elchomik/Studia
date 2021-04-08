#include <targets/AT91SAM7.h>
#include "lcd.h"
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD

void PIT_TIMER_interrupt();// zdefiniowanie prototypu funkcji obsługującej przerwanie
void enableInterrupt(); //zdefiniowanie prototypu funkcji obsługującej zezwolenie na przerwanie

int counter=0; //zmienna globalna odpowiadająca za zliczanie które mamy przerwanie

int main(){
	
	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B oraz zegara dla tego portu
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	

	initLCD(); //inicjalizacja wyświetlacza LCD
	LCDSettings();
	LCDClearScreen(); //wyczyść ekran
	
	int counter=0; //zmienna pomocnicza sprawdzająca czy wyświetlacz w danej chwili jest włączony czy wyłączony
	
	AIC_IDCR=AICR_IDCR_SYS; //wyłączenie przerwania od urządzeń peryferyjnych
	AIC_SVR1=(unsigned long)PIT_interrupt; //ustawienie wskaźnika do obsługi funkcji przerwania
	AIC_ICCR=AIC_ICCR_SYS; //wyczyszczenie flagi przerwania od urządzeń peryferyjych
	AIC_IECR=AIC_IECR_SYS; //włączenie przerwania od urządzeń peryferyjnych
	
	PIT_MR|=PIT_MR_PITIEN; //włączenie przerwania PIT Timera
	PIT_MR=(PIT_MR_PIV_MASK &0x1000); //ustawienie bitu PIV w rejestrze PIV_MR wartość po której następi przepełnienie licznika
	PIT_MR|=PIT_MR_PITEN; //aktywowanie Timera
	
	enableInterrupt(); //wywołanie funkcji pozwalającej na globalne zezwolenie ma przerwania
	
	while(1){
			
	}
	
}

//funkcja umożliwiająca występowanie globalnych przerwań
void interrupt_enable(){

__asm__("MRS r1,CPSR"); //Odczyt rejestru CPSR
__asm__("BIC r1,r1,#0x80"); //instrukcja czyszcząca bit przerwania
__asm__("MSR CPSR,r1"); //skopiowanie ustawienia do rejestru CPSR	

}


//funkcja obsługi przerwania od Timera PIT
void PIT_TIMER_interrupt(){

if(PIT_SR_PITS){

if(counter%2==0){ //jeśli globalna zmienna %2=0 to właczamy wyświetlacz
PIOB_SODR|=LCD_BACKLIGHT;
PIT_PIVR; //wyzerowanie licznika PIT razem z bitem PITS
counter++;
}

else{ // w przeciwnym razie wygaszamy wyświetlacz

PIOB_CODR|=LCD_BACKLIGHT; //wygaszenie wyświetlacza
PIT_PIVR; //wyzerowanie licznika PIT razem z bitem PITS
counter++;
}

AIC_EOICR; //przekazanie informacji o zakończeniu obsługi przerwania
	
}

	
}