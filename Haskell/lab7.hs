fact n = case n of
                0->1
				_->n*fact(n-1)


sign x 
      | x<0 = -1
	  | x>0 = 1
	  | otherwise =0

sign2 x = case x of
           0->0
           _-> if x<0 then -1 else 1
porownajLiczby a b
                 | a-b>0 = GT
				 | a-b<0 = LT
				 | otherwise = EQ


mul1 a 1 = a
mul1 a b = a + mul1 a (b-1)

mul2 1 b = b
mul2 a b = b + mul2 (a-1) b

mul3 a 1 = a
mul3 1 b = b
mul3 a b 
        | a>0 && b>0 = a + mul3 a (b-1)
		| a<0 && b>0 = a + mul3 a (b-1)
		| a>0 && b<0 = b + mul3 (a-1) b
		| otherwise = error "Nie jestem w stanie obliczyć iloczynu liczb ujemnych"

silniaCase x = case x of
                      0->1
					  _-> x*silniaCase(x-1)

silniaWarunek x = if x==0 then wynik
                   else x*silniaWarunek(wynik2)
                    where
                    wynik = 1
                    wynik2 = x-1					

fib x 
     | x<0 = error "Liczba musi być dodatnia"
	 | x>=0 && x<=1 = 1
	 | otherwise = fib (x-1) + fib (x-2)


fibWarunek n = if n<1 then error "Liczba musi być większa od 1"
               else if n<3 then ograniczenie
			   else wynikKoncowy
			    where
				ograniczenie = 1
				wynikKoncowy = fibWarunek(n-1) + fibWarunek(n-2)
				
