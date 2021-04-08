INSERT INTO Klient (ID_klienta,Imie,Nazwisko,Nr_telefonu) VALUES (1,’Karol’,’Abacki’,’547562158’);
INSERT INTO Klient (ID_klienta,Imie,Nazwisko,Nr_telefonu) VALUES (2,’Adam’,’Duk’,’735468157’);
INSERT INTO Klient (ID_klienta,Imie,Nazwisko,Nr_telefonu) VALUES (3,’Monika’,’Dmowska’,’0834681569’);
INSERT INTO Klient (ID_klienta,Imie,Nazwisko,Nr_telefonu) VALUES (4,’Robert’,’Kowalski’,’735465498’);
INSERT INTO Klient (ID_klienta,Imie,Nazwisko,Nr_telefonu) VALUES (5,’Danuta’,’Nowak’,’644165251’);

INSERT INTO Miasto (ID_miasta,Nazwa) VALUES (1,’Lublin’); 
INSERT INTO Miasto (ID_miasta,Nazwa) VALUES (2,’Lublin’);
INSERT INTO Miasto (ID_miasta,Nazwa) VALUES (3,’Lublin’);
INSERT INTO Miasto (ID_miasta,Nazwa) VALUES (4,’Lublin’);
INSERT INTO Miasto (ID_miasta,Nazwa) VALUES (5,’Lublin’);

INSERT INTO Adres (ID_adresu,Kod_pocztowy,Ulica,Nr_mieszkania,Nr_Lokalu,ID_Miasta) VALUES (1,’20-612’,’Muzyczna’,’46’,13,1);
INSERT INTO Adres (ID_adresu,Kod_pocztowy,Ulica,Nr_mieszkania,Nr_Lokalu,ID_Miasta) VALUES (2,’20-612’,’Nadbystrzycka’,’38B’,1,2);
INSERT INTO Adres (ID_adresu,Kod_pocztowy,Ulica,Nr_mieszkania,Nr_Lokalu,ID_Miasta) VALUES (3,’20-335’,’Pogodna’,’58’,23,3);
INSERT INTO Adres (ID_adresu,Kod_pocztowy,Ulica,Nr_mieszkania,Nr_Lokalu,ID_Miasta) VALUES (4,’20-468’,’Kresowa’,’87’,35,4);
INSERT INTO Adres (ID_adresu,Kod_pocztowy,Ulica,Nr_mieszkania,Nr_Lokalu,ID_Miasta) VALUES (5,’20-447’,’Diamentowa’,’10’,9,5);

INSERT INTO Karta_stalego_klienta (ID_karty,Wartosc_znizki,ID_klienta) VALUES (1,’400’,1);
INSERT INTO Karta_stalego_klienta (ID_karty,Wartosc_znizki,ID_klienta) VALUES (2,’141’,2);
INSERT INTO Karta_stalego_klienta (ID_karty,Wartosc_znizki,ID_klienta) VALUES (3,’546’,3);
INSERT INTO Karta_stalego_klienta (ID_karty,Wartosc_znizki,ID_klienta) VALUES (4,’300’,4);
INSERT INTO Karta_stalego_klienta (ID_karty,Wartosc_znizki,ID_klienta) VALUES (5,’460’,5);

INSERT INTO Uwagi (ID_uwagi,Tekst_uwagi,ID_klienta) VALUES (1,’Wszystko w porzadku’,1);
INSERT INTO Uwagi (ID_uwagi,Tekst_uwagi,ID_klienta) VALUES (2,’Polecam’,2);
INSERT INTO Uwagi (ID_uwagi,Tekst_uwagi,ID_klienta) VALUES (3,’Drogo,nie polecam’,3);
INSERT INTO Uwagi (ID_uwagi,Tekst_uwagi,ID_klienta) VALUES (4,’Tanio,polecam’,4);
INSERT INTO Uwagi (ID_uwagi,Tekst_uwagi,ID_klienta) VALUES (5,’Fachowa robota’,5);

INSERT INTO Zgloszenie (ID_zgloszenia,Rodzaj_usterki,Data_zgloszenia,ID_klienta,ID_miasta) VALUES (1,’awaria silnika’,TO_DATE(’2021-01-21’,’YYYY-MM-DD’),1,1);
INSERT INTO Zgloszenie (ID_zgloszenia,Rodzaj_usterki,Data_zgloszenia,ID_klienta,ID_miasta) VALUES (2,’wymiana opon’,TO_DATE(’2021-04-24’,’YYYY-MM-DD’),2,2);
INSERT INTO Zgloszenie (ID_zgloszenia,Rodzaj_usterki,Data_zgloszenia,ID_klienta,ID_miasta) VALUES (3,’wymiana klockow’,TO_DATE(’2020-12-01’,’YYYY-MM-DD’),3,3);
INSERT INTO Zgloszenie (ID_zgloszenia,Rodzaj_usterki,Data_zgloszenia,ID_klienta,ID_miasta) VALUES (4,’regeneracja turbo’,TO_DATE(’2020-10-14’,’YYYY-MM-DD’),4,4);
INSERT INTO Zgloszenie (ID_zgloszenia,Rodzaj_usterki,Data_zgloszenia,ID_klienta,ID_miasta) VALUES (5,’geometria kol’,TO_DATE(’2020-07-30’,’YYYY-MM-DD’),5,5);

INSERT INTO Status_zgloszenia (ID_statuszgloszenia,Nazwa,Opis,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (1,’w realizacji’,’-’,1,1,1);
INSERT INTO Status_zgloszenia (ID_statuszgloszenia,Nazwa,Opis,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (2,’oczekuje na klienta’,’warsztat oczekuje’,2,2,2);
INSERT INTO Status_zgloszenia (ID_statuszgloszenia,Nazwa,Opis,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (3,’zakonczone’,’-’,3,3,3);
INSERT INTO Status_zgloszenia (ID_statuszgloszenia,Nazwa,Opis,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (4,’zakonczone’,’-’,4,4,4);
INSERT INTO Status_zgloszenia (ID_statuszgloszenia,Nazwa,Opis,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (5,’oczekuje na klienta’,’warsztat oczekuje’,5,5,5);

INSERT INTO Warsztat (ID_warsztatu,Nazwa,Termin,ID_adresu,ID_miasta) VALUES (1,’Januszex’,TO_DATE(’2020-01-01’,’YYYY-MM-DD’),1,1);
INSERT INTO Warsztat (ID_warsztatu,Nazwa,Termin,ID_adresu,ID_miasta) VALUES (2,’KarolPol’,TO_DATE(’2001-01-01’,’YYYY-MM-DD’),2,2);
INSERT INTO Warsztat (ID_warsztatu,Nazwa,Termin,ID_adresu,ID_miasta) VALUES (3,’Andrzej i spółka’,TO_DATE(’2017-09-08’,’YYYY-MM-DD’),3,3);
INSERT INTO Warsztat (ID_warsztatu,Nazwa,Termin,ID_adresu,ID_miasta) VALUES (4,’u Mietka’,TO_DATE(’1999-04-24’,’YYYY-MM-DD’),4,4);
INSERT INTO Warsztat (ID_warsztatu,Nazwa,Termin,ID_adresu,ID_miasta) VALUES (5,’Wziuuum’,TO_DATE(’2005-05-05’,’YYYY-MM-DD’),5,5);

INSERT INTO Relation_3(ID_zgloszenia,ID_klienta,Zgloszenie_ID_miasta,ID_warsztatu,ID_adresu,Warsztat_ID_miasta) VALUES (1,1,1,1,1,1);
INSERT INTO Relation_3(ID_zgloszenia,ID_klienta,Zgloszenie_ID_miasta,ID_warsztatu,ID_adresu,Warsztat_ID_miasta) VALUES (2,2,2,2,2,2);
INSERT INTO Relation_3(ID_zgloszenia,ID_klienta,Zgloszenie_ID_miasta,ID_warsztatu,ID_adresu,Warsztat_ID_miasta) VALUES (3,3,3,3,3,3);
INSERT INTO Relation_3(ID_zgloszenia,ID_klienta,Zgloszenie_ID_miasta,ID_warsztatu,ID_adresu,Warsztat_ID_miasta) VALUES (4,4,4,4,4,4);
INSERT INTO Relation_3(ID_zgloszenia,ID_klienta,Zgloszenie_ID_miasta,ID_warsztatu,ID_adresu,Warsztat_ID_miasta) VALUES (5,5,5,5,5,5);

INSERT INTO Pracownik (ID_pracownika,Zawod,Imie,Nazwisko,Nr_telefonu,ID_warsztatu,ID_adresu,ID_miasta) VALUES (1,’elektryk’,’Michal’,’Adamiak’,’654484584’,1,1,1);
INSERT INTO Pracownik (ID_pracownika,Zawod,Imie,Nazwisko,Nr_telefonu,ID_warsztatu,ID_adresu,ID_miasta) VALUES (2,’mechanik’,’Jan’,’Fasola’,’521357465’,2,2,2);
INSERT INTO Pracownik (ID_pracownika,Zawod,Imie,Nazwisko,Nr_telefonu,ID_warsztatu,ID_adresu,ID_miasta) VALUES (3,’diagnosta’,’Szymon’,’Godziewski’,’621518744’,3,3,3);
INSERT INTO Pracownik (ID_pracownika,Zawod,Imie,Nazwisko,Nr_telefonu,ID_warsztatu,ID_adresu,ID_miasta) VALUES (4,’wulkanizator’,’Wojciech’,’Wazny’,’648548746’,4,4,4);
INSERT INTO Pracownik (ID_pracownika,Zawod,Imie,Nazwisko,Nr_telefonu,ID_warsztatu,ID_adresu,ID_miasta) VALUES (5,’mechanik’,’Kamil’,’Zakrzewski’,’515483548’,5,5,5);

INSERT INTO Laweta (ID_lawety,Dostepnosc,Cena_uslugi,ID_warsztatu,ID_adresu,ID_miasta) VALUES (1,’T’,200,1,1,1);
INSERT INTO Laweta (ID_lawety,Dostepnosc,Cena_uslugi,ID_warsztatu,ID_adresu,ID_miasta) VALUES (2,’T’,300,2,2,2);
INSERT INTO Laweta (ID_lawety,Dostepnosc,Cena_uslugi,ID_warsztatu,ID_adresu,ID_miasta) VALUES (3,’N’,450,3,3,3);
INSERT INTO Laweta (ID_lawety,Dostepnosc,Cena_uslugi,ID_warsztatu,ID_adresu,ID_miasta) VALUES (4,’T’,150,4,4,4);
INSERT INTO Laweta (ID_lawety,Dostepnosc,Cena_uslugi,ID_warsztatu,ID_adresu,ID_miasta) VALUES (5,’N’,80,5,5,5);

INSERT INTO Status_Lawety(ID_statuslawety,Nazwa,Opis,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) VALUES (1,’Dostepna’,’Udzwig 2,5t’,1,1,1,1);
INSERT INTO Status_Lawety(ID_statuslawety,Nazwa,Opis,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) VALUES (2,’Dostepna’,’Udzwig 3,5t’,2,2,2,2);
INSERT INTO Status_Lawety(ID_statuslawety,Nazwa,Opis,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) VALUES (3,’W drodze’,’Udzwig 4,5t’,3,3,3,3);
INSERT INTO Status_Lawety(ID_statuslawety,Nazwa,Opis,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) VALUES (4,’Dostepna’,’Udzwig 3,0t’,4,4,4,4);
INSERT INTO Status_Lawety(ID_statuslawety,Nazwa,Opis,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) VALUES (5,’Niedostepna’,’Udzwig 2,0t’,5,5,5,5);

INSERT INTO Zaopatrzenie_warsztatu (ID_zaopatrzenia,Dostepnosc_czesci,ID_warsztatu,ID_adresu,ID_miasta) VALUES (1,’T’,1,1,1);
INSERT INTO Zaopatrzenie_warsztatu (ID_zaopatrzenia,Dostepnosc_czesci,ID_warsztatu,ID_adresu,ID_miasta) VALUES (2,’T’,2,2,2);
INSERT INTO Zaopatrzenie_warsztatu (ID_zaopatrzenia,Dostepnosc_czesci,ID_warsztatu,ID_adresu,ID_miasta) VALUES (3,’T’,3,3,3);
INSERT INTO Zaopatrzenie_warsztatu (ID_zaopatrzenia,Dostepnosc_czesci,ID_warsztatu,ID_adresu,ID_miasta) VALUES (4,’T’,4,4,4);
INSERT INTO Zaopatrzenie_warsztatu (ID_zaopatrzenia,Dostepnosc_czesci,ID_warsztatu,ID_adresu,ID_miasta) VALUES (5,’T’,5,5,5);

INSERT INTO Platnosc (ID_platnosci,Data_platnosci,Kwota,Tytul_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (1,TO_DATE(’2021-10-04’,’YYYY-MM-DD’),40,’za czesci’,1,1,1);
INSERT INTO Platnosc (ID_platnosci,Data_platnosci,Kwota,Tytul_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (2,TO_DATE(’2021-07-31’,’YYYY-MM-DD’),490,’za czesci’,2,2,2);
INSERT INTO Platnosc (ID_platnosci,Data_platnosci,Kwota,Tytul_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (3,TO_DATE(’2021-03-15’,’YYYY-MM-DD’),2540,’za naprawe’,3,3,3);
INSERT INTO Platnosc (ID_platnosci,Data_platnosci,Kwota,Tytul_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (4,TO_DATE(’2021-02-15’,’YYYY-MM-DD’)’,340,’-’,4,4,4);
INSERT INTO Platnosc (ID_platnosci,Data_platnosci,Kwota,Tytul_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (5,TO_DATE(’2021-01-21’,’YYYY-MM-DD’),150,’-’,5,5,5);

INSERT INTO Sposob_platnosci (ID_sposobu_platnosci,Nazwa,ID_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (1,’Przelew bankowy’,1,1,1,1);
INSERT INTO Sposob_platnosci (ID_sposobu_platnosci,Nazwa,ID_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (2,’Blik’,2,2,2,2);
INSERT INTO Sposob_platnosci (ID_sposobu_platnosci,Nazwa,ID_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (3,’Gotowka’,3,3,3,3);
INSERT INTO Sposob_platnosci (ID_sposobu_platnosci,Nazwa,ID_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (4,’Gotowka’,4,4,4,4);
INSERT INTO Sposob_platnosci (ID_sposobu_platnosci,Nazwa,ID_platnosci,ID_zgloszenia,ID_klienta,ID_miasta) VALUES (5,’Przelew bankowy’,5,5,5,5);

INSERT INTO Samochod (ID_samochodu,Marka,Model_samochodu,Rok_produkcji,Pojemnosc_silnika,Rodzaj_silnika,Przebieg,Nr_rejestracji,ID_klienta) VALUES (1,’Audi’,’A4’,1999,’1896cm3’,’Diesel’,’35048km’,’LU80923’,1);
INSERT INTO Samochod (ID_samochodu,Marka,Model_samochodu,Rok_produkcji,Pojemnosc_silnika,Rodzaj_silnika,Przebieg,Nr_rejestracji,ID_klienta) VALUES (2,’Skoda’,’Octavia’,1997,’1896cm3’,’Benzyna’,’36154km’,’LU65748’,2);
INSERT INTO Samochod (ID_samochodu,Marka,Model_samochodu,Rok_produkcji,Pojemnosc_silnika,Rodzaj_silnika,Przebieg,Nr_rejestracji,ID_klienta) VALUES (3,’Ford’,’Mondeo’,2014,’1498cm3’,’Benzyna’,’16547km’,’LU35146’,3);
INSERT INTO  Samochod (ID_samochodu,Marka,Model_samochodu,Rok_produkcji,Pojemnosc_silnika,Rodzaj_silnika,Przebieg,Nr_rejestracji,ID_klienta) VALUES (4,’Opel’,’Omega’,2004,’2098cm3’,’Diesel’,’51658km’,’LU13657’,4);
INSERT INTO Samochod (ID_samochodu,Marka,Model_samochodu,Rok_produkcji,Pojemnosc_silnika,Rodzaj_silnika,Przebieg,Nr_rejestracji,ID_klienta) VALUES (5,’Kia’,’Ceed’,2020,’1389cm3’,’Benzyna’,’1365km’,’LU35465’,5);
