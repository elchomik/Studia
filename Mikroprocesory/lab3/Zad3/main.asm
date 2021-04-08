
.org 0 ;

jmp Reset ;
jmp EXT_INT0 ;

Reset:
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ; inicjalizujemy stos

	sei ;umo¿liwiamy obs³ugê przerwañ
	
	cbi DDRA,2 ; ustawienie linii 2 PORTD w tryb wejœcia

	in r17,MCUCR ; czytamy wartosæ MCUCR do r17
	ori r17,1<<ISC00
	out MCUCR,r17 ;umo¿liwiamy przerwania jakiej kolwiek zmiany stanu logicznego

	in r17,GICR
	ori r17,1<<INT0 ;zezwolenie na przerwania INT0
	out GICR,r17
	clr r24 ;wyczyœæ rejestr licznika pêtli

start:
	

	ldi r16,0x07 ; za³adowanie r16 wartoœci¹ 0x07
	out DDRA,r16 ;ustawienie PORTA jak wyjœcie
	
	ldi r16,0x05 ;za³adowanie r16 wartoœci¹ 0x05
	out PORTA,r16 ;wyœwietl r16

	call delay200 ;wywoa³anie delay250

	
	ldi r16,0x02 ; za³aduj wartoœæ 2 do r16
	out PORTA,r16 ;wyœwietl r16 na PORTA

	call delay400 ; wywo³aj procedure opóŸnienia o 400
	
    rjmp start ; nieskoñczona pêtla
	

EXT_INT0:
	push r16
	in r16,SREG ;zapamieujemy wartosæ SREG z przed przerwania
	push r16 ;odk³adamy rejestr r16 na stos
	
	cli ;blokujemy wyst¹pienie innych przerwañ
	
	
	inc r24;licznik czêstotliwoœci wyst¹pieñ przerwañ
	sbrs r24,0 ;sprawdzamy czy bit ustawiony 1
	cbi PORTA,1 ;jeœli nie zerujemy
	sbrc r24,0 ;sprawdzamy czy bit nie ustawiony
	sbi PORTA,1 ;


	pop r16 
	out SREG,r16 ;przywracamy wartoœæ rejestru z przed przerwania
	pop r16 ;zdejmujemy rejestr ze stosu

	sei; odblokowanie prerwañ

	reti ;powrót z obs³ugi przerwania
	

	delay200:
		ldi r17,2 ; za³aduj 2 do r17
		ldi r18,4 ;za³aduj 4 do r18
		ldi r19,186; za³aduj 186 do r19
	Loop1:
		dec r19 ;dekrementacja licznika pêtli
		brne Loop1 ;jeœli r19!=0 powrót do Loop1
		dec r18 ;dekrementacja licznika pêtli
		brne Loop1 ;jeœli r18!=0 powrót do Loop1
		dec r17 ;dekrementacja licznika
		brne Loop1 ;jeœli r17!=0 powrót do Loop1
		rjmp PC+1
		ret		;powrót z procedury

	delay400:
		ldi r17,3 ;zal¹duj 3 do r17
		ldi r18,8 ;za³aduj 8 do r18
		ldi r19,119 ;za³aduj 119 do r19 
	Loop2:
		dec r19 ;dekrementacja licznika pêtli 
		brne Loop2; skocz na pocz¹tek jeœli rózne od 0
		dec r18;dekrementacja licznika pêtli 
		brne Loop2 ;skocz na pocz¹tek jeœli rózne od 0
		dec r17;dekrementacja licznika pêtli 
		brne Loop2; skocz na pocz¹tek jeœli rózne od 0
		rjmp PC+1
		ret