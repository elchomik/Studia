--- TEMAT 5 Tworzenie perspektyw w bazach danych ---

--Zadanie 167
CREATE VIEW VStudenci AS 
    SELECT ID_Student, Nazwisko, Imie FROM Studenci;

SELECT * FROM VStudenci;

--Zadanie 168
CREATE VIEW VEGzaminyCKMP AS
    SELECT Miasto,s.ID_Student, Imie, Nazwisko, Nazwa_Przedmiot, Data_Egzamin
    FROM Egzaminy e INNER JOIN Osrodki o ON e.ID_Osrodek=o.ID_Osrodek
    INNER JOIN Studenci s ON s.ID_Student = e.ID_Student
    INNER JOIN Przedmioty p ON p.ID_Przedmiot = e.ID_Przedmiot
    WHERE Nazwa_Osrodek = 'CKMP';
    
SELECT * From VEgzaminyCKMP;

--Zadanie 169
CREATE VIEW VEgzaminatorStudent(ID_Egzaminator, EgzaminatorNazwisko, EgzaminatorImie,
            ID_Student, StudentNazwisko, StudentImie, LiczbaMax) AS 
        SELECT egz.ID_Egzaminator, egz.Imie, egz.Nazwisko, s.ID_Student, s.Imie, s.Nazwisko, COUNT(Id_Egzamin)
        FROM Studenci s INNER JOIN Egzaminy e ON e.ID_Student = s.ID_Student
        INNER JOIN Egzaminatorzy egz ON egz.ID_Egzaminator = e.ID_Egzaminator
        GROUP BY egz.ID_Egzaminator, egz.Imie, egz.Nazwisko, s.ID_Student, s.Imie, s.Nazwisko
        HAVING COUNT(Id_Egzamin) = (SELECT MAX(COUNT(ID_Egzamin)) 
                                    FROM Egzaminy e2 WHERE e2.ID_Egzaminator = egz.ID_Egzaminator
                                    GROUP BY ID_Student);
SELECT * From VEgzaminatorStudent;


--Zadanie 170 
CREATE VIEW VOsrodkiLublin AS SELECT * FROM Osrodki WHERE UPPER(Miasto) = 'LUBLIN'
    WITH CHECK OPTION;
SELECT * From VOsrodkiLublin;


--Zadanie 171
SELECT * FROM VOsrodkiLublin
ORDER BY Nazwa_Osrodek;

--Zadanie 172
INSERT INTO VStudenci VALUES('0101011','Kuraœ', 'Jan');

--Zadanie 173
UPDATE VStudenci
SET Imie = 'Marian'
WHERE ID_Student ='0101011';

--Zadanie 174
DESCRIBE VOsrodkiLublin;

SELECT e.ID_Student, Nazwa_Osrodek, Imie, Nazwisko
    FROM Studenci s INNER JOIN Egzaminy e ON s.ID_Student = e.ID_Student
    INNER JOIN VOsrodkiLublin vo ON vo.ID_Osrodek = e.ID_Osrodek
    ORDER BY 4,3;

--Zadanie 175
DESCRIBE Egzaminy;

CREATE VIEW VEgzaminy AS SELECT ID_Egzamin, ID_Student, ID_Przedmiot, ID_Egzaminator, ID_Osrodek FROM Egzaminy;

--Zadanie 176
SELECT o.Id_Osrodek, Nazwa_Osrodek, COUNT(ID_Egzamin) AS Liczba_egzaminow
FROM VEgzaminy vg INNER JOIN OSrodki o ON vg.ID_Osrodek = o.ID_Osrodek
GROUP BY o.ID_OSrodek, Nazwa_Osrodek;

--Zadanie 178
CREATE OR REPLACE VIEW VOsrodkiPrzedmioty(Nazwa_Przedmiot,Nazwa_Osrodek, Liczba_egzaminow) 
    AS
      SELECT Nazwa_Przedmiot, Nazwa_Osrodek, COUNT(ID_Egzamin) FROM
        Egzaminy e INNER JOIN Osrodki o ON e.ID_Osrodek = e.ID_Osrodek
        INNER JOIN Przedmioty p ON p.ID_Przedmiot = e.ID_Przedmiot
        GROUP BY Nazwa_Przedmiot, Nazwa_Osrodek;
        
SELECT * FRom VOsrodkiPrzedmioty;


-- Zadanie 179
CREATE OR REPLACE VIEW VStudenciL(NrAlbumu, Nazwisko, Imie, LiczbaEgzaminow) AS 
    SELECT s.Id_Student, Nazwisko, Imie, COUNT(DISTINCT ID_Egzamin)
    FROM  Egzaminy e LEFT JOIN Studenci s ON e.ID_Student = s.ID_Student
    GROUP BY s.ID_Student, Nazwisko, Imie;

SELECT * FROM VStudenciL;

--Zadanie 180
CREATE OR REPLACE VIEW VOsrodkiMinMax AS
    SELECT o.Id_osrodek, o.Nazwa_osrodek, COUNT(e.Id_osrodek) AS LiczbaEgzaminow
        FROM Osrodki o
        JOIN Egzaminy e ON o.Id_osrodek = e.Id_osrodek
        GROUP BY o.Id_osrodek, o.Nazwa_osrodek
        HAVING COUNT(e.Id_osrodek) = (SELECT MAX(COUNT(e2.Id_osrodek)) FROM Egzaminy e2 GROUP BY e2.Id_osrodek) 
        OR COUNT(e.Id_osrodek) = (SELECT MIN(COUNT(e3.Id_osrodek)) FROM Egzaminy e3 GROUP BY e3.Id_osrodek);

SELECT * From VOsrodkiMinMax;