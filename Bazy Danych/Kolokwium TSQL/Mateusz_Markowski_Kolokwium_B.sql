1.
CREATE DATABASE Salonik;

USE Salonik;
CREATE TABLE Klient (
IdKlient int identity(1,1) primary key not null,
nazwisko char(30) not null,
imie char(30) not null,
drugieImie char(30),
haslo  char(30) not null,
login char(30) UNIQUE not null,
email char(30) UNIQUE not null);

CREATE TABLE Samochod(
idSamochod int identity(1,1) primary key,
marka nchar(30) not null,
model nchar(30) not null,
liczbaDrzwi int not null,
dataProdukcja date not null);

CREATE TABLE Sprzedaz(
IdSprzedaz int identity(1,1) primary key,
data date not null,
idKlient int not null,
idSamochod int not null,
nrFaktury nchar(30) not null,
opis nchar(100)
);

ALTER TABLE Sprzedaz ADD CONSTRAINT Sprzedaz_Klient_FK FOREIGN KEY (idKlient)
REFERENCES Klient ON DELETE CASCADE;

ALTER TABLE Sprzedaz ADD CONSTRAINT Sprzedaz_Samochod_FK FOREIGN KEY (idSamochod)
REFERENCES Samochod ON DELETE CASCADE;

2.
Insert into Klient (nazwisko,imie,drugieImie,haslo,login,email) VALUES 
('Walaszek','Maniek','Waldzio','12345678','waldziu','emailu@waldek.pl');

Insert into Klient (nazwisko,imie,drugieImie,haslo,login,email) VALUES 
('Jankowski','Witek','Radek','987654321','radziu','emailu@radek.pl');

Insert into Klient (nazwisko,imie,drugieImie,haslo,login,email) VALUES 
('Serek','Pancio','Pancio','11112222','pancio','emailu@pancio.pl');

Insert into Samochod (marka, model, liczbaDrzwi, dataProdukcja) VALUES 
('Opel', 'Corsa' , 3, '01-01-2000');

Insert into Samochod (marka, model, liczbaDrzwi, dataProdukcja) VALUES 
('Mazda', '3' , 5, '01-05-2001');

Insert into Samochod (marka, model, liczbaDrzwi, dataProdukcja) VALUES 
('Toyota', 'Tundra' , 5, '12-02-1999');



Insert into Sprzedaz (data, idKlient, idSamochod, nrFaktury, opis) VALUES
('12-08-2008', 1, 3,'fa02/04','Zakup bardzo dobrego samochod, bardzo dobry wybor');

Insert into Sprzedaz (data, idKlient, idSamochod, nrFaktury, opis) VALUES
('09-02-2002', 2, 3,'fa02/09','Zakup wykonany poprawnie, polecam kupujacego');

Insert into Sprzedaz (data, idKlient, idSamochod, nrFaktury, opis) VALUES
('07-11-2012', 3, 1,'fa09/01','Klient bardzo zadowolony z zakupu');

3.

DECLARE @regex varchar(30)
SET @regex='_[o]%'
SELECT * FROM Samochod
WHERE marka LIKE @regex

4.
GO
CREATE PROCEDURE DaneSprzedazyKlienta @nazwisko char(30)
AS
SELECT
s.data 'Data',
s.nrFaktury 'Faktura',
s.idKlient 'Klient ID',
s.idSamochod 'Samochod ID',
s.opis 'Opis'
FROM Klient k INNER JOIN Sprzedaz s ON k.IdKlient=s.idKlient
WHERE nazwisko=@nazwisko
ORDER BY s.data DESC;


EXECUTE DaneSprzedazyKlienta Serek;

5.
GO
DECLARE  @id int,
@marka nchar(30),
@model nchar(30),
@liczbaDrzwi nchar(30),
@klientId int,
@dataSprzedane date,
@loopVariable int=1

DECLARE daneSamochodKlient CURSOR
FORWARD_ONLY FOR SELECT
s.idSamochod 'ID samochód',
s.liczbaDrzwi 'Liczba Drzwi',
s.marka 'Marka',
s.model 'Model',
sp.data 'Data Sprzedane',
sp.idKlient 'Klient id'
FROM Samochod s INNER JOIN Sprzedaz sp ON s.idSamochod=sp.idSamochod
INNER JOIN Klient k ON k.IdKlient=sp.idKlient
ORDER BY Marka ASC;

OPEN daneSamochodKlient;

FETCH NEXT FROM daneSamochodKlient
INTO @id,@liczbaDrzwi,@marka,@model,@dataSprzedane,@klientId;


WHILE @@FETCH_STATUS=0
BEGIN

IF @dataSprzedane < '2012' PRINT 'Samochod sprzedany przed rokiem 2012'
ELSE PRINT 'Samochód sprzedany po 2012'

SET @loopVariable=@loopVariable+1;
FETCH NEXT FROM daneSamochodKlient
INTO @id,@liczbaDrzwi,@marka,@model,@dataSprzedane,@klientId;
END

CLOSE daneSamochodKlient;
DEALLOCATE daneSamochodKlient;

