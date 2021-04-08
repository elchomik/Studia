
.org 0 ;

jmp Reset ;
jmp EXT_INT0 ;

Reset:
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ; inicjalizujemy stos

	sei ;umo�liwiamy obs�ug� przerwa�
	
	cbi DDRA,2 ; ustawienie linii 2 PORTD w tryb wej�cia

	in r17,MCUCR ; czytamy wartos� MCUCR do r17
	ori r17,1<<ISC00
	out MCUCR,r17 ;umo�liwiamy przerwania jakiej kolwiek zmiany stanu logicznego

	in r17,GICR
	ori r17,1<<INT0 ;zezwolenie na przerwania INT0
	out GICR,r17
	clr r24 ;wyczy�� rejestr licznika p�tli

start:
	

	ldi r16,0x07 ; za�adowanie r16 warto�ci� 0x07
	out DDRA,r16 ;ustawienie PORTA jak wyj�cie
	
	ldi r16,0x05 ;za�adowanie r16 warto�ci� 0x05
	out PORTA,r16 ;wy�wietl r16

	call delay200 ;wywoa�anie delay250

	
	ldi r16,0x02 ; za�aduj warto�� 2 do r16
	out PORTA,r16 ;wy�wietl r16 na PORTA

	call delay400 ; wywo�aj procedure op�nienia o 400
	
    rjmp start ; niesko�czona p�tla
	

EXT_INT0:
	push r16
	in r16,SREG ;zapamieujemy wartos� SREG z przed przerwania
	push r16 ;odk�adamy rejestr r16 na stos
	
	cli ;blokujemy wyst�pienie innych przerwa�
	
	
	inc r24;licznik cz�stotliwo�ci wyst�pie� przerwa�
	sbrs r24,0 ;sprawdzamy czy bit ustawiony 1
	cbi PORTA,1 ;je�li nie zerujemy
	sbrc r24,0 ;sprawdzamy czy bit nie ustawiony
	sbi PORTA,1 ;


	pop r16 
	out SREG,r16 ;przywracamy warto�� rejestru z przed przerwania
	pop r16 ;zdejmujemy rejestr ze stosu

	sei; odblokowanie prerwa�

	reti ;powr�t z obs�ugi przerwania
	

	delay200:
		ldi r17,2 ; za�aduj 2 do r17
		ldi r18,4 ;za�aduj 4 do r18
		ldi r19,186; za�aduj 186 do r19
	Loop1:
		dec r19 ;dekrementacja licznika p�tli
		brne Loop1 ;je�li r19!=0 powr�t do Loop1
		dec r18 ;dekrementacja licznika p�tli
		brne Loop1 ;je�li r18!=0 powr�t do Loop1
		dec r17 ;dekrementacja licznika
		brne Loop1 ;je�li r17!=0 powr�t do Loop1
		rjmp PC+1
		ret		;powr�t z procedury

	delay400:
		ldi r17,3 ;zal�duj 3 do r17
		ldi r18,8 ;za�aduj 8 do r18
		ldi r19,119 ;za�aduj 119 do r19 
	Loop2:
		dec r19 ;dekrementacja licznika p�tli 
		brne Loop2; skocz na pocz�tek je�li r�zne od 0
		dec r18;dekrementacja licznika p�tli 
		brne Loop2 ;skocz na pocz�tek je�li r�zne od 0
		dec r17;dekrementacja licznika p�tli 
		brne Loop2; skocz na pocz�tek je�li r�zne od 0
		rjmp PC+1
		ret