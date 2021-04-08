
.org 0 ;dyrektywa wymuszaj¹ca aby stoj¹ce po niej rozkazy by³y po³o¿one od adresu 0x000

jmp Reset ;skocz do funkcji inicjaliuj¹cej w pamiêci zapisana jest pod adresem 0x000

jmp EXT_INT0 ;adres 0x02 jest  wektorem przerwania zewnêtrznego INT0
			;poprzednia instrukcja zamjumuje dwa s³owa dlatego wystêpuje tutaj przesuniêcie	
			;skok bezpoœredni do programu EXT_INT0 czyli do obs³ugi przerwania

; author Mateusz Markowski 

Reset:
		
		cli ; wy³¹czenie przerwañ

		ldi r16,HIGH(RAMEND)
		out SPH,r16
		ldi r16,LOW(RAMEND)
		out SPL,r16 ;inicjalizacja stosu
		
		sei ;odblokowujemy przerwania
		
		
		
		cbi DDRD,2 ;ustawienie linii 2 PORTu D PD2=0 jako wejœcie
		
		ser r16 ;ustawienie wszystkich bitów w rejestrze r16
		out DDRA,r16 ; ustawienie w trybie wyjœciowym PORTA
		out DDRB,r16  ;ustawienie PORTB w tryb wyjœciowy

		in r17,MCUCR ;czytamy wartoœæ MCUCR do r17 
		ori r17,1<<ISC01; ustawienie sygna³u wyzwalaj¹cego przerwanie
		out MCUCR,r17

		
		in r17,GICR
		ori r17,1<<INT0; zezwolenie na przerwanie od INT0
		out GICR,r17 
		
		ldi r16,0xf0 ;za³aduj do r16 wartoœæ 0xf0
		out PORTA,r16

		ldi r24,0 ;³adujemy wartoœæ 0 do r24
		ldi r23,-2 ;³adujemy wartoœæ 2 do r23
		
main:
		
		add r24,r23 ;wykonujemy dzia³anie dodawania

		cpi r24,0
		brge wieksze_rowne
		
		ldi r16,0b10101010
		out PORTB,r16
		
		opoznienie:

		call opoznienie ;wywo³anie 256 instrukcji nop

		rjmp main ;powrót do programu g³ównego

wieksze_rowne:
	ldi r16,0b01010101
	out PORTB,r16
	rjmp main 
EXT_INT0:
		push r17
		in r17,SREG ;zachowujemy zawartoœæ rejestr SREG z przed przerwania
		push r17; wrzucamy rejestr na stos
		cli; blokujmey przerwanie
		
		in r16,PORTA ;wczytujemy do rejestru r16 wartoœæ PORTA
		com r16 ;uzupe³nienie jedynkowe 
		out PORTA,r16 ;na wyjœcie PORTA przekazujemy wartoœæ zmienion¹ r16
		
		sei ; ponowne odblokowanie przerwañ
		
		pop r17 ;zdejmujemy rejestr ze stosu
		out SREG,r17 ;zwracamy zawartoœæ rejestru z przed przerwania
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