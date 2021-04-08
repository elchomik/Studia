
--Sposob_platnosci PK--
ALTER TABLE Sposob_platnosci ADD CONSTRAINT Sposob_platnosci_PK PRIMARY KEY(ID_sposobu_platnosci,ID_klienta,ID_zgloszenia,ID_miasta,ID_platnosci);

--Platnosc PRIMARY KEY--
ALTER TABLE Platnosc ADD CONSTRAINT Platnosc_PK PRIMARY KEY(ID_platnosci,ID_klienta,ID_zgloszenia,ID_miasta);

--Samochod PRIMARY KEY--
ALTER TABLE Samochod ADD CONSTRAINT Samochod_PK PRIMARY KEY(ID_samochodu,ID_klienta);

--Status zgloszenia PK--
ALTER TABLE Status_zgloszenia ADD CONSTRAINT Status_zgloszenia_PK PRIMARY KEY(ID_klienta,ID_zgloszenia,ID_statuszgloszenia,ID_miasta);


--Zgloszenie PK--
ALTER TABLE Zgloszenie ADD CONSTRAINT Zgloszenie_PK PRIMARY KEY(ID_klienta,ID_zgloszenia,ID_miasta);

--Uwagi PK--
ALTER TABLE Uwagi ADD CONSTRAINT Uwagi_PK PRIMARY KEY(ID_klienta,ID_uwagi);

--Klient PK--
ALTER TABLE Klient ADD CONSTRAINT Klient_PK PRIMARY KEY(ID_klienta);

--Miasto PK--
ALTER TABLE Miasto ADD CONSTRAINT Miasto_PK PRIMARY KEY(ID_miasta);

--Zaopatrzenie warsztatu PK--
ALTER TABLE Zaopatrzenie_warsztatu ADD CONSTRAINT Zaopatrzenie_wartszatu_PK PRIMARY KEY(ID_zaopatrzenia,ID_warsztatu,ID_adresu,ID_miasta);


--Warsztat PK--
ALTER TABLE Warsztat ADD CONSTRAINT Warsztat_PK PRIMARY KEY(ID_adresu,ID_miasta,ID_warsztatu);

--Status Lawety PK--
ALTER TABLE Status_lawety ADD CONSTRAINT Status_lawety_PK PRIMARY KEY(ID_statuslawety,ID_lawety,ID_warsztatu,ID_adresu,ID_miasta);

--Laweta PK--
ALTER TABLE Laweta ADD CONSTRAINT Laweta_PK PRIMARY KEY(ID_lawety,ID_warsztatu,ID_adresu,ID_miasta);

--Adres PK--
ALTER TABLE Adres ADD CONSTRAINT Adres_PK PRIMARY KEY(ID_adresu,ID_miasta);

--Pracownik PK--
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_PK PRIMARY KEY(ID_pracownika,ID_adresu,ID_miasta,ID_warsztatu);


--Karta Stałego klient PK--
ALTER TABLE Karta_stalego_klienta ADD CONSTRAINT Karta_stalego_klienta_PK PRIMARY KEY(ID_karty);


--Relation 3 PK-
ALTER TABLE Relation_3 ADD CONSTRAINT Relation_32_PK PRIMARY KEY(ID_adresu,Warsztat_ID_miasta,ID_klienta,ID_zgloszenia,Zgloszenie_ID_miasta,ID_warsztatu);



--Samochod UQ--
ALTER TABLE Samochod ADD CONSTRAINT Samochod_Nr_rejestracji_UN UNIQUE(Nr_rejestracji);

--Klient UQ--
ALTER TABLE Klient ADD CONSTRAINT Klient_Nr_telefonu_UN UNIQUE(Nr_telefonu);

--Pracownik UQ--
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Nr_telefonu_UN UNIQUE(Nr_telefonu);











