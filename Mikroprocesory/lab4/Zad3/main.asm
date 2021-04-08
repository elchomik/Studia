.org 0x000 ;dyrektywa wymuszaj�ca po�o�enie nast�puj�cych po niej 
		;rozkaz�w od adresu 0x000
jmp Reset ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpo�redni do podprogramu Reset
jmp Ext_int0; ; adres 0x002 jest wektorem przerwania zewn�trznego INT0
			; skok bezpo�redni do podprogramu Ext_int0 
.def temp =r16 ; przypisujemy rejestrowi roboczemu r16 nazw� symboliczn�
.equ okres =230 ;definiujemy sta�� okre�laj�c� czas trwania ca�ego cyklu
.equ one =30 ;definijuemy sta�� okre�laj�c� czas trwania jednej sekundy
Reset:
	
	cli ;wy��cz obs�ug� przerwa�
	ldi temp,HIGH(RAMEND)
	out SPH,temp
	ldi temp,LOW(RAMEND)
	out SPL,temp ; inicjalizacja stosu
	
	sbi DDRD,5 ; ustawiamy lini� 5 PORTD w tryb wyj�ciowy
    cbi DDRD,2 ;ustawienie lini 2 PORTu D jako linii wej�ciowej


	
	ldi temp,HIGH(okres) ;�adujemy do rejestru ICR1A warto�� odpowiadaj�c� trwaniu 230 ms czyli jednego okresu
	out ICR1H,temp	;wykonujemy dok�adnie to samo co w zadaniu 2 zmieniaj�c tylko czas generacji 1 i 0
	ldi temp,LOW(okres)
	out ICR1L,temp 
	
	ldi temp,HIGH(one) ; �adujemy do rejestru OCR1AH warto�� trwania 30 ms
	out OCR1AH,temp		; wykonujemy dok�adnie to samo co w zadaniu 2 zmieniaj�c tylk czas generacji 1 i 0
	ldi temp,LOW(one)
	out OCR1AL,temp


	in temp,MCUCR ;odczytujemy obecn� warto�� rejestru MCUCR do r17
    ori temp,1<<ISC01 ; ustawienie sygna�u wyzwalaj�cego przerwanie zmiana stanu z 1->0 
    out MCUCR,temp ;zapisanie warto�ci r17 do rejestru MCUCR

    in temp,GICR ;odczytujemy obecn� warto�� rejestru GICR i zapisujemy j� do r17
    ori temp,1<<INT0 ;zezwolenie na przerwania od INT0
    out GICR,temp ;zapisanie warto�ci rejestru r17 do rejestru GICR

	in temp,TCCR1A ;odczytujemy warto�� rejestru TCCR1A i zapisujemy j� do rejestru temp
	ori temp,(1<<COM1A1) |(1<<COM1B1) | (1<<WGM11) | (0<<WGM10);ustawiamy tryb fast PWM gdzie maksymaln� warto�ci� b�dzie warto�� rejestru ICR1A
																;bity COM1A1 oraz COM1B1 b�d� odpowiedzialne za wyzerowanie cyklu
																;i ponownego jego zliczania od pocz�tku 
																;jednak nasz bit ustawi si� dopiero po osi�gni�ciu warto�ci odpowiadaj�cej czasowi 230 ms
	out TCCR1A,temp; zapisujemy warto�� rejestru temp do rejestru TCCR1A

	in temp,TCCR1B ;odczytujemy warto�� rejestru TCCR1B i zapisujemy j� do rejestru temp
	ldi temp,(1<<WGM13)|(1<<WGM12) |(1<<CS12)|(1<<CS10);ustawaimy tryb fast PWM gdzie maksymaln� warto�ci� b�dzie wartos� rejestru ICR1A
														;ustawiamy cz�stotliwo�� preskalera na 1024 przy cz�stotliwo�ci 1MHZ mikrokontrolera
	out TCCR1B,temp;zapisujemy warto�� rejestru temp do rejestru TCCR1B

	

	sei ;odblokowujemy wyst�powanie przerwa�
	jmp start

start:
    
    rjmp start

Ext_int0:
    cli   ;blokujemy mo�liwo�� pojawienia si� przerwa� w przerwaniu
    push temp ; wrzucamy rejestr temp na stos
    in temp,SREG ;zapisujemy warto�� SREG w rejestrze temp
    push temp ;wrzucamy rejestr temp na stos

	
	in XL,OCR1AL ;zapisujemy warto�� OCR1AL i OCR1AH w parze rejestr�w 16 bitowych
	in XH,OCR1AH

	sbiw XH:XL,10 ;odejmowanie 10 od warto�ci zapisanej w parze rejestr�w XH:XL

	mov YH,XH ;przenosimy  warto�� z odejmowania do pary rejestr�w YH:YL 
	mov YL,XL
		
	sbiw XH:XL,10 ;odejmujemy 10 od warto�ci zapisanej w parze rejestr�w XH:XL
					;to odejmowanie wykonujemy w celu sprawdzenia czy mamy warto��
	breq zero ;je�li warto�� r�wna zero to pomijamy  poni�sze instrukcje 
				;bo wiemy �e nasza warto�� w rejestrze wynosi 10 wi�c nie zmieniamy 
	
	in temp,TCCR1B ;odczytujemy aktualn� warto�� rejestru TCCR1B
	andi temp,0xe0 ;zatrzymujemy zegar 
	out TCCR1B,temp

	in temp,TCCR1A
	andi temp,0xfc
	out TCCR1A,temp

	
	out OCR1AH,YH
	out OCR1AL,YL ; aktualizacja rejestru OCR1A tzn zmieniamy warto�� z 30 na 20ms lub z 20 ms na 10 ms

	in temp,TCCR1A ; odczytujemy aktalny stan rejestru TCCR1A
	ori temp,(1<<WGM11) | (0<<WGM10) ;ustawaimy tryb fast pwn z OCR1A jak robili�my to wcze�niej
	out TCCR1A,temp ;przepisujemy warto�� rejestru temp do TCCR1A

	in temp,TCCR1B ;odczytujemy aktualny stan rejestru TCCR1B
	ori temp,(1<<WGM13)|(1<<WGM12) |(1<<CS12)|(1<<CS10) ;ustawiamy stan pwm za pomoc� bit�w WGM oraz preskaler na cz�stotliwos� 1024 za pomoc� bit�w CS
	out TCCR1B,temp; zapisujemy warto�� temp w TCCR1B
	
	zero: ;je�li warto�� r�wna zero powiniemy pow�ysze instrukcje przez co nasz czas nie b�dzie si� ju� zmienia�
  
    pop temp ;zdejmujemy rejestr temp ze stosu
    out SREG,temp ;zapisujemy warto�� temp w rejestrze SREG
    pop temp ;zdejmujemy rejestr temp ze stosu

reti ;powr�t do p�tli g��wnej programu nie musimy odblokowywa� przerwa� instrukcj�
		;sei zapewni nam to instrukcja reti