

--Platnosc IDX--

CREATE INDEX Platnosc__IDX ON Platnosc(ID_zgloszenia,ID_klienta,ID_miasta);

--Samochod IDX--
CREATE INDEX Samochod_Marka_Model_samochodu__IDX ON Samochod(Marka,Model_samochodu);
CREATE INDEX Samochod_Rok_produkcji__IDX ON Samochod(Rok_produkcji);

--Klient IDX--
CREATE INDEX Klient_Imie_Nazwisko__IDX ON Klient(Imie,Nazwisko);


--Warsztat IDX--
CREATE INDEX Warsztat__IDX ON Warsztat(ID_miasta,ID_adresu);


--Karta_sK IDX--
CREATE INDEX Karta_stalego_klienta__IDX ON Karta_stalego_klienta(ID_klienta);
