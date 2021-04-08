

; Replace with your application code
start:
    
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu

	ldi r16,0xff ; �adujemy sta�a do rejestru r16
	out DDRB,r16 ;ustawiamy PORTB w trybie wyj�ciowym
	out DDRA,r16 ;ustawiamy PORTA w tryb wej�ciowy

	ldi r18,0x01; deklaracja sta�ej pozwalaj�ca sprawdzi� czy ustawiony jest bit 0

	in r17,PINB ;odczytujemy warto�� PINB
	and r17,r18 ;wykonujemy iloczyn logiczny na obu rejestrach 
	breq not_set ;je�li iloczyn logiczny r�ny od zero przechodzimy do instrukcji not_set
	brne rowne ;skaczemy je�li 

	not_set:
		ldi r19,0xF0 ;�adujemy do rejestru warto�� 0xF0
		com r17 ;uzupe�nienie jedynkowe
		eor r17,r19 ;korzystamy z instrukcji exclusive or
		out PORTA,r17
		rjmp PC+1
		ret

	rowne:
		ldi r19,0x0f ;�adujemy do rejestru warto�� 0x0f
		com r17 ;uzupe�nienie jedynkowe
		eor r17,r19; ;wykonujemy operacj� suma modulo 2 
		ldi r19,0xf0 ;�adujemy warto�� 0xf0 do rejestru r19 
		and r17,r19 ;wykonujemy iloczyn logiczny dzi�ki czemu zostaje nam wartos� na wyj�ciu 0xf0
		out PORTA,r17 
		rjmp PC+1
		ret
	
	
