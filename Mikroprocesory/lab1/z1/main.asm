

; Author : Mateusz Markowski



		
	sbi DDRA,0; ustawienie linii 0 rejestru PORTA w tryb wyj�ciowy
	
	jmp start;

start:
	
	

	sbic PINA,1 ; je�li PINA1=0 to pomi� nast�pn� instrukcj� 
	cbi PORTA,0; zeruj 0 bit PORTA
	sbis PINA,1; je�li PINA1=1 to pomi� nast�pn� instrukcj�
	sbi PORTA,0 ;ustaw 0 bit PORTA

    rjmp start
