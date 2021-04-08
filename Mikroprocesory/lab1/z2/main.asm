
; Author : Mateusz Markowski
;

	ldi r16,HIGH(RAMEND)
	out SPH,r16;
	ldi r16,LOW(RAMEND)
	out SPL,r16; inicjalizacja stosu

	sbi DDRA,0; //ustawienie linii 0 PORTA w tryb wyj�ciowy
start:
	
		cbi PORTA,0 ;wyzerowanie bitu 0 w PORTA

		rcall Loop250; //wywo�anie p�tli odpowiadaj�cej za 250 milisekund przerwy

		sbi PORTA,0; ustawiamy bit 0 PORTA po up�ywie 250 milisekund

		rcall Loop250; //wywo�anie podwojne p�tli op�nienia 250 milisekund
		rcall Loop250; //��cznie da nam to czas 500ms i tym samym nie musimy pisa� dw�ch p�tli obliczaj�cych op�nienia


  
    rjmp start ;koniec p�tli g�ownej programu

	Loop250:
			ldi r17,2 ;za�adowanie warto�ci 2 do rejestru r17
			ldi r18,69 ;za�adowanie warto�ci 69 do rejestru r18
			ldi r19,170 ;za�adowanie warto�ci 170 do rejestru r19
		Loop:
			dec r19; dekrementacja licznika p�tli odpowiadaj�cego za r19
			brne Loop; je�li wynik operacji r�ny od 0 skocz do Loop
			dec r18; dekrementacja licznika p�tli odpowiadaj�cego za r18
			brne Loop; je�li wynik operacji r�ny od 0 skocz do Loop
			dec r17; dekrementacja licznika p�tli odpowiadaj�cego za r17
			brne Loop; je�li wynik operacji r�ny od 0 skocz do Loop

			ret ;powr�t z p�tli
