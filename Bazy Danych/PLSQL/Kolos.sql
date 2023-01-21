SET SERVEROUTPUT ON;

DECLARE
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, Data_Egzamin 
        FROM Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek
        ORDER BY 3 DESC;
    CURSOR c2(p_IdOsrodek Osrodki.Id_Osrodek%TYPE, pData Egzaminy.Data_Egzamin%TYPE) IS 
        SELECT s.Id_Student,Imie, Nazwisko FROM Studenci s INNER JOIN Egzaminy e ON s.Id_Student = e.Id_Student
        WHERE e.Id_Osrodek = p_IdOsrodek AND e.Data_Egzamin = pData;
BEGIN
    FOR vc1 IN c1 LOOP
        EXIT WHEN c1%ROWCOUNT>3;
        dbms_output.put_line(vc1.Id_Osrodek || ' ' || vc1.Nazwa_Osrodek || ' ' || vc1.Data_Egzamin);
        
        FOR vc2 IN c2(vc1.Id_Osrodek, vc1.Data_Egzamin) LOOP
             dbms_output.put_line(vc2.Id_Student || ' ' || vc2.Imie || ' ' || vc2.Nazwisko);
        END LOOP;
    END LOOP;
END;


--Zadanie 2

DECLARE
    punkty NUMBER;
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(year FROM Data_Egzamin) AS Rok FROM
        Osrodki o INNER JOIN Egzaminy e ON o.Id_Osrodek = e.Id_Osrodek
        GROUP BY o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(year FROM Data_Egzamin)
        ORDER BY 2,3;
        
    FUNCTION liczbaEgzamin(p_IdOsrodek Osrodki.Id_Osrodek%TYPE) RETURN NUMBER IS
        liczbaPkt NUMBER;
        CURSOR c2 IS SELECT COUNT(Id_Egzamin) AS Liczba_egz FROM Egzaminy WHERE Id_Osrodek = p_IdOsrodek;
    BEGIN
        OPEN c2;
            FETCH c2 INTO liczbaPkt;
            IF liczbaPkt IS NULL THEN
                RETURN 0;
            END IF;
            RETURN liczbaPkt;
        CLOSE c2;
    END liczbaEgzamin;
BEGIN
    FOR vc1 IN c1 LOOP
        punkty:= liczbaEgzamin(vc1.Id_Osrodek);
        dbms_output.put_line(vc1.Nazwa_Osrodek || ' ' || vc1.Rok || ' ' || punkty);
    END LOOP;
END;


--zadanie

DECLARE
    studenciLiczba NUMBER DEFAULT 0;
    CURSOR c1 IS SELECT DISTINCT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin) AS Rok FROM Osrodki o INNER JOIN Egzaminy e 
        ON e.Id_Osrodek = o.Id_Osrodek
        GROUP BY o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin)
        ORDER BY 2,3;
    FUNCTION zliczStudenta(p_IdOsrodek OSrodki.Id_Osrodek%TYPE) RETURN NUMBER IS
        liczbaStd NUMBER;
        CURSOR c2 IS SELECT COUNT(DISTINCT Id_Student) AS Liczba_student FROM Egzaminy e WHERE e.Id_Osrodek = p_IdOsrodek;
            BEGIN
                OPEN c2;
                FETCH c2 INTO liczbaStd;
                    IF liczbaStd IS NULL THEN RETURN 0;
                    END IF;
                    RETURN liczbaStd;
                CLOSE c2;
            END zliczStudenta;
BEGIN
    FOR vc1 IN c1 LOOP
    studenciLiczba:= zliczStudenta(vc1.Id_Osrodek);
    dbms_output.put_line(vc1.Id_Osrodek || ' ' || vc1.Nazwa_Osrodek || ' ' || studenciLiczba || ' ' || vc1.Rok);
    END LOOP;
END;


--Zadanie 3

DECLARE
    i NUMBER DEFAULT 0;
    TYPE Typ_Egzam_Rec IS RECORD(Id_Egzaminator NUMBER, Imie VARCHAR2(50), Nazwisko VARCHAR2(50),
        Liczba_stud NUMBER);
    TYPE Typ_Egzaminator IS TABLE OF Typ_Egzam_Rec;
    NT_Egzaminatorzy Typ_Egzaminator := Typ_Egzaminator();
    CURSOR c1 IS SELECT egz.Id_Egzaminator, Imie, Nazwisko, COUNT(DISTINCT Id_Student) AS Liczba_osb
        FROM Egzaminatorzy egz INNER JOIN Egzaminy e ON e.Id_Egzaminator = egz.Id_Egzaminator
        GROUP BY egz.Id_Egzaminator, Imie, Nazwisko
        ORDER BY 4;
BEGIN
    FOR vc1 IN c1 LOOP
        i:= c1%ROWCOUNT;
        NT_Egzaminatorzy.EXTEND;
        NT_Egzaminatorzy(i):= Typ_Egzam_Rec(vc1.Id_Egzaminator, vc1.Imie, vc1.Nazwisko, vc1.Liczba_osb);
    END LOOP;
    
    FOR i IN NT_Egzaminatorzy.FIRST .. NT_Egzaminatorzy.LAST LOOP
 dbms_output.put_line(NT_Egzaminatorzy(i).Id_Egzaminator || ' ' || NT_Egzaminatorzy(i).Imie || ' ' || NT_Egzaminatorzy(i).Nazwisko 
    || ' ' || NT_Egzaminatorzy(i).Liczba_stud);
    END LOOP;
END;


---zadanie 4
CREATE OR REPLACE TYPE Typ_Stud_Osr_Obj AS OBJECT(Rok NUMBER, Miesiac NUMBER, Liczba_egz NUMBER, Liczba_osb NUMBER);
CREATE OR REPLACE TYPE Typ_Stud_Osr IS TABLE OF Typ_Stud_Osr_Obj;
CREATE TABLE Osrodki_Analiza(ID_Osrodek NUMBER, Nazwa_Osrodek VARCHAR2(50),
    StudenciOsr Typ_Stud_Osr) NESTED TABLE StudenciOsr STORE AS dane; 
DECLARE
    i NUMBER DEFAULT 0;
    kolekcja Typ_Stud_Osr := Typ_Stud_Osr();
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin) AS Rok, 
        EXTRACT(MONTH FROM Data_Egzamin)AS Miesiac FROM Osrodki o INNER JOIN Egzaminy e
            ON e.Id_Osrodek = o.Id_Osrodek;
    CURSOR c2(p_IdOsrodek OSrodki.Id_Osrodek%TYPE) IS SELECT COUNT(DISTINCT Id_Egzamin) AS liczba_Egz FROM Egzaminy e
        WHERE e.Id_Osrodek = p_IdOsrodek
        GROUP BY e.Id_Osrodek;
    CURSOR c3(p_IdOsrodek Osrodki.Id_Osrodek%TYPE, pRok NUMBER, pMiesiac NUMBER) IS SELECT 
        COUNT(DISTINCT Id_Student) AS Liczba_Std FROM Egzaminy e WHERE e.ID_Osrodek = p_IdOsrodek
        AND EXTRACT(YEAR FROM e.Data_Egzamin) = pRok AND EXTRACT(MONTH FROM e.Data_Egzamin)= pMiesiac
        GROUP BY e.Id_Osrodek;
BEGIN
    FOR vc1 IN c1 LOOP
        FOR vc2 IN c2(vc1.Id_Osrodek) LOOP
            dbms_output.put_line(vc1.Id_Osrodek || ' ' || vc1.Rok || ' ' || vc1.Miesiac || ' ' || vc2.liczba_Egz);
            FOR vc3 IN c3(vc1.Id_Osrodek, vc1.Rok, vc1.Miesiac) LOOP
                i:= c3%ROWCOUNT;
                kolekcja.EXTEND;
                kolekcja(i):= Typ_Stud_Osr_Obj(vc1.Rok, vc1.Miesiac, vc2.liczba_Egz, vc3.Liczba_Std);
            END LOOP;
            INSERT INTO Osrodki_Analiza VALUES(vc1.Id_Osrodek, vc1.Nazwa_Osrodek, kolekcja);
            kolekcja := Typ_Stud_Osr();
        END LOOP;
    END LOOP;
END;

select ae.*, nt.* 
    from Osrodki_Analiza ae, table(ae.StudenciOsr) nt ;
    
    
---Zadanie 5 
DECLARE
    wyjatek EXCEPTION;
    CURSOR c1 IS SELECT e.Id_Egzaminator, Nazwisko, Imie, extract(year FROM Data_Egzamin) AS Rok,
        COUNT(Id_Egzamin) AS Liczba_egzaminow FROM Studenci s INNER JOIN Egzaminy e
        ON e.Id_Student = s.Id_Student INNER JOIN Przedmioty p ON p.Id_Przedmiot = e.Id_Przedmiot
        WHERE UPPER(Nazwa_Przedmiot) = 'Bazy danych'
        GROUP BY e.Id_Student,Nazwisko, Imie, EXTRACT(YEAR FROM Data_Egzamin);
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            IF vc1.Liczba_egzaminow > 10 THEN
                RAISE e;
            END IF;
        EXCEPTION
            WHEN e THEN 
                dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Nazwisko || ' ' || vc1.Imie || ' ' || vc1.Rok || ' ' || vc1.Liczba_egzaminow);
        END;
    END LOOP;
END;

SELECT DISTINCT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin) AS Rok 
        FROM Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek
        ORDER BY 3;


DECLARE
    wyjatek EXCEPTION;
    CURSOR c1 IS SELECT DISTINCT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin) AS Rok 
        FROM Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek
        ORDER BY 3;
    CURSOR c2(p_IdOsrodek Osrodki.Id_Osrodek%TYPE, pData NUMBER) 
        IS SELECT e.Id_Egzaminator, Imie, Nazwisko, COUNT(ID_Egzamin) AS liczba_egz
            FROM Egzaminatorzy egz INNER JOIN Egzaminy e ON egz.Id_Egzaminator = e.Id_Egzaminator
            WHERE e.Id_Osrodek = p_IdOsrodek AND EXTRACT(YEAR FROM e.Data_Egzamin) = pData
            GROUP BY e.Id_Egzaminator,Imie, Nazwisko;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line('----------');
        dbms_output.put_line(vc1.ID_Osrodek || ' ' || vc1.Nazwa_Osrodek || ' ' || vc1.Rok);
        FOR vc2 IN c2(vc1.Id_Osrodek, vc1.Rok) LOOP
            BEGIN
                IF vc2.liczba_egz > 50 THEN
                    RAISE wyjatek;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    dbms_output.put_line('W danym oœrodku w danym nie by³o egzaminów');
                WHEN wyjatek THEN
                    dbms_output.put_line(vc2.Id_Egzaminator || ' ' || vc2.Imie || ' ' || vc2.Nazwisko || ' ' || vc2.liczba_egz);
            END;
        END LOOP;
    END LOOP;
END;