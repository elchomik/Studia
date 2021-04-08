
start:
    ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ; inicjalizacja stosu

	ldi r16,0x07 ; za³adowanie r16 wartoœci¹ 0x07
	out DDRA,r16 ;ustawienie PORTA jak wyjœcie
	
	ldi r16,0x05 ;za³adowanie r16 wartoœci¹ 0x05
	out PORTA,r16 ;wyœwietl r16

	call delay250 ;wywoa³anie delay250

	ldi r18,0x08 ;za³aduj sta³¹ z któr¹ wykonasz iloczyn logiczny
	in r16,PINA ;przepisujemy wartoœæ PINA do rejestru
	and r16,r18 ;iloczyn logiczny
	brne nie_ustawiony ;skocz do instrukcji jeœli iloczyn bitów rózny od 0



	ldi r16,0x07 ; za³aduj 7 do r16
	out PORTA,r16 ;wyœwietl r16 na PORTA

	call delay500 ; wywo³aj procedure opóŸnienia o 500
	
	jmp start ;powrót na pocz¹tek programu
	
	nie_ustawiony:
		ldi r16,0x02 ; za³aduj wartoœæ 2 do r16
		out PORTA,r16 ;wyœwietl na porcie

		call delay500 ;wywo³aj opóŸnienie

		ret start ; powrót z procedury

	delay250:
		ldi r17,2 ; za³aduj 2 do r17
		ldi r18,69 ;za³aduj 69 do r18
		ldi r19,170; za³aduj 170 do r19
	Loop1:
		dec r19 ;dekrementacja licznika pêtli
		brne Loop1 ;jeœli r19!=0 powrót do Loop1
		dec r18 ;dekrementacja licznika pêtli
		brne Loop1 ;jeœli r18!=0 powrót do Loop1
		dec r17 ;dekrementacja licznika
		brne Loop1 ;jeœli r17!=0 powrót do Loop1
		rjmp PC+1
		ret		;powrót z procedury

	delay500:
		ldi r17,3 ;zal¹duj 3 do r17
		ldi r18,138 ;za³aduj 138 do r18
		ldi r19,86 ;za³aduj 86 do r19 
	Loop2:
		dec r19 ;dekrementacja licznika pêtli 
		brne Loop2; skocz na pocz¹tek jeœli rózne od 0
		dec r18;dekrementacja licznika pêtli 
		brne Loop2 ;skocz na pocz¹tek jeœli rózne od 0
		dec r17;dekrementacja licznika pêtli 
		brne Loop2; skocz na pocz¹tek jeœli rózne od 0
		rjmp PC+1
		ret
