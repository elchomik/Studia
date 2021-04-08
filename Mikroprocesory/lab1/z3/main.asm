
; Author : Mateusz Markowski
;

Begin:
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu
	

	sbi DDRA,0; ustawienie linii 0 PORTA w tryb wyj�ciowy
	sbi DDRA,1; ustawienie linii 1 PORTA w tryb wyj�ciowy
	sbi DDRA,2; ustawienie linii 2 PORTA w tryb wyj�ciowy



start:

		//ustawiamy dane pocz�tkowe 
	cbi PORTA,0 ;wyzerowanie 0 bitu w rejestrze PORTA
	sbi PORTA,1 ;ustawienie 1 bitu w rejestrze PORTA
	cbi PORTA,2 ;wyzerowanie 2 bitu w rejestrze PORTA

	rcall delay250 ;wywo�anie funkcji obliczaj�cej op�nienie 250ms

	rcall FunctionSetBit ;wywo�anie funkcji ustawiaj�cej bity

	rcall delay250; wywo�anie p�tli obliczaj�cej op�nienie 250ms
	rcall delay250; dwukrotnie wywo�ujemy t� funkcj� w celu uzyskania op�nienia 500ms


    rjmp start


	FunctionSetBit:
		cbi PORTA,1; wyzerowanie 1 bitu PORTA
					; nie zale�nie od warto��i bitu PA3
					;zawsze b�dzie 0

		sbic PINA,3 // je�li PA3=0 to pomijamy kolejn� instrukcj�
		rcall FunctionSet5PORTA; wywoa�aj funkcj� drug� ustawiaj�c� na PORTA=0x05
		sbis PINA,3 ;je�li PA3=1 to pomi� kolejn� instrukcje
		rcall FunctionSet0PORTA; wywo�aj funkcj� SETPORTA0 ustawiaj�ca na PORTA=0x00
		
		ret; powr�t z funkcji

		FunctionSet0PORTA:
			cbi PORTA,0 ;wyzeruj bit 0 w PORTA
			cbi PORTA,2; wyzeruj bit 2 w PORTA
			ret; powr�t z funkcji

		FunctionSet5PORTA:
			sbi PORTA,0 ;ustaw bit 0 w PORTA
			sbi PORTA,2; ustaw bit 2 w PORTA

			ret; powr�t z funkcji

		

		
		ret ;//powr�t z funkcji

		
			
		delay250:
			ldi r18,2; za�aduj warto�c 2 do r18
			ldi r19,69; za�aduj warto�� 69 do r19
			ldi r20, 170; za�aduj warto�� 170 do r20

			Loop:
				dec r20; dekrementacja licznika r20
				brne Loop; je�li r�ne od 0 skocz do Loop
				dec r19; dekrementacja licznika r19
				brne Loop; je�li r�ne od 0 skocz do Loop
				dec r18; dekrementacja licznika r18
				brne Loop; je�li r�ne od 0 skocz do Loop

				ret; powr�t z funkcji