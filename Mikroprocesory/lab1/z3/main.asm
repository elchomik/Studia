
; Author : Mateusz Markowski
;

Begin:
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu
	

	sbi DDRA,0; ustawienie linii 0 PORTA w tryb wyjœciowy
	sbi DDRA,1; ustawienie linii 1 PORTA w tryb wyjœciowy
	sbi DDRA,2; ustawienie linii 2 PORTA w tryb wyjœciowy



start:

		//ustawiamy dane pocz¹tkowe 
	cbi PORTA,0 ;wyzerowanie 0 bitu w rejestrze PORTA
	sbi PORTA,1 ;ustawienie 1 bitu w rejestrze PORTA
	cbi PORTA,2 ;wyzerowanie 2 bitu w rejestrze PORTA

	rcall delay250 ;wywo³anie funkcji obliczaj¹cej opóŸnienie 250ms

	rcall FunctionSetBit ;wywo³anie funkcji ustawiaj¹cej bity

	rcall delay250; wywo³anie pêtli obliczaj¹cej opóŸnienie 250ms
	rcall delay250; dwukrotnie wywo³ujemy t¹ funkcjê w celu uzyskania opóŸnienia 500ms


    rjmp start


	FunctionSetBit:
		cbi PORTA,1; wyzerowanie 1 bitu PORTA
					; nie zale¿nie od wartoœæi bitu PA3
					;zawsze bêdzie 0

		sbic PINA,3 // jeœli PA3=0 to pomijamy kolejn¹ instrukcjê
		rcall FunctionSet5PORTA; wywoa³aj funkcjê drug¹ ustawiaj¹c¹ na PORTA=0x05
		sbis PINA,3 ;jeœli PA3=1 to pomiñ kolejn¹ instrukcje
		rcall FunctionSet0PORTA; wywo³aj funkcjê SETPORTA0 ustawiaj¹ca na PORTA=0x00
		
		ret; powrót z funkcji

		FunctionSet0PORTA:
			cbi PORTA,0 ;wyzeruj bit 0 w PORTA
			cbi PORTA,2; wyzeruj bit 2 w PORTA
			ret; powrót z funkcji

		FunctionSet5PORTA:
			sbi PORTA,0 ;ustaw bit 0 w PORTA
			sbi PORTA,2; ustaw bit 2 w PORTA

			ret; powrót z funkcji

		

		
		ret ;//powrót z funkcji

		
			
		delay250:
			ldi r18,2; za³aduj wartoœc 2 do r18
			ldi r19,69; za³aduj wartoœæ 69 do r19
			ldi r20, 170; za³aduj wartoœæ 170 do r20

			Loop:
				dec r20; dekrementacja licznika r20
				brne Loop; jeœli ró¿ne od 0 skocz do Loop
				dec r19; dekrementacja licznika r19
				brne Loop; jeœli ró¿ne od 0 skocz do Loop
				dec r18; dekrementacja licznika r18
				brne Loop; jeœli ró¿ne od 0 skocz do Loop

				ret; powrót z funkcji