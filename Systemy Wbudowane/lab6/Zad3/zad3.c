#include <targets/AT91SAM7.h>
#include "lcd.h"
#include <stdlib.h>
#include <string.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD
#define BUTTON PIOB_SODR_P24 //definicja przycisku

void drawFigure(int number);
void LCDSetRect(int x0, int y0, int x1, int y1, unsigned char fill, int color); //funkcja rysująca kostkę
void LCDSetCircle(int x0, int y0, int radius, int color); //funkcja rysująca oczka
void drawOne();
void drawTwo();
void drawThree();
void drawFour();
void drawFive();
void drawSix();

int myRandomGenearator();
int RandomTimerGenerator();
int counterGlowny=0; //zmienna counterowa, która działa non stop w pętli while


int main(){
	
	time_t time; //inicjalizacja zmiennej do losowania 
    srand((unsigned)time(&time)); //inicjalizacja generatora liczb losowych
	
	char buffor[5]; //buffor przechowujący typ danych do konwersji
	
	int tablica_standardowa[6]={0,0,0,0,0,0}; //inicjalizacja tablicy dla losowania z wykorzystaniem funkcji rand
	int tablica_mGenerator[6]={0,0,0,0,0,0}; //inicjalizacja tablicy dla losowania liczb z wykorzystaniem własnej funkcji
	int ile_jedynekS=0,ile_dwojekS=0,ile_trojekS=0,ile_czworekS=0,ile_piatekS=0,ile_szostekS=0; //inicjalizacja zmiennych zliczających wystapienie cyfr z funkcji standardowej
	int ile_jedynekG=0,ile_dwojekG=0,ile_trojekG=0,ile_czworekG=0,ile_piatekG=0,ile_szostekG=0; //inicjalizacja zmiennych zliczających wystapienie cyfr z funkcji z zadania 2
	int counterPrzerwania=0; //zmienna counterowa, która działa jeśli nastąpi przepełnienie licznika countera

	int R1=0,R2=0; //zmienne pomocnicze przechowujące wartość funkcji randomowej
	
    PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście
	
	PIT_MR|=PIT_MR_PITEN; //aktywowanie Timera
	PIT_MR=(PIT_MR_PIV_MASK & 0x1000); //ustawienie bitu PIV w rejestrze PIV_MR wartość po której następi przepełnienie licznika

      InitLCD(); //ustawienie wyświetlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){
	  
	  for(int j=0;j<20;j++){
		  
	  R1=myRandomGenearator(); //wywołanie funkcji zliczającej 
	  if((PIT_SR&0x00000001)){		//jeśli nastąpi przepełnienie counter wywołaj funkcję pomocniczą
			R2=RandomTimerGenerator();
			PIT_MR=(PIT_MR_PITEN)|(PIT_MR_PIV_MASK & 0x1000); //ponowne ustawienie zliczania w Timerze
		}
	  
	  
      if((PIOB_PDSR&BUTTON)==0){ //jeśli wcisnęliśmy przycisk uruchomi się losowanie liczby
			
			int k=(R1+R2)%7; //wyolosowanie liczy z przedziału
			if(k==1) tablica_standardowa[k]=ile_jedynekS++; //zwiekszamy ilosc jedynek
			if(k==2) tablica_standardowa[k]=ile_dwojekS++; //zwiekszamy ilosc dwojek
			if(k==3) tablica_standardowa[k]=ile_trojekS++; //zwiekszamy ilosc trojek
			if(k==4) tablica_standardowa[k]=ile_czworekS++; //zwiekszamy ilosc czworek
			if(k==5) tablica_standardowa[k]=ile_piatekS++; //zwiekszamy ilosc piatek
			if(k==6) tablica_standardowa[k]=ile_szostekS++; //zwiekszamy ilosc szóstek
			drawFigure(k); //wykonanie funkcji odpowiedzialnej za narysowanie liczby na wyświetlaczu LCD
		  
	  }
	  
	   if((PIOB_PDSR&BUTTON)==0){ //jeśli wcisnęliśmy przycisk uruchomi się losowanie liczby
		  int k=rand()%6+1; //wylosowanie cyfry z zakresu 1 do 6
			if(k==1) tablica_mGenerator[k]=ile_jedynekG++; //zwiekszamy ilosc jedynek
			if(k==2) tablica_mGenerator[k]=ile_dwojekG++; //zwiekszamy ilosc dwojek
			if(k==3) tablica_mGenerator[k]=ile_trojekG++; //zwiekszamy ilosc trojek
			if(k==4) tablica_mGenerator[k]=ile_czworekG++; //zwiekszamy ilosc czworek
			if(k==5) tablica_mGenerator[k]=ile_piatekG++; //zwiekszamy ilosc piatek
			if(k==6) tablica_mGenerator[k]=ile_szostekG++; //zwiekszamy ilosc szóstek
		  drawFigure(k); //wykonanie funkcji odpowiedzialnej za narysowanie liczby na wyświetlaczu LCD
		  
	  }
	 }
	 LCDClearScreen(); //wyczyść ekran
	 //wyświetlenie wyników na LCD
	 LCDPutString("Funkcja rand",116,20,SMALL,WHITE,BLACK);
	 itoa(tablica_standardowa[1],buffor,10); //konwersja typu int na String
	 LCDPutString(buffor,96,20,SMALL,WHITE,BLACK); //wyświetlenie wyników dla jedynki
	 itoa(tablica_standardowa[2],buffor,10);
	 LCDPutString(buffor,96,29,SMALL,WHITE,BLACK); //wyświetlenie wyników dla dwójki
	 itoa(tablica_standardowa[3],buffor,10);
	 LCDPutString(buffor,96,38,SMALL,WHITE,BLACK); //wyświetlenie wyników dla trójki
	 itoa(tablica_standardowa[4],buffor,10);
	 LCDPutString(buffor,96,47,SMALL,WHITE,BLACK); //wyświetlenie wyników dla czwórki
	 itoa(tablica_standardowa[5],buffor,10);
	 LCDPutString(buffor,96,56,SMALL,WHITE,BLACK); //wyświetlenie wyników dla piątki
	 itoa(tablica_standardowa[6],buffor,10);
	 LCDPutString(buffor,96,65,SMALL,WHITE,BLACK); //wyświetlenie wyników dla szóstki
	 
	 LCDPutString("Funkcja wlasna",76,20,SMALL,WHITE,BLACK);
	 itoa(tablica_mGenerator[1],buffor,10); //konwersja typu int na String
	 LCDPutString(buffor,56,20,SMALL,WHITE,BLACK); //wyświetlenie wyników dla jedynki
	 itoa(tablica_mGenerator[2],buffor,10);
	 LCDPutString(buffor,56,29,SMALL,WHITE,BLACK); //wyświetlenie wyników dla dwójki
	 itoa(tablica_mGenerator[3],buffor,10);
	 LCDPutString(buffor,56,38,SMALL,WHITE,BLACK); //wyświetlenie wyników dla trójki
	 itoa(tablica_mGenerator[4],buffor,10);
	 LCDPutString(buffor,56,47,SMALL,WHITE,BLACK); //wyświetlenie wyników dla czwórki
	 itoa(tablica_mGenerator[5],buffor,10);
	 LCDPutString(buffor,56,56,SMALL,WHITE,BLACK); //wyświetlenie wyników dla piątki
	 itoa(tablica_mGenerator[6],buffor,10);
	 LCDPutString(buffor,56,65,SMALL,WHITE,BLACK); //wyświetlenie wyników dla szóstki
	 
} 


}

int myRandomGenearator(){
		if(++counterGlowny>6)
			counterGlowny=1;
		return counterGlowny;
}

int RandomTimerGenerator(){
		if(++counterPrzerwania>6)
			counterPrzerwania=1;
		return counterPrzerwania;
}
void drawFigure(int number){
		LCDSetRect(20,20,120,120,FILL,WHITE); //narysowanie boku kostki
		if(number==1) drawOne();
		if(number==2) drawTwo();
		if(number==3) drawThree();
		if(number==4) drawFour();
		if(number==5) drawFive();
		if(number==6) drawSix();
}

void drawOne(){
	LCDClearScreen(); //wyczyść ekran przed każdym narysowaniem
	LCDSetCircle(70,70,5,BLACK); //narysowanie jednego oczka 
}

void drawTwo(){
	LCDClearScreen(); // wyczyść ekran przed każdym nowym narysowaniem znaku
	LCDSetCircle(70,45,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(70,95,5,BLACK); //narysowanie jednego oczka 	
}

void drawThree(){
	LCDClearScreen(); // wyczyść ekran przed każdym nowym narysowaniem znaku
	LCDSetCircle(70,35,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(70,65,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(70,95,5,BLACK); //narysowanie jednego oczka
	 	
}

void drawFour(){
	LCDClearScreen(); // wyczyść ekran przed każdym nowym narysowaniem znaku
	LCDSetCircle(45,45,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(45,95,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,45,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,95,5,BLACK); //narysowanie jednego oczka
	
}

void drawFive(){
	LCDClearScreen(); // wyczyść ekran przed każdym nowym narysowaniem znaku
	LCDSetCircle(45,45,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(45,95,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,45,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,95,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(70,70,5,BLACK); //narysowanie jednego oczka
}

void drawSix(){
	LCDClearScreen(); // wyczyść ekran przed każdym nowym narysowaniem znaku
	LCDSetCircle(45,35,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(45,65,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(45,95,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,35,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,60,5,BLACK); //narysowanie jednego oczka
	LCDSetCircle(95,95,5,BLACK); //narysowanie jednego oczka
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
for (i = 0; i < ((((xmax - xmin + 1) * (ymax - ymin + 1)) / 2) + 1); i++) {

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
