--Temat 7 Obs³uga wyj¹tków --

--Zadanie 202
DECLARE 
    vPrzedmiot Przedmioty.Id_Przedmiot%TYPE;
BEGIN 
    SELECT DISTINCT p.Id_Przedmiot INTO vPrzedmiot FROM Przedmioty p
        INNER JOIN Egzaminy e ON p.Id_Przedmiot = e.Id_Przedmiot
        WHERE UPPER(Nazwa_Przedmiot) = 'Bazy Danych';
    dbms_output.put_line('Z przedpiotu Bazy danych odby³ siê ju¿ egzamin');
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line(' Z baz danych nie by³o jeszcze egzaminu');
END;

--Spsobó 2
DECLARE
    vPrzedmiot Przedmioty.Id_Przedmiot%TYPE;
    vP Egzaminy.Id_Przedmiot%TYPE;
    CURSOR c1 IS SELECT Id_przedmiot FROM Przedmioty
        WHERE UPPER(Nazwa_Przedmiot) = 'Bazy danych';
BEGIN
    OPEN c1;
    IF c1%ISOPEN THEN
        FETCH c1 INTO vPrzedmiot;
        IF c1%FOUND THEN
            SELECT DISTINCT Id_Przedmiot INTO vP FROM Egzaminy WHERE Id_Przedmiot = vPrzedmiot;
            dbms_output.put_line('Z baz danyh odby³ siê egzamin');
        ELSE 
            dbms_output.put_line('Nie ma takiego przedmiotu');
        END IF;
        CLOSE c1;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line(' Z baz danych nie by³o jescze egzaminu');
    CLOSE c1;
END;


--Zadanie 203
DECLARE 
    vX Egzaminy.ID_Egzaminator%TYPE;
    CURSOR cEgzaminatorzy IS SELECT ID_Egzaminator, Nazwisko, Imie FROM Egzaminatorzy;
    VRek cEgzaminatorzy%ROWTYPE;
BEGIN
    OPEN cEgzaminatorzy;
    FETCH CEgzaminatorzy INTO vRek;
    
    WHILE CEgzaminatorzy%FOUND LOOP
        BEGIN
            SELECT ID_Egzaminator INTO vX FROM Egzaminy
                WHERE ID_Egzaminator = VRek.ID_Egzaminator;
        EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                dbms_output.put_line(vRek.Id_Egzaminator || ' ' || vRek.Nazwisko || ' ' || vRek.Imie);
            WHEN NO_DATA_FOUND THEN NULL;
        END;
        FETCH CEgzaminatorzy INTO vRek;
    END LOOP;
    CLOSE CEgzaminatorzy;
END;


--Sposób 2
DECLARE 
    CURSOR c1 IS SELECT egz.ID_Egzaminator, Imie, Nazwisko, COUNT(ID_EGzamin) AS liczba
    FROM Egzaminatorzy egz INNER JOIN Egzaminy e ON egz.ID_Egzaminator = e.ID_Egzaminator
    GROUP BY egz.ID_Egzaminator, Imie, Nazwisko
    HAVING COUNT(ID_Egzamin) >1;
    
    wynik c1%ROWTYPE;
BEGIN 
    OPEN c1;
    FETCH c1 INTO wynik;
    WHILE c1%FOUND LOOP
        dbms_output.put_line( wynik.ID_Egzaminator || ' ' || wynik.Imie || ' ' || wynik.Nazwisko || ' ' || wynik.liczba);
        FETCH c1 INTO wynik;
    END LOOP;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN dbms_output.put_line('Nie znaleziono rekordów');
    close C1;
END;


--Zadanie 204 
DECLARE 
    CURSOR c1 IS SELECT Nazwa_Osrodek, Id_Osrodek
    FROM Osrodki ORDER BY 2;
    vX VARCHAR(1);
BEGIN
    FOR vc1 IN c1 LOOP
       BEGIN
       SELECT DISTINCT 'X' INTO vX FROM Egzaminy WHERE ID_Osrodek = vc1.ID_Osrodek;

       EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            dbms_output.put_line(vc1.Nazwa_Osrodek || ' ' || vc1.Id_Osrodek);
        END;
    END LOOP;
END;


--Zadanie 205
DECLARE 
    vX VARCHAR(1);
    CURSOR c1 IS SELECT Id_Student, Imie, Nazwisko FROM Studenci ORDER BY 3;
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            SELECT DISTINCT 'X' INTO vX FROM Egzaminy WHERE ID_Student = vc1.ID_Student;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Imie || ' ' || vc1.Nazwisko);
        END;
    END LOOP;
END;


--Sposób z w³asnym wyj¹tkiem
DECLARE
    Uwaga EXCEPTION;
    CURSOR c1 IS SELECT s.ID_Student, Nazwisko, Imie, COUNT(ID_Egzamin) AS liczba
    FROM Studenci s LEFT JOIN Egzaminy e ON s.ID_Student = e.ID_Student
    GROUP BY s.ID_Student, Nazwisko, Imie;
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            IF vc1.liczba = 0 THEN RAISE UWAGA;
            END IF;
        EXCEPTION
            WHEN Uwaga THEN
                dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Nazwisko || ' ' || vc1.Imie);
        END;
    END LOOP;
END;


--Zadanie 206
DECLARE 
    vX VARCHAR(1);
    CURSOR c1 IS SELECT Nazwa_Przedmiot, Id_Przedmiot FROM Przedmioty ORDER BY 1;
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            SELECT DISTINCT 'X' INTO vX FROM Egzaminy e WHERE e.ID_Przedmiot = vc1.Id_Przedmiot;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            dbms_output.put_line(vc1.Nazwa_Przedmiot || ' ' || vc1.ID_Przedmiot);
        END;
    END LOOP;
END;

--Zadanie 207

DECLARE 
    Uwaga EXCEPTION;
    CURSOR c1 IS SELECT egz.Id_egzaminator, Imie, Nazwisko, Data_Egzamin, COUNT(DISTINCT Id_Student) AS Liczba
    FROM Egzaminatorzy egz INNER JOIN Egzaminy e ON egz.ID_Egzaminator = e.ID_Egzaminator
    GROUP BY egz.Id_egzaminator, Imie, Nazwisko, Data_Egzamin
    ORDER BY 3,2;
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            IF vc1.Liczba > 2 THEN RAISE UWAGA;
            END IF;
        EXCEPTION
            WHEN Uwaga THEN
                dbms_output.put_line(vc1.Id_Egzaminator || ' ' || vc1.Imie || ' ' || vc1.Nazwisko || ' ' || vc1.Data_Egzamin || ' ' || vc1.Liczba);
        END;
    END LOOP;
END;