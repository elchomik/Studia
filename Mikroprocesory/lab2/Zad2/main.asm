



start:
  

  ldi r16,HIGH(RAMEND)
  out SPH,r16
  ldi r16,LOW(RAMEND)
  out SPL,r16 ; inicjalizacja stosu

  ldi r16,0xff ;³adujemy 1 do r16
  out DDRA,r16 ; ustawiamy wszystkie bity w  r16
 
  ldi r16,0x01 ; ³adujemy 1 do r16
  ldi r17,8 ;ustawiamy licznik pêtli
 
  Loop:
		call delay49
		lsl r16 ; przesuwamy 1 w lewo
		out PORTA,r16 ;wyœwietlenie
		dec r17 ;dekrementujemy licznik
		brne Loop;
		ret

	delay49:
		ldi r18,7
		ldi r19,91
		Loop2:
			dec r19; dekrementacja licznika
			brne Loop2; skocz do Loop jeœli r20!=0
			dec r18 ;dekrementacja licznika
			brne Loop2;skocz do Loop jeœli r19!=0
			rjmp PC+1
			ret ;powrót z pêtli
		

 
  
  
  
  
  

  


	

		
	
			

	
