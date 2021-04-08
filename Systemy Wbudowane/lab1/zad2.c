#include <targets/AT91SAM7.h> //dodanie biblioteki
#define LCD_BACKLIGHT PIOB_SODR_P20 //definicja podświetlenia LCD
#define IN_PUSH_BUTTON PIOB_SODR_P24 //definicja przycisku odpowiadającego za włączanie wyświetlacza
#define OUT_PUSH_BUTTON PIOB_SODR_P25 //definicja przycisku odpowiadającego za wyłączanie wyświetlacza

int main(){
	
	PMC_PCER=PMC_PCER_PIOB; //włączenie portu B
	PIOB_OER=LCD_BACKLIGHT; //ustawienie pinu 20 w stan wyjścia
	PIOB_PER=LCD_BACKLIGHT ;//włączenie pinu 


	while(1){  //nieskończona pętla w której odczytujemy stan aktualnie wciśniętego przyscisku
	
		//sprawdzanie stanu linii za pomocą rejestru PIOB_PDSR
		//sprawdzamy wykorzystując iloczyn logiczny czy wciśnięto
		//klawisz IN_PUSH_BUTTON czyli w tym przypadku 
		//jest to klawisz odpowiedzialny za podświetlenie LCD
		//stan 0 klawisz wciśnięty stan 1 klawisz nie jest wciśnięty
		if((PIOB_PDSR & IN_PUSH_BUTTON) == 0){ 
			PIOB_SODR|=LCD_BACKLIGHT; // włączenie podświetlania wyświetlacza
		}
		
		//sprawdzenie stanu linii za pomocą rejestru PIOB_PDSR
		//oraz wykorzystując iloczyn logiczny czy wciśniętego
		//klawisz OUT_PUSH_BUTTON czyli klawisz odpowiedzialny
		//za wyłączenie wyświetlacza
		//stan 0 klawisz wciśnięty stan 1 klawisz nie jest wciśnięty
		if((PIOB_PDSR & OUT_PUSH_BUTTON)== 0){
			PIOB_CODR|=LCD_BACKLIGHT; //wyłączenie podświetlania wyświetlacza
		}
		
	}
}