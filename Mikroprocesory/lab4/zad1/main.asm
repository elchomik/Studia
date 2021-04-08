
; Author : Mateusz Markowski

.org 0x000 ;dyrektywa wymuszaj¹ca po³o¿enie nastêpuj¹cych po niej 
		;rozkazów od adresu 0x000

jmp Reset ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpoœredni do podprogramu Reset
jmp Ext_int0; adres 0x002 jest wektorem przerwania zewnêtrznego INT0
			; skok bezpoœredni do podprogramu Ext_int0 
.org $00E jmp Ext_timer1; adres $00E jest wektorem przerwania TIMER/COUNTER 1 COMPA
				;skok bezpoœredni do podprogramu 
.def temp =r16 ; przypisujemy rejestrowi roboczemu r16 nazwê symboliczn¹
Reset:
	cli ;blokuj wystêpowanie przerwañ
	
	ldi temp,HIGH(RAMEND)
	out SPH,temp
	ldi temp,LOW(RAMEND)
	out SPL,temp ;inicjalizacja stosu

	sei; odblokuj mo¿liwoœæ pojawienia siê przerwañ
	
	cbi DDRD,2 ;ustawienie lini 2 PORTu D jako linii wejœciowej

	ldi temp,0x01 ;ustawienie zerowego bitu w rejestrze r16 
	out DDRA,r16 ;ustawienie linii 0 jako wyjœcia PA0

	in temp,MCUCR ;odczytujemy obecn¹ wartoœæ rejestru MCUCR do r17
	ori temp,1<<ISC01 ; ustawienie sygna³u wyzwalaj¹cego przerwanie zmiana stanu z 1->0 
	out MCUCR,temp ;zapisanie wartoœci r17 do rejestru MCUCR

	in temp,GICR ;odczytujemy obecn¹ wartoœæ rejestru GICR i zapisujemy j¹ do r17
	ori temp,1<<INT0 ;zezwolenie na przerwania od INT0
	out GICR,temp ;zapisanie wartoœci rejestru r17 do rejestru GICR

	in temp,TIMSK ;odczytujemy obecn¹ wartoœæ rejestru TIMSK do rejestru temp
	ori temp,(1<<OCIE1A) ;w³¹czamy obs³ugê przerwania 
	out TIMSK,temp ; uaktywnienie przerwañ zgodnych z porównaniem

	  
	jmp start

start:
   
    rjmp start

Ext_int0:
	cli  ;uniemo¿liwiamy przerwnia 
	push temp ; wrzucamy rejestr na stos
	in temp,SREG ; zapisujemy wartoœæ rejestru SREG w rejestrze temp
	push temp ;wrzucamy rejestr na stos

	sbi PORTA,0 ;po zmianie stanu z 1->0 na PIN2 ustawaimy na wyjœciu PA01
	
	in temp,TCCR1B ;odczytujemy aktualny stan rejestru TCCR1B i zapisujemy go rejestrze temp
	ori temp,1<<WGM12 ;ustawiamy tryb CTC
	out TCCR1B,temp ;wpisujemy wartoœæ rejestru temp do rejestru TCCR1B

	in temp,TCCR1B ;odczytujemy wartoœæ rejestru TCCR1B do rejestru temp
	ori temp,(1<<CS12) |(1<<CS10) ;ustawiamy  czêstotliwoœæ preskalera na 1024
	out TCCR1B,temp ;wpisujemy wartoœæ rejestru temp do rejestru TCCR1B


	ldi temp,high(1465) ;³adujemy do rejestru OCR1AH wartoœæ 1465
	out OCR1AH,temp		;która odpowiada czasowi 1,5 sekundy
	ldi temp,low(1465) ;przy czêstotliwoœci preskalera 1024 oraz 
	out OCR1AL,temp		; czêstotliwoœci mikrokontrolera 1MHz

	
	pop temp ;zdejmujemy rejestr temp ze stosu
	out SREG,temp ;zapisujemy wartoœæ rejestru temp do rejestru SREG
	pop temp ;zdejmujemy rejestr ze stos
	
reti ;wracamy do pêtli g³ównej reti odblokowuje
	;stosowania przerwañ

Ext_timer1:
	cli ;blokujemy mo¿liwoœæ wyst¹pienia przerwañ
	push temp ;wrzucamy rejestr tymczasowy na stos
	in temp,SREG ;wpisujemy do rejestru temp wartoœæ rejestru SREG
	push temp ;wrzucamy rejestr temp na stod

	cbi PORTA,0 ;po up³yniêciu 1,5 s PORTA0=0
	
	in temp,TCCR1B ;czytamy wartoœæ rejestru TCCR1B
	andi temp,0xf8 ;dokonujemy wyzerowania 3 ostatni bitów
					;rejestru TCCR1B, które odpowiadaj¹ za zatrzymanie
					;zegara
	out TCCR1B,temp ;zapisujemy wartoœæ r17 do TCCR0 i zatrzymujemy timer

	pop temp ;zdejmujemy rejestr tymczasowy ze stosu
	out SREG,temp ;zapisujemy wartoœæ rejestru temp do rejestru SREG
	pop temp ;zdejmujemy rejestr tymczasowy ze stosu

	reti ;wracamy do pêtli g³ównej programu
		;instrukcja reti odblokowuje mo¿liwoœæ wystêpowania przerwañ
		; nie ma koniecznoœci u¿ywania instrukcji sei