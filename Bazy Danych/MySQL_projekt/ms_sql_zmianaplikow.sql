CREATE TABLE DziedzinaPracy (
  ID_DziedzinaPracy INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(40) NOT NULL,
  PRIMARY KEY (ID_DziedzinaPracy),
  CONSTRAINT ID_DziedzinaPracy_UNIQUE UNIQUE (ID_DziedzinaPracy ) );



CREATE TABLE RodzajUmowy (
  ID_RodzajUmowy INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(70) NOT NULL,
  PRIMARY KEY (ID_RodzajUmowy),
  CONSTRAINT ID_RodzajUmowy_UNIQUE UNIQUE (ID_RodzajUmowy));



CREATE TABLE Umowa (
  ID_Umowa INT IDENTITY(1,1) NOT NULL,
  MiejsceWykonania VARCHAR(30) NOT NULL,
  Wynagrodzenie DECIMAL(7,2) NOT NULL,
  CzasPracy VARCHAR(5) NOT NULL,
  RodzajUmowy_ID_RodzajUmowy INT NULL,
  PRIMARY KEY (ID_Umowa),
  CONSTRAINT ID_Umowa_UNIQUE UNIQUE (ID_Umowa),
  CONSTRAINT fk_Umowa_RodzajUmowy1
    FOREIGN KEY (RodzajUmowy_ID_RodzajUmowy)
    REFERENCES RodzajUmowy(ID_RodzajUmowy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Umowa_RodzajUmowy1_idx ON Umowa(RodzajUmowy_ID_RodzajUmowy);
CREATE UNIQUE INDEX Miejsce_Wykonania_UNIQUE ON Umowa (MiejsceWykonania);


CREATE TABLE Uprawnienia (
  ID_Uprawnienia INT IDENTITY(1,1) NOT NULL,
  RodzajUprawnień VARCHAR(30) NOT NULL,
  CONSTRAINT ID_Uprawnienia_UNIQUE UNIQUE (ID_Uprawnienia),
  PRIMARY KEY (ID_Uprawnienia));




CREATE TABLE StatusKonta (
  ID_StatusKonta INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_StatusKonta),
  CONSTRAINT ID_StatusKonta_UNIQUE UNIQUE (ID_StatusKonta));




CREATE TABLE DaneLogowaniaPracodawca (
  ID_DaneLogowaniaPracodawca INT IDENTITY(1,1) NOT NULL,
  Login VARCHAR(40) NOT NULL,
  Hasło VARCHAR(40) NOT NULL,
  DataUtworzenia DATE NOT NULL,
  Pracodawca_ID_Pracodawca INT NOT NULL,
  Uprawnienia_ID_Uprawnienia INT NOT NULL,
  StatusKonta_ID_StatusKonta INT NOT NULL,
  PRIMARY KEY (ID_DaneLogowaniaPracodawca),
  CONSTRAINT ID_DaneLogowania_UNIQUE UNIQUE  (ID_DaneLogowaniaPracodawca),
  CONSTRAINT fk_DaneLogowania_Uprawnienia10
    FOREIGN KEY (Uprawnienia_ID_Uprawnienia)
    REFERENCES Uprawnienia (ID_Uprawnienia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowania_StatusKonta10
    FOREIGN KEY (StatusKonta_ID_StatusKonta)
    REFERENCES StatusKonta (ID_StatusKonta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_DaneLogowania_Uprawnienia1_idx ON DaneLogowaniaPracodawca (Uprawnienia_ID_Uprawnienia);
CREATE INDEX fk_DaneLogowania_StatusKonta1_idx ON DaneLogowaniaPracodawca (StatusKonta_ID_StatusKonta);
CREATE UNIQUE INDEX Login_UNIQUE ON DaneLogowaniaPracodawca (Login);
CREATE UNIQUE INDEX Hasło_UNIQUE ON DaneLogowaniaPracodawca (Hasło);


CREATE TABLE Pracodawca (
  ID_Pracodawca INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(60) NOT NULL,
  Miasto VARCHAR(40) NOT NULL,
  KodPocztowy VARCHAR(6) NOT NULL,
  Województwo VARCHAR(40) NULL,
  Ulica VARCHAR(30) NULL,
  Nrdomu VARCHAR(5) NOT NULL,
  NrMieszkania VARCHAR(5) NULL,
  Telefon VARCHAR(12) NOT NULL,
  Email VARCHAR(40) NOT NULL,
  DaneLogowaniaPracodawcy_ID_DaneLogowania INT NOT NULL,
  CONSTRAINT ID_Pracodawca_UNIQUE UNIQUE (ID_Pracodawca),
  PRIMARY KEY (ID_Pracodawca),
  CONSTRAINT fk_Pracodawca_DaneLogowaniaPracodawcy1
    FOREIGN KEY (DaneLogowaniaPracodawcy_ID_DaneLogowania)
    REFERENCES DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Pracodawca_DaneLogowaniaPracodawcy1_idx ON Pracodawca (DaneLogowaniaPracodawcy_ID_DaneLogowania);
CREATE UNIQUE INDEX Telefon_UNIQUE ON Pracodawca (Telefon);
CREATE UNIQUE INDEX Email_UNIQUE ON Pracodawca (Email);



CREATE TABLE Stanowisko (
  ID_Stanowisko INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(40) NOT NULL,
  PRIMARY KEY (ID_Stanowisko),
  CONSTRAINT ID_Stanowisko_UNIQUE UNIQUE (ID_Stanowisko));



CREATE TABLE OfertyPracy (
  ID_OfertyPracy INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(50) NOT NULL,
  Opis TEXT NOT NULL,
  DziedzinaPracy_ID_DziedzinaPracy INT NULL,
  Umowa_ID_Umowa INT NOT NULL,
  Pracodawca_ID_Pracodawca INT NOT NULL,
  Stanowisko_ID_Stanowisko INT NULL,
  JezykiObceOfertyPracy_ID_JezykiObce INT NOT NULL,
  PRIMARY KEY (ID_OfertyPracy),
  CONSTRAINT ID_OfertyPracy_UNIQUE UNIQUE (ID_OfertyPracy),
  CONSTRAINT fk_OfertyPracy_DziedzinaPracy1
    FOREIGN KEY (DziedzinaPracy_ID_DziedzinaPracy)
    REFERENCES DziedzinaPracy (ID_DziedzinaPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Umowa1
    FOREIGN KEY (Umowa_ID_Umowa)
    REFERENCES Umowa (ID_Umowa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Pracodawca1
    FOREIGN KEY (Pracodawca_ID_Pracodawca)
    REFERENCES Pracodawca (ID_Pracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Stanowisko1
    FOREIGN KEY (Stanowisko_ID_Stanowisko)
    REFERENCES Stanowisko (ID_Stanowisko)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_OfertyPracy_DziedzinaPracy1_idx ON OfertyPracy (DziedzinaPracy_ID_DziedzinaPracy);
CREATE INDEX fk_OfertyPracy_Umowa1_idx ON OfertyPracy (Umowa_ID_Umowa);
CREATE INDEX fk_OfertyPracy_Pracodawca1_idx ON OfertyPracy (Pracodawca_ID_Pracodawca);
CREATE INDEX fk_OfertyPracy_Stanowisko1_idx ON OfertyPRacy (Stanowisko_ID_Stanowisko);



CREATE TABLE PoszukujacyPracy (
  ID_PoszukujacyPracy INT IDENTITY(1,1) NOT NULL,
  Imie VARCHAR(30) NOT NULL,
  DrugieImie VARCHAR(30) NULL,
  Nazwisko VARCHAR(40) NOT NULL,
  Email VARCHAR(40) NOT NULL,
  Telefon VARCHAR(12) NOT NULL,
  JezykiObcePoszukujacyPracy_ID_JezykiObce INT NOT NULL,
  PRIMARY KEY (ID_PoszukujacyPracy),
  CONSTRAINT ID_PoszukujacyPracy_UNIQUE UNIQUE (ID_PoszukujacyPracy)
  );
  
CREATE UNIQUE INDEX EmailPoszukujacy_UNIQUE ON PoszukujacyPracy (Email);
CREATE UNIQUE INDEX TelefonPoszukujacy_UNIQUE ON PoszukujacyPracy (Telefon);






CREATE TABLE Kwalifikacje (
  ID_Kwalifikacje INT IDENTITY(1,1) NOT NULL ,
  Doswiadczenie TEXT NOT NULL,
  Edukacja TEXT NOT NULL,
  InformacjeDodatkowe TEXT,
  PRIMARY KEY (ID_Kwalifikacje),
  CONSTRAINT ID_Kwalifikacje_UNIQUE UNIQUE (ID_Kwalifikacje));




CREATE TABLE List (
  ID_Listu INT IDENTITY(1,1) NOT NULL,
  Tresc VARCHAR(45) NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  PRIMARY KEY (ID_Listu),
  CONSTRAINT ID_Listu_UNIQUE UNIQUE (ID_Listu),
  CONSTRAINT fk_List_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_List_PoszukujacyPracy1_idx ON List (PoszukujacyPracy_ID_PoszukujacyPracy);


CREATE TABLE StatusZgłoszenia (
  ID_StatusZgłoszenia INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(25) NOT NULL,
  Opis TEXT NULL,
  PRIMARY KEY (ID_StatusZgłoszenia),
  CONSTRAINT ID_StatusZgłoszenia_UNIQUE UNIQUE (ID_StatusZgłoszenia));




CREATE TABLE Rekrutacja (
  ID_Rekrutacja INT IDENTITY(1,1) NOT NULL,
  InformacjaZwrotna VARCHAR(200) NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
  PRIMARY KEY (ID_Rekrutacja),
  CONSTRAINT ID_Rekrutacja_UNIQUE UNIQUE (ID_Rekrutacja),
  CONSTRAINT fk_Rekrutacja_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Rekrutacja_OfertyPracy1_idx ON Rekrutacja (OfertyPracy_ID_OfertyPracy);




CREATE TABLE Zgloszenie (
  ID_Zgloszenie INT IDENTITY(1,1) NOT NULL,
  TerminSkładaniaZgłoszenia DATE NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  StatusZgłoszenia_ID_StatusZgłoszenia INT NOT NULL,
  Rekrutacja_ID_Rekrutacja INT NOT NULL,
  CONSTRAINT ID_Zgloszenia_UNIQUE UNIQUE (ID_Zgloszenie),
  PRIMARY KEY (ID_Zgloszenie),
  CONSTRAINT fk_Zgloszenia_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Zgloszenia_StatusZgłoszenia1
    FOREIGN KEY (StatusZgłoszenia_ID_StatusZgłoszenia)
    REFERENCES StatusZgłoszenia (ID_StatusZgłoszenia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Zgloszenia_Rekrutacja1
    FOREIGN KEY (Rekrutacja_ID_Rekrutacja)
    REFERENCES Rekrutacja (ID_Rekrutacja)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Zgloszenia_PoszukujacyPracy1_idx ON Zgloszenie (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_Zgloszenia_StatusZgłoszenia1_idx ON Zgloszenie (StatusZgłoszenia_ID_StatusZgłoszenia);
CREATE INDEX fk_Zgloszenia_Rekrutacja1_idx ON Zgloszenie (Rekrutacja_ID_Rekrutacja);



CREATE TABLE DaneLogowaniaPoszukujacyPracy (
  ID_DaneLogowaniaPoszukujacyPracy INT IDENTITY(1,1) NOT NULL,
  Login VARCHAR(40) NOT NULL,
  Hasło VARCHAR(40) NOT NULL,
  DataUtworzenia DATE NOT NULL,
  Pracodawca_ID_Pracodawca INT NOT NULL,
  Uprawnienia_ID_Uprawnienia INT NOT NULL,
  StatusKonta_ID_StatusKonta INT NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  PRIMARY KEY (ID_DaneLogowaniaPoszukujacyPracy),
  CONSTRAINT ID_DaneLogowaniaPoszukujacy_UNIQUE UNIQUE  (ID_DaneLogowaniaPoszukujacyPracy),
  CONSTRAINT fk_DaneLogowania_UprawnieniaPoszukujacy
    FOREIGN KEY (Uprawnienia_ID_Uprawnienia)
    REFERENCES Uprawnienia (ID_Uprawnienia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowania_StatusKonta1
    FOREIGN KEY (StatusKonta_ID_StatusKonta)
    REFERENCES StatusKonta (ID_StatusKonta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowaniaPoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE INDEX fk_DaneLogowania_UprawnieniaPoszukujacy_idx ON DaneLogowaniaPoszukujacyPracy (Uprawnienia_ID_Uprawnienia);
CREATE INDEX fk_DaneLogowania_StatusKontaPoszukujacy_idx ON DaneLogowaniaPoszukujacyPracy (StatusKonta_ID_StatusKonta);
CREATE INDEX fk_DaneLogowaniaPoszukujacyPracy_PoszukujacyPracy1_idx ON DaneLogowaniaPoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE UNIQUE INDEX HasłoPoszukujacyPracy_UNIQUE ON DaneLogowaniaPoszukujacyPracy (Hasło);
CREATE  UNIQUE INDEX LoginPoszukujacyPracy_UNIQUE ON DaneLogowaniaPoszukujacyPracy (Login);


CREATE TABLE StatusLogowania (
  ID_StatusLogowania INT IDENTITY(1,1) NOT NULL,
  DataLogowania DATE NOT NULL,
  DataWylogowania DATE NOT NULL,
  DaneLogowaniaPracodawca_ID_DaneLogowania INT NULL,
  DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania INT NULL,
  PRIMARY KEY (ID_StatusLogowania),
  CONSTRAINT ID_StatusDanychLogowania_UNIQUE UNIQUE  (ID_StatusLogowania),
  CONSTRAINT fk_StatusLogowania_DaneLogowaniaPracodawcy1
    FOREIGN KEY (DaneLogowaniaPracodawca_ID_DaneLogowania)
    REFERENCES DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_StatusLogowania_DaneLogowaniaPoszukujacyPracy1
    FOREIGN KEY (DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania)
    REFERENCES DaneLogowaniaPoszukujacyPracy (ID_DaneLogowaniaPoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_StatusLogowania_DaneLogowaniaPracodawcy1_idx ON StatusLogowania (DaneLogowaniaPracodawca_ID_DaneLogowania);
CREATE INDEX fk_StatusLogowania_DaneLogowaniaPoszukujacyPracy1_idx ON StatusLogowania (DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania);




CREATE TABLE ID_JezykiObce (
  ID_JezykiObce INT IDENTITY(1,1) NOT NULL,
  Nazwa VARCHAR(30) NOT NULL,
  StopieńZaawansowania VARCHAR(30) NOT NULL,
  PRIMARY KEY (ID_JezykiObce));

CREATE TABLE JezykiObceOfertyPracy (
  ID_JezykiObce_ID_JezykiObce INT IDENTITY(1,1) NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
    PRIMARY KEY (ID_JezykiObce_ID_JezykiObce),
  CONSTRAINT fk_ID_JezykiObce_has_OfertyPracy_ID_JezykiObce1
    FOREIGN KEY (ID_JezykiObce_ID_JezykiObce)
    REFERENCES ID_JezykiObce (ID_JezykiObce)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ID_JezykiObce_has_OfertyPracy_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_ID_JezykiObce_has_OfertyPracy_OfertyPracy1_idx ON JezykiObceOfertyPracy (OfertyPracy_ID_OfertyPracy);
CREATE INDEX fk_ID_JezykiObce_has_OfertyPracy_ID_JezykiObce1_idx ON JezykiObceOfertyPracy (ID_JezykiObce_ID_JezykiObce);

CREATE TABLE JezykiObcePoszukujacyPracy (
  ID_JezykiObce_ID_JezykiObce INT IDENTITY(1,1) NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
    PRIMARY KEY (ID_JezykiObce_ID_JezykiObce),
  CONSTRAINT fk_ID_JezykiObce_has_PoszukujacyPracy_ID_JezykiObce1
    FOREIGN KEY (ID_JezykiObce_ID_JezykiObce)
    REFERENCES ID_JezykiObce (ID_JezykiObce)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ID_JezykiObce_has_PoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_ID_JezykiObce_has_PoszukujacyPracy_PoszukujacyPracy1_idx ON JezykiObcePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_ID_JezykiObce_has_PoszukujacyPracy_ID_JezykiObce1_idx ON JezykiObcePoszukujacyPracy (ID_JezykiObce_ID_JezykiObce);

CREATE TABLE KwalifikacjeOfertyPracy (
  Kwalifikacje_ID_Kwalifikacje INT IDENTITY(1,1) NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
  PRIMARY KEY (Kwalifikacje_ID_Kwalifikacje),
  CONSTRAINT fk_Kwalifikacje_has_OfertyPracy_Kwalifikacje1
    FOREIGN KEY (Kwalifikacje_ID_Kwalifikacje)
    REFERENCES Kwalifikacje (ID_Kwalifikacje)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Kwalifikacje_has_OfertyPracy_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Kwalifikacje_has_OfertyPracy_OfertyPracy1_idx ON KwalifikacjeOfertyPracy (OfertyPracy_ID_OfertyPracy);
CREATE INDEX fk_Kwalifikacje_has_OfertyPracy_Kwalifikacje1_idx ON KwalifikacjeOfertyPracy (Kwalifikacje_ID_Kwalifikacje);

CREATE TABLE KwalifikacjePoszukujacyPracy (
  Kwalifikacje_ID_Kwalifikacje INT  IDENTITY(1,1) NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  PRIMARY KEY (Kwalifikacje_ID_Kwalifikacje),
  CONSTRAINT fk_Kwalifikacje_has_PoszukujacyPracy_Kwalifikacje1
    FOREIGN KEY (Kwalifikacje_ID_Kwalifikacje)
    REFERENCES Kwalifikacje (ID_Kwalifikacje)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Kwalifikacje_has_PoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Kwalifikacje_has_PoszukujacyPracy_PoszukujacyPracy1_idx ON KwalifikacjePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_Kwalifikacje_has_PoszukujacyPracy_Kwalifikacje1_idx ON KwalifikacjePoszukujacyPracy (Kwalifikacje_ID_Kwalifikacje);


INSERT INTO DziedzinaPracy (Nazwa) VALUES ('Administracja');
INSERT INTO DziedzinaPracy ( Nazwa) VALUES ('Informatyka');
INSERT INTO DziedzinaPracy (Nazwa) VALUES ('Budownictwo');

INSERT INTO RodzajUmowy ( Nazwa) VALUES ( 'Umowa o pracę');
INSERT INTO RodzajUmowy ( Nazwa) VALUES ( 'Umowa o dzieło');
INSERT INTO RodzajUmowy ( Nazwa) VALUES ('Umowa zlecenie');
  
INSERT INTO Umowa ( MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	( 'Warszawa', 3500, '120' ,1);
INSERT INTO Umowa (  MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	( 'Lublin', 3000, '110',2);
INSERT INTO Umowa (  MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	( 'Poznań', 5500, '140' ,3);

INSERT INTO Uprawnienia (  RodzajUprawnień ) VALUES ( 'Użytkownik');
INSERT INTO Uprawnienia ( RodzajUprawnień  ) VALUES ( 'Użytkownik');
INSERT INTO Uprawnienia (  RodzajUprawnień  ) VALUES ( 'Użytkownik');
INSERT INTO Uprawnienia (  RodzajUprawnień  ) VALUES ( 'Pracodawca');
INSERT INTO Uprawnienia (  RodzajUprawnień  ) VALUES ( 'Pracodawca');
INSERT INTO Uprawnienia (   RodzajUprawnień  ) VALUES ('Pracodawca');

INSERT INTO StatusKonta (Nazwa ) VALUES ( 'Niezablokowane');
INSERT INTO StatusKonta (Nazwa ) VALUES ('Niezablokowane');
INSERT INTO StatusKonta ( Nazwa) VALUES ( 'Niezablokowane');
INSERT INTO StatusKonta ( Nazwa ) VALUES ('Niezablokowane');
INSERT INTO StatusKonta ( Nazwa ) VALUES ( 'Niezablokowane');
INSERT INTO StatusKonta ( Nazwa ) VALUES ( 'Niezablokowane');

INSERT INTO DaneLogowaniaPracodawca ( Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
( 'MietekW' , 'MietekW', '2021-04-12', 1 , 4 , 4);
INSERT INTO DaneLogowaniaPracodawca (Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
( 'MietekL' , 'MietekL', '2021-04-12', 2 , 5 , 5);
INSERT INTO DaneLogowaniaPracodawca (Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
('MietekP' , 'MietekP', '2021-04-12', 3 , 6 , 6);

INSERT INTO Pracodawca ( Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu , NrMieszkania, Telefon, Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
( 'MietekW' , 'Warszawa', '03-887', 'mazowieckie', 'Al. Jerozolimskie', '43', '1A' , '015265489154', 'MietekW@gmail.com', 1);
INSERT INTO Pracodawca ( Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu , NrMieszkania, Telefon, Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
( 'MietekL' , 'Lublin', '20-310', 'lubelskie', 'Al. Kraśnickie', '26', '' , '185265489154', 'MietekL@gmail.com', 2);
INSERT INTO Pracodawca (  Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu , NrMieszkania, Telefon, Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
( 'MietekP' , 'Poznań', '30-468', 'wielkopolskie', 'Prosta', '43', '1A' , '015653254698', 'MietekP@gmail.com', 3);

INSERT INTO Stanowisko ( Nazwa) VALUES ( 'Młodszy Specjalista');
INSERT INTO Stanowisko ( Nazwa) VALUES ('Specjalista');
INSERT INTO Stanowisko ( Nazwa) VALUES ( 'Starszy Specjalista');

INSERT INTO OfertyPracy (  Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
('Potrzebny peon w urzędzie pracy', 'Praca, praca!' ,1,1,1,1,1);
INSERT INTO OfertyPracy (  Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
('Programista', 'A Twój język to *werble* PHP!' ,2,2,2,2,2);
INSERT INTO OfertyPracy (   Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
('Operator koparki ręcznej', 'Nie opierać się o betoniarkę!' ,3,3,3,3,3);

INSERT INTO PoszukujacyPracy (Imie, DrugieImie, Nazwisko,Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
('Andrzej','','Kowalski','andrzej@gmail.com','214569853214',4);
INSERT INTO PoszukujacyPracy (Imie, DrugieImie, Nazwisko,Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
('Jan','','Nowak','jan@gmail.com','214652148214',5);
INSERT INTO PoszukujacyPracy (Imie, DrugieImie, Nazwisko,Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
('Pjoter','','Rzyła','pjoter@gmail.com','214566413598',6);

INSERT INTO Kwalifikacje (Doswiadczenie, Edukacja,InformacjeDodatkowe) VALUES 
( 'Brak', 'Szkoła Wyższa w Bytomiu', 'Administracja to moje drugie życie');
INSERT INTO Kwalifikacje (Doswiadczenie, Edukacja,InformacjeDodatkowe) VALUES 
('3 lata w branży', 'Politechnika Lubelska', 'PHP? A co to takiego?');
INSERT INTO Kwalifikacje ( Doswiadczenie, Edukacja,InformacjeDodatkowe) VALUES 
( '10 lat', 'Zawodowa Szkoła Branżowa', '-');


INSERT INTO List (  Tresc, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
('Dzień dobry, ja do urzędu pracy', 1);
INSERT INTO List (Tresc, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
('Proszę tylko nie PHP', 2);
INSERT INTO List ( Tresc,PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
('Co dziś kopiemy?', 3);

INSERT INTO StatusZgłoszenia(Nazwa,Opis) VALUES 
( 'Oczekiwanie','Odezwiemy się do Pana');
INSERT INTO StatusZgłoszenia ( Nazwa, Opis) VALUES 
( 'Zatwierdzone','Oczekuj kontaktu');
INSERT INTO StatusZgłoszenia ( Nazwa, Opis) VALUES 
('Zatwierdzone','Oczekuj kontaktu');

INSERT INTO Rekrutacja ( InformacjaZwrotna , OfertyPracy_ID_OfertyPracy) VALUES 
('Zgłoszenie przyjęte', 1);
INSERT INTO Rekrutacja ( InformacjaZwrotna , OfertyPracy_ID_OfertyPracy) VALUES 
('Zgłoszenie przyjęte', 2);
INSERT INTO Rekrutacja ( InformacjaZwrotna , OfertyPracy_ID_OfertyPracy)  VALUES 
('Zgłoszenie przyjęte', 3);

INSERT INTO Zgloszenie ( TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja) VALUES 
('2020-03-03',1,1,1);
INSERT INTO Zgloszenie ( TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja) VALUES 
('2020-06-08',2,2,2);
INSERT INTO Zgloszenie ( TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja)VALUES 
('2020-05-23',3,3,3);

INSERT INTO DaneLogowaniaPoszukujacyPracy (Login, Hasło,DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES
('andrzejK','andrzej123','2020-03-28',1,1,1,1);
INSERT INTO DaneLogowaniaPoszukujacyPracy (Login, Hasło,DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES
('janN','jan123','2021-02-22',2,2,2,2);
INSERT INTO DaneLogowaniaPoszukujacyPracy (Login, Hasło,DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES
('pjoterR','pjoter123','2021-01-24',3,3,3,3);
  
INSERT INTO StatusLogowania (DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
('2020-03-28','2020-03-28',1,1);
INSERT INTO StatusLogowania (DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
('2021-02-22','2021-02-22',2,2);
INSERT INTO StatusLogowania (DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
('2021-01-24','2021-01-24',3,3);

INSERT INTO ID_JezykiObce ( Nazwa,StopieńZaawansowania) VALUES
('Angielski','C1');
INSERT INTO ID_JezykiObce ( Nazwa,StopieńZaawansowania)  VALUES
('Angielski','B1');
INSERT INTO ID_JezykiObce ( Nazwa,StopieńZaawansowania)  VALUES
('Angielski','A1');

INSERT INTO JezykiObceOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES 
(1);
INSERT INTO JezykiObceOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES 
(2);
INSERT INTO JezykiObceOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES 
(3);

INSERT INTO JezykiObcePoszukujacyPracy(  PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(1);
INSERT INTO JezykiObcePoszukujacyPracy ( PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(2);
INSERT INTO JezykiObcePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(3);

INSERT INTO KwalifikacjeOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES
(1);
INSERT INTO KwalifikacjeOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES
(2);
INSERT INTO KwalifikacjeOfertyPracy (OfertyPracy_ID_OfertyPracy) VALUES
(3);

INSERT INTO KwalifikacjePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(1);
INSERT INTO KwalifikacjePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(2);
INSERT INTO KwalifikacjePoszukujacyPracy(PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(3);

