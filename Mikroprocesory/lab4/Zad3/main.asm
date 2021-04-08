.org 0x000 ;dyrektywa wymuszaj¹ca po³o¿enie nastêpuj¹cych po niej 
		;rozkazów od adresu 0x000
jmp Reset ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpoœredni do podprogramu Reset
jmp Ext_int0; ; adres 0x002 jest wektorem przerwania zewnêtrznego INT0
			; skok bezpoœredni do podprogramu Ext_int0 
.def temp =r16 ; przypisujemy rejestrowi roboczemu r16 nazwê symboliczn¹
.equ okres =230 ;definiujemy sta³¹ okreœlaj¹c¹ czas trwania ca³ego cyklu
.equ one =30 ;definijuemy sta³¹ okreœlaj¹c¹ czas trwania jednej sekundy
Reset:
	
	cli ;wy³¹cz obs³ugê przerwañ
	ldi temp,HIGH(RAMEND)
	out SPH,temp
	ldi temp,LOW(RAMEND)
	out SPL,temp ; inicjalizacja stosu
	
	sbi DDRD,5 ; ustawiamy liniê 5 PORTD w tryb wyjœciowy
    cbi DDRD,2 ;ustawienie lini 2 PORTu D jako linii wejœciowej


	
	ldi temp,HIGH(okres) ;³adujemy do rejestru ICR1A wartoœæ odpowiadaj¹c¹ trwaniu 230 ms czyli jednego okresu
	out ICR1H,temp	;wykonujemy dok³adnie to samo co w zadaniu 2 zmieniaj¹c tylko czas generacji 1 i 0
	ldi temp,LOW(okres)
	out ICR1L,temp 
	
	ldi temp,HIGH(one) ; ³adujemy do rejestru OCR1AH wartoœæ trwania 30 ms
	out OCR1AH,temp		; wykonujemy dok³adnie to samo co w zadaniu 2 zmieniaj¹c tylk czas generacji 1 i 0
	ldi temp,LOW(one)
	out OCR1AL,temp


	in temp,MCUCR ;odczytujemy obecn¹ wartoœæ rejestru MCUCR do r17
    ori temp,1<<ISC01 ; ustawienie sygna³u wyzwalaj¹cego przerwanie zmiana stanu z 1->0 
    out MCUCR,temp ;zapisanie wartoœci r17 do rejestru MCUCR

    in temp,GICR ;odczytujemy obecn¹ wartoœæ rejestru GICR i zapisujemy j¹ do r17
    ori temp,1<<INT0 ;zezwolenie na przerwania od INT0
    out GICR,temp ;zapisanie wartoœci rejestru r17 do rejestru GICR

	in temp,TCCR1A ;odczytujemy wartoœæ rejestru TCCR1A i zapisujemy j¹ do rejestru temp
	ori temp,(1<<COM1A1) |(1<<COM1B1) | (1<<WGM11) | (0<<WGM10);ustawiamy tryb fast PWM gdzie maksymaln¹ wartoœci¹ bêdzie wartoœæ rejestru ICR1A
																;bity COM1A1 oraz COM1B1 bêd¹ odpowiedzialne za wyzerowanie cyklu
																;i ponownego jego zliczania od pocz¹tku 
																;jednak nasz bit ustawi siê dopiero po osi¹gniêciu wartoœci odpowiadaj¹cej czasowi 230 ms
	out TCCR1A,temp; zapisujemy wartoœæ rejestru temp do rejestru TCCR1A

	in temp,TCCR1B ;odczytujemy wartoœæ rejestru TCCR1B i zapisujemy j¹ do rejestru temp
	ldi temp,(1<<WGM13)|(1<<WGM12) |(1<<CS12)|(1<<CS10);ustawaimy tryb fast PWM gdzie maksymaln¹ wartoœci¹ bêdzie wartosæ rejestru ICR1A
														;ustawiamy czêstotliwoœæ preskalera na 1024 przy czêstotliwoœci 1MHZ mikrokontrolera
	out TCCR1B,temp;zapisujemy wartoœæ rejestru temp do rejestru TCCR1B

	

	sei ;odblokowujemy wystêpowanie przerwañ
	jmp start

start:
    
    rjmp start

Ext_int0:
    cli   ;blokujemy mo¿liwoœæ pojawienia siê przerwañ w przerwaniu
    push temp ; wrzucamy rejestr temp na stos
    in temp,SREG ;zapisujemy wartoœæ SREG w rejestrze temp
    push temp ;wrzucamy rejestr temp na stos

	
	in XL,OCR1AL ;zapisujemy wartoœæ OCR1AL i OCR1AH w parze rejestrów 16 bitowych
	in XH,OCR1AH

	sbiw XH:XL,10 ;odejmowanie 10 od wartoœci zapisanej w parze rejestrów XH:XL

	mov YH,XH ;przenosimy  wartoœæ z odejmowania do pary rejestrów YH:YL 
	mov YL,XL
		
	sbiw XH:XL,10 ;odejmujemy 10 od wartoœci zapisanej w parze rejestrów XH:XL
					;to odejmowanie wykonujemy w celu sprawdzenia czy mamy wartoœæ
	breq zero ;jeœli wartoœæ równa zero to pomijamy  poni¿sze instrukcje 
				;bo wiemy ¿e nasza wartoœæ w rejestrze wynosi 10 wiêc nie zmieniamy 
	
	in temp,TCCR1B ;odczytujemy aktualn¹ wartoœæ rejestru TCCR1B
	andi temp,0xe0 ;zatrzymujemy zegar 
	out TCCR1B,temp

	in temp,TCCR1A
	andi temp,0xfc
	out TCCR1A,temp

	
	out OCR1AH,YH
	out OCR1AL,YL ; aktualizacja rejestru OCR1A tzn zmieniamy wartoœæ z 30 na 20ms lub z 20 ms na 10 ms

	in temp,TCCR1A ; odczytujemy aktalny stan rejestru TCCR1A
	ori temp,(1<<WGM11) | (0<<WGM10) ;ustawaimy tryb fast pwn z OCR1A jak robiliœmy to wczeœniej
	out TCCR1A,temp ;przepisujemy wartoœæ rejestru temp do TCCR1A

	in temp,TCCR1B ;odczytujemy aktualny stan rejestru TCCR1B
	ori temp,(1<<WGM13)|(1<<WGM12) |(1<<CS12)|(1<<CS10) ;ustawiamy stan pwm za pomoc¹ bitów WGM oraz preskaler na czêstotliwosæ 1024 za pomoc¹ bitów CS
	out TCCR1B,temp; zapisujemy wartoœæ temp w TCCR1B
	
	zero: ;jeœli wartoœæ równa zero powiniemy pow¿ysze instrukcje przez co nasz czas nie bêdzie siê ju¿ zmieniaæ
  
    pop temp ;zdejmujemy rejestr temp ze stosu
    out SREG,temp ;zapisujemy wartoœæ temp w rejestrze SREG
    pop temp ;zdejmujemy rejestr temp ze stosu

reti ;powrót do pêtli g³ównej programu nie musimy odblokowywaæ przerwañ instrukcj¹
		;sei zapewni nam to instrukcja reti