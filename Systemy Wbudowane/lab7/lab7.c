#include <targets/AT91SAM7.h>
#include <lcd.h>
#include <acd.h>
#include <bmp.h>
#include <bits.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD
#define ENTER PIOB_SODR_P24 //definicja przycisku SW1
#define RESET PIOB_SODR_P25 //definicja przycisku SW2
#define UP PIOA_SODR_P7 // definicja joystick UP
#define DOWN PIOA_SODR_P15 //definicja joystick DOWN
#define LEFT PIOA_SODR_P9 //definicja joystick LEFT
#define RIGHT PIOA_SODR_P14 //definicja joystick RIGHT
#define BUZZER PIOB_SODR_P19 //definicja głośniczka w mikrokontrolerze
#define TimeClock  1000 //ustawienie taktowania zegara
#define PIV ((MCK/TimeClock/16)-1) //przerwanie od Timera generowane co sekunde

int counterTimer=0;

void showStartMenu();
void showMenuProgramy();
void showMenuZegar();
void showInfo();
void backFromFunctions();
void backFromFunctions2();
void LCDSetRect(int x0, int y0, int x1, int y1, unsigned char fill, int color); //funkcja pomocnicza do narysowanie prostokąta
void Backlight(unsigned char state); //nagłowek funkcji podświetlającej
void isJoystickDOWN(); //deklaracja funkcji pomocniczej sprawdzającej czy wcisnieto DOWN
void isJoystickUP(); //deklaracja funkcji pomocniczej sprawdzającej czy wciśnięto UP
void ImageFunction(); //deklaracja funkcji odpowiedzialnej za wyświetlenie obrazu
void board(); //funkcja pomocnicza do rysowania planszy do gry
void LCDSetLine(int x0, int y0, int x1, int y1, int color); //funkcja pomocnicza do rysowania linii
void LCDSetCircle(int x0, int y0, int radius, int color); //funkcja pomocnicza do rysowania kółka
void drawX(int x,int y); //funkcja pomocnicza do rysowania "X"
void drawCircle(int x,int y); //funkcja pomocnicza do rysowania "O"
void drawFigure(int x,int y,char sign); //funkcja pomocnicza do rysowania figury
void game(); //funkcja do rysowania gry
void PIT_TIMER_interrupt();// funkcja pomocnicza do obsługi Timera
void enableInterrupt(); //zdefiniowanie prototypu funkcji obsługującej zezwolenie na przerwanie
void potencjometr(); //funkcja do obsługi potencjometru
void termistor(); //funkcja do obsługi termistora
void aktualnyCzas(); //funkcja pomocnicza dla ustawiania aktualnego czasu
void setHoursFunction(int hours,int setHours); //ustawienie godziny
void setMinutesFunction(int minutes,int setMinutes); //ustawienie minut
void setSecondsFunction(int seconds,int setSeconds);
int position=0; //zmienna pomocnicza dla głownego menu
int subposition=0; //zmienna pomocnicza dla menu pomocniczego
float sredniaPotencjometr=0;
float sredniaTermistor=0;
void stoper(); //funkcja stopera
void czasomierz(); //funkcja czasomierza

int main(){
       
    PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_OER=BUZZER; //ustawienie Buzzera
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście
	
	PMC_PCER|=PMC_PCER_ADC; //konfiguracja ADC
	ADC_CR=(1<<0); //reset przetwornika			
	ADC_CHER=(1<<6)|(1<<4)|(1<<5); //wybór kanałów do nasłuchiwania jako potencjometr i termistor
	ADC_MR=(23<<ADC_MR_PRESCAL_BIT)|(2<<ADC_STARTUP_BIT)|(1<<ADC_MR_SHTIM_BIT); //konfiguracja rejestru ADC Mode Register

	AIC_IDCR=AICR_IDCR_SYS; //wyłączenie przerwania od urządzeń peryferyjnych
	AIC_SVR1=(unsigned long)PIT_TIMER_interrupt; //ustawienie wskaźnika do obsługi funkcji przerwania
	AIC_ICCR=AIC_ICCR_SYS; //wyczyszczenie flagi przerwania od urządzeń peryferyjych
	AIC_IECR=AIC_IECR_SYS; //włączenie przerwania od urządzeń peryferyjnych
	
	PIT_MR|=PIT_MR_PITIEN; //włączenie przerwania PIT Timera
	PIT_MR=(PIT_MR_PIV_MASK &0x01); //ustawienie bitu PIV w rejestrze PIV_MR wartość po której następi przepełnienie licznika
	PIT_MR|=PIT_MR_PITEN; //aktywowanie Timera
	
	enableInterrupt(); //wywołanie funkcji pozwalającej na globalne zezwolenie ma przerwania
	
	
	
      InitLCD(); //ustawienie wyświetlacza
	  initADC(); //inicjalizacja ADC
      LCDSettings();
      LCDClearScreen();
      
  while(1){
		
		showStartMenu(); //wywołanie funkcji pokazującej menu startowe
		isJoystickDOWN();// wywołanie funkcji sprawdzającej czy wciśnieto DOWN
		isJoystickUP(); //wywołanie funkcji sprawdzającej czy wciśnieto UP
		
		if(position==120 && ((PIOB_PDSR&ENTER)==0){ // sprawdzamy czy wybrano PROGRAMY
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				Backlight(1); //podświetlenie
				showMenuProgramy(); //wyświetlenie pod Menu
				subposition=1;				
				isJoystickDOWN();
				isJoystickUP();
				Backlight(0); //wyłączenie podświetlenia
				
			if(position==110 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				ImageFunction(); //wywołanie funkcji odpowiedzialnej za pokazanie obrazu
				Backlight(0); //wyłączenie podświetlenia
			}
			
			if(position==100 && ((PIOB_PDSR&ENTER)==0) && subposition==1{
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				game(); //wywołanie funkcji gra kółko i krzyżyk
				Backlight(0);
			}
				
			if(position==90 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				potencjometr(); //wywołanie funkcji potencjometru
				Backlight(0); //wyłączenie podświetlenia
			}
			
			if(position==80 && ((PIOB_PDSR&ENTER)==0 && subposition==1){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				termistor(); //wywołanie funkcji termistora
				Backlight(0); //wyłączenie podświetlenia
			}
		
			}
			
			if(position==70 && ((PIOB_PDSR&ENTER)==0){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1);
				showMenuZegar();
				subposition=2;
				isJoystickDOWN();
				isJoystickUP();
				
			if(position==60 && ((PIOB_PDSR&ENTER)==0 && subposition==2){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				subposition=3; //ustawienie wartości subpostion na 3 aby po wciśnięciu joysticka można było ustawić godzinę
				aktualnyCzas();
				Backlight(0);
			}
			
			if(position==50 && ((PIOB_PDSR&ENTER)==0) && subposition==2{
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				subposition=4; //ustawienie wartości subposition na 4 aby reagować na stoper
				stoper(); //wywołanie funkcji stopera
				Backlight(0); //wyłączenie podświetlenia 
			}
				
			if(position==40 && ((PIOB_PDSR&ENTER)==0 && subposition==2){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włączenie podświetlenia
				czasomierz();
				Backlight(0);
			}
				
			}
			
			if(position==30 & (PIOB_PDSR&ENTER)==0){
				PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
				Delay(10);
				PIOB_CODR|=BUZZER;//wyłączenie dźwięku
				
				Backlight(1); //włącz podświetlenie
				LCDClearScreen();
				showInfo();
				Backlight(0); //wyłącz podświetlenie
			}
		
		
	
} 

}
//1.1
void ImageFunction(){
		LCDClearScreen(); //wyczyszczenie ekranu LCD
		while((PIOB_PDSR&ESCAPE)!=0){ //dopóki nie wciśnięto przycisku wyjdź
		LCDWrite130x130bmp(); //wywołanie funkcji odpowiedzialnej za wyświetlenie pliku bmp
		LCDSetRect(20,50,40,120,FILL,WHITE); //wywołanie funkcji odpowiedzialnej za narysowanie prostokątku na wyświetlaczu LCD
		LCDPutStr("Hello!",24,52,SMALL,BLACK,WHITE); //wywołanie funkcji odpowiedzialnej za wypisanie tekstu
	}
	
	if((PIOB_PDSR&ESCAPE)==0){
		PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
		Delay(10);
		PIOB_CODR|=BUZZER;//wyłączenie dźwięku
		backFromFunctions(); //wywołanie funkcji powrotu z podfunkcji
		
	}
}

//1.2
void game(){
	LCDClearScreen(); //wyczyszczenie ekranu
	while((PIOB_PDSR&ESCAPE)!=0){
		int row,column; //deklaracja zmiennych odpowiedzialnych za to w którym wierzu,kolumnie ma być wyświetlany znak X lub O
		char sign; //zmienna określająca jaki wprowadziliśmy znak
		board(); //wywołanie funkcji odpowiedzialnej za narysowanie tablicy
		drawFigure(row,column,sign);//wywołujemy funkcję rysującą kółko lub krzyzyk
									//w funkcji tej nie ma zaimplementowanej logiki naszej gry ponieważ nie to było
									//celem laboratorium
	}
	
	if((PIOB_PDSR&ESCAPE)==0){
		PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
		Delay(10);
		PIOB_CODR|=BUZZER;//wyłączenie dźwięku
		backFromFunctions(); //wywołanie funkcji powrotu z podfunkcji
	}
	
}

//1.3
void potencjometr(){
	LCDClearScreen(); //wyczyszczenie ekranu LCD
	while((PIOB_PDSR&ESCAPE)!=0){
		ADC_CR=ADC_CR_START;
		while(ADC_SR&ADC_SR_EOC6)==0){}
		for(int i=0;i<10;i++){
			sredniaPotencjometr+=ADC_CDR6;	
		}
		
	float napiecie=((float)sredniaPotencjometr/10.0)/(1023.0*3.3);
	int napiecieCalkowite=(int)napiecie;
	int napiecieZmierzone(int)(napiecie*100)%100;
	sprintf(tekst,"%d.%dV",napiecieCalkowite,napiecieZmierzone);
	LCDPutStr(tekst,65,65,SMALL,BLACK,WHITE);
	}
	
	if((PIOB_PDSR&ESCAPE)==0){
		PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
		Delay(10);
		PIOB_CODR|=BUZZER;//wyłączenie dźwięku
		backFromFunctions(); //wywołanie funkcji powrotu z podfunkcji
	}
	
}

//1.4
void termistor(){
		LCDClearScreen(); //wyczyszczenie ekranu
		while((PIOB_PDSR&ESCAPE)!=0){
			ADC_CR=ADC_CR_START; //rozpoczęcie konwersji
			while(ADC_SR&ADC_SR_EOC5)==0){}
			for(int i=0;i<10;i++){
			stopnie=((ADC_CDR5-wartosc1)/przelicznik)+temperatura1; //obliczenie wyniku w stopniach Celsjusz
			sredniaTermistor+=stopnie;	
			}
			
			float stopnieSrednie=sredniaTermistor*100;
			int stopnieCalkowite=(int)stopnieSrednie;
			int stopnieCzescCalkowita=(int)stopnieCalkowite/100;
			int stopnieDziesietne=(int)stopnieCalkowite%100;
			sprintf(tekst,"%d.%dCV",stopnieCzescCalkowita,stopnieDziesietne);
			LCDPutStr(tekst,65,65,SMALL,BLACK,WHITE);
		}
	
		if((PIOB_PDSR&ESCAPE)==0){
		PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
		Delay(10);
		PIOB_CODR|=BUZZER;//wyłączenie dźwięku
		backFromFunctions(); //wywołanie funkcji powrotu z podfunkcji
	}
	
}

//2.1
void aktualnyCzas(){
	int hours=0,minutes=0,seconds=0; //dane wartości będą ustawiane na LCD
	int setHours=0,setMinutes=0,setSeconds=0; //zmienne pomocnicze pomagające przy poruszaniu się joystickiem w prawo i lewo
	LCDClearScreen(); //wyczyść ekranu
	LCDPutStr("Ustaw godzinę ",120,20,SMALL,WHITE,BLACK);
	LCDPutStr("Zatwierdź klawiszem SW_1",100,20,SMALL,WHITE,BLACK);
	LCDPutStr("00:00:00",65,40,LARGE,WHITE,BLACK); //ustawienie aktualnego czasu jako 00:00:00
	
	while((PIOB_PDSR&ESCAPE)!=0){ //dopóki nie wciśnięto klawisza ESCAPE
	
	while((PIOB_PDSR&ENTER)!=0){ //dopóki nie wciśnięto klawisza Enter
		//ustawienie godziny
		setHours=1; //obecnie ustawiamy godzinę
		setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godzinę
	
	
		if((PIOA_PDSR&RIGHT)==0 && setHours==1){
			setHours=0; //przechodzimy na prawo ustawiamy minuty
			setMinutes=1; //obecnie ustawiamy minuty
			setMinutesFunction(minutes,setMinutes); //wywołanie funkcji ustaw minuty
			
		}
		
		if((PIOB_PDSR&LEFT)==0 && setHours==1){
			setHours=0; //nie ustawiamy już godzin
			setSeconds=1; //ustawiamy sekundy
			setSecondsFunction(seconds,setSeconds); //wywołanie funkcji ustaw seknudy
		}
	
	
		if((PIOA_PDSR&RIGHT)==0 && setMinutes==1){
			setMinutes=0; //przechodzimy na prawo ustawiamy minuty
			setSeconds=1; //obecnie ustawiamy minuty
			setSecondsFunction(seconds,setSeconds); //wywołanie funkcji ustaw sekundy			
			
		}
		
		if((PIOB_PDSR&LEFT)==0 && setMinutes==1){
			setHours=1; //nie ustawiamy już godzin
			setMinutes=0; //ustawiamy sekundy
			setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godzine
			
		}
		
		
		if((PIOA_PDSR&RIGHT)==0 && setSeconds==1){
			setHours=1; //przechodzimy na prawo ustawiamy minuty
			setSeconds=0; //obecnie ustawiamy minuty
			setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godziny
						
		}
		
		if((PIOB_PDSR&LEFT)==0 && setMinutes==1){
			setMinutes=1; //nie ustawiamy już godzin
			setSeconds=0; //ustawiamy sekundy
			setMinutesFunction(minutes,setMinutes); //wywołanie funkcji ustaw minuty
					
		}
	
	}
		if((PIOB_PDSR&ENTER)==0){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			LCDClearScreen();
			LCDPutStr("Godzina została zatwierdzona",110,60,MEDIUM,WHITE,BLACK);
			LCDPutStr(hours,80,40,MEDIUM,WHITE,BLACK);
			LCDPutStr(minutes,80,60,MEDIUM,WHITE,BLACK);
			LCDPutStr(seconds,80,80,MEDIUM,WHITE,BLACK);
		}
	}
		if((PIOB_PDSR&ESCAPE)==0){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			backFromFunctions2(); //wywołanie powrotu z pod funkcji
		}
	
}

void setHoursFunction(int hours,int setHours){
	while(((PIOA_PDSR&LEFT)!=0 || ((PIOA_PDSR&RIGHT)!=0)) && setHours==1){
			
		
		if(((PIOA_PDSR&DOWN)==0) && hours==0 && subpositon==3){ //sprawdzamy czy wciśnięto klawisz down i aktualna godzina 00.00.00
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			hours=23;
			LCDPutStr("gg:",65,40,LARGE,WHITE,BLACK);
			LCDPutStr(hours,40,40,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
		}
		
		if(((PIOA_PDSR&UP)==0) && hours==23 && subposition==3){ //sprawdzamy czy wciśnięto klawisz UP oraz aktualna godzina 23
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			hours=0;
			LCDPutStr("gg:",65,40,LARGE,WHITE,BLACK);
			LCDPutStr(hours,40,40,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
			
		}
		
		if((PIOA_PDSR&DOWN)==0 && subposition==3){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			hours--; //dekrementujemy zmienną godzinową
			LCDPutStr("gg:",65,40,LARGE,WHITE,BLACK);
			LCDPutStr(hours,40,40,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
		}
		
		if((PIOA_PDSR&UP)==0 && subposition==3){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			hours++; //inkrementujemy zmienną godzinową
			LCDPutStr("gg:",65,40,LARGE,WHITE,BLACK);
			LCDPutStr(hours,40,40,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
		}
}
}

void setMinutesFunction(int minutes,int setMinutes){
	while(((PIOA_PDSR&LEFT)!=0 || ((PIOA_PDSR&RIGHT)!=0)) && setMinutes==1){
			
		
				if(((PIOA_PDSR&DOWN)==0) && minutes==0 && subposition==3){ 
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					minutes=59;
					LCDPutStr("mm:",65,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK); //wyświetlenie aktualnej minuty
					}
				
				if(((PIOA_PDSR&UP)==0) && minutes==59 && subposition==3){ 
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					minutes=0;
					LCDPutStr("mm:",65,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
			
					}
		
				if((PIOA_PDSR&DOWN)==0 && subposition==3){
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					minutes--; 
					LCDPutStr("mm:",65,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
					}
		
				if((PIOA_PDSR&UP)==0 && subposition==3){
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					minutes++; 
					LCDPutStr("mm:",65,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
				}
	
			}
}

void setSecondsFunction(int seconds,int setSeconds){
	while(((PIOA_PDSR&LEFT)!=0 || ((PIOA_PDSR&RIGHT)!=0)) && setSeconds==1){
			
		
				if(((PIOA_PDSR&DOWN)==0) && seconds==0 && subposition==3){ //sprawdzamy czy wciśnięto klawisz down i aktualna godzina 00.00.00
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					seconds=59;
					LCDPutStr("ss:",65,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
					}
				
				if(((PIOA_PDSR&UP)==0) && seconds==59 && subposition==3){ //sprawdzamy czy wciśnięto klawisz UP 
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					seconds=0;
					LCDPutStr("ss:",65,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
			
					}
		
				if((PIOA_PDSR&DOWN)==0 && subposition==3){
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					seconds--; 
					LCDPutStr("ss:",65,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
					}
		
				if((PIOA_PDSR&UP)==0 && subposition==3){
					PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
					Delay(10);
					PIOB_CODR|=BUZZER;//wyłączenie dźwięku
					seconds++; 
					LCDPutStr("ss:",65,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK); //wyświetlenie aktualnej godziny
				}
	
			}
}

//2.2 stoper
void stoper(){
	int hours=0,minutes=0,seconds=0; //zmmienne pomocnicze odliczające czas
	int start=0; //zmienna pomocnicza pomagająca zatrzymać stoper i włączyć stoper 
	LCDClearScreen();
	while((PIOB_PDSR&ESCAPE)!=0){
		
		if(((PIOB_PDSR&ENTER)==0 && start==0)){ //włączenie stopera
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			start=1;// stoper działa
			if(counterTimer==1){ //sprawdzamy czy minęła 1 sekunda
				seconds++;
					if(seconds!=60){
						LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
						LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
					}
				counterTimer=0; //zerujemy wartość Timera
			}
			if(seconds==60){ //sprawdzamy czy minęło 60 sekund
				seconds=0; //zerujemy sekundy
				LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
				LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
				minutes++; //zwiększamy minuty
					if(minutes!=60){
						LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
						LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);
					}
			}
			
			if(minutes==60){ //sprawdzamy czy 60 minut minęło
				minutes=0; //zerujemy minuty
				LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
				LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);
				hours++; //zwiększamy godziny
				if(hours!=24){
					LCDPutStr("gg:",60,40,LARGE,WHITE,BLACK);
					LCDPutStr(hours,40,40,LARGE,WHITE,BLACK);
				}
			}
			if(hours==24){ //sprawdzamy czy minęły 24 godziny
				hours=0; //ustawiamy wartość godzin na 0
				LCDPutStr("gg:",60,40,LARGE,WHITE,BLACK);
				LCDPutStr(hours,40,40,LARGE,WHITE,BLACK);
				seconds++; //ponownie zliczamy sekundy
			}
			
		}
		
		if(((PIOB_PDSR&ENTER)==0 && start==1)){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			start=0; //zatrzymujemy stoper
			//wyświetlamy aktualny czas stopera
			LCDPutStr("gg:",60,40,LARGE,WHITE,BLACK);
			LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
			LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
			LCDPutStr(hours,40,40,LARGE,WHITE,BLACK);
			LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);
			LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
		}
		
	}
	
	if((PIOB_PDSR&ESCAPE)==0){
		PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
		Delay(10);
		PIOB_CODR|=BUZZER;//wyłączenie dźwięku
		backFromFunctions2();
	}
}


void czasomierz(){
	int hours=0,minutes=0,seconds=0; //dane wartości będą ustawiane na LCD
	int setHours=0,setMinutes=0,setSeconds=0; //zmienne pomocnicze pomagające przy poruszaniu się joystickiem w prawo i lewo
	int startCzasomierz=0; //powoduje włączenie czasomierza
	LCDClearScreen(); //wyczyść ekranu
	LCDPutStr("Ustaw godzinę ",120,20,SMALL,WHITE,BLACK);
	LCDPutStr("Zatwierdź klawiszem SW_1",100,20,SMALL,WHITE,BLACK);
	LCDPutStr("00:00:00",65,40,LARGE,WHITE,BLACK); //ustawienie aktualnego czasu jako 00:00:00
	
	while((PIOB_PDSR&ESCAPE)!=0){ //dopóki nie wciśnięto klawisza ESCAPE
	
	while((PIOB_PDSR&ENTER)!=0){ //dopóki nie wciśnięto klawisza Enter
		//ustawienie godziny
		setHours=1; //obecnie ustawiamy godzinę
		setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godzinę
	
	
		if((PIOA_PDSR&RIGHT)==0 && setHours==1){
			setHours=0; //przechodzimy na prawo ustawiamy minuty
			setMinutes=1; //obecnie ustawiamy minuty
			setMinutesFunction(minutes,setMinutes); //wywołanie funkcji ustaw minuty
			
		}
		
		if((PIOB_PDSR&LEFT)==0 && setHours==1){
			setHours=0; //nie ustawiamy już godzin
			setSeconds=1; //ustawiamy sekundy
			setSecondsFunction(seconds,setSeconds); //wywołanie funkcji ustaw seknudy
		}
	
	
		if((PIOA_PDSR&RIGHT)==0 && setMinutes==1){
			setMinutes=0; //przechodzimy na prawo ustawiamy minuty
			setSeconds=1; //obecnie ustawiamy minuty
			setSecondsFunction(seconds,setSeconds); //wywołanie funkcji ustaw sekundy			
			
		}
		
		if((PIOB_PDSR&LEFT)==0 && setMinutes==1){
			setHours=1; //nie ustawiamy już godzin
			setMinutes=0; //ustawiamy sekundy
			setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godzine
			
		}
		
		
		if((PIOA_PDSR&RIGHT)==0 && setSeconds==1){
			setHours=1; //przechodzimy na prawo ustawiamy minuty
			setSeconds=0; //obecnie ustawiamy minuty
			setHoursFunction(hours,setHours); //wywołanie funkcji ustaw godziny
						
		}
		
		if((PIOB_PDSR&LEFT)==0 && setMinutes==1){
			setMinutes=1; //nie ustawiamy już godzin
			setSeconds=0; //ustawiamy sekundy
			setMinutesFunction(minutes,setMinutes); //wywołanie funkcji ustaw minuty
					
		}
	
	}
		if(((PIOB_PDSR&ENTER)==0 && startCzasomierz==0)){ //zatwierdzenie godziny
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			startCzasomierz=1; //czasomierz zacznie działać po kolejnym wciśnięciu przycisku
			LCDClearScreen();
			LCDPutStr("Godzina została zatwierdzona",110,60,MEDIUM,WHITE,BLACK);
			LCDPutStr(hours,80,40,MEDIUM,WHITE,BLACK);
			LCDPutStr(minutes,80,60,MEDIUM,WHITE,BLACK);
			LCDPutStr(seconds,80,80,MEDIUM,WHITE,BLACK);
		}
		
		
		if(((PIOB_PDSR&ENTER)==0 && startCzasomierz==1)){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			startCzasomierz=0;
				if(counterTimer==1){ //sprawdzamy czy minęła sekunda z wykorystaniem Timera
					seconds--;
					LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
					counterTimer=0; //ustawiamy z powrotem wartość countera na 0
				}
				
				if(seconds==0 && minutes!=0){ //sprawdzamy czy sekundy się wyzerowały i minuty są różne od zera
					seconds=59; //ustawiamy sekundy na wartość 59
					minutes--; //zmniejszamy wartość minut
					LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
					LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);						
				}
				
				if(minutes==0 && hours!=0){ //sprawdzamy czy wyzerowały się minuty i godziny są różne od zera
					minutes=59; //ustawiamy wartość minut na 59
					hours--; //zmniejszamy wartość godzin
					LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
					LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);	
					LCDPutStr("gg:",60,40,LARGE,WHITE,BLACK);
					LCDPutStr(hours,40,40,LARGE,WHITE,BLACK);	
				}
				
				if(hours==0 && minutes==0 && seconds==0){ //jeśli wszystkie wartości minut,godzin i sekund są na 0 to czasomiersz zakończył działanie
					
					LCDPutStr("Koniec działania czasomirza",95,20,MEDIUM,WHITE,BLACK);
					LCDPutStr("ss:",60,80,LARGE,WHITE,BLACK);
					LCDPutStr(seconds,40,80,LARGE,WHITE,BLACK);
					LCDPutStr("mm:",60,60,LARGE,WHITE,BLACK);
					LCDPutStr(minutes,40,60,LARGE,WHITE,BLACK);	
					LCDPutStr("gg:",60,40,LARGE,WHITE,BLACK);
					LCDPutStr(hours,40,40,LARGE,WHITE,BLACK);	
					
				}
				
		}
	}
		if((PIOB_PDSR&ESCAPE)==0){
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			backFromFunctions2(); //wywołanie powrotu z pod funkcji
		}
	
}

void backFromFunctions(){
	LCDClearScreen(); //wyczyszczenie ekranu
	showStartMenu(); //wyświetlenie Menu podstawowego
	showMenuProgramy(); //wyświetlenie pod Menu
	subposition=1;				
	isJoystickDOWN();
	isJoystickUP();
}

void backFromFunctions2(){
	LCDClearScreen(); //wyczyszczenie ekranu
	showStartMenu(); //wyświetlenie Menu podstawowego
	showMenuZegar(); //wyświetlenie pod Menu
	subposition=2;				
	isJoystickDOWN();
	isJoystickUP();
}

void interrupt_enable(){

__asm__("MRS r1,CPSR"); //Odczyt rejestru CPSR
__asm__("BIC r1,r1,#0x80"); //instrukcja czyszcząca bit przerwania
__asm__("MSR CPSR,r1"); //skopiowanie ustawienia do rejestru CPSR	

}

void PIT_TIMER_interrupt(){

		if(PIT_SR_PITS){
			PIT_PIVR; //wyzerowanie liczika PIT
			counterTimer++; //zwiększenie licznika ile razy się wywołał timer
		}
		
		AIC_EOICR; //przekazanie informacji o zakończeniu obsługi Timera
}


void isJoystickDOWN(){
	if((PIOA_PDSR&DOWN)==0){ //sprawdzamy czy wciśnięto joystick DOWN
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
			if(position=>10) position=position-10; //zmniejszamy pozycje na której jest joystick
			else position=0;
		}
}

void isJoystickUP(){
if((PIOA_PDSR&UP)==0){ //sprawdzamy czy wciśnięto joystick DOWN
			PIOB_SODR|=BUZZER; //włączenie dźwięku w głośniczku
			Delay(10);
			PIOB_CODR|=BUZZER;//wyłączenie dźwięku
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

void LCDSetRect(int x0, int y0, int x1, int y1, unsigned char fill, int color) {
int xmin, xmax, ymin, ymax;
 int i;

// check if the rectangle is to be filled
if (fill == FILL) {

// best way to create a filled rectangle is to define a drawing box
// and loop two pixels at a time

// calculate the min and max for x and y directions
xmin = (x0 <= x1) ? x0 : x1;
xmax = (x0 > x1) ? x0 : x1;
ymin = (y0 <= y1) ? y0 : y1;
ymax = (y0 > y1) ? y0 : y1;

// specify the controller drawing box according to those limits
// Row address set (command 0x2B)
 WriteSpiCommand(PASET);
 WriteSpiData(xmin);
 WriteSpiData(xmax);

// Column address set (command 0x2A)
 WriteSpiCommand(CASET);
 WriteSpiData(ymin);
 WriteSpiData(ymax);

 // WRITE MEMORY
 WriteSpiCommand(RAMWR);

// loop on total number of pixels / 2
for (i = 0; i < ((((xmax - xmin + 1) * (ymax - ymin + 1)) / 2) + 130); i++) {

// use the color value to output three data bytes covering two pixels
 WriteSpiData((color >> 4) & 0xFF);
WriteSpiData(((color & 0xF) << 4) | ((color >> 8) & 0xF));
 WriteSpiData(color & 0xFF);
 }
} else {

 // best way to draw un unfilled rectangle is to draw four lines
LCDSetLine(x0, y0, x1, y0, color);
LCDSetLine(x0, y1, x1, y1, color);
LCDSetLine(x0, y0, x0, y1, color);
LCDSetLine(x1, y0, x1, y1, color);
 }
}

void board(){
	
	LCDSetRect(70,70,103,103,FILL,WHITE); //narysowanie obramowania planszy i wypłenienie jej kolorem
	LCDSetLine(81,70,81,103,BLACK); //narysowanie 1 poziomej linii
	LCDSetLine(92,70,92,103,BLACK); //narysowanie 2 poziomej linii
	LCDSetLine(70,81,103,81,BLACK); //narysowanie 1 pinowej linii
	LCDSetLine(70,92,103,92,BLACK); //narysowanie 2 pinowej linii
	
}

//funkcja pozwalająca na narysowanie X lub O
void drawFigure(int x,int y,char sign){
	if((y>0 || y<4)&&(x>0 ||x<4)){
		if(sign=="X" || sign=="x"){
			drawX(x,y);
		}
		else if(sign=="Y" || sign=="y"){
			drawCircle(x,y);
		}
	}
}

//funkcja odpowiadająca za narysowanie X w zależności od podanych współrzędnych
void drawX(int x,int y){
	
	if(x==1 && y==1) {
	
	LCDSetLine(70,70,80,80,BLACK);
	LCDSetLine(70,80,80,71,BLACK);
	}
	
	if(x==1 && y==2){
	LCDSetLine(70,82,80,91,BLACK);
	LCDSetLine(70,91,80,82,BLACK);
	}
	
	if(x==1 && y==3){
	LCDSetLine(70,93,80,102,BLACK);
	LCDSetLine(70,103,80,93,BLACK);
	}
	
	if(x==2 && y==1){
	LCDSetLine(81,71,91,80,BLACK);
	LCDSetLine(80,80,92,71,BLACK);
	}
	
	if(x==2 && y==2){
	LCDSetLine(82,82,91,91,BLACK);
	LCDSetLine(80,91,91,82,BLACK);
	}
	
	if(x==2 && y==3){
	LCDSetLine(82,93,91,102,BLACK);
	LCDSetLine(82,102,91,93,BLACK);	
	}
	
	if(x==3 && y==1){
	LCDSetLine(93,71,102,80,BLACK);
	LCDSetLine(93,80,103,70,BLACK);	
	}
	
	if(x==3 && y==2){
	LCDSetLine(93,82,102,91,BLACK);
	LCDSetLine(93,91,102,82,BLACK);
	}
	
	if(x==3 && y==3){
	LCDSetLine(93,93,103,103,BLACK);
	LCDSetLine(93,102,102,93,BLACK);
	}
	
}

//funkcja odpowiadająca za wyświetlenie kółka na wyświetlaczu LCD
void drawCircle(int x,int y){

	if(x==1 && y==1) {
	LCDSetCircle(76,76,4,GREEN);
	}
	
	if(x==1 && y==2){
	LCDSetCircle(76,86,4,GREEN);
	}
	
	if(x==1 && y==3){
	LCDSetCircle(76,97,4,GREEN);
	}
	
	if(x==2 && y==1){
	LCDSetCircle(86,76,4,GREEN);
	}
	
	if(x==2 && y==2){
	LCDSetCircle(86,86,4,GREEN);
	}
	
	if(x==2 && y==3){
	LCDSetCircle(86,97,4,GREEN);
	}
	
	if(x==3 && y==1){
	LCDSetCircle(97,76,4,GREEN);
	}
	
	if(x==3 && y==2){
	LCDSetCircle(97,86,4,GREEN);
	}
	
	if(x==3 && y==3){
	LCDSetCircle(97,97,4,GREEN);
	}
	
}


void LCDSetLine(int x0, int y0, int x1, int y1, int color) {
 int dy = y1 - y0;
 int dx = x1 - x0;
 int stepx, stepy; 

if (dy < 0) { dy = -dy; stepy = -1; } else { stepy = 1; }
 if (dx < 0) { dx = -dx; stepx = -1; } else { stepx = 1; }
 dy <<= 1; // dy is now 2*dy
 dx <<= 1; // dx is now 2*dx
LCDSetPixel(x0, y0, color);
 if (dx > dy) {
 int fraction = dy - (dx >> 1); // same as 2*dy - dx
 while (x0 != x1) {
 if (fraction >= 0) {
 y0 += stepy;
 fraction -= dx; // same as fraction -= 2*dx
 }
 x0 += stepx;
 fraction += dy; // same as fraction -= 2*dy
 LCDSetPixel(x0, y0, color);
 }
 } else {
 int fraction = dx - (dy >> 1);
 while (y0 != y1) {
 if (fraction >= 0) {
 x0 += stepx;
 fraction -= dy;
 }
 y0 += stepy;
 fraction += dx;
 LCDSetPixel(x0, y0, color);
 }
 }
} 



void LCDSetCircle(int x0, int y0, int radius, int color) {
int f = 1 - radius;
int ddF_x = 0;
int ddF_y = -2 * radius;
int x = 0;
int y = radius;

LCDSetPixel(x0, y0 + radius, color);
LCDSetPixel(x0, y0 - radius, color);
LCDSetPixel(x0 + radius, y0, color);
LCDSetPixel(x0 - radius, y0, color);

While (x < y) {
 if (f >= 0) {
 y--;
 ddF_y += 2;
 f += ddF_y;
 }
 x++;
 ddF_x += 2;
f += ddF_x + 1;
LCDSetPixel(x0 + x, y0 + y, color);
LCDSetPixel(x0 - x, y0 + y, color);
LCDSetPixel(x0 + x, y0 - y, color);
LCDSetPixel(x0 - x, y0 - y, color);
LCDSetPixel(x0 + y, y0 + x, color);
LCDSetPixel(x0 - y, y0 + x, color);
LCDSetPixel(x0 + y, y0 - x, color);
LCDSetPixel(x0 - y, y0 - x, color);
 }
} 