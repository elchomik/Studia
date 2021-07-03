DECLARE @zdanie varchar(30)
SET @zdanie='Programowanie w jêzyku T-SQL'
PRINT @zdanie;


GO 
DECLARE @x int, @y int
SET @x=15
SET @y=9
PRINT 'Ró¿nica liczb ' +
CONVERT(VARCHAR(2),@x) + ' oraz '+
CONVERT(VARCHAR(2),@y) + ' wynosi ' +
CONVERT(VARCHAR(2),@x-@y)

GO
DECLARE @dzisiaj NVARCHAR(40)
SET @dzisiaj=LEFT(GETDATE(),11)
PRINT 'Dzisiaj mamy '+@dzisiaj

GO
DECLARE @marka VARCHAR(30)
SELECT @marka=Marka
FROM Samochod
WHERE ID_Samochod=6;
PRINT @marka

GO
DECLARE @imie VARCHAR(30), @nazwisko VARCHAR(30)
SELECT @imie=Imie, @nazwisko=Nazwisko
FROM Klient
SELECT @nazwisko AS Nazwisko,
		@imie AS Imie

GO
DECLARE @rokProdukcji CHAR(4)
SELECT @rokProdukcji=( SELECT
Rok_produkcji
FROM Samochod
WHERE ID_Samochod=10)
SELECT @rokProdukcji AS 'Rok Produkcji'

GO
DECLARE @nr int=8
SELECT Znizka,ID_Klienta
FROM KartaStalegoKlienta
WHERE ID_Karta<@nr

GO
DECLARE @a int
SET @a=15
IF @a%2=0
PRINT 'Liczba jest parzysta'
ELSE PRINT 'Liczba nie parzysta'


GO
DECLARE @nr int
SET @nr=RAND()*3
PRINT @nr
IF @nr=1
PRINT 'Wygra³eœ tablet'
ELSE IF @nr=2
PRINT 'Wygraleœ telefon'
ELSE 
PRINT 'Wygra³eœ cukierka'

GO
DECLARE @liczbaAut int
SELECT @liczbaAut=( SELECT COUNT(*) 'Liczba Aut'
FROM Samochod
WHERE ID_Klienta=9)
IF @liczbaAut=0
PRINT 'Brak Aut'
ELSE IF @liczbaAut<2
PRINT 'Kilka Aut'
ELSE
PRINT 'Powy¿ej 2 aut'

GO
DECLARE @l int
SET @l=77
PRINT CASE
WHEN @l%2=0 THEN 'Liczba jest parzysta'
WHEN @l%3=0 THEN 'Liczba jest podzielna przez 3'
WHEN @l%5=0 THEN 'Liczba jest podzielna przez 5'
WHEN @l%7=0 THEN 'Liczba jest podzielna przez 7'
ELSE 'Liczba nie jest podzielna przez 2, 3, 5 i 7'
END;

GO
DECLARE @l int, @os int
SET @os=9
SELECT @l=(SELECT COUNT(*)
FROM Samochod
WHERE ID_Klienta=@os)
PRINT CASE
WHEN @l IN  (0,1,2,3) THEN 'Ma³o aut'
ELSE 'Du¿o aut'
END;

GO 
SELECT Marka,Rok_produkcji,ID_Klienta
FROM Samochod
WHERE ID_Klienta IN(1,2,3,4,5,6,7,8,9,10)
ORDER BY
CASE ID_Klienta WHEN 1 THEN Marka end desc,
CASE ID_Klienta WHEN 4 THEN Rok_produkcji end asc

GO
DECLARE @id int, @i int=1
SET @id=(SELECT MAX(ID_Karta) FROM KartaStalegoKlienta)/2

WHILE @i<=@id
BEGIN
SELECT Imie,Nazwisko,Telefon
FROM Klient
WHERE ID_Klient=@i
SET @i=@i+1
END

GO
DECLARE @i int=1
WHILE @i<20
BEGIN
PRINT @i
SET @i=@i+3
END

GO
CREATE FUNCTION dbo.LiczbaAut2(@idKlienta INT )
RETURNS int 
AS
BEGIN
   DECLARE @licz int
   SET @licz=(SELECT COUNT(*) 
   FROM Samochod
   WHERE ID_Klienta=@idKlienta AND Rok_produkcji>2017)

RETURN(@licz) END;

GO
SELECT dbo.LiczbaAut2(10)

GO 
CREATE FUNCTION dbo.KlienciPosiadajacyAutoRok2(@rok CHAR(4))
RETURNS TABLE
AS
RETURN(
SELECT
k.Imie Imie,
k.Nazwisko,
k.Telefon,
s.Marka,
s.Rok_produkcji
FROM Klient k INNER JOIN Samochod s ON k.ID_Klient=s.ID_Klienta
WHERE Rok_produkcji=@rok);

GO
select * from dbo.KlienciPosiadajacyAutoRok2('2019');

GO
CREATE PROC SamochodProc
AS
BEGIN
   SELECT Marka,Rok_produkcji,ID_Klienta
   FROM Samochod
   ORDER BY Rok_produkcji desc;
   END;


GO

ALTER PROCEDURE SamochodProc 
AS
BEGIN 
 SELECT Marka,Rok_produkcji,ID_Klienta
   FROM Samochod
   ORDER BY Marka desc;
   END;

GO
EXECUTE SamochodProc;
GO