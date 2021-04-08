
; Author : Mateusz Markowski

.org 0x000 ;dyrektywa wymuszaj�ca po�o�enie nast�puj�cych po niej 
		;rozkaz�w od adresu 0x000

jmp Reset ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpo�redni do podprogramu Reset
jmp Ext_int0; adres 0x002 jest wektorem przerwania zewn�trznego INT0
			; skok bezpo�redni do podprogramu Ext_int0 
.org $00E jmp Ext_timer1; adres $00E jest wektorem przerwania TIMER/COUNTER 1 COMPA
				;skok bezpo�redni do podprogramu 
.def temp =r16 ; przypisujemy rejestrowi roboczemu r16 nazw� symboliczn�
Reset:
	cli ;blokuj wyst�powanie przerwa�
	
	ldi temp,HIGH(RAMEND)
	out SPH,temp
	ldi temp,LOW(RAMEND)
	out SPL,temp ;inicjalizacja stosu

	sei; odblokuj mo�liwo�� pojawienia si� przerwa�
	
	cbi DDRD,2 ;ustawienie lini 2 PORTu D jako linii wej�ciowej

	ldi temp,0x01 ;ustawienie zerowego bitu w rejestrze r16 
	out DDRA,r16 ;ustawienie linii 0 jako wyj�cia PA0

	in temp,MCUCR ;odczytujemy obecn� warto�� rejestru MCUCR do r17
	ori temp,1<<ISC01 ; ustawienie sygna�u wyzwalaj�cego przerwanie zmiana stanu z 1->0 
	out MCUCR,temp ;zapisanie warto�ci r17 do rejestru MCUCR

	in temp,GICR ;odczytujemy obecn� warto�� rejestru GICR i zapisujemy j� do r17
	ori temp,1<<INT0 ;zezwolenie na przerwania od INT0
	out GICR,temp ;zapisanie warto�ci rejestru r17 do rejestru GICR

	in temp,TIMSK ;odczytujemy obecn� warto�� rejestru TIMSK do rejestru temp
	ori temp,(1<<OCIE1A) ;w��czamy obs�ug� przerwania 
	out TIMSK,temp ; uaktywnienie przerwa� zgodnych z por�wnaniem

	  
	jmp start

start:
   
    rjmp start

Ext_int0:
	cli  ;uniemo�liwiamy przerwnia 
	push temp ; wrzucamy rejestr na stos
	in temp,SREG ; zapisujemy warto�� rejestru SREG w rejestrze temp
	push temp ;wrzucamy rejestr na stos

	sbi PORTA,0 ;po zmianie stanu z 1->0 na PIN2 ustawaimy na wyj�ciu PA01
	
	in temp,TCCR1B ;odczytujemy aktualny stan rejestru TCCR1B i zapisujemy go rejestrze temp
	ori temp,1<<WGM12 ;ustawiamy tryb CTC
	out TCCR1B,temp ;wpisujemy warto�� rejestru temp do rejestru TCCR1B

	in temp,TCCR1B ;odczytujemy warto�� rejestru TCCR1B do rejestru temp
	ori temp,(1<<CS12) |(1<<CS10) ;ustawiamy  cz�stotliwo�� preskalera na 1024
	out TCCR1B,temp ;wpisujemy warto�� rejestru temp do rejestru TCCR1B


	ldi temp,high(1465) ;�adujemy do rejestru OCR1AH warto�� 1465
	out OCR1AH,temp		;kt�ra odpowiada czasowi 1,5 sekundy
	ldi temp,low(1465) ;przy cz�stotliwo�ci preskalera 1024 oraz 
	out OCR1AL,temp		; cz�stotliwo�ci mikrokontrolera 1MHz

	
	pop temp ;zdejmujemy rejestr temp ze stosu
	out SREG,temp ;zapisujemy warto�� rejestru temp do rejestru SREG
	pop temp ;zdejmujemy rejestr ze stos
	
reti ;wracamy do p�tli g��wnej reti odblokowuje
	;stosowania przerwa�

Ext_timer1:
	cli ;blokujemy mo�liwo�� wyst�pienia przerwa�
	push temp ;wrzucamy rejestr tymczasowy na stos
	in temp,SREG ;wpisujemy do rejestru temp warto�� rejestru SREG
	push temp ;wrzucamy rejestr temp na stod

	cbi PORTA,0 ;po up�yni�ciu 1,5 s PORTA0=0
	
	in temp,TCCR1B ;czytamy warto�� rejestru TCCR1B
	andi temp,0xf8 ;dokonujemy wyzerowania 3 ostatni bit�w
					;rejestru TCCR1B, kt�re odpowiadaj� za zatrzymanie
					;zegara
	out TCCR1B,temp ;zapisujemy warto�� r17 do TCCR0 i zatrzymujemy timer

	pop temp ;zdejmujemy rejestr tymczasowy ze stosu
	out SREG,temp ;zapisujemy warto�� rejestru temp do rejestru SREG
	pop temp ;zdejmujemy rejestr tymczasowy ze stosu

	reti ;wracamy do p�tli g��wnej programu
		;instrukcja reti odblokowuje mo�liwo�� wyst�powania przerwa�
		; nie ma konieczno�ci u�ywania instrukcji sei