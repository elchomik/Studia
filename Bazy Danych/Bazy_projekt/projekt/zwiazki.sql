
--Sposob Platnosci FK--
ALTER TABLE Sposob_platnosci ADD CONSTRAINT Sposob_platnosci_Platnosc_FK FOREIGN KEY(ID_platnosci,ID_klienta,ID_zgloszenia,ID_miasta)
REFERENCES Platnosc ON DELETE CASCADE;


--Platnosc FK--
ALTER TABLE Platnosc ADD CONSTRAINT Platnosc_Zgloszenie_FK FOREIGN KEY(ID_klienta,ID_zgloszenia,ID_miasta)
REFERENCES Zgloszenie ON DELETE CASCADE;


--Samochod FK--
ALTER TABLE Samochod ADD CONSTRAINT Samochod_Klient_FK FOREIGN KEY(ID_klienta)
REFERENCES Klient ON DELETE CASCADE;

--Warsztat FK--
ALTER TABLE Warsztat ADD CONSTRAINT Warsztat_Adres_FK FOREIGN KEY(ID_adresu,ID_miasta)
REFERENCES Adres ON DELETE CASCADE;

--Laweta FK--
ALTER TABLE Laweta ADD CONSTRAINT Laweta_Warsztat_FK FOREIGN KEY(ID_adresu,ID_miasta,ID_warsztatu)
REFERENCES Warsztat ON DELETE CASCADE;


--Pracownik FK--
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Warsztat_FK FOREIGN KEY(ID_adresu,ID_miasta,ID_warsztatu)
REFERENCES Warsztat ON DELETE CASCADE;


--Status Zgloszenia FK--
ALTER TABLE Status_zgloszenia ADD CONSTRAINT Status_zgloszenia_Zgloszenie_FK FOREIGN KEY(ID_zgloszenia,ID_klienta,ID_miasta)
REFERENCES Zgloszenie ON DELETE CASCADE;


--Relation_3 FK--
ALTER TABLE Relation_3 ADD CONSTRAINT Relation_3_Warsztat_FK FOREIGN KEY(ID_warsztatu,ID_adresu,Warsztat_ID_miasta)
REFERENCES Warsztat ON DELETE CASCADE;


ALTER TABLE Relation_3 ADD CONSTRAINT Relation_3_Zgloszenie_FK FOREIGN KEY(ID_klienta,ID_zgloszenia,Zgloszenie_ID_miasta)
REFERENCES Zgloszenie ON DELETE CASCADE;


--Zaopatrzenie warsztatu FK--
ALTER TABLE Zaopatrzenie_warsztatu ADD CONSTRAINT Zaopatrzenie_warsztatu_Warsztat_FK
FOREIGN KEY(ID_adresu,ID_miasta,ID_warsztatu) REFERENCES Warsztat ON DELETE CASCADE;

--Adres FK--
ALTER TABLE Adres ADD CONSTRAINT Adres_Miasto_FK FOREIGN KEY(ID_miasta) 
REFERENCES Miasto ON DELETE CASCADE;

--Status Lawety FK--
ALTER TABLE Status_lawety ADD CONSTRAINT Status_lawety_Laweta_FK FOREIGN KEY
(ID_lawety,ID_warsztatu,ID_adresu,ID_miasta) REFERENCES Laweta ON DELETE CASCADE;

--Karta SSK FK--
ALTER TABLE Karta_stalego_klienta ADD CONSTRAINT Karta_stalego_klienta_Klient_FK FOREIGN KEY
(ID_klienta) REFERENCES Klient ON DELETE CASCADE;


--Uwagi FK--
ALTER TABLE Uwagi ADD CONSTRAINT Uwagi_Klient_FK FOREIGN KEY(ID_klienta) 
REFERENCES Klient ON DELETE CASCADE;


--Zgloszenie FK--
ALTER TABLE Zgloszenie ADD CONSTRAINT Zgloszenie_Klient_FK FOREIGN KEY(ID_klienta)
REFERENCES Klient ON DELETE CASCADE;

ALTER TABLE Zgloszenie ADD CONSTRAINT Zgloszenie_Miasto_FK FOREIGN KEY(ID_miasta)
REFERENCES Miasto ON DELETE CASCADE;  