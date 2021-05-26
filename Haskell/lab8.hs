--polecenie1
iloczyn lista = foldr (*) 1 lista

--polecenie2

czyZnak znak = znak `elem` ['A'..'Z']

--polecenie 3 nie działa
usun lista lista2=filter (\e->[lista2])

--polecenie 4

trojkiPitagorejskie = [(a,b,c) | a<-[0..20], b<-[0..20],c<-[0..20],a*a+b*b==c*c]]

--polecenie 5

silniaParzyste n = map(\x->silnia x) (filter (parzysta)[1..n])
                   where
				   parzysta x = x `mod` 2 ==0 && x<=20
				   silnia w = case w of
				               0->1
							   _->w*silnia(w-1)

--polecenie 6a bez funkcji anonimowej

kwadratLiczb n = if n<=20 then map kwadrat [1..n]
                 else error "Zle dane"
				  where
				  kwadrat x = x*x

--polecenie 6b z funkcją anonimową

kwadratLiczb2 n = if n<=20 then map (\x->x*x)[1..n]
                  else error "Zle dane"

--polecenie 7 twórczość własna ale działa

najwiekszaWartosc = if wynik==0 then liczba
                    else if liczba2==0 then liczba3
					else error "Nie ma takiej liczby"
					 where
					 wynik = 1000000 `mod` 3829
					 liczba=wynik*3829
					 liczba2 = ((1000000-wynik) `mod` 3829)
					 liczba3 = 1000000 - wynik