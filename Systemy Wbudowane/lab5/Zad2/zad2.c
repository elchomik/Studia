#include <targets/AT91SAM7.h>
#include "adc.h"
#include "lcd.h"
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD

void PIT_TIMER_interrupt();// zdefiniowanie prototypu funkcji obsługującej przerwanie
void enableInterrupt(); //zdefiniowanie prototypu funkcji obsługującej zezwolenie na przerwanie
int wyniki[10];
int licznik=0;
char tekst[25];
float stopnie=0;
float wartosc1=533,wartosc2=600;
float temperatura1=24,temperatura2=36.6;
float przelicznik=(wartosc2-wartosc1)/(temperatura2-temperatura1); //obliczenie przelicznika na podstawie temperatur ciała oraz przemieszczenia

int main(){

	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B oraz zegara dla tego portu
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20

	PMC_PCER|=PMC_PCER_ADC; //konfiguracja ADC
	ADC_CR=(1<<0); //reset przetwornika			
	ADC_CHER=(1<<5)|(1<<4); //wybór kanału do nasłuchiwania ADC Channel Enable Rejestr 5 i 4
	ADC_MR=(23<<ADC_MR_PRESCAL_BIT)|(2<<ADC_STARTUP_BIT)|(1<<ADC_MR_SHTIM_BIT); //konfiguracja rejestru ADC Mode Register
	
	initLCD(); //inicjalizacja wyświetlacza LCD
	initADC(); //inicjalizacja ADC
	LCDSettings();
	LCDClearScreen(); //wyczyść ekran
	
	
	AIC_IDCR=AICR_IDCR_SYS; //wyłączenie przerwania od urządzeń peryferyjnych
	AIC_SVR1=(unsigned long)PIT_TIMER_interrupt; //ustawienie wskaźnika do obsługi funkcji przerwania
	AIC_ICCR=AIC_ICCR_SYS; //wyczyszczenie flagi przerwania od urządzeń peryferyjych
	AIC_IECR=AIC_IECR_SYS; //włączenie przerwania od urządzeń peryferyjnych
	
	PIT_MR|=PIT_MR_PITIEN; //włączenie przerwania PIT Timera
	PIT_MR=(PIT_MR_PIV_MASK &0xFFFFF); //ustawienie bitu PIV w rejestrze PIV_MR wartość po której następi przepełnienie licznika
	PIT_MR|=PIT_MR_PITEN; //aktywowanie Timera
	
	enableInterrupt(); //wywołanie funkcji pozwalającej na globalne zezwolenie ma przerwania
	int srednia;
	
while(1){

	if(licznik==10){
		srednia=0;
	for(int j=0;j<licznik;j++){
		srednia+=wyniki[j]; //obliczanie średniej
	
	}
	float stopnieSrednie=srednia*100;
	int stopnieCalkowite=(int)stopnieSrednie;
	int stopnieCzescCalkowita=(int)stopnieCalkowite/100;
	int stopnieDziesietne=(int)stopnieCalkowite%100;
	sprintf(tekst,"%d.%dCV",stopnieCzescCalkowita,stopnieDziesietne);
	LCDPutStr(tekst,65,65,SMALL,BLACK,WHITE);
	
	}

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

ADC_CR=ADC_CR_START; //rozpoczęcie konwersji
while(ADC_SR&ADC_SR_EOC5)==0){}

for(int i=0;i<10;i++){
	
stopnie=((ADC_CDR5-wartosc1)/przelicznik)+temperatura1; //obliczenie wyniku w stopniach Celsjusz
wyniki[licznik]+=stopnie;	
}
licznik++;
PIT_PIVR; //zresetowanie licznika
	
}
AIC_EOICR; //przekazanie informacji o zakończeniu obsługi przerwania
	
}


