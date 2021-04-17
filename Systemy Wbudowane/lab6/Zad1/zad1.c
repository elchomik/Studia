#include <targets/AT91SAM7.h>
#include "lcd.h"
#include <stdlib.h>
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


int main(){
	
	time_t time; //inicjalizacja zmiennej do losowania 
    srand((unsigned)time(&time)); //inicjalizacja generatora liczb losowych
	
    PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście

      InitLCD(); //ustawienie wyświetlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){
      if((PIOB_PDSR&BUTTON)==0){ //jeśli wcisnęliśmy przycisk uruchomi się losowanie liczby
		  int k=rand()%6+1; //wylosowanie cyfry z zakresu 1 do 6
		  drawFigure(k); //wykonanie funkcji odpowiedzialnej za narysowanie liczby na wyświetlaczu LCD
		  
	  }
} 


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