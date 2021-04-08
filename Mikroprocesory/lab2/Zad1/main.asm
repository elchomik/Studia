
start:
    ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ; inicjalizacja stosu

	ldi r16,0x07 ; za�adowanie r16 warto�ci� 0x07
	out DDRA,r16 ;ustawienie PORTA jak wyj�cie
	
	ldi r16,0x05 ;za�adowanie r16 warto�ci� 0x05
	out PORTA,r16 ;wy�wietl r16

	call delay250 ;wywoa�anie delay250

	ldi r18,0x08 ;za�aduj sta�� z kt�r� wykonasz iloczyn logiczny
	in r16,PINA ;przepisujemy warto�� PINA do rejestru
	and r16,r18 ;iloczyn logiczny
	brne nie_ustawiony ;skocz do instrukcji je�li iloczyn bit�w r�zny od 0



	ldi r16,0x07 ; za�aduj 7 do r16
	out PORTA,r16 ;wy�wietl r16 na PORTA

	call delay500 ; wywo�aj procedure op�nienia o 500
	
	jmp start ;powr�t na pocz�tek programu
	
	nie_ustawiony:
		ldi r16,0x02 ; za�aduj warto�� 2 do r16
		out PORTA,r16 ;wy�wietl na porcie

		call delay500 ;wywo�aj op�nienie

		ret start ; powr�t z procedury

	delay250:
		ldi r17,2 ; za�aduj 2 do r17
		ldi r18,69 ;za�aduj 69 do r18
		ldi r19,170; za�aduj 170 do r19
	Loop1:
		dec r19 ;dekrementacja licznika p�tli
		brne Loop1 ;je�li r19!=0 powr�t do Loop1
		dec r18 ;dekrementacja licznika p�tli
		brne Loop1 ;je�li r18!=0 powr�t do Loop1
		dec r17 ;dekrementacja licznika
		brne Loop1 ;je�li r17!=0 powr�t do Loop1
		rjmp PC+1
		ret		;powr�t z procedury

	delay500:
		ldi r17,3 ;zal�duj 3 do r17
		ldi r18,138 ;za�aduj 138 do r18
		ldi r19,86 ;za�aduj 86 do r19 
	Loop2:
		dec r19 ;dekrementacja licznika p�tli 
		brne Loop2; skocz na pocz�tek je�li r�zne od 0
		dec r18;dekrementacja licznika p�tli 
		brne Loop2 ;skocz na pocz�tek je�li r�zne od 0
		dec r17;dekrementacja licznika p�tli 
		brne Loop2; skocz na pocz�tek je�li r�zne od 0
		rjmp PC+1
		ret
