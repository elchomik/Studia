

; Author : Mateusz Markowski



		
	sbi DDRA,0; ustawienie linii 0 rejestru PORTA w tryb wyjœciowy
	
	jmp start;

start:
	
	

	sbic PINA,1 ; jeœli PINA1=0 to pomiñ nastêpn¹ instrukcjê 
	cbi PORTA,0; zeruj 0 bit PORTA
	sbis PINA,1; jeœli PINA1=1 to pomiñ nastêpn¹ instrukcjê
	sbi PORTA,0 ;ustaw 0 bit PORTA

    rjmp start
