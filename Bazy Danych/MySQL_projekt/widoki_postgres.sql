create view widokTestowy AS 
select
p.Nazwa AS Nazwa,
p.Miasto AS Miasto,
p.Województwo AS Wojewodztwo,
p.Email AS Email
from mydb.pracodawca p;

create view UmowaRodzajUmowy AS
SELECT
u.miejscewykonania AS Miejsce,
u.wynagrodzenie AS Wynagrodzenie,
op.nazwa AS NazwaOferty,
op.opis AS Opis
FROM mydb.ofertypracy op INNER JOIN mydb.umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;

create view UmowaRodzajUmowy2 AS
SELECT
u.miejscewykonania AS Miejsce,
u.wynagrodzenie AS Wynagrodzenie,
op.nazwa AS NazwaOferty,
op.opis AS Opis
FROM mydb.ofertypracy op LEFT JOIN mydb.umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;

create view UmowaOfertaRodzaj AS 
	SELECT
			u.miejscewykonania AS Miejsce,
			u.wynagrodzenie AS Wynagrodzenie,
			op.nazwa AS NazwaOferty,
			op.opis AS Opis,
			ru.nazwa AS NazwaUmowy
	FROM mydb.OfertyPracy op INNER JOIN mydb.Umowa u
		ON op.umowa_ID_umowa=u.ID_Umowa
		INNER JOIN mydb.Rodzajumowy ru 
		ON ru.ID_RodzajUmowy=u.RodzajUmowy_ID_RodzajUmowy;


create view UmowaOfertaRodzajPracodawca AS
		SELECT
			p.Nazwa AS Pracodawca,
            p.Miasto AS Miasto,
            p.Telefon AS Telefon,
            p.Email AS Email,
			u.miejscewykonania AS Miejsce,
			u.wynagrodzenie AS Wynagrodzenie,
			op.nazwa AS NazwaOferty,
			op.opis AS Opis,
			ru.nazwa AS NazwaUmowy,
            dp.nazwa AS DziedzinaPracy
        FROM mydb.Pracodawca p INNER JOIN mydb.OfertyPracy op 
        ON p.ID_Pracodawca=op.Pracodawca_ID_Pracodawca
        INNER JOIN mydb.Umowa u
        ON u.ID_Umowa=op.Umowa_ID_Umowa
        LEFT JOIN mydb.RodzajUmowy ru
        ON ru.ID_RodzajUmowy=u.RodzajUmowy_ID_RodzajUmowy
		LEFT JOIN mydb.DziedzinaPracy dp 
        ON dp.ID_DziedzinaPracy=op.DziedzinaPracy_ID_DziedzinaPracy;
