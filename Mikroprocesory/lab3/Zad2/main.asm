
.org 0 ;dyrektwya wymuszaj�ca po�o�enie nast�puj�cych po
		;niej rozkaz�w poczynaj�c od adresu 0x000

jmp Reset ;bezpo�redni skok do instrukcji Reset

jmp exit0 ;adres 0x02 jest wektorem przerwania zewn�trznego INT0

jmp EXT_int1 ;adres 0x04 jest wektorem przerwania zewn�trznego INT1

;author Mateusz Markowski

Reset:
	cli ;wy��czenie obs�ugi przerwa�

	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu

	sei ;umo�liwienie na wykonywanie przerwa�

	cbi DDRD,2 ;ustawimy linie 2 portu jako wej�ciow� 
	cbi DDRD,3 ;ustawiamy linie 3 portu jako wej�ciow�

	sbi DDRA,0 ;ustawimy linie 0 jako wyj�ciow� w PORTA
	cbi PORTA,0 ;na pocz�tku programu linia jest w stanie niskim

	in r17,MCUCR ;czytamy warto�� rejestru MCUCR do r17
	ori r17,1<<ISC01 ;ustawienie sygna�u wyzwalaj�cego przerwanie  
	ori r17,1<<ISC10 ;ustawianie sygna�u wyzwalaj�cego przerwanie
	out MCUCR,r17

	in r17,GICR ;zapisanie do rejestru r17 warto�� z rejestru GICR
	ori r17,1<<INT0 ;zezwolenie na przerwania INT0
	ori r17,1<<INT1	;zezwolenie na przerwania INT1
	out GICR,r17 ;zapisanie warto�ci rejestru r17 w rejestrze GICR

start:
    
    rjmp start

exit0:
	push r16
	in r16,SREG ;zachowujemy zawarto�ci rejestru SREG z przed przerwania
	push r16 ;wrzu� na stos
	cli ;blokujmey wyst�pienia przerwa�

	sbi PORTA,0 ;ustawiamy linie Portu PA0=1

	sei ;odblokowujemy mo�liwo�� wyst�powania przerwa�
	pop r16 ;zdejmujemy adres ze stosu
	out SREG,r16	;zwracamy zawarto�� rejestru z przed przerwania
	pop r16
	reti

Ext_int1:
	push r16
	in r16,SREG ;zachowujemy zawarto�ci rejestru SREG z przed przerwania
	push r16 ;wrzucamy rejestr na stos
	cli ;blokujemy wyst�powanie przerwa�

	cbi PORTA,0 ;ustawiamy linie PORTU PA0=0
	
	sei ;wznawiamy mo�liwo�� obs�ugi przerwa�

	pop r16 ;zdejmujemy rejestr ze stosu
	out SREG,r16 ;zwracamy zawarto�� rejestru z przed przerwania
	pop r16
	reti
