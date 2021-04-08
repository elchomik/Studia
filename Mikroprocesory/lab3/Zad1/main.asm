
.org 0 ;dyrektywa wymuszaj�ca aby stoj�ce po niej rozkazy by�y po�o�one od adresu 0x000

jmp Reset ;skocz do funkcji inicjaliuj�cej w pami�ci zapisana jest pod adresem 0x000

jmp EXT_INT0 ;adres 0x02 jest  wektorem przerwania zewn�trznego INT0
			;poprzednia instrukcja zamjumuje dwa s�owa dlatego wyst�puje tutaj przesuni�cie	
			;skok bezpo�redni do programu EXT_INT0 czyli do obs�ugi przerwania

; author Mateusz Markowski 

Reset:
		
		cli ; wy��czenie przerwa�

		ldi r16,HIGH(RAMEND)
		out SPH,r16
		ldi r16,LOW(RAMEND)
		out SPL,r16 ;inicjalizacja stosu
		
		sei ;odblokowujemy przerwania
		
		
		
		cbi DDRD,2 ;ustawienie linii 2 PORTu D PD2=0 jako wej�cie
		
		ser r16 ;ustawienie wszystkich bit�w w rejestrze r16
		out DDRA,r16 ; ustawienie w trybie wyj�ciowym PORTA
		out DDRB,r16  ;ustawienie PORTB w tryb wyj�ciowy

		in r17,MCUCR ;czytamy warto�� MCUCR do r17 
		ori r17,1<<ISC01; ustawienie sygna�u wyzwalaj�cego przerwanie
		out MCUCR,r17

		
		in r17,GICR
		ori r17,1<<INT0; zezwolenie na przerwanie od INT0
		out GICR,r17 
		
		ldi r16,0xf0 ;za�aduj do r16 warto�� 0xf0
		out PORTA,r16

		ldi r24,0 ;�adujemy warto�� 0 do r24
		ldi r23,-2 ;�adujemy warto�� 2 do r23
		
main:
		
		add r24,r23 ;wykonujemy dzia�anie dodawania

		cpi r24,0
		brge wieksze_rowne
		
		ldi r16,0b10101010
		out PORTB,r16
		
		opoznienie:

		call opoznienie ;wywo�anie 256 instrukcji nop

		rjmp main ;powr�t do programu g��wnego

wieksze_rowne:
	ldi r16,0b01010101
	out PORTB,r16
	rjmp main 
EXT_INT0:
		push r17
		in r17,SREG ;zachowujemy zawarto�� rejestr SREG z przed przerwania
		push r17; wrzucamy rejestr na stos
		cli; blokujmey przerwanie
		
		in r16,PORTA ;wczytujemy do rejestru r16 warto�� PORTA
		com r16 ;uzupe�nienie jedynkowe 
		out PORTA,r16 ;na wyj�cie PORTA przekazujemy warto�� zmienion� r16
		
		sei ; ponowne odblokowanie przerwa�
		
		pop r17 ;zdejmujemy rejestr ze stosu
		out SREG,r17 ;zwracamy zawarto�� rejestru z przed przerwania
		pop r17
		reti ;rozkaz powrotu z przerwania

opoznienie:
	cli ;blokujemy przerwania

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	nop
	nop
	nop
	nop
	nop
	nop
	nop 
	nop

	sei ;odblokowujemy przerwania

	ret 