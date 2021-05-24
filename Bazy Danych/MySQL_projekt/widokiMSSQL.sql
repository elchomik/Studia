
create view widokTestowy AS 
select
p.Nazwa AS 'Nazwa',
p.Miasto AS 'Miasto',
p.Województwo AS 'Wojewodztwo',
p.Email AS 'Email'
from pracodawca p;
GO

select * from widoktestowy;

GO

create view UmowaRodzajUmowy AS
SELECT
u.MiejsceWykonania AS 'Miejsce',
u.wynagrodzenie AS 'Wynagrodzenie',
op.nazwa AS 'Nazwa oferty',
op.opis AS 'Opis'
FROM ofertypracy op INNER JOIN umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;
GO

create view UmowaRodzajUmowy2 AS
SELECT
u.MiejsceWykonania AS 'Miejsce',
u.wynagrodzenie AS 'Wynagrodzenie',
op.nazwa AS 'Nazwa oferty',
op.opis AS 'Opis'
FROM ofertypracy op LEFT JOIN umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;

GO
create view UmowaOfertaRodzaj AS 
	SELECT
			u.MiejsceWykonania AS 'Miejsce',
			u.wynagrodzenie AS 'Wynagrodzenie',
			op.nazwa AS 'Nazwa oferty',
			op.opis AS 'Opis',
			ru.nazwa AS 'Nazwa Umowy'
	FROM OfertyPracy op INNER JOIN Umowa u
		ON op.umowa_ID_umowa=u.ID_Umowa
		INNER JOIN RodzajUmowy ru 
		ON ru.ID_RodzajUmowy=u.RodzajUmowy_ID_RodzajUmowy;

GO

create view UmowaOfertaRodzajPracodawca AS
		SELECT
			p.Nazwa AS 'Pracodawca',
            p.Miasto AS 'Miasto',
            p.Telefon AS 'Telefon',
            p.Email AS 'Email',
			u.MiejsceWykonania AS 'Miejsce',
			u.wynagrodzenie AS 'Wynagrodzenie',
			op.nazwa AS 'Nazwa oferty',
			op.opis AS 'Opis',
			ru.nazwa AS 'Nazwa Umowy',
            dp.nazwa AS 'Dziedzina Pracy'
        FROM Pracodawca p INNER JOIN OfertyPracy op 
        ON p.ID_Pracodawca=op.Pracodawca_ID_Pracodawca
        INNER JOIN Umowa u
        ON u.ID_Umowa=op.Umowa_ID_Umowa
        LEFT JOIN RodzajUmowy ru
        ON ru.ID_RodzajUmowy=u.RodzajUmowy_ID_RodzajUmowy
		LEFT JOIN DziedzinaPracy dp 
        ON dp.ID_DziedzinaPracy=op.DziedzinaPracy_ID_DziedzinaPracy;
		GO


