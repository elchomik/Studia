create view widokTestowy AS 
select
p.Nazwa AS 'Nazwa',
p.Miasto AS 'Miasto',
p.Województwo AS 'Wojewodztwo',
p.Email AS 'Email'
from pracodawca p;

select * from widoktestowy;
describe umowa;

create view UmowaRodzajUmowy AS
SELECT
u.`miejsce wykonania` AS 'Miejsce',
u.wynagrodzenie AS 'Wynagrodzenie',
op.nazwa AS 'Nazwa oferty',
op.opis AS 'Opis'
FROM ofertypracy op INNER JOIN umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;

create view UmowaRodzajUmowy2 AS
SELECT
u.`miejsce wykonania` AS 'Miejsce',
u.wynagrodzenie AS 'Wynagrodzenie',
op.nazwa AS 'Nazwa oferty',
op.opis AS 'Opis'
FROM ofertypracy op LEFT JOIN umowa u
ON op.umowa_ID_umowa=u.ID_Umowa;

create view UmowaOfertaRodzaj AS 
	SELECT
			u.`miejsce wykonania` AS 'Miejsce',
			u.wynagrodzenie AS 'Wynagrodzenie',
			op.nazwa AS 'Nazwa oferty',
			op.opis AS 'Opis',
			ru.nazwa AS 'Nazwa Umowy'
	FROM OfertyPracy op INNER JOIN Umowa u
		ON op.umowa_ID_umowa=u.ID_Umowa
		INNER JOIN `Rodzaj umowy` ru 
		ON ru.ID_RodzajUmowy=u.`Rodzaj Umowy_ID_RodzajUmowy`;


create view UmowaOfertaRodzajPracodawca AS
		SELECT
			p.Nazwa AS 'Pracodawca',
            p.Miasto AS 'Miasto',
            p.Telefon AS 'Telefon',
            p.Email AS 'Email',
			u.`miejsce wykonania` AS 'Miejsce',
			u.wynagrodzenie AS 'Wynagrodzenie',
			op.nazwa AS 'Nazwa oferty',
			op.opis AS 'Opis',
			ru.nazwa AS 'Nazwa Umowy',
            dp.nazwa AS 'Dziedzina Pracy'
        FROM Pracodawca p INNER JOIN OfertyPracy op 
        ON p.ID_Pracodawca=op.Pracodawca_ID_Pracodawca
        INNER JOIN Umowa u
        ON u.ID_Umowa=op.Umowa_ID_Umowa
        LEFT JOIN `Rodzaj Umowy` ru
        ON ru.ID_RodzajUmowy=u.`Rodzaj Umowy_ID_RodzajUmowy`
		LEFT JOIN DziedzinaPracy dp 
        ON dp.ID_DziedzinaPracy=op.DziedzinaPracy_ID_DziedzinaPracy;

DELIMITER $$
create trigger Wynagrodzenie
	before insert on Umowa
		for each row
				begin 
					if new.wynagrodzenie < 2800 then
						set new.wynagrodzenie=2800;
					end if;
				end$$

DELIMITER $$
create trigger StatusLogo
	before insert on StatusLogowania
		for each row
			begin
				if new.DataLogowania <> now() then
					set new.DataLogowania=now();
				end if;
                end $$
