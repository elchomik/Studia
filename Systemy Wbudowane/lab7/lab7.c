#include <targets/AT91SAM7.h>
#include <lcd.h>
#include <acd.h>
#include <bmp.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD
#define ENTER PIOB_SODR_P24 //definicja przycisku SW1
#define RESET PIOB_SODR_P25 //definicja przycisku SW2
#define UP PIOA_SODR_P7 // definicja joystick UP
#define DOWN PIOA_SODR_P15 //definicja joystick DOWN
#define LEFT PIOA_SODR_P9 //definicja joystick LEFT
#define RIGHT PIOA_SODR_P14 //definicja joystick RIGHT
#define BUZZER PIOB_SODR_P19 //definicja głośniczka w mikrokontrolerze

void showStartMenu();
void showMenuProgramy();
void showMenuZegar();
void showInfo();
void Backlight(unsigned char state); //nagłowek funkcji podświetlającej
void isJoystickDOWN(); //deklaracja funkcji pomocniczej sprawdzającej czy wcisnieto DOWN
void isJoystickUP(); //deklaracja funkcji pomocniczej sprawdzającej czy wciśnięto UP

int position=0; //zmienna pomocnicza dla głownego menu
int subposition=0; //zmienna pomocnicza dla menu pomocniczego

int main(){
       
    PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście

	
	int subposition=0; //zmienna pomocnicza dla menu mniejszego
	
      InitLCD(); //ustawienie wyświetlacza
	  initADC(); //inicjalizacja ADC
      LCDSettings();
      LCDClearScreen();
      
  while(1){
		
		showStartMenu(); //wywołanie funkcji pokazującej menu startowe
		isJoystickDOWN();// wywołanie funkcji sprawdzającej czy wciśnieto DOWN
		isJoystickUP(); //wywołanie funkcji sprawdzającej czy wciśnieto UP
		
		if(position==120 && ((PIOB_PDSR&ENTER)==0){ // sprawdzamy czy wybrano PROGRAMY
				Backlight(1); //podświetlenie
				showMenuProgramy(); //wyświetlenie pod Menu
				subposition=1;				
				isJoystickDOWN();
				isJoystickUP();
				Backlight(0); //wyłączenie podświetlenia
				
			if(position==110 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji obraz
			}
			
			if(position==100 && ((PIOB_PDSR&ENTER)==0) && subposition==1{
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji gra
			}
				
			if(position==90 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji Potencjometr
			}
			
			if(position==80 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji temperatura
			}
		
			}
			
			if(position==70 && ((PIOB_PDSR&ENTER)==0){
				Backlight(1);
				showMenuZegar();
				subposition=2;
				isJoystickDOWN();
				isJoystickUP();
				
			if(position==60 && ((PIOB_PDSR&ENTER)==0 && subposition==2){
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji AKTUALNY CZAS
			}
			
			if(position==50 && ((PIOB_PDSR&ENTER)==0) && subposition==2{
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji STOPER
			}
				
			if(position==40 && ((PIOB_PDSR&ENTER)==0 && subposition==2){
				Backlight(1); //włączenie podświetlenia
				//wywołanie funkcji Czasomierz
			}
				
			}
			
			if(position==30 & (PIOB_PDSR&ENTER)==0){
				Backlight(1); //włącz podświetlenie
				LCDClearScreen();
				showInfo();
			}
		
		
	
} 

}


void isJoystickDOWN(){
	if((PIOB_PDSR&DOWN)==0){ //sprawdzamy czy wciśnięto joystick DOWN
			if(position=>10) position=position-10; //zmniejszamy pozycje na której jest joystick
			else position=0;
		}
}

void isJoystickUP(){
if((PIOB_PDSR&UP)==0){ //sprawdzamy czy wciśnięto joystick DOWN
			if(position<=120) position=position+10; //zmniejszamy pozycje na której jest joystick
			else position=0;
		}	
}	
	
void showStartMenu(){
		LCDPutStr("1.PROGRAMY",120,40,MEDIUM,BLACK,WHITE);
		LCDPutStr("2.ZEGAR",70,40,MEDIUM,BLACK,WHITE);
		LCDPutStr("3.INFO O AUTORZE",30,40,MEDIUM,BLACK,WHITE);
}

void showMenuProgramy(){
	LCDPutStr("1.1.OBRAZ",110,40,MEDIUM,BLACK,WHITE);
	LCDPutStr("1.2 GRA",100,40,MEDIUM,BLACK,WHITE);
	LCDPutStr("1.3 POTENCJOMETR",90,40,MEDIUM,BLACK,WHITE);
	LCDPutStr("1.4 TEMPERATURA",80,40,MEDIUM,BLACK,WHITE);
}

void showMenuZegar(){
	LCDPutStr("2.1 AKTUALNY CZAS",60,40,MEDIUM,BLACK,WHITE);
	LCDPutStr("2.2 STOPER",50,40,MEDIUM,BLACK,WHITE);
	LCDPutStr("2.3 CZASOMIERZ",40,40,MEDIUM,BLACK,WHITE);
}

void showInfo(){
	LCDPutStr("Mateusz Markowski",15,10,MEDIUM,BLACK,WHITE);
	LCDPutStr("6.4.8", 8, 10, SMALL,BLACK,WHITE);
}

void Backlight(unsigned char state) {
if (state == 1)
pPIOB->PIO_SODR = BIT20; // Set PB20 to HIGH
 else
pPIOB->PIO_CODR = BIT20; // Set PB20 to LOW
}