1. DECLARE
@imie varchar(30)
SET @imie='Andrzej'
PRINT 'Witaj ' + @imie + '!';

2.DECLARE 
@a int,
@b int,
@c int,
@w int
SET @a=23
SET @b=13
SET @c=2
SET @w=@a+@b+@c;
PRINT 'Suma trzech liczb ' + convert(varchar(2),@a)+ ' i '+
convert(varchar(2),@b) + ' i '+convert(varchar(2),@c)+ ' wynosi '+
convert(varchar(2),@w);

3.DECLARE
@a int,
@b int,
@wynik int
SET @a=15
SET @b=7
SET @wynik=@a%@b
PRINT 'Reszta z dzielenia liczb '+convert(varchar(2),@a)+' '+convert(varchar(2),@b) +' to ' +convert(varchar(2),@wynik);

4.DECLARE
@data NVARCHAR(11)
SET @data=GETDATE()
PRINT 'Bieżąca data to ' + @data;

5.DECLARE
@imie varchar(30),
@nazwisko varchar(30),
@email varchar(30)
SELECT @nazwisko=nazwisko, @imie=imie,@email=Email
FROM dbo.PoszukujacyPracy;
PRINT @nazwisko+ ' ' + @imie+ ' '+@email

6.DECLARE 
@imie varchar(30),
@nazwisko varchar(30),
@email varchar(30),
@zmienna int
SET @zmienna=2
SELECT
@imie=Imie,@nazwisko=Nazwisko,@email=Email
FROM dbo.PoszukujacyPracy
WHERE ID_PoszukujacyPracy>@zmienna;
PRINT @nazwisko+ ' '+@imie+ ' - '+@email

7.DECLARE
@imie varchar(30),
@nazwisko varchar(30),
@email varchar(30),
@wzor varchar(4)='and%'
SELECT
@imie=imie,@nazwisko=Nazwisko,@email=Email
FROM dbo.PoszukujacyPracy
WHERE Email LIKE @wzor
PRINT @nazwisko + ' '+@imie + ' - ' +@email

8.DECLARE
@dzielna int=7,
@dzielnik int=3,
@wynik float
IF @dzielnik !=0
BEGIN
    SET @wynik=@dzielna/@dzielnik;
	PRINT 'Wynik dzielenia liczb ' + convert(varchar(4),@dzielna)+ ' '+
	convert(varchar(4),@dzielnik)+ ' to '+convert(varchar(4),@wynik)
END
ELSE
   PRINT 'Dzielenie przez 0 !'
   
 9.DECLARE
@zmienna int
SET @zmienna=RAND()*(100-1)+1
IF @zmienna<5 
BEGIN
    PRINT 'Wylosowana liczba ' + convert(varchar(2),@zmienna) + ' Nic nie wygrałeś'
END
ELSE IF @zmienna>=5 AND @zmienna<=10
BEGIN
    PRINT 'Wylosowana liczba ' + convert(varchar(2),@zmienna) + ' Wygrałeś kubek'
END
ELSE IF @zmienna>10 AND @zmienna<=30
BEGIN
      PRINT 'Wylosowana liczba ' + convert(varchar(2),@zmienna) + ' Wygrałeś tablet'
END
ELSE IF @zmienna>30 AND @zmienna<=60
BEGIN
     PRINT 'Wylosowana liczba ' + convert(varchar(2),@zmienna) + ' Wygrałeś laptop'
END
ELSE
    PRINT 'Poza przedziałem'
	
10.	DECLARE 
@liczbaOgloszen int
SELECT @liczbaOgloszen=(SELECT COUNT(*) 'Nazwa' 
FROM dbo.OfertyPracy 
WHERE Pracodawca_ID_Pracodawca=3)
IF @liczbaOgloszen>0 AND @liczbaOgloszen<=2
PRINT 'Mało ogłoszeń '+convert(varchar(2),@liczbaOgloszen)
ELSE IF @liczbaOgloszen>2 AND @liczbaOgloszen<=8
PRINT 'Sporo ogłoszeń ' + convert(varchar(2),@liczbaOgloszen)
ELSE PRINT 'Dużo ogłoszeń ' + convert(varchar(2),@liczbaOgloszen);

11.DECLARE 
@liczbaOgloszen int
SELECT @liczbaOgloszen=(SELECT COUNT(*) 'Nazwa' 
FROM dbo.OfertyPracy 
WHERE Pracodawca_ID_Pracodawca=3)
PRINT CASE
WHEN @liczbaOgloszen%2=0 THEN 'Liczba parzysta'
ELSE 'Liczba ogłoszeń jest nieparzysta'
END;

12.
DECLARE 
@liczbaOgloszen int
SELECT @liczbaOgloszen=(SELECT COUNT(*) 'Nazwa' 
FROM dbo.OfertyPracy 
WHERE Pracodawca_ID_Pracodawca=3)
PRINT CASE
WHEN @liczbaOgloszen>0 AND @liczbaOgloszen<=2 THEN 'Mało ogłoszeń'
WHEN  @liczbaOgloszen>2 AND @liczbaOgloszen<=8 THEN 'Sporo ogłoszeń'
ELSE 'Dużo ogłoszeń '
END;

13.SELECT 
ID_OfertyPracy, Nazwa,Opis,DziedzinaPracy_ID_DziedzinaPracy,Umowa_ID_Umowa,Pracodawca_ID_Pracodawca,
Stanowisko_ID_Stanowisko,JezykiObceOfertyPracy_ID_JezykiObce
FROM dbo.OfertyPracy
ORDER BY
CASE  WHEN ID_OfertyPracy%2=0 THEN Nazwa end asc,
CASE WHEN ID_OfertyPracy%2!=0 THEN Nazwa end desc

15.DECLARE @i int = 1
WHILE @i < 21
BEGIN
PRINT @i
SET @i = @i +1
END;

17.CREATE FUNCTION dbo.LiczbaPracodawca()
RETURNS int
AS
BEGIN
    DECLARE @licz int
	SET @licz=( select COUNT(*)
	from dbo.Pracodawca
	)
RETURN (@licz)
END;

18.CREATE FUNCTION dbo.MaxValue()
RETURNS int
AS
BEGIN
    DECLARE @licz int
	SET @licz=(
	SELECT MAX(Uprawnienia_ID_Uprawnienia) AS 'Uprawnienia'
	FROM dbo.DaneLogowaniaPracodawca
	)
RETURN (@licz)
END;

19.CREATE FUNCTION dbo.LiczbaOgloszen(@zmienna int)
RETURNS Varchar(30)
AS
BEGIN
	DECLARE @liczbaOgloszen int,
	        @wynik varchar(30)
    SELECT @liczbaOgloszen=(
	SELECT COUNT(*) 'Nazwa'
	FROM dbo.OfertyPracy
	WHERE Pracodawca_ID_Pracodawca=@zmienna
	)
    IF @liczbaOgloszen>0 AND @liczbaOgloszen<=2
	SET @wynik='Mało ogłoszeń'
	ELSE IF @liczbaOgloszen>2 AND @liczbaOgloszen<=8
	SET @wynik='Sporo ogłoszeń'
	ELSE 
	SET @wynik='Dużo ogłoszeń'
RETURN (@wynik)
END;

25.
CREATE PROCEDURE DanePracodawcy
AS 
SELECT 
*
FROM dbo.DaneLogowaniaPracodawca
WHERE DataUtworzenia>CONVERT(DATETIME,'2020-12-31')
ORDER BY DataUtworzenia,Login ASC;

27.CREATE PROCEDURE DanePracodawcy20 @Login varchar(30),@Haslo varchar(30)
AS
SELECT 
DataUtworzenia
FROM dbo.DaneLogowaniaPracodawca
WHERE Login=@Login AND Hasło=@Haslo;

