
; Author : Mateusz Markowski
;

.org 0x000 ;;dyrektywa wymuszaj�ca po�o�enie nast�puj�cych po niej 
		;rozkaz�w od adresu 0x000
 jmp Reset  ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpo�redni do podprogramu Reset
.def temp = r16 ;przypisujemy rejestrowi roboczemu r16 nazw� symboliczn�
.equ okres =2931 ;definiujemy sta�� okre�laj�c� czas trwania ca�ego cyklu
.equ onesecond =977 ;definijuemy sta�� okre�laj�c� czas trwania jednej sekundy

Reset:
	;pocz�tek zadania 2
	cli ;wy��cz obs�ug� przerwa�
	ldi temp,HIGH(RAMEND)
	out SPH,r16
	ldi temp,LOW(RAMEND)
	out SPL,r16 ; inicjalizacja stosu
	
	sbi DDRD,5 ; ustawiamy lini� 5 PORTD w tryb wyj�ciowy


	in temp,TCCR1A ;odczytujemy warto�� rejestru TCCR1A i zapisujemy j� do rejestru temp
	ori temp,(1<<COM1A1) |(1<<COM1B1) | (1<<WGM11) | (0<<WGM10) ;ustawiamy tryb fast PWM gdzie maksymaln� warto�ci� b�dzie warto�� rejestru ICR1A
																;bity COM1A1 oraz COM1B1 b�d� odpowiedzialne za wyzerowanie cyklu
																;i ponownego jego zliczania od pocz�tku 
																;jednak nasz bit ustawi si� dopiero po osi�gni�ciu warto�ci odpowiadaj�cej czasowi 
																;trwania 3 sekund wi�c przez pierwsze 3 sekundy nie stanie si� nic
	out TCCR1A,temp; zapisujemy warto�� rejestru temp do rejestru TCCR1A

	
	in temp,TCCR1B ;odczytujemy warto�� rejestru TCCR1B i zapisujemy j� do rejestru temp
	ori temp,(1<<WGM13)|(1<<WGM12)|(1<<CS12)|(1<<CS10) ;ustawaimy tryb fast PWM gdzie maksymaln� warto�ci� b�dzie wartos� rejestru ICR1A
														;ustawiamy cz�stotliwo�� preskalera na 1024 przy cz�stotliwo�ci 1MHZ mikrokontrolera
														; w celu ustalenia preskalera na warto�� 1 nale�y ustawi� zamiast bit�w CS12 i CS10 ustawi� bit
														;1<<CS10
									;instrukcja ta powinna wyg�ada� nast�puj�co
									; ori temp ,(1<<WGM13)| (1<<WGM12) |(1<<CS10)
	out TCCR1B,temp ;zapisujemy warto�� rejestru temp do rejestru TCCR1B


	ldi temp,HIGH(okres) ;w tym moemncie �adujemy do rejstru ICR1A warto�� naszego okresu czyli 2931 czas trwania cyklu 3 sekundy
	out ICR1H,temp		;Timer 1 jest timerem 16 bitowym wi�� musimy za�adowa� t� warto�� do rejestru ICR1AH i ICR1AL
	ldi temp,LOW(okres)
	out ICR1L,temp 
	
	ldi temp,HIGH(onesecond) ; w tym momencie �adujemy do rejestru OCR1A warto�� odpowiadaj�c� czasowi trwania jednej sekundy
	out OCR1AH,temp			;korzystamy z Timera1 16 bitowego wi�c warto�� tego rejestru musimy za�adowa� korzystaj�c z rejestr�w
	ldi temp,LOW(onesecond) ;OCR1AH i OCR1AL kiedy up�ynie czas trwania jednej sekundy dioda zga�nie wynika to z dokmunetacji oraz z 
	out OCR1AL,temp ; dobranych przez nas bit�w rejestru TCCR1A COM1A1 i COM1B1 
	

	sei ; odblokowujemy wyst�powanie przerwa� 
	jmp start

start:
			; p�tla g�owna programu kt�ra wykonuje si� w niesko�czono��
    rjmp start


