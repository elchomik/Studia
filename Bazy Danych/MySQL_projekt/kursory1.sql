DECLARE daneKlient CURSOR
FORWARD_ONLY 
FOR select * from Klient 
ORDER BY Telefon;

open daneKlient;

GO
DECLARE @id int,
@imie VARCHAR(30),
@nazwisko VARCHAR(30),
@telefon VARCHAR(10),
@il int=1

DECLARE daneKlient CURSOR
FORWARD_ONLY
FOR SELECT 
ID_Klient,Imie,Nazwisko,Telefon
FROM Klient 
ORDER BY Nazwisko;

OPEN daneKlient;

FETCH NEXT FROM daneKlient
INTO @id,@imie,@nazwisko,@telefon;

WHILE @@FETCH_STATUS=0
BEGIN
IF @telefon is null
PRINT 'Podany Telfon jest pusty '+@imie+' '+@nazwisko;
ELSE PRINT 'Podany telefon nie jest pusty '+@imie+' '+@nazwisko;

SET @il=@il+1
FETCH NEXT FROM daneKlient INTO @id,@imie,@nazwisko,@telefon;
END;
CLOSE daneKlient;
DEALLOCATE daneKlient;

Select * from Samochod;

GO
DECLARE @id int, --deklaracja zmiennych dla kursora
@idKlient int,
@marka varchar(30),
@rok char(4),
@loopVariable int=1

DECLARE daneSamochodu CURSOR --deklaracja kursora
FORWARD_ONLY FOR SELECT
ID_Samochod,ID_Klienta,Marka,Rok_produkcji
FROM Samochod
WHERE Rok_produkcji!='2017'
ORDER BY Marka

OPEN daneSamochodu; --otwarcie kursora

FETCH NEXT FROM daneSamochodu -- pobranie kolejnego rekordu
INTO @id,@idKlient,@marka,@rok;


WHILE @@FETCH_STATUS=0 --sprawdzamy czy pobrano ju¿ wszystkie dane z tabeli
BEGIN

IF @rok='2019' PRINT 'Samochód wyprodukowano w roku 2019 '+ @marka;
ELSE PRINT 'Samochód wyprodukowano w '+@rok + ' ' +@marka;

SET @loopVariable=@loopVariable+1
FETCH NEXT FROM daneSamochodu
INTO @id,@idKlient,@marka,@rok

END;

CLOSE daneSamochodu;
DEALLOCATE daneSamochodu;
