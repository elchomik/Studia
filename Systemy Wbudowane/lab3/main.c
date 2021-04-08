#include <targets/AT91SAM7.h>
#include "lcd.h"
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD

void board();
void drawX(int x0,int y0,int x1,int y1,int x3,int y3,int x4,int y4);
void LCDSetRect(int x0, int y0, int x1, int y1, unsigned char fill, int color);
void LCDSetLine(int x0, int y0, int x1, int y1, int color);
void LCDSetCircle(int x0, int y0, int radius, int color);
void drawX(int x,int y);
void drawCircle(int x,int y);
void drawFigure(int x,int y,char sign);

int main(){

	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście

	int row,column; //deklaracja zmiennych odpowiedzialnych za to w którym wierzu,kolumnie ma być wyświetlany znak X lub O
	char sign; //zmienna określająca jaki wprowadziliśmy znak
	initLCD(); //inicjalizacja wyświetlacza LCD
	LCDSettings();
	LCDClearScreen(); //wyczyść ekran
	
	board(); //wywołanie funkcji odpowiedzialnej za narysowanie tablicy
		
	
	//w nieskończonej pętli while wywołujemy funkcję rysującą kółko lub krzyzyk
	//w funkcji tej nie ma zaimplementowanej logiki naszej gry ponieważ nie to było
	//celem laboratorium
	while(1){
		drawFigure(row,column,sign);
	}

}

//funkcja rysująca tablicę do gry na wyświetlaczu LCD
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




