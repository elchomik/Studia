

/* SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; */
/* SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; */
/* SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; */

CREATE SCHEMA mydb;

CREATE SEQUENCE mydb.DziedzinaPracy_seq;

CREATE TABLE IF NOT EXISTS mydb.DziedzinaPracy (
  ID_DziedzinaPracy INT NOT NULL DEFAULT NEXTVAL ('mydb.DziedzinaPracy_seq'),
  Nazwa VARCHAR(40) NOT NULL,
  PRIMARY KEY (ID_DziedzinaPracy),
  CONSTRAINT ID_DziedzinaPracy_UNIQUE UNIQUE (ID_DziedzinaPracy ) );

CREATE SEQUENCE mydb.RodzajUmowy_seq;

CREATE TABLE IF NOT EXISTS mydb.RodzajUmowy (
  ID_RodzajUmowy INT NOT NULL DEFAULT NEXTVAL ('mydb.RodzajUmowy_seq'),
  Nazwa VARCHAR(70) NOT NULL,
  PRIMARY KEY (ID_RodzajUmowy),
  CONSTRAINT ID_RodzajUmowy_UNIQUE UNIQUE (ID_RodzajUmowy));

CREATE SEQUENCE mydb.Umowa_seq;

CREATE TABLE IF NOT EXISTS mydb.Umowa (
  ID_Umowa INT NOT NULL DEFAULT NEXTVAL ('mydb.Umowa_seq'),
  MiejsceWykonania VARCHAR(30) NOT NULL,
  Wynagrodzenie DECIMAL(7,2) NOT NULL,
  CzasPracy VARCHAR(5) NOT NULL,
  RodzajUmowy_ID_RodzajUmowy INT NULL,
  PRIMARY KEY (ID_Umowa),
  CONSTRAINT ID_Umowa_UNIQUE UNIQUE (ID_Umowa),
  CONSTRAINT fk_Umowa_RodzajUmowy1
    FOREIGN KEY (RodzajUmowy_ID_RodzajUmowy)
    REFERENCES mydb.RodzajUmowy(ID_RodzajUmowy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Umowa_RodzajUmowy1_idx ON mydb.Umowa(RodzajUmowy_ID_RodzajUmowy);
CREATE UNIQUE INDEX Miejsce_Wykonania_UNIQUE ON mydb.Umowa (MiejsceWykonania);
CREATE SEQUENCE mydb.Uprawnienia_seq;

CREATE TABLE IF NOT EXISTS mydb.Uprawnienia (
  ID_Uprawnienia INT NOT NULL DEFAULT NEXTVAL ('mydb.Uprawnienia_seq'),
  RodzajUprawnień VARCHAR(30) NOT NULL,
  CONSTRAINT ID_Uprawnienia_UNIQUE UNIQUE (ID_Uprawnienia),
  PRIMARY KEY (ID_Uprawnienia));



CREATE SEQUENCE mydb.StatusKonta_seq;

CREATE TABLE IF NOT EXISTS mydb.StatusKonta (
  ID_StatusKonta INT NOT NULL DEFAULT NEXTVAL ('mydb.StatusKonta_seq'),
  Nazwa VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_StatusKonta),
  CONSTRAINT ID_StatusKonta_UNIQUE UNIQUE (ID_StatusKonta));


CREATE SEQUENCE mydb.DaneLogowaniaPracodawca_seq;

CREATE TABLE IF NOT EXISTS mydb.DaneLogowaniaPracodawca (
  ID_DaneLogowaniaPracodawca INT NOT NULL DEFAULT NEXTVAL ('mydb.DaneLogowaniaPracodawca_seq'),
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
    REFERENCES mydb.Uprawnienia (ID_Uprawnienia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowania_StatusKonta10
    FOREIGN KEY (StatusKonta_ID_StatusKonta)
    REFERENCES mydb.StatusKonta (ID_StatusKonta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_DaneLogowania_Uprawnienia1_idx ON mydb.DaneLogowaniaPracodawca (Uprawnienia_ID_Uprawnienia);
CREATE INDEX fk_DaneLogowania_StatusKonta1_idx ON mydb.DaneLogowaniaPracodawca (StatusKonta_ID_StatusKonta);
CREATE UNIQUE INDEX Login_UNIQUE ON mydb.DaneLogowaniaPracodawca (Login);
CREATE UNIQUE INDEX Hasło_UNIQUE ON mydb.DaneLogowaniaPracodawca (Hasło);

CREATE SEQUENCE mydb.Pracodawca_seq;

CREATE TABLE IF NOT EXISTS mydb.Pracodawca (
  ID_Pracodawca INT NOT NULL DEFAULT NEXTVAL ('mydb.Pracodawca_seq'),
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
    REFERENCES mydb.DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Pracodawca_DaneLogowaniaPracodawcy1_idx ON mydb.Pracodawca (DaneLogowaniaPracodawcy_ID_DaneLogowania);
CREATE UNIQUE INDEX Telefon_UNIQUE ON mydb.Pracodawca (Telefon);
CREATE UNIQUE INDEX Email_UNIQUE ON mydb.Pracodawca (Email);

CREATE SEQUENCE mydb.Stanowisko_seq;

CREATE TABLE IF NOT EXISTS mydb.Stanowisko (
  ID_Stanowisko INT NOT NULL DEFAULT NEXTVAL ('mydb.Stanowisko_seq'),
  Nazwa VARCHAR(40) NOT NULL,
  PRIMARY KEY (ID_Stanowisko),
  CONSTRAINT ID_Stanowisko_UNIQUE UNIQUE (ID_Stanowisko));


CREATE SEQUENCE mydb.OfertyPracy_seq;

CREATE TABLE IF NOT EXISTS mydb.OfertyPracy (
  ID_OfertyPracy INT NOT NULL DEFAULT NEXTVAL ('mydb.OfertyPracy_seq'),
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
    REFERENCES mydb.DziedzinaPracy (ID_DziedzinaPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Umowa1
    FOREIGN KEY (Umowa_ID_Umowa)
    REFERENCES mydb.Umowa (ID_Umowa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Pracodawca1
    FOREIGN KEY (Pracodawca_ID_Pracodawca)
    REFERENCES mydb.Pracodawca (ID_Pracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_OfertyPracy_Stanowisko1
    FOREIGN KEY (Stanowisko_ID_Stanowisko)
    REFERENCES mydb.Stanowisko (ID_Stanowisko)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_OfertyPracy_DziedzinaPracy1_idx ON mydb.OfertyPracy (DziedzinaPracy_ID_DziedzinaPracy);
CREATE INDEX fk_OfertyPracy_Umowa1_idx ON mydb.OfertyPracy (Umowa_ID_Umowa);
CREATE INDEX fk_OfertyPracy_Pracodawca1_idx ON mydb.OfertyPracy (Pracodawca_ID_Pracodawca);
CREATE INDEX fk_OfertyPracy_Stanowisko1_idx ON mydb.OfertyPRacy (Stanowisko_ID_Stanowisko);

CREATE SEQUENCE mydb.PoszukujacyPracy_seq;

CREATE TABLE IF NOT EXISTS mydb.PoszukujacyPracy (
  ID_PoszukujacyPracy INT NOT NULL DEFAULT NEXTVAL ('mydb.PoszukujacyPracy_seq'),
  Imie VARCHAR(30) NOT NULL,
  DrugieImie VARCHAR(30) NULL,
  Nazwisko VARCHAR(40) NOT NULL,
  Email VARCHAR(40) NOT NULL,
  Telefon VARCHAR(12) NOT NULL,
  JezykiObcePoszukujacyPracy_ID_JezykiObce INT NOT NULL,
  PRIMARY KEY (ID_PoszukujacyPracy),
  CONSTRAINT ID_PoszukujacyPracy_UNIQUE UNIQUE (ID_PoszukujacyPracy)
  );
  
CREATE UNIQUE INDEX EmailPoszukujacy_UNIQUE ON mydb.PoszukujacyPracy (Email);
CREATE UNIQUE INDEX TelefonPoszukujacy_UNIQUE ON mydb.PoszukujacyPracy (Telefon);




CREATE SEQUENCE mydb.Kwalifikacje_seq;

CREATE TABLE IF NOT EXISTS mydb.Kwalifikacje (
  ID_Kwalifikacje INT NOT NULL DEFAULT NEXTVAL ('mydb.Kwalifikacje_seq'),
  Doswiadczenie TEXT NOT NULL,
  Edukacja TEXT NOT NULL,
  InformacjeDodatkowe TEXT,
  PRIMARY KEY (ID_Kwalifikacje),
  CONSTRAINT ID_Kwalifikacje_UNIQUE UNIQUE (ID_Kwalifikacje));



CREATE SEQUENCE mydb.List_seq;

CREATE TABLE IF NOT EXISTS mydb.List (
  ID_Listu INT NOT NULL DEFAULT NEXTVAL ('mydb.List_seq'),
  Tresc VARCHAR(45) NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  PRIMARY KEY (ID_Listu),
  CONSTRAINT ID_Listu_UNIQUE UNIQUE (ID_Listu),
  CONSTRAINT fk_List_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES mydb.PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_List_PoszukujacyPracy1_idx ON mydb.List (PoszukujacyPracy_ID_PoszukujacyPracy);

CREATE SEQUENCE mydb.StatusZgłoszenia_seq;

CREATE TABLE IF NOT EXISTS mydb.StatusZgłoszenia (
  ID_StatusZgłoszenia INT NOT NULL DEFAULT NEXTVAL ('mydb.StatusZgłoszenia_seq'),
  Nazwa VARCHAR(25) NOT NULL,
  Opis TEXT NULL,
  PRIMARY KEY (ID_StatusZgłoszenia),
  CONSTRAINT ID_StatusZgłoszenia_UNIQUE UNIQUE (ID_StatusZgłoszenia));



CREATE SEQUENCE mydb.Rekrutacja_seq;

CREATE TABLE IF NOT EXISTS mydb.Rekrutacja (
  ID_Rekrutacja INT NOT NULL DEFAULT NEXTVAL ('mydb.Rekrutacja_seq'),
  InformacjaZwrotna VARCHAR(200) NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
  PRIMARY KEY (ID_Rekrutacja),
  CONSTRAINT ID_Rekrutacja_UNIQUE UNIQUE (ID_Rekrutacja),
  CONSTRAINT fk_Rekrutacja_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES mydb.OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Rekrutacja_OfertyPracy1_idx ON mydb.Rekrutacja (OfertyPracy_ID_OfertyPracy);


CREATE SEQUENCE mydb.Zgloszenie_seq;

CREATE TABLE IF NOT EXISTS mydb.Zgloszenie (
  ID_Zgloszenie INT NOT NULL DEFAULT NEXTVAL ('mydb.Zgloszenie_seq'),
  TerminSkładaniaZgłoszenia DATE NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  StatusZgłoszenia_ID_StatusZgłoszenia INT NOT NULL,
  Rekrutacja_ID_Rekrutacja INT NOT NULL,
  CONSTRAINT ID_Zgloszenia_UNIQUE UNIQUE (ID_Zgloszenie),
  PRIMARY KEY (ID_Zgloszenie),
  CONSTRAINT fk_Zgloszenia_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES mydb.PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Zgloszenia_StatusZgłoszenia1
    FOREIGN KEY (StatusZgłoszenia_ID_StatusZgłoszenia)
    REFERENCES mydb.StatusZgłoszenia (ID_StatusZgłoszenia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Zgloszenia_Rekrutacja1
    FOREIGN KEY (Rekrutacja_ID_Rekrutacja)
    REFERENCES mydb.Rekrutacja (ID_Rekrutacja)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Zgloszenia_PoszukujacyPracy1_idx ON mydb.Zgloszenie (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_Zgloszenia_StatusZgłoszenia1_idx ON mydb.Zgloszenie (StatusZgłoszenia_ID_StatusZgłoszenia);
CREATE INDEX fk_Zgloszenia_Rekrutacja1_idx ON mydb.Zgloszenie (Rekrutacja_ID_Rekrutacja);

CREATE SEQUENCE mydb.DaneLogowaniaPoszukujacyPracy_seq;

CREATE TABLE IF NOT EXISTS mydb.DaneLogowaniaPoszukujacyPracy (
  ID_DaneLogowaniaPoszukujacyPracy INT NOT NULL DEFAULT NEXTVAL ('mydb.DaneLogowaniaPoszukujacyPracy_seq'),
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
    REFERENCES mydb.Uprawnienia (ID_Uprawnienia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowania_StatusKonta1
    FOREIGN KEY (StatusKonta_ID_StatusKonta)
    REFERENCES mydb.StatusKonta (ID_StatusKonta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_DaneLogowaniaPoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES mydb.PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE INDEX fk_DaneLogowania_UprawnieniaPoszukujacy_idx ON mydb.DaneLogowaniaPoszukujacyPracy (Uprawnienia_ID_Uprawnienia);
CREATE INDEX fk_DaneLogowania_StatusKontaPoszukujacy_idx ON mydb.DaneLogowaniaPoszukujacyPracy (StatusKonta_ID_StatusKonta);
CREATE INDEX fk_DaneLogowaniaPoszukujacyPracy_PoszukujacyPracy1_idx ON mydb.DaneLogowaniaPoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE UNIQUE INDEX HasłoPoszukujacyPracy_UNIQUE ON mydb.DaneLogowaniaPoszukujacyPracy (Hasło);
CREATE  UNIQUE INDEX LoginPoszukujacyPracy_UNIQUE ON mydb.DaneLogowaniaPoszukujacyPracy (Login);

CREATE SEQUENCE mydb.StatusLogowania_seq;

CREATE TABLE IF NOT EXISTS mydb.StatusLogowania (
  ID_StatusLogowania INT NOT NULL DEFAULT NEXTVAL ('mydb.StatusLogowania_seq'),
  DataLogowania DATE NOT NULL,
  DataWylogowania DATE NOT NULL,
  DaneLogowaniaPracodawca_ID_DaneLogowania INT NULL,
  DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania INT NULL,
  PRIMARY KEY (ID_StatusLogowania),
  CONSTRAINT ID_StatusDanychLogowania_UNIQUE UNIQUE  (ID_StatusLogowania),
  CONSTRAINT fk_StatusLogowania_DaneLogowaniaPracodawcy1
    FOREIGN KEY (DaneLogowaniaPracodawca_ID_DaneLogowania)
    REFERENCES mydb.DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_StatusLogowania_DaneLogowaniaPoszukujacyPracy1
    FOREIGN KEY (DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania)
    REFERENCES mydb.DaneLogowaniaPoszukujacyPracy (ID_DaneLogowaniaPoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_StatusLogowania_DaneLogowaniaPracodawcy1_idx ON mydb.StatusLogowania (DaneLogowaniaPracodawca_ID_DaneLogowania);
CREATE INDEX fk_StatusLogowania_DaneLogowaniaPoszukujacyPracy1_idx ON mydb.StatusLogowania (DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania);


CREATE SEQUENCE mydb.ID_JezykiObce_seq;

CREATE TABLE IF NOT EXISTS mydb.ID_JezykiObce (
  ID_JezykiObce INT NOT NULL DEFAULT NEXTVAL ('mydb.ID_JezykiObce_seq'),
  Nazwa VARCHAR(30) NOT NULL,
  StopieńZaawansowania VARCHAR(30) NOT NULL,
  PRIMARY KEY (ID_JezykiObce));

CREATE TABLE IF NOT EXISTS mydb.JezykiObceOfertyPracy (
  ID_JezykiObce_ID_JezykiObce INT NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
  CONSTRAINT fk_ID_JezykiObce_has_OfertyPracy_ID_JezykiObce1
    FOREIGN KEY (ID_JezykiObce_ID_JezykiObce)
    REFERENCES mydb.ID_JezykiObce (ID_JezykiObce)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ID_JezykiObce_has_OfertyPracy_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES mydb.OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_ID_JezykiObce_has_OfertyPracy_OfertyPracy1_idx ON mydb.JezykiObceOfertyPracy (OfertyPracy_ID_OfertyPracy);
CREATE INDEX fk_ID_JezykiObce_has_OfertyPracy_ID_JezykiObce1_idx ON mydb.JezykiObceOfertyPracy (ID_JezykiObce_ID_JezykiObce);

CREATE TABLE IF NOT EXISTS mydb.JezykiObcePoszukujacyPracy (
  ID_JezykiObce_ID_JezykiObce INT NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  CONSTRAINT fk_ID_JezykiObce_has_PoszukujacyPracy_ID_JezykiObce1
    FOREIGN KEY (ID_JezykiObce_ID_JezykiObce)
    REFERENCES mydb.ID_JezykiObce (ID_JezykiObce)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ID_JezykiObce_has_PoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES mydb.PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_ID_JezykiObce_has_PoszukujacyPracy_PoszukujacyPracy1_idx ON mydb.JezykiObcePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_ID_JezykiObce_has_PoszukujacyPracy_ID_JezykiObce1_idx ON mydb.JezykiObcePoszukujacyPracy (ID_JezykiObce_ID_JezykiObce);

CREATE TABLE IF NOT EXISTS mydb.KwalifikacjeOfertyPracy (
  Kwalifikacje_ID_Kwalifikacje INT NOT NULL,
  OfertyPracy_ID_OfertyPracy INT NOT NULL,
  CONSTRAINT fk_Kwalifikacje_has_OfertyPracy_Kwalifikacje1
    FOREIGN KEY (Kwalifikacje_ID_Kwalifikacje)
    REFERENCES mydb.Kwalifikacje (ID_Kwalifikacje)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Kwalifikacje_has_OfertyPracy_OfertyPracy1
    FOREIGN KEY (OfertyPracy_ID_OfertyPracy)
    REFERENCES mydb.OfertyPracy (ID_OfertyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Kwalifikacje_has_OfertyPracy_OfertyPracy1_idx ON mydb.KwalifikacjeOfertyPracy (OfertyPracy_ID_OfertyPracy);
CREATE INDEX fk_Kwalifikacje_has_OfertyPracy_Kwalifikacje1_idx ON mydb.KwalifikacjeOfertyPracy (Kwalifikacje_ID_Kwalifikacje);

CREATE TABLE IF NOT EXISTS mydb.KwalifikacjePoszukujacyPracy (
  Kwalifikacje_ID_Kwalifikacje INT NOT NULL,
  PoszukujacyPracy_ID_PoszukujacyPracy INT NOT NULL,
  CONSTRAINT fk_Kwalifikacje_has_PoszukujacyPracy_Kwalifikacje1
    FOREIGN KEY (Kwalifikacje_ID_Kwalifikacje)
    REFERENCES mydb.Kwalifikacje (ID_Kwalifikacje)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Kwalifikacje_has_PoszukujacyPracy_PoszukujacyPracy1
    FOREIGN KEY (PoszukujacyPracy_ID_PoszukujacyPracy)
    REFERENCES mydb.PoszukujacyPracy (ID_PoszukujacyPracy)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX fk_Kwalifikacje_has_PoszukujacyPracy_PoszukujacyPracy1_idx ON mydb.KwalifikacjePoszukujacyPracy (PoszukujacyPracy_ID_PoszukujacyPracy);
CREATE INDEX fk_Kwalifikacje_has_PoszukujacyPracy_Kwalifikacje1_idx ON mydb.KwalifikacjePoszukujacyPracy (Kwalifikacje_ID_Kwalifikacje);

/* SET SQL_MODE=@OLD_SQL_MODE; */
/* SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; */
/* SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; */

INSERT INTO mydb.DziedzinaPracy (ID_DziedzinaPracy , Nazwa) VALUES (1, 'Administracja');
INSERT INTO mydb.DziedzinaPracy (ID_DziedzinaPracy , Nazwa) VALUES (2, 'Informatyka');
INSERT INTO mydb.DziedzinaPracy (ID_DziedzinaPracy , Nazwa) VALUES (3, 'Budownictwo');

INSERT INTO mydb.RodzajUmowy ( ID_RodzajUmowy, Nazwa) VALUES (1, 'Umowa o pracę');
INSERT INTO mydb.RodzajUmowy ( ID_RodzajUmowy, Nazwa) VALUES (2, 'Umowa o dzieło');
INSERT INTO mydb.RodzajUmowy ( ID_RodzajUmowy, Nazwa) VALUES (3, 'Umowa zlecenie');
  
INSERT INTO mydb.Umowa (ID_Umowa, MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	(1, 'Warszawa', 3500, '120' ,1);
INSERT INTO mydb.Umowa (ID_Umowa, MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	(2, 'Lublin', 3000, '110',2);
INSERT INTO mydb.Umowa (ID_Umowa, MiejsceWykonania, Wynagrodzenie, CzasPracy, RodzajUmowy_ID_RodzajUmowy) VALUES
	(3, 'Poznań', 5500, '140' ,3);

INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (1 , 'Użytkownik');
INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (2 , 'Użytkownik');
INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (3 , 'Użytkownik');
INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (4 , 'Pracodawca');
INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (5 , 'Pracodawca');
INSERT INTO mydb.Uprawnienia ( ID_Uprawnienia , Rodzajuprawnień ) VALUES (6 , 'Pracodawca');

INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (1, 'Niezablokowane');
INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (2, 'Niezablokowane');
INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (3, 'Niezablokowane');
INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (4, 'Niezablokowane');
INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (5, 'Niezablokowane');
INSERT INTO mydb.StatusKonta (ID_StatusKonta , Nazwa ) VALUES (6, 'Niezablokowane');

INSERT INTO mydb.DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
(1, 'MietekW' , 'MietekW', '2021-04-12', 1 , 4 , 4);
INSERT INTO mydb.DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
(2, 'MietekL' , 'MietekL', '2021-04-12', 2 , 5 , 5);
INSERT INTO mydb.DaneLogowaniaPracodawca (ID_DaneLogowaniaPracodawca, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta) VALUES
(3, 'MietekP' , 'MietekP', '2021-04-12', 3 , 6 , 6);

INSERT INTO mydb.Pracodawca ( ID_Pracodawca,  Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu ,  NrMieszkania,  Telefon ,  Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
(1, 'MietekW' , 'Warszawa', '03-887', 'mazowieckie', 'Al. Jerozolimskie', '43', '1A' , '015265489154', 'MietekW@gmail.com', 1);
INSERT INTO mydb.Pracodawca ( ID_Pracodawca,  Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu ,  NrMieszkania,  Telefon ,  Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
(2, 'MietekL' , 'Lublin', '20-310', 'lubelskie', 'Al. Kraśnickie', '26', '' , '185265489154', 'MietekL@gmail.com', 2);
INSERT INTO mydb.Pracodawca ( ID_Pracodawca,  Nazwa,  Miasto,  KodPocztowy,  Województwo,  Ulica,  Nrdomu ,  NrMieszkania,  Telefon ,  Email,  DaneLogowaniaPracodawcy_ID_DaneLogowania) VALUES
(3, 'MietekP' , 'Poznań', '30-468', 'wielkopolskie', 'Prosta', '43', '1A' , '015653254698', 'MietekP@gmail.com', 3);

INSERT INTO mydb.Stanowisko ( ID_Stanowisko, Nazwa) VALUES (1, 'Młodszy Specjalista');
INSERT INTO mydb.Stanowisko ( ID_Stanowisko, Nazwa) VALUES (2, 'Specjalista');
INSERT INTO mydb.Stanowisko ( ID_Stanowisko, Nazwa) VALUES (3, 'Starszy Specjalista');

INSERT INTO mydb.OfertyPracy ( ID_OfertyPracy, Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
(1,'Potrzebny peon w urzędzie pracy', 'Praca, praca!' ,1,1,1,1,1);
INSERT INTO mydb.OfertyPracy ( ID_OfertyPracy, Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
(2,'Programista', 'A Twój język to *werble* PHP!' ,2,2,2,2,2);
INSERT INTO mydb.OfertyPracy ( ID_OfertyPracy, Nazwa, Opis, DziedzinaPracy_ID_DziedzinaPracy, Umowa_ID_Umowa, Pracodawca_ID_Pracodawca, Stanowisko_ID_Stanowisko, JezykiObceOfertyPracy_ID_JezykiObce) VALUES
(3,'Operator koparki ręcznej', 'Nie opierać się o betoniarkę!' ,3,3,3,3,3);

INSERT INTO mydb.PoszukujacyPracy ( ID_PoszukujacyPracy, Imie, DrugieImie, Nazwisko, Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
(1,'Andrzej','','Kowalski','andrzej@gmail.com','214569853214',4);
INSERT INTO mydb.PoszukujacyPracy ( ID_PoszukujacyPracy, Imie, DrugieImie, Nazwisko, Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
(2,'Jan','','Nowak','jan@gmail.com','214652148214',5);
INSERT INTO mydb.PoszukujacyPracy ( ID_PoszukujacyPracy, Imie, DrugieImie, Nazwisko, Email, Telefon, JezykiObcePoszukujacyPracy_ID_JezykiObce) VALUES 
(3,'Pjoter','','Rzyła','pjoter@gmail.com','214566413598',6);

INSERT INTO mydb.Kwalifikacje ( ID_Kwalifikacje, Doswiadczenie, Edukacja, InformacjeDodatkowe) VALUES 
(1, 'Brak', 'Szkoła Wyższa w Bytomiu', 'Administracja to moje drugie życie');
INSERT INTO mydb.Kwalifikacje ( ID_Kwalifikacje, Doswiadczenie, Edukacja, InformacjeDodatkowe) VALUES 
(2, '3 lata w branży', 'Politechnika Lubelska', 'PHP? A co to takiego?');
INSERT INTO mydb.Kwalifikacje ( ID_Kwalifikacje, Doswiadczenie, Edukacja, InformacjeDodatkowe) VALUES 
(3, '10 lat', 'Zawodowa Szkoła Branżowa', '-');


INSERT INTO mydb.List ( ID_Listu, Tresc, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(1,'Dzień dobry, ja do urzędu pracy', 1);
INSERT INTO mydb.List ( ID_Listu, Tresc, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(2,'Proszę tylko nie PHP', 2);
INSERT INTO mydb.List ( ID_Listu, Tresc, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(3,'Co dziś kopiemy?', 3);

INSERT INTO mydb.StatusZgłoszenia ( ID_StatusZgłoszenia , Nazwa, Opis) VALUES 
(1, 'Oczekiwanie','Odezwiemy się do Pana');
INSERT INTO mydb.StatusZgłoszenia ( ID_StatusZgłoszenia , Nazwa, Opis) VALUES 
(2, 'Zatwierdzone','Oczekuj kontaktu');
INSERT INTO mydb.StatusZgłoszenia ( ID_StatusZgłoszenia , Nazwa, Opis) VALUES 
(3, 'Zatwierdzone','Oczekuj kontaktu');

INSERT INTO mydb.Rekrutacja ( ID_Rekrutacja, InformacjaZwrotna , OfertyPracy_ID_OfertyPracy) VALUES 
(1,'Zgłoszenie przyjęte', 1);
INSERT INTO mydb.Rekrutacja ( ID_Rekrutacja, InformacjaZwrotna , OfertyPracy_ID_OfertyPracy) VALUES 
(2,'Zgłoszenie przyjęte', 2);
INSERT INTO mydb.Rekrutacja ( ID_Rekrutacja, InformacjaZwrotna , OfertyPracy_ID_OfertyPracy) VALUES 
(3,'Zgłoszenie przyjęte', 3);

INSERT INTO mydb.Zgloszenie ( ID_Zgloszenie, TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja) VALUES 
(1,'2020-03-03',1,1,1);
INSERT INTO mydb.Zgloszenie ( ID_Zgloszenie, TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja) VALUES 
(2,'2020-06-08',2,2,2);
INSERT INTO mydb.Zgloszenie ( ID_Zgloszenie, TerminSkładaniaZgłoszenia, PoszukujacyPracy_ID_PoszukujacyPracy, StatusZgłoszenia_ID_StatusZgłoszenia, Rekrutacja_ID_Rekrutacja) VALUES 
(3,'2020-05-23',3,3,3);

INSERT INTO mydb.DaneLogowaniaPoszukujacyPracy ( ID_DaneLogowaniaPoszukujacyPracy, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy ) VALUES
(1,'andrzejK','andrzej123','2020-03-28',1,1,1,1);
INSERT INTO mydb.DaneLogowaniaPoszukujacyPracy ( ID_DaneLogowaniaPoszukujacyPracy, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy ) VALUES
(2,'janN','jan123','2021-02-22',2,2,2,2);
INSERT INTO mydb.DaneLogowaniaPoszukujacyPracy ( ID_DaneLogowaniaPoszukujacyPracy, Login, Hasło, DataUtworzenia, Pracodawca_ID_Pracodawca, Uprawnienia_ID_Uprawnienia, StatusKonta_ID_StatusKonta, PoszukujacyPracy_ID_PoszukujacyPracy ) VALUES
(3,'pjoterR','pjoter123','2021-01-24',3,3,3,3);
  
INSERT INTO mydb.StatusLogowania ( ID_StatusLogowania, DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
(1,'2020-03-28','2020-03-28',1,1);
INSERT INTO mydb.StatusLogowania ( ID_StatusLogowania, DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
(2,'2021-02-22','2021-02-22',2,2);
INSERT INTO mydb.StatusLogowania ( ID_StatusLogowania, DataLogowania, DataWylogowania, DaneLogowaniaPracodawca_ID_DaneLogowania, DaneLogowaniaPoszukujacyPracy_ID_DaneLogowania) VALUES 
(3,'2021-01-24','2021-01-24',3,3);

INSERT INTO mydb.ID_JezykiObce ( ID_JezykiObce, Nazwa , StopieńZaawansowania ) VALUES
(1,'Angielski','C1');
INSERT INTO mydb.ID_JezykiObce ( ID_JezykiObce, Nazwa , StopieńZaawansowania ) VALUES
(2,'Angielski','B1');
INSERT INTO mydb.ID_JezykiObce ( ID_JezykiObce, Nazwa , StopieńZaawansowania ) VALUES
(3,'Angielski','A1');

INSERT INTO mydb.JezykiObceOfertyPracy ( ID_JezykiObce_ID_JezykiObce, OfertyPracy_ID_OfertyPracy) VALUES 
(1,1);
INSERT INTO mydb.JezykiObceOfertyPracy ( ID_JezykiObce_ID_JezykiObce, OfertyPracy_ID_OfertyPracy) VALUES 
(2,2);
INSERT INTO mydb.JezykiObceOfertyPracy ( ID_JezykiObce_ID_JezykiObce, OfertyPracy_ID_OfertyPracy) VALUES 
(3,3);

INSERT INTO mydb.JezykiObcePoszukujacyPracy ( ID_JezykiObce_ID_JezykiObce, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(1,1);
INSERT INTO mydb.JezykiObcePoszukujacyPracy ( ID_JezykiObce_ID_JezykiObce, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(2,2);
INSERT INTO mydb.JezykiObcePoszukujacyPracy ( ID_JezykiObce_ID_JezykiObce, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(3,3);

INSERT INTO mydb.KwalifikacjeOfertyPracy ( Kwalifikacje_ID_Kwalifikacje, OfertyPracy_ID_OfertyPracy) VALUES
(1,1);
INSERT INTO mydb.KwalifikacjeOfertyPracy ( Kwalifikacje_ID_Kwalifikacje, OfertyPracy_ID_OfertyPracy) VALUES
(2,2);
INSERT INTO mydb.KwalifikacjeOfertyPracy ( Kwalifikacje_ID_Kwalifikacje, OfertyPracy_ID_OfertyPracy) VALUES
(3,3);

INSERT INTO mydb.KwalifikacjePoszukujacyPracy ( Kwalifikacje_ID_Kwalifikacje, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(1,1);
INSERT INTO mydb.KwalifikacjePoszukujacyPracy ( Kwalifikacje_ID_Kwalifikacje, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(2,2);
INSERT INTO mydb.KwalifikacjePoszukujacyPracy ( Kwalifikacje_ID_Kwalifikacje, PoszukujacyPracy_ID_PoszukujacyPracy) VALUES 
(3,3);
