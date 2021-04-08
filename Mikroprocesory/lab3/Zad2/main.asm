
.org 0 ;dyrektwya wymuszaj¹ca po³o¿enie nastêpuj¹cych po
		;niej rozkazów poczynaj¹c od adresu 0x000

jmp Reset ;bezpoœredni skok do instrukcji Reset

jmp exit0 ;adres 0x02 jest wektorem przerwania zewnêtrznego INT0

jmp EXT_int1 ;adres 0x04 jest wektorem przerwania zewnêtrznego INT1

;author Mateusz Markowski

Reset:
	cli ;wy³¹czenie obs³ugi przerwañ

	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu

	sei ;umo¿liwienie na wykonywanie przerwañ

	cbi DDRD,2 ;ustawimy linie 2 portu jako wejœciow¹ 
	cbi DDRD,3 ;ustawiamy linie 3 portu jako wejœciow¹

	sbi DDRA,0 ;ustawimy linie 0 jako wyjœciow¹ w PORTA
	cbi PORTA,0 ;na pocz¹tku programu linia jest w stanie niskim

	in r17,MCUCR ;czytamy wartoœæ rejestru MCUCR do r17
	ori r17,1<<ISC01 ;ustawienie sygna³u wyzwalaj¹cego przerwanie  
	ori r17,1<<ISC10 ;ustawianie sygna³u wyzwalaj¹cego przerwanie
	out MCUCR,r17

	in r17,GICR ;zapisanie do rejestru r17 wartoœæ z rejestru GICR
	ori r17,1<<INT0 ;zezwolenie na przerwania INT0
	ori r17,1<<INT1	;zezwolenie na przerwania INT1
	out GICR,r17 ;zapisanie wartoœci rejestru r17 w rejestrze GICR

start:
    
    rjmp start

exit0:
	push r16
	in r16,SREG ;zachowujemy zawartoœci rejestru SREG z przed przerwania
	push r16 ;wrzuæ na stos
	cli ;blokujmey wyst¹pienia przerwañ

	sbi PORTA,0 ;ustawiamy linie Portu PA0=1

	sei ;odblokowujemy mo¿liwoœæ wystêpowania przerwañ
	pop r16 ;zdejmujemy adres ze stosu
	out SREG,r16	;zwracamy zawartoœæ rejestru z przed przerwania
	pop r16
	reti

Ext_int1:
	push r16
	in r16,SREG ;zachowujemy zawartoœci rejestru SREG z przed przerwania
	push r16 ;wrzucamy rejestr na stos
	cli ;blokujemy wystêpowanie przerwañ

	cbi PORTA,0 ;ustawiamy linie PORTU PA0=0
	
	sei ;wznawiamy mo¿liwoœæ obs³ugi przerwañ

	pop r16 ;zdejmujemy rejestr ze stosu
	out SREG,r16 ;zwracamy zawartoœæ rejestru z przed przerwania
	pop r16
	reti
