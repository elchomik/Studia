

; Replace with your application code
start:
    
	ldi r16,HIGH(RAMEND)
	out SPH,r16
	ldi r16,LOW(RAMEND)
	out SPL,r16 ;inicjalizacja stosu

	ldi r16,0xff ; ³adujemy sta³a do rejestru r16
	out DDRB,r16 ;ustawiamy PORTB w trybie wyjœciowym
	out DDRA,r16 ;ustawiamy PORTA w tryb wejœciowy

	ldi r18,0x01; deklaracja sta³ej pozwalaj¹ca sprawdziæ czy ustawiony jest bit 0

	in r17,PINB ;odczytujemy wartoœæ PINB
	and r17,r18 ;wykonujemy iloczyn logiczny na obu rejestrach 
	breq not_set ;jeœli iloczyn logiczny ró¿ny od zero przechodzimy do instrukcji not_set
	brne rowne ;skaczemy jeœli 

	not_set:
		ldi r19,0xF0 ;³adujemy do rejestru wartoœæ 0xF0
		com r17 ;uzupe³nienie jedynkowe
		eor r17,r19 ;korzystamy z instrukcji exclusive or
		out PORTA,r17
		rjmp PC+1
		ret

	rowne:
		ldi r19,0x0f ;³adujemy do rejestru wartoœæ 0x0f
		com r17 ;uzupe³nienie jedynkowe
		eor r17,r19; ;wykonujemy operacjê suma modulo 2 
		ldi r19,0xf0 ;³adujemy wartoœæ 0xf0 do rejestru r19 
		and r17,r19 ;wykonujemy iloczyn logiczny dziêki czemu zostaje nam wartosæ na wyjœciu 0xf0
		out PORTA,r17 
		rjmp PC+1
		ret
	
	
