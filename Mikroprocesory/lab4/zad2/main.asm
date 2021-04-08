
; Author : Mateusz Markowski
;

.org 0x000 ;;dyrektywa wymuszaj¹ca po³o¿enie nastêpuj¹cych po niej 
		;rozkazów od adresu 0x000
 jmp Reset  ;adres 0x000 jest wektorem przerwania inicjalizacyjnego
			; skok bezpoœredni do podprogramu Reset
.def temp = r16 ;przypisujemy rejestrowi roboczemu r16 nazwê symboliczn¹
.equ okres =2931 ;definiujemy sta³¹ okreœlaj¹c¹ czas trwania ca³ego cyklu
.equ onesecond =977 ;definijuemy sta³¹ okreœlaj¹c¹ czas trwania jednej sekundy

Reset:
	;pocz¹tek zadania 2
	cli ;wy³¹cz obs³ugê przerwañ
	ldi temp,HIGH(RAMEND)
	out SPH,r16
	ldi temp,LOW(RAMEND)
	out SPL,r16 ; inicjalizacja stosu
	
	sbi DDRD,5 ; ustawiamy liniê 5 PORTD w tryb wyjœciowy


	in temp,TCCR1A ;odczytujemy wartoœæ rejestru TCCR1A i zapisujemy j¹ do rejestru temp
	ori temp,(1<<COM1A1) |(1<<COM1B1) | (1<<WGM11) | (0<<WGM10) ;ustawiamy tryb fast PWM gdzie maksymaln¹ wartoœci¹ bêdzie wartoœæ rejestru ICR1A
																;bity COM1A1 oraz COM1B1 bêd¹ odpowiedzialne za wyzerowanie cyklu
																;i ponownego jego zliczania od pocz¹tku 
																;jednak nasz bit ustawi siê dopiero po osi¹gniêciu wartoœci odpowiadaj¹cej czasowi 
																;trwania 3 sekund wiêc przez pierwsze 3 sekundy nie stanie siê nic
	out TCCR1A,temp; zapisujemy wartoœæ rejestru temp do rejestru TCCR1A

	
	in temp,TCCR1B ;odczytujemy wartoœæ rejestru TCCR1B i zapisujemy j¹ do rejestru temp
	ori temp,(1<<WGM13)|(1<<WGM12)|(1<<CS12)|(1<<CS10) ;ustawaimy tryb fast PWM gdzie maksymaln¹ wartoœci¹ bêdzie wartosæ rejestru ICR1A
														;ustawiamy czêstotliwoœæ preskalera na 1024 przy czêstotliwoœci 1MHZ mikrokontrolera
														; w celu ustalenia preskalera na wartoœæ 1 nale¿y ustawiæ zamiast bitów CS12 i CS10 ustawiæ bit
														;1<<CS10
									;instrukcja ta powinna wyg³adaæ nastêpuj¹co
									; ori temp ,(1<<WGM13)| (1<<WGM12) |(1<<CS10)
	out TCCR1B,temp ;zapisujemy wartoœæ rejestru temp do rejestru TCCR1B


	ldi temp,HIGH(okres) ;w tym moemncie ³adujemy do rejstru ICR1A wartoœæ naszego okresu czyli 2931 czas trwania cyklu 3 sekundy
	out ICR1H,temp		;Timer 1 jest timerem 16 bitowym wiêæ musimy za³adowaæ t¹ wartoœæ do rejestru ICR1AH i ICR1AL
	ldi temp,LOW(okres)
	out ICR1L,temp 
	
	ldi temp,HIGH(onesecond) ; w tym momencie ³adujemy do rejestru OCR1A wartoœæ odpowiadaj¹c¹ czasowi trwania jednej sekundy
	out OCR1AH,temp			;korzystamy z Timera1 16 bitowego wiêc wartoœæ tego rejestru musimy za³adowaæ korzystaj¹c z rejestrów
	ldi temp,LOW(onesecond) ;OCR1AH i OCR1AL kiedy up³ynie czas trwania jednej sekundy dioda zgaœnie wynika to z dokmunetacji oraz z 
	out OCR1AL,temp ; dobranych przez nas bitów rejestru TCCR1A COM1A1 i COM1B1 
	

	sei ; odblokowujemy wystêpowanie przerwañ 
	jmp start

start:
			; pêtla g³owna programu która wykonuje siê w nieskoñczonoœæ
    rjmp start


