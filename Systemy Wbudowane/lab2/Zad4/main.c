#include <targets/AT91SAM7.h>
#include <lcd.h>
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD

void LCDSetRect(int x0,int y0,int x1,int y1,unsigned char fill,int color); //dodanie nagłówka funkcji LCDSetRect

int main(){
       
        PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 20
	PIOB_SODR|=LCD_BACKLIGHT;	//ustawienie 1 na wyjście

      InitLCD(); //ustawienie wyświetlacza
      LCDSettings();
      LCDClearScreen();
      
  while(1){
        LCDWrite130x130bmp(); //wywołanie funkcji odpowiedzialnej za wyświetlenie pliku bmp
		LCDSetRect(20,50,40,120,FILL,WHITE); //wywołanie funkcji odpowiedzialnej za narysowanie prostokątku na wyświetlaczu LCD
		LCDPutStr("Hello!",24,52,SMALL,BLACK,WHITE); //wywołanie funkcji odpowiedzialnej za wypisanie tekstu
} 


}

//zdefiniowanie funkcji odpowiadającej za wyświetlenie na wyświetlaczu prostokąta
//jest to funkcja, która jest zaimplementowana w tutorialu LCD NOKII
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