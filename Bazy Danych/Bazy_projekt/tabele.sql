CREATE TABLE Sposob_platnosci(
ID_sposobu_platnosci NUMBER(4) NOT NULL,
Nazwa VARCHAR(20) NOT NULL,
ID_klienta NUMBER(4) NOT NULL,
ID_zgloszenia NUMBER(4) NOT NULL,
ID_platnosci NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Platnosc(
ID_platnosci NUMBER(4) NOT NULL,
Data_platnosci DATE NOT NULL,
Kwota NUMERIC(8,2) NOT NULL,
Tytul_platnosci CLOB NOT NULL,
ID_zgloszenia NUMBER(4) NOT NULL,
ID_klienta NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Samochod(
ID_samochodu NUMBER(4) NOT NULL,
Marka VARCHAR(15) NOT NULL,
Model_samochodu VARCHAR(15) NOT NULL,
Rok_produkcji CHAR(4) NOT NULL,
Rodzaj_silnika VARCHAR(8) NOT NULL,
Przebieg VARCHAR(7) NOT NULL,
Pojemnosc_silnika VARCHAR(8) NOT NULL,
Nr_rejestracji VARCHAR(9) NOT NULL,
ID_klienta NUMBER(4) NOT NULL
);


CREATE TABLE Karta_stalego_klienta(
ID_karty NUMBER(4) NOT NULL,
Wartosc_znizki NUMERIC(8,2) NOT NULL,
ID_klienta NUMBER(4) NOT NULL
);


CREATE TABLE Klient(
ID_klienta NUMBER(4) NOT NULL,
Imie VARCHAR(15) NOT NULL,
Nazwisko VARCHAR(30) NOT NULL,
Nr_telefonu VARCHAR(14) NOT NULL
);

CREATE TABLE Uwagi(
ID_uwagi NUMBER(4) NOT NULL,
ID_klienta NUMBER(4) NOT NULL,
Tekst_uwagi CLOB
);


CREATE TABLE Status_zgloszenia(
ID_statuszgloszenia NUMBER(4) NOT NULL,
ID_zgloszenia NUMBER(4) NOT NULL,
Nazwa VARCHAR(20) NOT NULL,
Opis CLOB,
ID_klienta NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Zgloszenie(
ID_zgloszenia NUMBER(4) NOT NULL,
Rodzaj_usterki CLOB NOT NULL,
Data_zgloszenia DATE NOT NULL,
ID_klienta NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);



CREATE TABLE Miasto(
ID_miasta NUMBER(4) NOT NULL,
Nazwa VARCHAR(30) NOT NULL
);


CREATE TABLE Zaopatrzenie_warsztatu(
ID_zaopatrzenia NUMBER(4) NOT NULL,
Dostepnosc_czesci CHAR(1) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL,
ID_warsztatu NUMBER(4) NOT NULL
);


CREATE TABLE Status_lawety(
ID_statuslawety NUMBER(4) NOT NULL,
Nazwa VARCHAR(15) NOT NULL,
Opis CLOB,
ID_lawety NUMBER(4) NOT NULL,
ID_warsztatu NUMBER(4) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Laweta(
ID_lawety NUMBER(4) NOT NULL,
Dostepnosc CHAR(1) NOT NULL,
Cena_uslugi NUMERIC(7,2) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL,
ID_warsztatu NUMBER(4) NOT NULL
);

CREATE TABLE Warsztat (
ID_warsztatu NUMBER(4) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
Nazwa VARCHAR(20) NOT NULL,
Termin DATE NOT NULL,
ID_miasta NUMBER(4) NOT NULL
);


CREATE TABLE Relation_3(
ID_zgloszenia NUMBER(4) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
Zgloszenie_ID_miasta NUMBER(4) NOT NULL,
ID_klienta NUMBER(4) NOT NULL,
ID_warsztatu NUMBER(4) NOT NULL,
Warsztat_ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Adres(
ID_adresu NUMBER(4) NOT NULL,
Kod_pocztowy CHAR(6) NOT NULL,
Ulica VARCHAR(20) NOT NULL,
Nr_mieszkania VARCHAR(6) NOT NULL,
Nr_lokalu NUMBER(4),
ID_miasta NUMBER(4) NOT NULL
);

CREATE TABLE Pracownik(
ID_pracownika NUMBER(4) NOT NULL,
Zawod VARCHAR(20) NOT NULL,
Imie VARCHAR(15) NOT NULL,
Nazwisko VARCHAR(30) NOT NULL,
Nr_telefonu VARCHAR(14) NOT NULL,
ID_adresu NUMBER(4) NOT NULL,
ID_miasta NUMBER(4) NOT NULL,
ID_warsztatu NUMBER(4) NOT NULL
);

