
; Author : Mateusz Markowski
;

	ldi r16,HIGH(RAMEND)
	out SPH,r16;
	ldi r16,LOW(RAMEND)
	out SPL,r16; inicjalizacja stosu

	sbi DDRA,0; //ustawienie linii 0 PORTA w tryb wyjœciowy
start:
	
		cbi PORTA,0 ;wyzerowanie bitu 0 w PORTA

		rcall Loop250; //wywo³anie pêtli odpowiadaj¹cej za 250 milisekund przerwy

		sbi PORTA,0; ustawiamy bit 0 PORTA po up³ywie 250 milisekund

		rcall Loop250; //wywo³anie podwojne pêtli opóŸnienia 250 milisekund
		rcall Loop250; //³¹cznie da nam to czas 500ms i tym samym nie musimy pisaæ dwóch pêtli obliczaj¹cych opóŸnienia


  
    rjmp start ;koniec pêtli g³ownej programu

	Loop250:
			ldi r17,2 ;za³adowanie wartoœci 2 do rejestru r17
			ldi r18,69 ;za³adowanie wartoœci 69 do rejestru r18
			ldi r19,170 ;za³adowanie wartoœci 170 do rejestru r19
		Loop:
			dec r19; dekrementacja licznika pêtli odpowiadaj¹cego za r19
			brne Loop; jeœli wynik operacji ró¿ny od 0 skocz do Loop
			dec r18; dekrementacja licznika pêtli odpowiadaj¹cego za r18
			brne Loop; jeœli wynik operacji ró¿ny od 0 skocz do Loop
			dec r17; dekrementacja licznika pêtli odpowiadaj¹cego za r17
			brne Loop; jeœli wynik operacji ró¿ny od 0 skocz do Loop

			ret ;powrót z pêtli
